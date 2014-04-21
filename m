From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 3/4] exynos: cpuidle: do not allow cpuidle registration for Exynos5420
Date: Mon, 21 Apr 2014 17:19:17 +0530
Message-ID: <1398080958-21677-4-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398080958-21677-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, daniel.lezcano@linaro.org, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>
List-Id: linux-pm@vger.kernel.org

Exynos5420 is big.Little Soc. It uses cpuidle-big-litle generic cpuidle driver.
Hence do not allow exynos cpuidle driver registration for Exynos5420.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index c57cae0..242f75d 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -219,6 +219,9 @@ static int exynos_cpuidle_probe(struct platform_device *pdev)
 	int cpu_id, ret;
 	struct cpuidle_device *device;
 
+	if (soc_is_exynos5420())
+		return -ENODEV;
+
 	if (soc_is_exynos5250())
 		exynos5_core_down_clk();
 
-- 
1.7.9.5
