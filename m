From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v2 1/9] [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
Date: Mon, 14 Jan 2019 15:51:03 +0530
Message-ID: <2ae45b9263f51a14a7f672f40da2193caf174971.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

(Resent to allow people testing the series to test it easily)

subsys_initcall causes problems registering the driver as a thermal
cooling device.

If "faster boot" is the main reason for doing subsys_initcall, this
should be handled in the bootloader or another boot constraint
framework.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4..649dddd72749 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -296,7 +296,7 @@ static int __init qcom_cpufreq_hw_init(void)
 {
 	return platform_driver_register(&qcom_cpufreq_hw_driver);
 }
-subsys_initcall(qcom_cpufreq_hw_init);
+device_initcall(qcom_cpufreq_hw_init);
 
 static void __exit qcom_cpufreq_hw_exit(void)
 {
-- 
2.17.1
