From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] imx6q-cpufreq: fix return value check in imx6q_cpufreq_probe()
Date: Fri, 22 Feb 2013 12:39:30 +0800
Message-ID: <CAPgLHd_sbN0i_6Lqh+-2o9rZx_CG3=czZJV3N6oAuSKrjkttbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, shawn.guo@linaro.org
Cc: yongjun_wei@trendmicro.com.cn, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_regulator_get() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/cpufreq/imx6q-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index d6b6ef3..54e336d 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -245,7 +245,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	arm_reg = devm_regulator_get(cpu_dev, "arm");
 	pu_reg = devm_regulator_get(cpu_dev, "pu");
 	soc_reg = devm_regulator_get(cpu_dev, "soc");
-	if (!arm_reg || !pu_reg || !soc_reg) {
+	if (IS_ERR(arm_reg) || IS_ERR(pu_reg) || IS_ERR(soc_reg)) {
 		dev_err(cpu_dev, "failed to get regulators\n");
 		ret = -ENOENT;
 		goto put_node;


