From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 11/13] thermal: convert exynos to use
 devm_thermal_zone_of_sensor_register
Date: Wed,  9 Mar 2016 13:35:33 -0800
Message-ID: <1457559336-17652-12-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, linux-samsung-soc@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index fa61eff..256039e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1363,8 +1363,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	 * data->tzd must be registered before calling exynos_tmu_initialize(),
 	 * requesting irq and calling exynos_tmu_control().
 	 */
-	data->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
-						    &exynos_sensor_ops);
+	data->tzd = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, data,
+							 &exynos_sensor_ops);
 	if (IS_ERR(data->tzd)) {
 		ret = PTR_ERR(data->tzd);
 		dev_err(&pdev->dev, "Failed to register sensor: %d\n", ret);
@@ -1374,21 +1374,19 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	ret = exynos_tmu_initialize(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to initialize TMU\n");
-		goto err_thermal;
+		goto err_sclk;
 	}
 
 	ret = devm_request_irq(&pdev->dev, data->irq, exynos_tmu_irq,
 		IRQF_TRIGGER_RISING | IRQF_SHARED, dev_name(&pdev->dev), data);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request irq: %d\n", data->irq);
-		goto err_thermal;
+		goto err_sclk;
 	}
 
 	exynos_tmu_control(pdev, true);
 	return 0;
 
-err_thermal:
-	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk:
@@ -1406,9 +1404,7 @@ err_sensor:
 static int exynos_tmu_remove(struct platform_device *pdev)
 {
 	struct exynos_tmu_data *data = platform_get_drvdata(pdev);
-	struct thermal_zone_device *tzd = data->tzd;
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, tzd);
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-- 
2.1.4
