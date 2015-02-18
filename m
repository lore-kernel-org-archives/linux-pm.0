From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH 1/8] tools/thermal: tmon: add --target-temp parameter
Date: Tue, 17 Feb 2015 18:18:29 -0800
Message-ID: <1424225916-13488-2-git-send-email-computersforpeace@gmail.com>
References: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424225916-13488-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, jacob.jun.pan@linux.intel.com
Cc: Neil Horman <nhorman@tuxdriver.com>, Brian Norris <computersforpeace@gmail.com>, Javi Merino <javi.merino@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If we launch in daemon mode (--daemon), we don't have the ncurses UI,
but we might want to set the target temperature still. For example,
someone might stick the following in their boot script:

  tmon --control intel_powerclamp --target-temp 90 --log --daemon

This would turn on CPU idle injection when we're around 90 degrees
celsius, and would log temperature and throttling info to
/var/tmp/tmon.log.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 tools/thermal/tmon/tmon.8 |  2 ++
 tools/thermal/tmon/tmon.c | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/tmon/tmon.8 b/tools/thermal/tmon/tmon.8
index 0be727cb9892..02d5179803aa 100644
--- a/tools/thermal/tmon/tmon.8
+++ b/tools/thermal/tmon/tmon.8
@@ -55,6 +55,8 @@ The \fB-l --log\fP option write data to /var/tmp/tmon.log
 .PP
 The \fB-t --time-interval\fP option sets the polling interval in seconds
 .PP
+The \fB-T --target-temp\fP option sets the initial target temperature
+.PP
 The \fB-v --version\fP option shows the version of \fBtmon \fP
 .PP
 The \fB-z --zone\fP option sets the target therma zone instance to be controlled
diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 09b7c3218334..9aa19652e8e8 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -64,6 +64,7 @@ void usage()
 	printf("  -h, --help            show this help message\n");
 	printf("  -l, --log             log data to /var/tmp/tmon.log\n");
 	printf("  -t, --time-interval   sampling time interval, > 1 sec.\n");
+	printf("  -T, --target-temp     initial target temperature\n");
 	printf("  -v, --version         show version\n");
 	printf("  -z, --zone            target thermal zone id\n");
 
@@ -219,6 +220,7 @@ static struct option opts[] = {
 	{ "control", 1, NULL, 'c' },
 	{ "daemon", 0, NULL, 'd' },
 	{ "time-interval", 1, NULL, 't' },
+	{ "target-temp", 1, NULL, 'T' },
 	{ "log", 0, NULL, 'l' },
 	{ "help", 0, NULL, 'h' },
 	{ "version", 0, NULL, 'v' },
@@ -231,7 +233,7 @@ int main(int argc, char **argv)
 {
 	int err = 0;
 	int id2 = 0, c;
-	double yk = 0.0; /* controller output */
+	double yk = 0.0, temp; /* controller output */
 	int target_tz_index;
 
 	if (geteuid() != 0) {
@@ -239,7 +241,7 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	while ((c = getopt_long(argc, argv, "c:dlht:vgz:", opts, &id2)) != -1) {
+	while ((c = getopt_long(argc, argv, "c:dlht:T:vgz:", opts, &id2)) != -1) {
 		switch (c) {
 		case 'c':
 			no_control = 0;
@@ -254,6 +256,14 @@ int main(int argc, char **argv)
 			if (ticktime < 1)
 				ticktime = 1;
 			break;
+		case 'T':
+			temp = strtod(optarg, NULL);
+			if (temp < 0) {
+				fprintf(stderr, "error: temperature must be positive\n");
+				return 1;
+			}
+			target_temp_user = temp;
+			break;
 		case 'l':
 			printf("Logging data to /var/tmp/tmon.log\n");
 			logging = 1;
-- 
1.9.1
