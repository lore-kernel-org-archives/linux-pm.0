From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 03/13] soc: samsung: pmu: Remove messages for failed memory
 allocation
Date: Tue, 17 Jan 2017 13:44:34 +0100
Message-ID: <1484657084-26227-4-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124458eucas1p10463c19d77a501284c7302c3b848fecc@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

Memory subsystem already prints message about failed memory
allocation, there is no need to do it in the driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 1f914e63dcc6..813df6e7292d 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -117,10 +117,8 @@ static int exynos_pmu_probe(struct platform_device *pdev)
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
