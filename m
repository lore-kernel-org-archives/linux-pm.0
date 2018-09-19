From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: qcom: Fix section attribute for qcom_cpufreq_kryo_exit()
Date: Wed, 19 Sep 2018 14:32:27 -0700
Message-ID: <c0fa33819e4b51a98e6d52e978cd856303d64097.1537392723.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, natechancellor@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is an exit routine and is marked with __init. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index b8d1e6875f16..cb7063797c01 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -221,7 +221,7 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
-static void __init qcom_cpufreq_kryo_exit(void)
+static void __exit qcom_cpufreq_kryo_exit(void)
 {
 	platform_device_unregister(kryo_cpufreq_pdev);
 	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
-- 
2.14.1
