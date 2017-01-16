From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 03/12] soc: samsung: pmu: Remove messages for failed memory
 allocation
Date: Mon, 16 Jan 2017 07:44:58 +0100
Message-ID: <1484549107-5957-4-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064524eucas1p164e0f5bd1252e8599bf2570851772493@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Memory subsystem already prints message about failed memory
allocation, there is no need to do it in the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 0f4b4fce9d90..43937a3aea28 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -106,10 +106,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 	pmu_context = devm_kzalloc(&pdev->dev,
 			sizeof(struct exynos_pmu_context),
 			GFP_KERNEL);
-	if (!pmu_context) {
-		dev_err(dev, "Cannot allocate memory.\n");
+	if (!pmu_context)
 		return -ENOMEM;
-	}
 	pmu_context->dev = dev;
 	pmu_context->pmu_data = of_device_get_match_data(dev);
 
-- 
1.9.1

