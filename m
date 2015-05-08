From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] x86: replace cpu_up hard-coded mdelay with variable udelay
Date: Fri,  8 May 2015 02:37:54 -0400
Message-ID: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
References: <1431067075-11449-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f53.google.com ([209.85.216.53]:44977 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbbEHGiT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 8 May 2015 02:38:19 -0400
In-Reply-To: <1431067075-11449-1-git-send-email-lenb@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Replace the hard-coded mdelay(10) in cpu_up() to a variable udelay.

Add a boot-time override, "cpu_init_udelay=N"

Default unchanged at 10ms on all systems.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/smpboot.c           | 28 +++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bfcb1a6..0a16309 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -737,6 +737,12 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
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
index febc6aa..76734f4 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -517,6 +517,32 @@ void __inquire_remote_apic(int apicid)
 }
 
 /*
+ * The Multiprocessor Specification 1.4 (1997) example code suggests
+ * that there should be a 10ms delay between the BSP asserting INIT
+ * and de-asserting INIT, when starting a remote processor.
+ * But that slows boot and resume on modern processors, which include
+ * many cores and don't require that delay.
+ *
+ * cmdline "init_cpu_udelay=" is available to specify this delay.
+ */
+#define UDELAY_10MS_DEFAULT 10000
+
+static unsigned int init_udelay = UDELAY_10MS_DEFAULT;
+
+static int __init cpu_init_udelay(char *str)
+{
+	unsigned int new_udelay;
+
+	get_option(&str, &new_udelay);
+	pr_debug("cpu_init_udelay=%d, was %d", new_udelay, init_udelay);
+	init_udelay = new_udelay;
+
+	return 0;
+}
+
+early_param("cpu_init_udelay", cpu_init_udelay);
+
+/*
  * Poke the other CPU in the eye via NMI to wake it up. Remember that the normal
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
  * won't ... remember to clear down the APIC, etc later.
@@ -586,7 +612,7 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 	pr_debug("Waiting for send to finish...\n");
 	send_status = safe_apic_wait_icr_idle();
 
-	mdelay(10);
+	udelay(init_udelay);
 
 	pr_debug("Deasserting INIT\n");
 
-- 
2.4.0.rc1

