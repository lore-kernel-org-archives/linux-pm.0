From: Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH RFC 2/9] OPP: Export a number of helpers to prevent code duplication
Date: Thu, 28 Mar 2019 20:58:15 +0530
Message-ID: <20190328152822.532-3-sibis@codeaurora.org>
References: <20190328152822.532-1-sibis@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328152822.532-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, andy.gross@linaro.org, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org
Cc: bjorn.andersson@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org, devicetree@vger.kernel.org, rnayak@codeaurora.org, cw00.choi@samsung.com, linux-pm@vger.kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org, dianders@chromium.org, Sibi Sankar <sibis@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Export 'dev_pm_opp_find_opp_of_np' and 'of_parse_required_nodes'
as it will be used by passive governor to parse and auto-populate
mapping specified using the required-opps property.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/opp/of.c       | 13 +++++++++++--
 include/linux/pm_opp.h | 13 +++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 539f3d013a59..d9d8875eca05 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -98,8 +98,8 @@ static struct dev_pm_opp *_find_opp_of_np(struct opp_table *opp_table,
 	return NULL;
 }
 
-static struct device_node *of_parse_required_opp(struct device_node *np,
-						 int index)
+struct device_node *of_parse_required_opp(struct device_node *np,
+					  int index)
 {
 	struct device_node *required_np;
 
@@ -111,6 +111,15 @@ static struct device_node *of_parse_required_opp(struct device_node *np,
 
 	return required_np;
 }
+EXPORT_SYMBOL_GPL(of_parse_required_opp);
+
+/* The caller must call dev_pm_opp_put() after the OPP is used */
+struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table,
+					     struct device_node *opp_np)
+{
+	return _find_opp_of_np(opp_table, opp_np);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_opp_of_np);
 
 /* The caller must call dev_pm_opp_put_opp_table() after the table is used */
 static struct opp_table *_find_table_of_opp_np(struct device_node *opp_np)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 82ff8e2e1ff7..d7cb0e65c4f0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -359,8 +359,11 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+struct device_node *of_parse_required_opp(struct device_node *np, int index);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 void dev_pm_opp_of_register_em(struct cpumask *cpus);
+struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table,
+					     struct device_node *opp_np);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -390,6 +393,11 @@ static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct
 	return -ENOTSUPP;
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_opp_of_np(struct opp_table *opp_table, struct device_node *opp_np)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 {
 	return NULL;
@@ -408,6 +416,11 @@ static inline int of_get_required_opp_performance_state(struct device_node *np,
 {
 	return -ENOTSUPP;
 }
+
+static inline struct device_node *of_parse_required_opp(struct device_node *np, int index)
+{
+	return NULL;
+}
 #endif
 
 #endif		/* __LINUX_OPP_H__ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
