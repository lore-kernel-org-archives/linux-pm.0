From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v3 4/9] clk: qcom: create virtual child device for TSENS
Date: Thu, 8 Oct 2015 00:03:46 -0700
Message-ID: <20151008070345.GF26883@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-5-git-send-email-rnayak@codeaurora.org>
 <20151008060557.GD26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151008060557.GD26883@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org, punit.agrawal@arm.com
List-Id: linux-pm@vger.kernel.org

On 10/07, Stephen Boyd wrote:
> On 10/08, Rajendra Nayak wrote:
> 
> I've also been considering putting some devm stuff inside
> qcom_cc_probe() itself so that in the normal case you don't even
> need to call qcom_cc_remove(), it just gets done automatically.
> That would open up the possibility for drivers to use the drvdata
> member as they wish.
> 

Something like this untested patch

---8<---
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] qcom: clk: Make qcom_cc_probe() fully devm safe

Some APIs in qcom_cc_probe() don't have a devm counterpart, so we
have to use the calling device's platform data to pass pointers
to the remove path. Let's use devm_add_action() instead, so that
the remove path doesn't need to do anything, allowing us to
remove qcom_cc_remove() entirely.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/common.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 150692879e92..327d2e5d9f1c 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -73,6 +73,21 @@ qcom_cc_map(struct platform_device *pdev, const struct qcom_cc_desc *desc)
 }
 EXPORT_SYMBOL_GPL(qcom_cc_map);
 
+static void qcom_cc_del_clk_provider(void *data)
+{
+	of_clk_del_provider(data);
+}
+
+static void qcom_cc_reset_unregister(void *data)
+{
+	reset_controller_unregister(data);
+}
+
+static void qcom_cc_gdsc_unregister(void *data)
+{
+	gdsc_unregister(data);
+}
+
 int qcom_cc_really_probe(struct platform_device *pdev,
 			 const struct qcom_cc_desc *desc, struct regmap *regmap)
 {
@@ -111,6 +126,8 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	if (ret)
 		return ret;
 
+	devm_add_action(dev, qcom_cc_del_clk_provider, pdev->dev.of_node);
+
 	reset = &cc->reset;
 	reset->rcdev.of_node = dev->of_node;
 	reset->rcdev.ops = &qcom_reset_ops;
@@ -118,25 +135,24 @@ int qcom_cc_really_probe(struct platform_device *pdev,
 	reset->rcdev.nr_resets = desc->num_resets;
 	reset->regmap = regmap;
 	reset->reset_map = desc->resets;
-	platform_set_drvdata(pdev, &reset->rcdev);
 
 	ret = reset_controller_register(&reset->rcdev);
 	if (ret)
-		goto err_reset;
+		return ret;
+
+	devm_add_action(dev, qcom_cc_reset_unregister, &reset->rcdev);
 
 	if (desc->gdscs && desc->num_gdscs) {
 		ret = gdsc_register(dev, desc->gdscs, desc->num_gdscs,
 				    &reset->rcdev, regmap);
 		if (ret)
-			goto err_pd;
+			return ret;
 	}
 
+	devm_add_action(dev, qcom_cc_gdsc_unregister, dev);
+
+
 	return 0;
-err_pd:
-	reset_controller_unregister(&reset->rcdev);
-err_reset:
-	of_clk_del_provider(dev->of_node);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
 
@@ -154,9 +170,6 @@ EXPORT_SYMBOL_GPL(qcom_cc_probe);
 
 void qcom_cc_remove(struct platform_device *pdev)
 {
-	gdsc_unregister(&pdev->dev);
-	of_clk_del_provider(pdev->dev.of_node);
-	reset_controller_unregister(platform_get_drvdata(pdev));
 }
 EXPORT_SYMBOL_GPL(qcom_cc_remove);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
