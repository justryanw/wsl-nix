{ pkgs, lib, config, ... }:
let
  cfg = config.wsl-vpn;
in
{
  options.wsl-vpn = {
    enable = lib.mkEnableOption "Enable connection to vpn on windows host";
    checkURL = lib.mkOption {
      default = "172.17.0.75";
      description = "URL to check if connection is sucessful";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services = {
      wsl-vpnkit-auto = {
        enable = true;
        description = "wsl-vpnkit";

        path = [ pkgs.iputils ];
        script = ''
          has_internet () {
            ping -q -w 1 -c 1 8.8.8.8 >/dev/null
          }

          has_company_network () {
            ping -q -w 1 -c 1 ${cfg.checkURL} >/dev/null
          }

          is_active_wsl-vpnkit () {
            systemctl is-active -q wsl-vpnkit.service
          }

          main () {
            if is_active_wsl-vpnkit; then
              if has_internet && ! has_company_network; then
                echo "Stopping wsl-vpnkit..."
                systemctl stop wsl-vpnkit.service
              fi
            else
              if ! has_internet; then
                echo "Starting wsl-vpnkit..."
                systemctl start wsl-vpnkit.service
              fi
            fi
          }

          while :
          do
            main
            sleep 5
          done
        '';

        wantedBy = [ "multi-user.target" ];
      };

      wsl-vpnkit = {
        enable = true;
        description = "wsl-vpnkit";

        serviceConfig = {
          ExecStart = "${pkgs.wsl-vpnkit}/bin/wsl-vpnkit";
          Type = "idle";
          Restart = "always";
          KillMode = "mixed";
        };
      };
    };
  };
}
