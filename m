From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] x86: Add cmdline "cpu_init_udelay=N" to specify cpu_up() delay
Date: Mon, 11 May 2015 17:06:47 -0400
Message-ID: <98c0dd8b8d5516124418cf4c1bf6c2e3630d7d8b.1431378048.git.len.brown@intel.com>
References: <1431378408-5840-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:36353 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932368AbbEKVG5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 17:06:57 -0400
In-Reply-To: <1431378408-5840-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

No change to default behavior.

Replace the hard-coded mdelay(10) in cpu_up() with a variable udelay,
that is set to a defined default -- rather than a magic number.

Add a boot-time override, "cpu_init_udelay=N"

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/smpboot.c           | 23 ++++++++++++++++++++++-
 arch/x86/kernel/smpboot.c.rej       | 11 +++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/smpboot.c.rej

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 61ab162..a320a41 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -746,6 +746,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
+	cpu_init_udelay=N
+			[X86] Delay for N microsec between assert and de-assert
+			of APIC INIT to start processors.  This delay occurs
+			on every CPU online, such as boot, and resume from suspend.
+			Default: 10000
+
 	cpcihp_generic=	[HW,PCI] Generic port I/O CompactPCI driver
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 51203f6..0629a8e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -514,6 +514,27 @@ void __inquire_remote_apic(int apicid)
 }
 
 /*
+ * The Multiprocessor Specification 1.4 (1997) example code suggests
+ * that there should be a 10ms delay between the BSP asserting INIT
+ * and de-asserting INIT, when starting a remote processor.
+ * But that slows boot and resume on modern processors, which include
+ * many cores and don't require that delay.
+ *
+ * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
+ */
+#define UDELAY_10MS_DEFAULT 10000
+
+static unsigned int init_udelay = UDELAY_10MS_DEFAULT;
+
+static int __init cpu_init_udelay(char *str)
+{
+	get_option(&str, &init_udelay);
+
+	return 0;
+}
+early_param("cpu_init_udelay", cpu_init_udelay);
+
+/*
  * Poke the other CPU in the eye via NMI to wake it up. Remember that the normal
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
  * won't ... remember to clear down the APIC, etc later.
@@ -584,7 +605,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		pr_debug("Waiting for send to finish...\n");
 		send_status = safe_apic_wait_icr_idle();
 
-		mdelay(10);
+		mdelay(init_udelay);
 
 		pr_debug("Deasserting INIT\n");
 
diff --git a/arch/x86/kernel/smpboot.c.rej b/arch/x86/kernel/smpboot.c.rej
new file mode 100644
index 0000000..ccf0bd0
--- /dev/null
+++ b/arch/x86/kernel/smpboot.c.rej
@@ -0,0 +1,11 @@
+--- arch/x86/kernel/smpboot.c
++++ arch/x86/kernel/smpboot.c
+@@ -607,7 +628,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
+ 	pr_debug("Waiting for send to finish...\n");
+ 	send_status = safe_apic_wait_icr_idle();
+ 
+-	mdelay(10);
++	udelay(init_udelay);
+ 
+ 	pr_debug("Deasserting INIT\n");
+ 
-- 
2.4.0.rc1

