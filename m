From: Len Brown <lenb@kernel.org>
Subject: [PATCH] cpufreq: Add the "cpufreq.off=1" cmdline option
Date: Tue, 28 Feb 2017 16:44:16 -0500
Message-ID: <5fd2c737538635f032e8cfa115c802145f0a9911.1488318151.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34413 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbdB1VrM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Feb 2017 16:47:12 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Add the "cpufreq.off=1" cmdline option.

At boot-time, this allows a user to request CONFIG_CPU_FREQ=n
behavior from a kernel built with CONFIG_CPU_FREQ=y.

This is analogous to the existing "cpuidle.off=1" option
and CONFIG_CPU_IDLE=y

This capability is valuable when we need to debug end-user
issues in the BIOS or in Linux.  It is also convenient
for enabling comparisons, which may otherwise require a new kernel,
or help from BIOS SETUP, which may be buggy or unavailable.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 +++
 drivers/cpufreq/cpufreq.c                       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index be7c0d9506b1..3988d2311f97 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -662,6 +662,9 @@
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
+	cpufreq.off=1	[CPU_FREQ]
+			disable the cpufreq sub-system
+
 	cpu_init_udelay=N
 			[X86] Delay for N microsec between assert and de-assert
 			of APIC INIT to start processors.  This delay occurs
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cc475eff90b3..1c90782e3e11 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2543,4 +2543,5 @@ static int __init cpufreq_core_init(void)
 
 	return 0;
 }
+module_param(off, int, 0444);
 core_initcall(cpufreq_core_init);
-- 
2.11.0.161.g6610af872
