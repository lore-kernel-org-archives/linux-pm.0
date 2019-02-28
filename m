From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3] cpufreq: kryo: Release OPP tables on module removal
Date: Thu, 28 Feb 2019 09:40:12 +0530
Message-ID: <0334906c06967142c8805fbe88acf787f65d3d26.1551326937.git.viresh.kumar@linaro.org>
References: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
Sender: stable-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org, georgi.djakov@linaro.org, "4 . 18+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Commit 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit") made
it possible to build the kryo cpufreq driver as a module, but it failed
to release all the resources, i.e. OPP tables, when the module is
unloaded.

This patch fixes it by releasing the OPP tables, by calling
dev_pm_opp_put_supported_hw() for them, from the
qcom_cpufreq_kryo_remove() routine. The array of pointers to the OPP
tables is also allocated dynamically now in qcom_cpufreq_kryo_probe(),
as the pointers will be required while releasing the resources.

Compile tested only.

Cc: 4.18+ <stable@vger.kernel.org> # v4.18+
Fixes: 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit")
Reviewed-by: Georgi Djakov <georgi.djakov@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- s/kyro/kryo/
- s/unsigned/unsigned int/
- Added Reviewed-by tag

 drivers/cpufreq/qcom-cpufreq-kryo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..a472b814058f 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	struct opp_table **opp_tables;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	}
 	kfree(speedbin);
 
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
@@ -151,8 +155,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
-	if (!IS_ERR(cpufreq_dt_pdev))
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
 		return 0;
+	}
 
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
@@ -163,13 +169,23 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 			break;
 		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
 	}
+	kfree(opp_tables);
 
 	return ret;
 }
 
 static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
 {
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned int cpu;
+
 	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
 	return 0;
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b
