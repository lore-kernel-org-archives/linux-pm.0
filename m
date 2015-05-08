From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] x86: remove 10ms delay from cpu_up() on modern processors
Date: Fri,  8 May 2015 13:48:07 -0400
Message-ID: <8cfb5aaffa494a62f67af45d952bf02a1c8c718b.1431106775.git.len.brown@intel.com>
References: <1431107287-22022-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431107287-22022-1-git-send-email-lenb@kernel.org>
In-Reply-To: <3f51dfd7de5bf660b62d01216edce41b0904fddf.1431106775.git.len.brown@intel.com>
References: <3f51dfd7de5bf660b62d01216edce41b0904fddf.1431106775.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Modern processor familes do not require the 10ms delay
in cpu_up() to de-assert INIT.  This speeds up boot
and resume by 10ms per (application) processor.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0ddc28b..3ab3df5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -524,6 +524,7 @@ void __inquire_remote_apic(int apicid)
  * many cores and don't require that delay.
  *
  * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
+ * Modern processor families are quirked to remove the delay entirely.
  */
 #define UDELAY_10MS_DEFAULT 10000
 
@@ -537,6 +538,18 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
+static void __init smp_quirk_init_udelay(void)
+{
+	/* if cmdline changed it from default, leave it alone */
+	if (init_udelay != UDELAY_10MS_DEFAULT)
+		return;
+
+	/* if modern processor, use no delay */
+	if (((boot_cpu_data.x86_vendor == X86_VENDOR_INTEL) && (boot_cpu_data.x86 == 6)) ||
+	    ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) && (boot_cpu_data.x86 >= 0xF)))
+		init_udelay = 0;
+}
+
 /*
  * Poke the other CPU in the eye via NMI to wake it up. Remember that the normal
  * INIT, INIT, STARTUP sequence will reset the chip hard for us, and this
@@ -1191,6 +1204,8 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 		uv_system_init();
 
 	set_mtrr_aps_delayed_init();
+
+	smp_quirk_init_udelay();
 }
 
 void arch_enable_nonboot_cpus_begin(void)
-- 
2.4.0.rc1
