From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 01/11] EDAC, sb_edac: Use Intel family processor macros
Date: Thu, 13 Oct 2016 17:30:55 +0200
Message-ID: <20161013153105.2517-2-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:26433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754221AbcJMPbW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Oct 2016 11:31:22 -0400
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

Use macros of Intel processor families instead of raw numbers.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
---
 drivers/edac/sb_edac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index ce0067b..90564bc 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -23,6 +23,7 @@
 #include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
 
@@ -3366,12 +3367,12 @@ fail0:
 	{ X86_VENDOR_INTEL, 6, model, 0, (unsigned long)&table }
 
 static const struct x86_cpu_id sbridge_cpuids[] = {
-	ICPU(0x2d, pci_dev_descr_sbridge_table),	/* SANDY_BRIDGE */
-	ICPU(0x3e, pci_dev_descr_ibridge_table),	/* IVY_BRIDGE */
-	ICPU(0x3f, pci_dev_descr_haswell_table),	/* HASWELL */
-	ICPU(0x4f, pci_dev_descr_broadwell_table),	/* BROADWELL */
-	ICPU(0x56, pci_dev_descr_broadwell_table),	/* BROADWELL-DE */
-	ICPU(0x57, pci_dev_descr_knl_table),		/* KNIGHTS_LANDING */
+	ICPU(INTEL_FAM6_SANDYBRIDGE_X, pci_dev_descr_sbridge_table),
+	ICPU(INTEL_FAM6_IVYBRIDGE_X, pci_dev_descr_ibridge_table),
+	ICPU(INTEL_FAM6_HASWELL_X, pci_dev_descr_haswell_table),
+	ICPU(INTEL_FAM6_BROADWELL_X, pci_dev_descr_broadwell_table),
+	ICPU(INTEL_FAM6_BROADWELL_XEON_D, pci_dev_descr_broadwell_table),
+	ICPU(INTEL_FAM6_XEON_PHI_KNL, pci_dev_descr_knl_table),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
-- 
2.10.1

