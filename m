From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] x86: speed cpu_up by quirking cpu_init_udelay
Date: Fri,  8 May 2015 02:37:55 -0400
Message-ID: <170f6f6e9ac4aa4d8ec1ed5000bee95463897337.1431066425.git.len.brown@intel.com>
References: <1431067075-11449-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431067075-11449-1-git-send-email-lenb@kernel.org>
In-Reply-To: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
References: <418898b5b9a6d76e7fbbd2af7cc988de1a5a287d.1431066425.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Modern processor familes are on a white-list to remove
the costly cpu_init_udelay 10000.  Unknown processor families
get the traditional 10ms delay in cpu_up().

This seemed more efficient than forcing modern processors
to exhaustively search a black-list having all the old
processor families that should have a 10ms delay.
For not only are new processor familes infrequently added,
the white list also allows a delay other than 0, if needed.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 76734f4..34a08ff 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -76,6 +76,7 @@
 #include <asm/i8259.h>
 #include <asm/realmode.h>
 #include <asm/misc.h>
+#include <asm/cpu_device_id.h>
 
 /* State of each CPU */
 DEFINE_PER_CPU(int, cpu_state) = { 0 };
@@ -521,14 +522,44 @@ void __inquire_remote_apic(int apicid)
  * that there should be a 10ms delay between the BSP asserting INIT
  * and de-asserting INIT, when starting a remote processor.
  * But that slows boot and resume on modern processors, which include
- * many cores and don't require that delay.
- *
+ * many cores and don't require that delay.  Here we default to the
+ * legacy delay, but quirk new processors to skip the delay.
  * cmdline "init_cpu_udelay=" is available to specify this delay.
  */
 #define UDELAY_10MS_DEFAULT 10000
 
 static unsigned int init_udelay = UDELAY_10MS_DEFAULT;
 
+static const struct x86_cpu_id init_udelay_ids[] = {
+	{ X86_VENDOR_INTEL, 0x6, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x16, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x15, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x14, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x12, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x11, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0x10, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{ X86_VENDOR_AMD, 0xF, X86_MODEL_ANY, X86_FEATURE_ANY, 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, init_udelay_ids);
+
+static void __init smp_quirk_init_udelay(void)
+{
+	const struct x86_cpu_id *id;
+	unsigned int new_udelay;
+
+	id = x86_match_cpu(init_udelay_ids);
+	if (id == NULL)
+		return;	/* if no match, keep default */
+
+	if (init_udelay != UDELAY_10MS_DEFAULT)
+		return;	/* if cmdline changed from default, leave it alone */
+
+	new_udelay = (unsigned long) id->driver_data;
+	pr_debug("cpu_init_udelay quirk to %d, was %d", new_udelay, init_udelay);
+	init_udelay = new_udelay;
+}
+
 static int __init cpu_init_udelay(char *str)
 {
 	unsigned int new_udelay;
@@ -1196,6 +1227,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		uv_system_init();
 
 	set_mtrr_aps_delayed_init();
+
+	smp_quirk_init_udelay();
 }
 
 void arch_enable_nonboot_cpus_begin(void)
-- 
2.4.0.rc1
