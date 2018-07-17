From: Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH] cpufreq: qcom-kryo: Silently error out on EPROBE_DEFER
Date: Tue, 17 Jul 2018 22:48:21 +0200
Message-ID: <20180717204821.15987-1-niklas.cassel@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilia Lin <ilia.lin@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If of_nvmem_cell_get() fails due to probe deferal, we shouldn't print an
error message. Just be silent in this case.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 29389accf3e9..b8d1e6875f16 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -109,8 +109,9 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
 	of_node_put(np);
 	if (IS_ERR(speedbin_nvmem)) {
-		dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
-			PTR_ERR(speedbin_nvmem));
+		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
+				PTR_ERR(speedbin_nvmem));
 		return PTR_ERR(speedbin_nvmem);
 	}
 
-- 
2.17.1
