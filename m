From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] cpupower: fix potential memory leak
Date: Sat, 22 Aug 2015 17:31:02 +0530
Message-ID: <1440244862-7255-1-git-send-email-arjun024@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
---
 tools/power/cpupower/bench/parse.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index f503fb5..058a351 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -65,7 +65,7 @@ FILE *prepare_output(const char *dirname)
 {
 	FILE *output = NULL;
 	int len;
-	char *filename;
+	char *filename, *filename_tmp;
 	struct utsname sysdata;
 	DIR *dir;
 
@@ -80,17 +80,19 @@ FILE *prepare_output(const char *dirname)
 	}
 
 	len = strlen(dirname) + 30;
-	filename = malloc(sizeof(char) * len);
+	filename = malloc(sizeof(*filename) * len);
 
 	if (uname(&sysdata) == 0) {
 		len += strlen(sysdata.nodename) + strlen(sysdata.release);
-		filename = realloc(filename, sizeof(char) * len);
+		filename_tmp = realloc(filename, sizeof(*filename) * len);
 
-		if (filename == NULL) {
+		if (filename_tmp == NULL) {
+			free(filename);
 			perror("realloc");
 			return NULL;
 		}
 
+		filename = filename_tmp;
 		snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
 			dirname, sysdata.nodename, sysdata.release, time(NULL));
 	} else {
-- 
2.4.5
