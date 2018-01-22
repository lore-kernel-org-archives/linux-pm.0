From: davidwang <davidwang@zhaoxin.com>
Subject: [PATCH] x86/centaur: Mark TSC invariant
Date: Mon, 22 Jan 2018 18:14:17 +0800
Message-ID: <1516616057-5158-1-git-send-email-davidwang@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:14808 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750890AbeAVK3t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jan 2018 05:29:49 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, davidwang <davidwang@zhaoxin.com>

Centaur CPU has a constant frequency TSC and that TSC does not stop in
C-States. But because the flags are not set for that CPU, the TSC is
treated as not constant frequency and assumed to stop in C-States, which
makes it an unreliable and unusable clock source. Setting those flags
tells the kernel that the TSC is usable, so it will select it over HPET.
The effect of this is that reading time stamps (from kernel or user space)
will be faster and more efficent.

Signed-off-by: davidwang <davidwang@zhaoxin.com>
---
 arch/x86/kernel/cpu/centaur.c | 4 ++++
 drivers/acpi/processor_idle.c | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 68bc6d9..c578cd2 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -106,6 +106,10 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_64
 	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
 #endif
+	if (c->x86_power & (1 << 8)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	}
 }
 
 static void init_centaur(struct cpuinfo_x86 *c)
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index d50a7b6..5f0071c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -207,6 +207,7 @@ static void tsc_check_state(int state)
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
 	case X86_VENDOR_INTEL:
+	case X86_VENDOR_CENTAUR:
 		/*
 		 * AMD Fam10h TSC will tick in all
 		 * C/P/S0/S1 states when this bit is set.
-- 
1.9.1
