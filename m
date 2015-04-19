From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/12] tools/power turbostat: modprobe msr, if needed
Date: Sat, 18 Apr 2015 20:40:22 -0400
Message-ID: <a21d38c846fce05ef55ab240f18fb19755bed16a.1429402554.git.len.brown@intel.com>
References: <1429404027-23203-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33029 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbDSAky (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Apr 2015 20:40:54 -0400
Received: by qgdy78 with SMTP id y78so37942961qgd.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2015 17:40:53 -0700 (PDT)
In-Reply-To: <1429404027-23203-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
References: <1cc21f7b6b747220c29b42cfd1c84b5648d12407.1429402554.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Some distros (Ubuntu) ship the msr driver as a module.
If turbosat is run as root on those systems, and discovers
that there is no /dev/cpu/cpu0/msr, it will now "modprobe msr"
for the user.

If not root, the modprobe attempt will fail, and turbostat will exit as before:

turbostat: no /dev/cpu/0/msr, Try "# modprobe msr" : No such file or directory

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index f05a3f7..50341a3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1528,7 +1528,8 @@ void check_dev_msr()
 	struct stat sb;
 
 	if (stat("/dev/cpu/0/msr", &sb))
-		err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
+ 		if (system("/sbin/modprobe msr > /dev/null 2>&1"))
+			err(-5, "no /dev/cpu/0/msr, Try \"# modprobe msr\" ");
 }
 
 void check_permissions()
@@ -2713,7 +2714,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(stderr, "turbostat version 4.2 23 Mar, 2015"
+	fprintf(stderr, "turbostat version 4.3 24 Mar, 2015"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.4.0.rc1

