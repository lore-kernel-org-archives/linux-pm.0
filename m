From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] thermal: TI: remove TI_THERMAL dependency on CPU_THERMAL
Date: Fri, 04 Oct 2013 14:39:43 +0200
Message-ID: <1412622.ASunnW5zzY@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29250 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab3JDMkh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Oct 2013 08:40:37 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>

Cover cpufreq_get_current_driver() call in ti-thermal-common.c with
CPU_FREQ ifdefs and remove no longer needed CPU_THERMAL dependency
from TI_THERMAL config option (stubs for other cpufreq functions for
CPU_THERMAL=n case are already available).

Please note that this enables TI_THERMAL config option in the final
config derived from omap2plus_defconfig (which enables CPU_THERMAL
config option but without CPU_FREQ one so TI_THERMAL config option
was not enabled previously in the final config).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/thermal/ti-soc-thermal/Kconfig             | 1 -
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/Kconfig b/drivers/thermal/ti-soc-thermal/Kconfig
index bd4c7be..bf5d6e4 100644
--- a/drivers/thermal/ti-soc-thermal/Kconfig
+++ b/drivers/thermal/ti-soc-thermal/Kconfig
@@ -13,7 +13,6 @@ config TI_SOC_THERMAL
 config TI_THERMAL
 	bool "Texas Instruments SoCs thermal framework support"
 	depends on TI_SOC_THERMAL
-	depends on CPU_THERMAL
 	help
 	  If you say yes here you want to get support for generic thermal
 	  framework for the Texas Instruments on die bandgap temperature sensor.
diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
index 4f8b9af..94d91af 100644
--- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -357,10 +357,12 @@ int ti_thermal_register_cpu_cooling(struct ti_bandgap *bgp, int id)
 	if (!data)
 		return -EINVAL;
 
+#ifdef CONFIG_CPU_FREQ
 	if (!cpufreq_get_current_driver()) {
 		dev_dbg(bgp->dev, "no cpufreq driver yet\n");
 		return -EPROBE_DEFER;
 	}
+#endif
 
 	/* Register cooling device */
 	data->cool_dev = cpufreq_cooling_register(cpu_present_mask);
-- 
1.8.2.3


