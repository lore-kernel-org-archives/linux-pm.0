From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: [RFC PATCH 4/9] cpufreq: qcom: support qcs404 on nvmem driver
Date: Thu,  4 Apr 2019 07:09:25 +0200
Message-ID: <20190404050931.9812-5-niklas.cassel@linaro.org>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404050931.9812-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 366c65a7132a..7fdc38218390 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
@@ -79,6 +80,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 	return version;
 }
 
+static int qcom_cpufreq_qcs404_name_version(struct device *cpu_dev,
+					    struct nvmem_cell *speedbin_nvmem,
+					    struct qcom_cpufreq_drv *drv)
+{
+	return 0;
+}
+
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
 					  struct qcom_cpufreq_drv *drv)
@@ -191,6 +199,14 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			dev_err(cpu_dev, "Failed to set supported hardware\n");
 			goto free_opp;
 		}
+
+		ret = dev_pm_domain_attach(cpu_dev, false);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				goto free_opp;
+			dev_err(cpu_dev, "Could not attach to pm_domain: %d\n",
+				ret);
+		}
 	}
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
@@ -247,6 +263,8 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	  .data = qcom_cpufreq_kryo_name_version },
 	{ .compatible = "qcom,msm8996",
 	  .data = qcom_cpufreq_kryo_name_version },
+	{ .compatible = "qcom,qcs404",
+	  .data = qcom_cpufreq_qcs404_name_version },
 	{},
 };
 
-- 
2.20.1
