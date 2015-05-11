From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] x86: Add cmdline "cpu_init_udelay=N" to specify cpu_up() delay
Date: Mon, 11 May 2015 17:27:09 -0400
Message-ID: <2fe8e6c798e8def271122f62df9bbf58dc283e2a.1431379433.git.len.brown@intel.com>
References: <1431379630-6716-1-git-send-email-lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431379630-6716-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

No change to default behavior.

Replace the hard-coded mdelay(10) in cpu_up() with a variable udelay,
that is set to a defined default -- rather than a magic number.

Add a boot-time override, "cpu_init_udelay=N"

Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/kernel-parameters.txt |  6 ++++++
 arch/x86/kernel/smpboot.c           | 23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

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
 
-- 
2.4.0.rc1
