From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
Date: Thu, 8 Oct 2015 16:21:11 -0700
Message-ID: <20151008232110.GK26883@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On 10/08, Rajendra Nayak wrote:
> 8960 family of devices have TSENS as part of GCC in hardware.
> Hence DT would represent a GCC node with GCC properties as well
> as TSENS. Create a virtual platform child device here for TSENS
> so the driver can probe it and use the parent (GCC) to extract DT
> properties.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next with some massaging. Is there going to be an
update to the gcc binding too?

---8<----
From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH] clk: qcom: create virtual child device for TSENS

8960 family of devices have TSENS as part of GCC in hardware.
Hence DT would represent a GCC node with GCC properties as well
as TSENS. Create a virtual platform child device here for TSENS
so the driver can probe it and use the parent (GCC) to extract DT
properties.

Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
[sboyd@codeaurora.org: Massaged to work with devm friendly
qcom_cc_probe()]
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8960.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
index b52153903893..66c18bc97857 100644
--- a/drivers/clk/qcom/gcc-msm8960.c
+++ b/drivers/clk/qcom/gcc-msm8960.c
@@ -3506,6 +3506,8 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *match;
+	struct platform_device *tsens;
+	int ret;
 
 	match = of_match_device(gcc_msm8960_match_table, &pdev->dev);
 	if (!match)
@@ -3520,11 +3522,26 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	return qcom_cc_probe(pdev, match->data);
+	ret = qcom_cc_probe(pdev, match->data);
+	if (ret)
+		return ret;
+
+	tsens = platform_device_register_data(&pdev->dev, "qcom-tsens", -1,
+					      NULL, 0);
+	if (IS_ERR(tsens))
+		return PTR_ERR(tsens);
+
+	platform_set_drvdata(pdev, tsens);
+
+	return 0;
 }
 
 static int gcc_msm8960_remove(struct platform_device *pdev)
 {
+	struct platform_device *tsens = platform_get_drvdata(pdev);
+
+	platform_device_unregister(tsens);
+
 	return 0;
 }
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
