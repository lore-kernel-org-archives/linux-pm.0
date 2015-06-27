From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 11/16] drivers: qcom: spm: Support cache and coherency SPMs
Date: Fri, 26 Jun 2015 21:02:31 -0600
Message-ID: <1435374156-19214-12-git-send-email-lina.iyer@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34951 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbF0DDB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:03:01 -0400
Received: by pdbci14 with SMTP id ci14so84811006pdb.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:03:01 -0700 (PDT)
In-Reply-To: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Recognize non-CPU SPM devices defined in the DT and configure the
corresponding SPM hardware. SPM controllers for L2 controls the cache's
idle low power state and may also be used to turn off the cluster's
power rail.

On multi-cluster SoCs, each cluster would have an SPM for the cache and
an additional coherency level SPM. The coherency SPM turns off or puts
the coherency hardware in idle and any caches present at that level.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 drivers/soc/qcom/spm.c | 75 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index b04b05a..bef2dfe1 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -68,9 +68,17 @@ struct spm_reg_data {
 	u8 start_index[PM_SLEEP_MODE_NR];
 };
 
+struct cluster;
+
 struct spm_driver_data {
 	void __iomem *reg_base;
 	const struct spm_reg_data *reg_data;
+	struct cluster *domain;
+};
+
+/* Group for domain entities */
+struct cluster {
+	struct spm_driver_data *domain_spm;
 };
 
 static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
@@ -116,6 +124,9 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
 
 static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
 
+/* 3 instances: little, big and coherency (cluster of clusters) */
+static struct cluster cpu_domain[3];
+
 typedef int (*idle_fn)(int);
 static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
 
@@ -282,14 +293,26 @@ static struct cpuidle_ops qcom_cpuidle_ops __initdata = {
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v1, "qcom,kpss-acc-v1", &qcom_cpuidle_ops);
 CPUIDLE_METHOD_OF_DECLARE(qcom_idle_v2, "qcom,kpss-acc-v2", &qcom_cpuidle_ops);
 
+/* Match L2 SPM with their affinity level */
+static const struct of_device_id cache_spm_table[] = {
+	{ },
+};
+
 static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
-		int *spm_cpu)
+		int *index, bool *is_domain_spm)
 {
 	struct spm_driver_data *drv = NULL;
-	struct device_node *cpu_node, *saw_node;
+	struct device_node *cpu_node, *saw_node, *cache_node;
 	int cpu;
 	bool found;
+	const struct of_device_id *match_id;
+	int idx;
 
+	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return ERR_PTR(-ENOMEM);
+
+	/* Check for a CPU SPM, if found we are done */
 	for_each_possible_cpu(cpu) {
 		cpu_node = of_cpu_device_node_get(cpu);
 		if (!cpu_node)
@@ -302,10 +325,37 @@ static struct spm_driver_data *spm_get_drv(struct platform_device *pdev,
 			break;
 	}
 
+	/* 
+	 * If found, we have a CPU SPM, if not,
+	 * check if we have a cache SPM
+	 */
 	if (found) {
-		drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_KERNEL);
-		if (drv)
-			*spm_cpu = cpu;
+		/*
+		 * Now that we have our CPU, find the associated L2
+		 * SAW and bind the CPU with the domain that contains
+		 * the L2 SAW.
+		 */
+		cache_node = of_parse_phandle(cpu_node,
+				"next-level-cache", 0);
+		saw_node = of_parse_phandle(cache_node, "qcom,saw", 0);
+		match_id = of_match_node(cache_spm_table, saw_node);
+		if (match_id) {
+			idx = (int) match_id->data;
+			drv->domain = &cpu_domain[idx];
+		}
+		of_node_put(saw_node);
+		of_node_put(cache_node);
+		*index = cpu;
+		*is_domain_spm = false;
+	} else {
+		/* Check if this is a cache SPM */
+		match_id = of_match_node(cache_spm_table, pdev->dev.of_node);
+		if (!match_id) {
+			devm_kfree(&pdev->dev, drv);
+			return ERR_PTR(-ENODEV);
+		}
+		*index = (int) match_id->data;
+		*is_domain_spm = true;
 	}
 
 	return drv;
@@ -327,11 +377,12 @@ static int spm_dev_probe(struct platform_device *pdev)
 	struct resource *res;
 	const struct of_device_id *match_id;
 	void __iomem *addr;
-	int cpu;
+	int index;
+	bool is_domain_spm;
 
-	drv = spm_get_drv(pdev, &cpu);
-	if (!drv)
-		return -EINVAL;
+	drv = spm_get_drv(pdev, &index, &is_domain_spm);
+	if (IS_ERR(drv))
+		return PTR_ERR(drv);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	drv->reg_base = devm_ioremap_resource(&pdev->dev, res);
@@ -366,7 +417,11 @@ static int spm_dev_probe(struct platform_device *pdev)
 	/* Set up Standby as the default low power mode */
 	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
-	per_cpu(cpu_spm_drv, cpu) = drv;
+	/* We are ready to use the CPU/Cache SPM. */
+	if (is_domain_spm)
+		cpu_domain[index].domain_spm = drv;
+	else
+		per_cpu(cpu_spm_drv, index) = drv;
 
 	return 0;
 }
-- 
2.1.4

