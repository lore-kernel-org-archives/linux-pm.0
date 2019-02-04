From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: qcom-kryo: make some variables static
Date: Mon,  4 Feb 2019 01:13:10 -0500
Message-ID: <20190204061310.1211-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The variables are local to the source and do not
need to be in global scope, so make them static.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..1c8583cc06a2 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -42,7 +42,7 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
-struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
+static struct platform_device *cpufreq_dt_pdev, *kryo_cpufreq_pdev;
 
 static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 {
-- 
2.17.0
