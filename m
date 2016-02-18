From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 2/3] thermal: exynos: Use devm_regulator_get_optional() for vtmu
Date: Thu, 18 Feb 2016 15:19:10 -0300
Message-ID: <1455819551-4666-3-git-send-email-javier@osg.samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

The Exynos TMU DT binding says that the vtmu-supply is optional but the
driver uses devm_regulator_get() that creates a dummy regulator if it's
not defined in the DT. For example the following message is in the log:

10060000.tmu supply vtmu not found, using dummy regulator

Use the optional version of regulator_get() that doesn't create a dummy
regulator and instead returns a -ENODEV errno code. Since it's expected
that a regulator may not be defined and the driver will inform about it:

exynos-tmu 10060000.tmu: Regulator node (vtmu) not found

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/thermal/samsung/exynos_tmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 6c6f59ba7423..f4f36bba7be9 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1310,7 +1310,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	 * TODO: Add regulator as an SOC feature, so that regulator enable
 	 * is a compulsory call.
 	 */
-	data->regulator = devm_regulator_get(&pdev->dev, "vtmu");
+	data->regulator = devm_regulator_get_optional(&pdev->dev, "vtmu");
 	if (!IS_ERR(data->regulator)) {
 		ret = regulator_enable(data->regulator);
 		if (ret) {
-- 
2.5.0
