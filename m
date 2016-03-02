From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpupower: bench: parse.c: fix several resource leaks
Date: Wed,  2 Mar 2016 16:31:25 +0000
Message-ID: <1456936285-22915-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56568 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcCBQb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 11:31:27 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The error handling in prepare_output has several issues with
resource leaks.  Ensure that filename is free'd and the directory
stream DIR is closed before returning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/power/cpupower/bench/parse.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/bench/parse.c b/tools/power/cpupower/bench/parse.c
index f503fb5..2d09c92 100644
--- a/tools/power/cpupower/bench/parse.c
+++ b/tools/power/cpupower/bench/parse.c
@@ -81,14 +81,18 @@ FILE *prepare_output(const char *dirname)
 
 	len = strlen(dirname) + 30;
 	filename = malloc(sizeof(char) * len);
+	if (!filename) {
+		perror("malloc");
+		goto out_dir;
+	}
 
 	if (uname(&sysdata) == 0) {
 		len += strlen(sysdata.nodename) + strlen(sysdata.release);
 		filename = realloc(filename, sizeof(char) * len);
 
-		if (filename == NULL) {
+		if (!filename) {
 			perror("realloc");
-			return NULL;
+			goto out_dir;
 		}
 
 		snprintf(filename, len - 1, "%s/benchmark_%s_%s_%li.log",
@@ -104,12 +108,16 @@ FILE *prepare_output(const char *dirname)
 	if (output == NULL) {
 		perror("fopen");
 		fprintf(stderr, "error: unable to open logfile\n");
+		goto out;
 	}
 
 	fprintf(stdout, "Logfile: %s\n", filename);
 
-	free(filename);
 	fprintf(output, "#round load sleep performance powersave percentage\n");
+out:
+	free(filename);
+out_dir:
+	closedir(dir);
 	return output;
 }
 
-- 
2.7.0

