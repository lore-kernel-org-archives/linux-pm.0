From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] x86 smpboot: fix cpu_init_udelay=10000
Date: Fri, 16 Oct 2015 00:14:28 -0400
Message-ID: <de363cdbbcfcca1d22569683f7eb9873e0177251.1444968087.git.len.brown@intel.com>
References: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f67.google.com ([209.85.192.67]:34384 "EHLO
	mail-qg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbbJPEPG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 Oct 2015 00:15:06 -0400
In-Reply-To: <1444968869-21435-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, shrybman@teksavvy.com, dparsons@brightdsl.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

For legacy machines cpu_init_udelay defaults to 10,000.
For modern machines it is set to 0.

The user should be able to set cpu_init_udelay to
any value on the cmdline, including 10,000.
Before this patch, that was seen as "unchanged from default"
and thus on a modern machine, the user request was ignored
and the delay was set to 0.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index e0c198e..32267cc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -509,7 +509,7 @@ void __inquire_remote_apic(int apicid)
  */
 #define UDELAY_10MS_DEFAULT 10000
 
-static unsigned int init_udelay = UDELAY_10MS_DEFAULT;
+static unsigned int init_udelay = INT_MAX;
 
 static int __init cpu_init_udelay(char *str)
 {
@@ -522,13 +522,16 @@ early_param("cpu_init_udelay", cpu_init_udelay);
 static void __init smp_quirk_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
-	if (init_udelay != UDELAY_10MS_DEFAULT)
+	if (init_udelay != INT_MAX)
 		return;
 
 	/* if modern processor, use no delay */
 	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
 	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF)))
 		init_udelay = 0;
+
+	/* else, use legacy delay */
+	init_udelay = UDELAY_10MS_DEFAULT;
 }
 
 /*
-- 
2.6.1.145.gb27dacc

