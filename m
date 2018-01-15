From: TimGuo <timguo@zhaoxin.com>
Subject: [PATCH] x86/centaur: Mark TSC invariant
Date: Mon, 15 Jan 2018 09:35:45 +0800
Message-ID: <1515980145-3693-1-git-send-email-timguo@zhaoxin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:31777 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752259AbeAOBgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jan 2018 20:36:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, mingo@kernel.org, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: brucechang@via-alliance.com, cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, TimGuo <timguo@zhaoxin.com>

Centaur CPU has a constant frequency TSC and that TSC does not stop in C-States.
But because the flags are not set for that CPU, the TSC is treated as non constant
frequency and assumed to stop in C-States, which makes it an unreliable and unusable
clock source. Setting those flags tells the kernel that the TSC is usable, so it
will select it over HPET. The effect of this is that reading time stamps (from kernel
or userspace) will be faster and more efficient.

Signed-off-by: TimGuo <timguo@zhaoxin.com>
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
+       if (c->x86_power & (1 << 8)) {
+               set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+               set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+       }
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
+       case X86_VENDOR_CENTAUR:
                /*
                 * AMD Fam10h TSC will tick in all
                 * C/P/S0/S1 states when this bit is set.
--
1.9.1



保密声明：
本邮件含有保密或专有信息，仅供指定收件人使用。严禁对本邮件或其内容做任何未经授权的查阅、使用、复制或转发。
CONFIDENTIAL NOTE:
This email contains confidential or legally privileged information and is for the sole use of its intended recipient. Any unauthorized review, use, copying or forwarding of this email or the content of this email is strictly prohibited.
