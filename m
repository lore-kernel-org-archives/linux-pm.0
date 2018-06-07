From: ilia.lin@gmail.com
Subject: [PATCH] cpufreq: kryo: Add module remove and exit
Date: Thu,  7 Jun 2018 20:58:26 +0000
Message-ID: <20180607205827.1588-1-ilia.lin@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilia.lin@gmail.com>, Ilia Lin <ilialin@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

Add device remove and module exit code to make the driver
functioning as a loadable module.

Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index d049fe4b80c4..a08de0253169 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -71,10 +71,10 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
+struct platform_device *cpufreq_dt_pdev;
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
 	struct opp_table *opp_tables[NR_CPUS] = {0};
-	struct platform_device *cpufreq_dt_pdev;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
@@ -162,8 +164,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(cpufreq_dt_pdev);
+	return 0;
+}
+
 static struct platform_driver qcom_cpufreq_kryo_driver = {
 	.probe = qcom_cpufreq_kryo_probe,
+	.remove = qcom_cpufreq_kryo_remove,
 	.driver = {
 		.name = "qcom-cpufreq-kryo",
 	},
@@ -174,6 +183,7 @@ static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", },
 };
 
+struct platform_device *kryo_cpufreq_pdev;
 /*
  * Since the driver depends on smem and nvmem drivers, which may
  * return EPROBE_DEFER, all the real activity is done in the probe,
@@ -198,8 +208,9 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (unlikely(ret < 0))
 		return ret;
 
-	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0));
+	kryo_cpufreq_pdev = platform_device_register_simple(
+		"qcom-cpufreq-kryo", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
@@ -208,5 +219,12 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
+static void __init qcom_cpufreq_kryo_exit(void)
+{
+	platform_device_unregister(kryo_cpufreq_pdev);
+	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+}
+module_exit(qcom_cpufreq_kryo_exit);
+
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0
