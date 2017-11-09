From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/1] intel_idle: Graceful probe failure when MWAIT is disabled
Date: Thu,  9 Nov 2017 02:19:39 -0500
Message-ID: <3739abd83907f97dff53be4303336d4b7f5d0ea9.1510211872.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:53611 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdKIHTr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2017 02:19:47 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, jacob.jun.pan@linux.intel.com
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

When MWAIT is disabled, intel_idle refuses to probe.
But it may mis-lead the user by blaming this on the model number:

intel_idle: does not run on family 6 modesl 79

So defer the check for MWAIT until after the model# white-list check succeeds,
and if the MWAIT check fails, tell the user how to fix it:

intel_idle: Please enable MWAIT in BIOS SETUP

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/intel_idle.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f0b06b14e782..16249b0953ff 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1061,7 +1061,7 @@ static const struct idle_cpu idle_cpu_dnv = {
 };
 
 #define ICPU(model, cpu) \
-	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_MWAIT, (unsigned long)&cpu }
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (unsigned long)&cpu }
 
 static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_NEHALEM_EP,		idle_cpu_nehalem),
@@ -1125,6 +1125,11 @@ static int __init intel_idle_probe(void)
 		return -ENODEV;
 	}
 
+	if (!boot_cpu_has(X86_FEATURE_MWAIT)) {
+		pr_debug("Please enable MWAIT in BIOS SETUP\n");
+		return -ENODEV;
+	}
+
 	if (boot_cpu_data.cpuid_level < CPUID_MWAIT_LEAF)
 		return -ENODEV;
 
-- 
2.14.0-rc0
