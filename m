From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 6/9] cpupower: If root, try to load msr driver on x86 if /dev/cpu/0/msr is not avail
Date: Tue, 13 May 2014 12:41:43 +0200
Message-ID: <1399977706-50854-7-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760304AbaEMKlx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:53 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/cpupower.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
index 7efc570..7cdcf88 100644
--- a/tools/power/cpupower/utils/cpupower.c
+++ b/tools/power/cpupower/utils/cpupower.c
@@ -12,6 +12,9 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
 
 #include "builtin.h"
 #include "helpers/helpers.h"
@@ -169,6 +172,8 @@ int main(int argc, const char *argv[])
 {
 	const char *cmd;
 	unsigned int i, ret;
+	struct stat statbuf;
+	struct utsname uts;
 
 	cpus_chosen = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
 
@@ -195,6 +200,15 @@ int main(int argc, const char *argv[])
 
 	get_cpu_info(0, &cpupower_cpu_info);
 	run_as_root = !getuid();
+	if (run_as_root) {
+		ret = uname(&uts);
+		if (!ret && !strcmp(uts.machine, "x86_64") &&
+		    stat("/dev/cpu/0/msr", &statbuf) != 0) {
+			if (system("modprobe msr") == -1)
+	fprintf(stderr, _("MSR access not available.\n"));
+		}
+	}
+		
 
 	for (i = 0; i < ARRAY_SIZE(commands); i++) {
 		struct cmd_struct *p = commands + i;
-- 
1.7.6.1

