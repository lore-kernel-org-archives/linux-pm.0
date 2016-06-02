From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 18/20] x86, thermal: clean up and fix cpu model detection for intel_soc_dts_thermal
Date: Wed, 01 Jun 2016 17:12:22 -0700
Message-ID: <20160602001222.9971AA84@viggo.jf.intel.com>
References: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602001157.D8BE59D7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The X86_FAMILY_ANY in here is bogus.  "BYT" and model 0x37 are
family-6 only.  Simplify the code while we are in here.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org
---

 b/drivers/thermal/intel_soc_dts_thermal.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -puN drivers/thermal/intel_soc_dts_thermal.c~buggy-intel_soc_dts_thermal drivers/thermal/intel_soc_dts_thermal.c
--- a/drivers/thermal/intel_soc_dts_thermal.c~buggy-intel_soc_dts_thermal	2016-06-01 15:45:10.235220153 -0700
+++ b/drivers/thermal/intel_soc_dts_thermal.c	2016-06-01 15:45:10.239220335 -0700
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 #include "intel_soc_dts_iosf.h"
 
 #define CRITICAL_OFFSET_FROM_TJ_MAX	5000
@@ -42,7 +43,8 @@ static irqreturn_t soc_irq_thread_fn(int
 }
 
 static const struct x86_cpu_id soc_thermal_ids[] = {
-	{ X86_VENDOR_INTEL, X86_FAMILY_ANY, 0x37, 0, BYT_SOC_DTS_APIC_IRQ},
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_MODEL_ATOM_SILVERMONT1,
+		0, BYT_SOC_DTS_APIC_IRQ},
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, soc_thermal_ids);
_
