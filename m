From: Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 1/9] OPP: Add and export helpers to get avg/peak bw
Date: Thu, 28 Mar 2019 20:58:14 +0530
Message-ID: <20190328152822.532-2-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Add and export helpers 'dev_pm_opp_get_avg_bw()' and
'dev_pm_opp_get_peak_bw()' that can be used to get the
average and peak bandwidth values read from device tree
when present.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/core.c     | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h | 12 ++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 4fcc2b9259c5..addaf7aae9ae 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -149,6 +149,44 @@ unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
 
+/**
+ * dev_pm_opp_get_avg_bw() - Gets the average bandwidth corresponding to an
+ * available opp
+ * @opp:	opp for which average bandwidth has to be returned for
+ *
+ * Return: average bandwidth read from device tree corresponding to the
+ * opp, else return 0.
+ */
+unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->bandwidth->avg;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_avg_bw);
+
+/**
+ * dev_pm_opp_get_peak_bw() - Gets the peak bandwidth corresponding to an
+ * available opp
+ * @opp:	opp for which peak bandwidth has to be returned for
+ *
+ * Return: peak bandwidth read from device tree corresponding to the
+ * opp, else return 0.
+ */
+unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->bandwidth->peak;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_peak_bw);
+
 /**
  * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 80a49d1fa9a8..82ff8e2e1ff7 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -99,6 +99,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
 unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
+unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp);
+unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp);
 
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
@@ -179,6 +181,16 @@ static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned int dev_pm_opp_get_avg_bw(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
+static inline unsigned int dev_pm_opp_get_peak_bw(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	return false;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
