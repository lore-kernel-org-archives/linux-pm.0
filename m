From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH] cpupower: fix potential memory leak
Date: Fri, 29 Apr 2016 09:00:14 +0200
Message-ID: <1461913214-15900-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33030 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751910AbcD2HAa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 29 Apr 2016 03:00:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, arjun024@gmail.com, trenn@suse.com

From: Arjun Sreedharan <arjun024@gmail.com>

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/bench/parse.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index 2d09c92..9b65f05 100644
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
 
@@ -88,13 +88,15 @@ FILE *prepare_output(const char *dirname)
 
 	if (uname(&sysdata) == 0) {
 		len += strlen(sysdata.nodename) + strlen(sysdata.release);
-		filename = realloc(filename, sizeof(char) * len);
+		filename_tmp = realloc(filename, sizeof(*filename) * len);
 
-		if (!filename) {
+		if (filename_tmp == NULL) {
+			free(filename);
 			perror("realloc");
 			goto out_dir;
 		}
 
+		filename = filename_tmp;
 		snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
 			dirname, sysdata.nodename, sysdata.release, time(NULL));
 	} else {
-- 
2.1.4

