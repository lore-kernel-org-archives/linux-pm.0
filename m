From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 02/13] soc: samsung: pmu: Use of_device_get_match_data
 helper
Date: Thu, 19 Jan 2017 14:48:42 +0100
Message-ID: <1484833733-16082-3-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134904eucas1p1cc044892728a1716acc2f77f32180c42@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
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

Replace custom code with generic helper to retrieve driver data.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/soc/samsung/exynos-pmu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 5c269bf23210..1f914e63dcc6 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
@@ -105,7 +106,6 @@ struct regmap *exynos_get_pmu_regmap(void)
 
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 
@@ -122,10 +122,7 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	pmu_context->dev = dev;
-
-	match = of_match_node(exynos_pmu_of_device_ids, dev->of_node);
-
-	pmu_context->pmu_data = match->data;
+	pmu_context->pmu_data = of_device_get_match_data(dev);
 
 	if (pmu_context->pmu_data->pmu_init)
 		pmu_context->pmu_data->pmu_init();
-- 
1.9.1
