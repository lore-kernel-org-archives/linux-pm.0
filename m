From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 7/8] devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix
 probe fail
Date: Thu, 13 Mar 2014 17:17:28 +0900
Message-ID: <1394698649-20996-8-git-send-email-cw00.choi@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, b.zolnierkie@samsaung.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ijc+devicetree@hellion.org.uk, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch add CONFIG_PM_OPP dependecy to exynos4_bus driver
to fix probe fail as following log:

[    3.721389] exynos4-busfreq busfreq.3: Fail to add opp entries.
[    3.721697] exynos4-busfreq: probe of busfreq.3 failed with error -22

If CONFIG_PM_OPP is disabled, dev_pm_opp_find_freq_floor() in xxx_probe()
will always return -EINVAL error.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 7d2f435..b2de2a1 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -70,6 +70,7 @@ config ARM_EXYNOS4_BUS_DEVFREQ
 	depends on (CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412) && !ARCH_MULTIPLATFORM
 	select ARCH_HAS_OPP
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
+	select PM_OPP
 	help
 	  This adds the DEVFREQ driver for Exynos4210 memory bus (vdd_int)
 	  and Exynos4212/4412 memory interface and bus (vdd_mif + vdd_int).
-- 
1.8.0
