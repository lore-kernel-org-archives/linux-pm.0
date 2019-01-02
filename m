From: Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC RESEND PATCH 3/7] soc: mediatek: add support for the performance state
Date: Wed, 2 Jan 2019 22:09:54 +0800
Message-ID: <1546438198-1677-4-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Henry Chen <henryc.chen@mediatek.com>
List-Id: linux-pm@vger.kernel.org

Support power domain performance state, add header file for scp event.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 60 +++++++++++++++++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.h | 22 ++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 58d84fe..90102ae 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -11,7 +11,9 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_opp.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/soc/mediatek/infracfg.h>
 #include <linux/soc/mediatek/scpsys-ext.h>
 
@@ -22,6 +24,7 @@
 #include <dt-bindings/power/mt7623a-power.h>
 #include <dt-bindings/power/mt8173-power.h>
 #include <dt-bindings/power/mt8183-power.h>
+#include "mtk-scpsys.h"
 
 #define MTK_POLL_DELAY_US   10
 #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
@@ -187,6 +190,18 @@ struct scp_soc_data {
 	bool bus_prot_reg_update;
 };
 
+BLOCKING_NOTIFIER_HEAD(scpsys_notifier_list);
+
+int register_scpsys_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&scpsys_notifier_list, nb);
+}
+
+int unregister_scpsys_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&scpsys_notifier_list, nb);
+}
+
 static int scpsys_domain_is_on(struct scp_domain *scpd)
 {
 	struct scp *scp = scpd->scp;
@@ -536,6 +551,48 @@ static void init_clks(struct platform_device *pdev, struct clk **clk)
 		clk[i] = devm_clk_get(&pdev->dev, clk_names[i]);
 }
 
+static int mtk_pd_set_performance(struct generic_pm_domain *genpd,
+				  unsigned int state)
+{
+	int i;
+	struct scp_domain *scpd =
+		container_of(genpd, struct scp_domain, genpd);
+	struct scp_event_data scpe;
+	struct scp *scp = scpd->scp;
+	struct genpd_onecell_data *pd_data = &scp->pd_data;
+
+	for (i = 0; i < pd_data->num_domains; i++) {
+		if (genpd == pd_data->domains[i]) {
+			dev_dbg(scp->dev, "%d. %s = %d\n",
+				i, genpd->name, state);
+			break;
+		}
+	}
+
+	scpe.event_type = MTK_SCPSYS_PSTATE;
+	scpe.genpd = genpd;
+	scpe.domain_id = i;
+	blocking_notifier_call_chain(&scpsys_notifier_list, state, &scpe);
+
+	return 0;
+}
+
+static unsigned int mtk_pd_get_performance(struct generic_pm_domain *genpd,
+					   struct dev_pm_opp *opp)
+{
+	struct device_node *np;
+	unsigned int state;
+
+	np = dev_pm_opp_get_of_node(opp);
+
+	if (of_property_read_u32(np, "mtk,level", &state))
+		return 0;
+
+	of_node_put(np);
+
+	return state;
+}
+
 static struct scp *init_scp(struct platform_device *pdev,
 			const struct scp_domain_data *scp_domain_data, int num,
 			const struct scp_ctrl_reg *scp_ctrl_reg,
@@ -659,6 +716,9 @@ static struct scp *init_scp(struct platform_device *pdev,
 		genpd->power_on = scpsys_power_on;
 		if (MTK_SCPD_CAPS(scpd, MTK_SCPD_ACTIVE_WAKEUP))
 			genpd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+
+		genpd->set_performance_state = mtk_pd_set_performance;
+		genpd->opp_to_performance_state = mtk_pd_get_performance;
 	}
 
 	return scp;
diff --git a/drivers/soc/mediatek/mtk-scpsys.h b/drivers/soc/mediatek/mtk-scpsys.h
new file mode 100644
index 0000000..c1e8325
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-scpsys.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+
+#ifndef __MTK_SCPSYS_H__
+#define __MTK_SCPSYS_H__
+
+struct scp_event_data {
+	int event_type;
+	int domain_id;
+	struct generic_pm_domain *genpd;
+};
+
+enum scp_event_type {
+	MTK_SCPSYS_PSTATE,
+};
+
+int register_scpsys_notifier(struct notifier_block *nb);
+int unregister_scpsys_notifier(struct notifier_block *nb);
+
+#endif /* __MTK_SCPSYS_H__ */
-- 
1.9.1
