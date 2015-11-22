From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] x86 smpboot: re-enable init_udelay=0 by default on modern CPUs
Date: Sun, 22 Nov 2015 18:16:15 -0500
Message-ID: <9082eb809ef40dad02db714759c7aaf618c518d4.1448232494.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:35617 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbbKVXQv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Nov 2015 18:16:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, shrybman@teksavvy.com, dparsons@brightdsl.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Fix a Linux-4.3 performance regression:

commit f1ccd249319e ("x86/smpboot: Fix cpu_init_udelay=10000 corner case
boot parameter misbehavior")
allowed the cmdline  "cpu_init_udelay=" to work
with all values, including the default of 10000.

But in setting the default of 10000, it over-rode
the code stat sets the delay 0 on modern processors.

Also, tidy up use of INT/UINT.

Reported-by: Shane <shrybman@teksavvy.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 892ee2e5..fbabe4f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -509,7 +509,7 @@ void __inquire_remote_apic(int apicid)
  */
 #define UDELAY_10MS_DEFAULT 10000
 
-static unsigned int init_udelay = INT_MAX;
+static unsigned int init_udelay = UINT_MAX;
 
 static int __init cpu_init_udelay(char *str)
 {
@@ -522,14 +522,15 @@ early_param("cpu_init_udelay", cpu_init_udelay);
 static void __init smp_quirk_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
-	if (init_udelay != INT_MAX)
+	if (init_udelay != UINT_MAX)
 		return;
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
-	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF)))
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF))) {
 		init_udelay = 0;
-
+		return;
+	}
 	/* else, use legacy delay */
 	init_udelay = UDELAY_10MS_DEFAULT;
 }
-- 
2.6.3.368.gf34be46

