From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 2/5] cpupower: bench: parse.c: fix several resource leaks
Date: Thu, 28 Apr 2016 15:24:37 +0200
Message-ID: <1461849880-24777-2-git-send-email-trenn@suse.com>
References: <1461849880-24777-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33284 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbcD1NYo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 09:24:44 -0400
In-Reply-To: <1461849880-24777-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, trenn@suse.com, Colin Ian King <colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

The error handling in prepare_output has several issues with
resource leaks.  Ensure that filename is free'd and the directory
stream DIR is closed before returning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Thomas Renninger <trenn@suse.com>
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
1.8.5.6

