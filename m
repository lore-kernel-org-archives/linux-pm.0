From: Arjun Sreedharan <arjun024@gmail.com>
Subject: [PATCH] cpupower: fix potential memory leak
Date: Sun, 14 Feb 2016 13:29:05 +0530
Message-ID: <1455436745-22444-1-git-send-email-arjun024@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34981 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbcBNH7U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Feb 2016 02:59:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

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

