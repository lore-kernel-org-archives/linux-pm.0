From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] cpufreq: qcom-kryo: add NULL entry to the end of_device_id array
Date: Mon, 23 Jul 2018 20:34:29 +0800
Message-ID: <20180723123429.20040-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ilia.lin@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-pm@vger.kernel.org

Make sure of_device_id tables are NULL terminated
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 29389ac..efc9a7a 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -183,6 +183,7 @@ static struct platform_driver qcom_cpufreq_kryo_driver = {
 static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", },
 	{ .compatible = "qcom,msm8996", },
+	{}
 };
 
 /*
-- 
2.7.0
