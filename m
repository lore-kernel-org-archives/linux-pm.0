From: Jacob Shin <jacob.shin@amd.com>
Subject: [PATCH 2/2] cpufreq: AMD "frequency sensitivity feedback" powersave bias for ondemand governor
Date: Wed, 27 Mar 2013 17:37:21 -0500
Message-ID: <1364423841-6920-3-git-send-email-jacob.shin@amd.com>
References: <1364423841-6920-1-git-send-email-jacob.shin@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:36774
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754068Ab3C0Wh2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 18:37:28 -0400
In-Reply-To: <1364423841-6920-1-git-send-email-jacob.shin@amd.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jacob Shin <jacob.shin@amd.com>

Future AMD processors, starting with Family 16h, can provide software
with feedback on how the workload may respond to frequency change --
memory-bound workloads will not benefit from higher frequency, where
as compute-bound workloads will. This patch enables this "frequency
sensitivity feedback" to aid the ondemand governor to make better
frequency change decisions by hooking into the powersave bias.

Signed-off-by: Jacob Shin <jacob.shin@amd.com>
---
 arch/x86/include/uapi/asm/msr-index.h |    1 +
 drivers/cpufreq/Kconfig.x86           |   10 ++++++++++
 drivers/cpufreq/Makefile              |    1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/x86/include/uapi/asm/msr-index.h b/arch/x86/include/uapi/asm/msr-index.h
index 7a060f4..b2e6c49 100644
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -173,6 +173,7 @@
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
+#define MSR_AMD64_FREQ_SENSITIVITY	0xc0010080
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD64_DC_CFG		0xc0011022
diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index d7dc0ed..6c714b0 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -129,6 +129,16 @@ config X86_POWERNOW_K8
 
 	  For details, take a look at <file:Documentation/cpu-freq/>.
 
+config X86_AMD_FREQ_SENSITIVITY
+	tristate "AMD 'frequency sensitivity feedback' powersave bias"
+	depends on CPU_FREQ_GOV_ONDEMAND && X86_ACPI_CPUFREQ
+	help
+	  This adds support for 'frequency sensitivity feedback' feature on
+	  supported AMD processors, which hooks into the ondemand governor's
+	  powersave bias to influence frequency change decisions.
+
+	  If in doubt, say N.
+
 config X86_GX_SUSPMOD
 	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
 	depends on X86_32 && PCI
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 863fd18..01dfdaf 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_X86_SPEEDSTEP_CENTRINO)	+= speedstep-centrino.o
 obj-$(CONFIG_X86_P4_CLOCKMOD)		+= p4-clockmod.o
 obj-$(CONFIG_X86_CPUFREQ_NFORCE2)	+= cpufreq-nforce2.o
 obj-$(CONFIG_X86_INTEL_PSTATE)		+= intel_pstate.o
+obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
-- 
1.7.9.5


