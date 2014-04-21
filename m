From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 1/4] cpuidle: config: Add SOC_EXYNOS5420 entry to select cpuidle-big-little driver
Date: Mon, 21 Apr 2014 17:19:15 +0530
Message-ID: <1398080958-21677-2-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos5420 is a big-little SoC from Samsung. It has 4 A15 and 4 A7 cores.
In order to use generic cpuidle-big-little driver, this patch adds Exynos5420
specific check to initialize generic cpuidle driver.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/cpuidle/Kconfig.arm |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 97ccc31..5244d87 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -4,7 +4,7 @@
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
-	depends on ARCH_VEXPRESS_TC2_PM
+	depends on ARCH_VEXPRESS_TC2_PM || SOC_EXYNOS5420
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	help
-- 
1.7.9.5
