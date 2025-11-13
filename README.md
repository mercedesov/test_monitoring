
# Process Monitoring Script

The script monitors `test` process and every 60 sec does the following:
- Checks that the process is running
- If so – HTTP requests `https://test.com/monitoring/test/api`
- If the process was restarted it's written to the log (/var/log/monitoring.log)
- If the process is unavailable it's written to the log

## Install

1. Clone repo 
2. Make executable: `chmod +x monitor_test.sh`
3. Copy `monitor_test.service` and `monitor_test.timer` in `/etc/systemd/system/`
4. Run:

```bash
sudo systemctl daemon-reload
sudo systemctl enable monitor_test.timer
sudo systemctl start monitor_test.timer
