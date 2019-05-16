From: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
Subject: [PATCH 8/8] devfreq: mediatek: cci devfreq register opp notification
 for SVS support
Date: Thu, 16 May 2019 17:08:45 +0800
Message-ID: <1557997725-12178-9-git-send-email-andrew-sh.cheng@mediatek.com>
References: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1557997725-12178-1-git-send-email-andrew-sh.cheng@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>, srv_heupstream@mediatek.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, fan.chen@mediatek.com, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>

SVS will change the voltage of opp item.
CCI devfreq need to react to change frequency.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
---
 drivers/devfreq/mt8183-cci-devfreq.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
index 818a167c442f..250c963789f3 100644
--- a/drivers/devfreq/mt8183-cci-devfreq.c
+++ b/drivers/devfreq/mt8183-cci-devfreq.c
@@ -19,7 +19,10 @@ struct cci_devfreq {
 	struct regulator *proc_reg;
 	unsigned long proc_reg_uV;
 	struct clk *cci_clk;
+	unsigned long freq;
 	struct notifier_block nb;
+	struct notifier_block opp_nb;
+	int cci_min_freq;
 };
 
 static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
@@ -65,17 +68,62 @@ static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
 	return 0;
 }
 
+static int ccidevfreq_opp_notifier(struct notifier_block *nb,
+unsigned long event, void *data)
+{
+	int ret;
+	struct dev_pm_opp *opp = data;
+	struct cci_devfreq *cci_df = container_of(nb, struct cci_devfreq,
+						  opp_nb);
+	unsigned long	freq, volt, cur_volt;
+
+	if (event == OPP_EVENT_ADJUST_VOLTAGE) {
+		freq = dev_pm_opp_get_freq(opp);
+		/* current opp item is changed */
+		if (freq == cci_df->freq) {
+			volt = dev_pm_opp_get_voltage(opp);
+			cur_volt = regulator_get_voltage(cci_df->proc_reg);
+
+			if (volt > cur_volt) {
+				/* need reduce freq */
+				mutex_lock(&cci_df->devfreq->lock);
+				ret = update_devfreq(cci_df->devfreq);
+				if (ret)
+					pr_err("Fail to reduce cci frequency by opp notification: %d\n",
+					       ret);
+				mutex_unlock(&cci_df->devfreq->lock);
+			}
+		}
+
+		if (freq == cci_df->cci_min_freq) {
+			volt = dev_pm_opp_get_voltage(opp);
+			regulator_set_voltage(cci_df->proc_reg, volt, INT_MAX);
+		}
+	} else if (event == OPP_EVENT_DISABLE) {
+	}
+
+	return 0;
+}
+
+
 static int mtk_cci_governor_get_target(struct devfreq *devfreq,
 				       unsigned long *freq)
 {
 	struct cci_devfreq *cci_df;
 	struct dev_pm_opp *opp;
+	int ret;
 
 	cci_df = dev_get_drvdata(devfreq->dev.parent);
 
 	/* find available frequency */
 	opp = dev_pm_opp_find_freq_ceil_by_volt(devfreq->dev.parent,
 						cci_df->proc_reg_uV);
+	ret = PTR_ERR_OR_ZERO(opp);
+	if (ret) {
+		pr_err("%s[%d], cannot find opp with voltage=%d: %d\n",
+		       __func__, __LINE__, cci_df->proc_reg_uV, ret);
+		return ret;
+	}
 	*freq = dev_pm_opp_get_freq(opp);
 
 	return 0;
@@ -87,9 +135,11 @@ static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
 	int ret;
 	struct cci_devfreq *cci_df;
 	struct notifier_block *nb;
+	struct notifier_block *opp_nb;
 
 	cci_df = dev_get_drvdata(devfreq->dev.parent);
 	nb = &cci_df->nb;
+	opp_nb = &cci_df->opp_nb;
 
 	switch (event) {
 	case DEVFREQ_GOV_START:
@@ -100,6 +150,8 @@ static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
 		if (ret)
 			pr_err("%s: failed to add governor: %d\n", __func__,
 			       ret);
+		opp_nb->notifier_call = ccidevfreq_opp_notifier;
+		dev_pm_opp_register_notifier(devfreq->dev.parent, opp_nb);
 		break;
 
 	case DEVFREQ_GOV_STOP:
@@ -141,6 +193,8 @@ static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
 		return ret;
 	}
 
+	cci_df->freq = *freq;
+
 	return 0;
 }
 
@@ -152,6 +206,8 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
 {
 	struct device *cci_dev = &pdev->dev;
 	struct cci_devfreq *cci_df;
+	unsigned long freq, volt;
+	struct dev_pm_opp *opp;
 	int ret;
 
 	cci_df = devm_kzalloc(cci_dev, sizeof(*cci_df), GFP_KERNEL);
@@ -181,6 +237,13 @@ static int mtk_cci_devfreq_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* set voltage lower bound */
+	freq = 1;
+	opp = dev_pm_opp_find_freq_ceil(cci_dev, &freq);
+	cci_df->cci_min_freq = dev_pm_opp_get_freq(opp);
+	volt = dev_pm_opp_get_voltage(opp);
+	dev_pm_opp_put(opp);
+
 	platform_set_drvdata(pdev, cci_df);
 
 	cci_df->devfreq = devm_devfreq_add_device(cci_dev,
-- 
2.12.5
