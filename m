From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] x86 thermal: Disable power limit notification interrupt by default
Date: Tue, 21 May 2013 15:35:17 -0400
Message-ID: <23719540e936bae5539df52172ada2cf208f6440.1368740425.git.len.brown@intel.com>
References: <1368741246-3998-1-git-send-email-lenb@kernel.org>
 <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45519 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3EUTfb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2013 15:35:31 -0400
Received: by mail-qc0-f174.google.com with SMTP id m16so590103qcq.5
        for <linux-pm@vger.kernel.org>; Tue, 21 May 2013 12:35:30 -0700 (PDT)
In-Reply-To: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
In-Reply-To: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
References: <f0a8f9faefa8da662d5450ea90db7e8e4d943e25.1368740425.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>

From: Fenghua Yu <fenghua.yu@intel.com>

The package power limit notification interrupt is primarily for
system diagnosis, and should not be blindly enabled on every
system by default -- particuarly since Linux does nothing in the
handler except count how many times it has been called...

Add a new kernel cmdline parameter "int_pln_enable" for situations where
users want to oberve these events via existing system counters:

$ grep TRM /proc/interrupts

$ grep . /sys/devices/system/cpu/cpu*/thermal_throttle/*

https://bugzilla.kernel.org/show_bug.cgi?id=36182

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt      |  2 ++
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 34 ++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 8ccbf27..217165b 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1130,6 +1130,8 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	inport.irq=	[HW] Inport (ATI XL and Microsoft) busmouse driver
 			Format: <irq>
 
+	int_pln_enable  [x86] Enable power limit notification interrupt
+
 	intel_iommu=	[DMAR] Intel IOMMU driver (DMAR) option
 		on
 			Enable intel iommu driver.
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 68fa890..f7feb2e 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -210,6 +210,15 @@ static int thresh_event_valid(int event)
 	return 1;
 }
 
+static bool int_pln_enable;
+static int __init int_pln_enable_setup(char *s)
+{
+	int_pln_enable = true;
+
+	return 1;
+}
+__setup("int_pln_enable", int_pln_enable_setup);
+
 #ifdef CONFIG_SYSFS
 /* Add/Remove thermal_throttle interface for CPU device: */
 static __cpuinit int thermal_throttle_add_dev(struct device *dev,
@@ -222,7 +231,7 @@ static __cpuinit int thermal_throttle_add_dev(struct device *dev,
 	if (err)
 		return err;
 
-	if (cpu_has(c, X86_FEATURE_PLN))
+	if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
 		err = sysfs_add_file_to_group(&dev->kobj,
 					      &dev_attr_core_power_limit_count.attr,
 					      thermal_attr_group.name);
@@ -230,7 +239,7 @@ static __cpuinit int thermal_throttle_add_dev(struct device *dev,
 		err = sysfs_add_file_to_group(&dev->kobj,
 					      &dev_attr_package_throttle_count.attr,
 					      thermal_attr_group.name);
-		if (cpu_has(c, X86_FEATURE_PLN))
+		if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
 			err = sysfs_add_file_to_group(&dev->kobj,
 					&dev_attr_package_power_limit_count.attr,
 					thermal_attr_group.name);
@@ -343,7 +352,7 @@ static void intel_thermal_interrupt(void)
 				CORE_LEVEL) != 0)
 		mce_log_therm_throt_event(msr_val);
 
-	if (this_cpu_has(X86_FEATURE_PLN))
+	if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
 		therm_throt_process(msr_val & THERM_STATUS_POWER_LIMIT,
 					POWER_LIMIT_EVENT,
 					CORE_LEVEL);
@@ -353,7 +362,7 @@ static void intel_thermal_interrupt(void)
 		therm_throt_process(msr_val & PACKAGE_THERM_STATUS_PROCHOT,
 					THERMAL_THROTTLING_EVENT,
 					PACKAGE_LEVEL);
-		if (this_cpu_has(X86_FEATURE_PLN))
+		if (this_cpu_has(X86_FEATURE_PLN) && int_pln_enable)
 			therm_throt_process(msr_val &
 					PACKAGE_THERM_STATUS_POWER_LIMIT,
 					POWER_LIMIT_EVENT,
@@ -461,9 +470,13 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	apic_write(APIC_LVTTHMR, h);
 
 	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
-	if (cpu_has(c, X86_FEATURE_PLN))
+	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
+		wrmsr(MSR_IA32_THERM_INTERRUPT,
+			(l | (THERM_INT_LOW_ENABLE
+			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
+	else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
 		wrmsr(MSR_IA32_THERM_INTERRUPT,
-		      l | (THERM_INT_LOW_ENABLE
+			l | (THERM_INT_LOW_ENABLE
 			| THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), h);
 	else
 		wrmsr(MSR_IA32_THERM_INTERRUPT,
@@ -471,9 +484,14 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 
 	if (cpu_has(c, X86_FEATURE_PTS)) {
 		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
-		if (cpu_has(c, X86_FEATURE_PLN))
+		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
 			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			      l | (PACKAGE_THERM_INT_LOW_ENABLE
+				(l | (PACKAGE_THERM_INT_LOW_ENABLE
+				| PACKAGE_THERM_INT_HIGH_ENABLE))
+				& ~PACKAGE_THERM_INT_PLN_ENABLE, h);
+		else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+				l | (PACKAGE_THERM_INT_LOW_ENABLE
 				| PACKAGE_THERM_INT_HIGH_ENABLE
 				| PACKAGE_THERM_INT_PLN_ENABLE), h);
 		else
-- 
1.8.3.rc2

