From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 2/2] soc: imx: add SCU power domains driver
Date: Sat, 28 Apr 2018 02:51:03 +0800
Message-ID: <1524855063-14996-3-git-send-email-aisheng.dong@nxp.com>
References: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, ulf.hansson@linaro.org, dongas86@gmail.com, khilman@kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

Some i.MX SoCs contain a system controller that is responsible for
controlling the state of the IPs that are present. Communication
between the host processor running an OS and the system controller
happens through a SCU protocol. This patch adds SCU protocol based
power domains drivers.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/soc/imx/Kconfig  |   4 ++
 drivers/soc/imx/Makefile |   1 +
 drivers/soc/imx/sc-pd.c  | 151 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 drivers/soc/imx/sc-pd.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index 4cad3c0..8d56e9b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -14,4 +14,8 @@ config HAVE_IMX_SCU
 	bool
 	depends on HAVE_IMX_MU
 
+config HAVE_IMX_SC_PD
+	bool
+	depends on HAVE_IMX_SCU
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index f931984..40ad2a5 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_HAVE_IMX_MU) += imx_mu.o
 obj-$(CONFIG_HAVE_IMX_SCU) += sc/
+obj-$(CONFIG_HAVE_IMX_SC_PD) += sc-pd.o
diff --git a/drivers/soc/imx/sc-pd.c b/drivers/soc/imx/sc-pd.c
new file mode 100644
index 0000000..ecbfd2c
--- /dev/null
+++ b/drivers/soc/imx/sc-pd.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * Implementation of the SCU based Power Domains
+ *
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+#include <soc/imx/sc/sci.h>
+
+struct imx_sc_pm_domain {
+	struct generic_pm_domain pd;
+	sc_rsrc_t rsrc_id;
+};
+
+static sc_ipc_t pm_ipc_handle;
+
+static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	struct imx_sc_pm_domain *pd;
+	sc_err_t sci_err;
+
+	pd = container_of(domain, struct imx_sc_pm_domain, pd);
+
+	sci_err = sc_pm_set_resource_power_mode(pm_ipc_handle, pd->rsrc_id,
+						power_on ? SC_PM_PW_MODE_ON :
+						SC_PM_PW_MODE_LP);
+	if (sci_err) {
+		pr_err("imx_sc_pm: failed to power %s resource %d ret %d\n",
+			power_on ? "up" : "off", pd->rsrc_id, sci_err);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static int imx_sc_pd_power_on(struct generic_pm_domain *domain)
+{
+	return imx_sc_pd_power(domain, true);
+}
+
+static int imx_sc_pd_power_off(struct generic_pm_domain *domain)
+{
+	return imx_sc_pd_power(domain, false);
+}
+
+static struct __init generic_pm_domain * imx_sc_pm_add_one_domain(struct device_node *np,
+						struct generic_pm_domain *genpd_parent)
+{
+	struct imx_sc_pm_domain *imx_sc_pd;
+	sc_rsrc_t rsrc_id;
+	int ret;
+
+	imx_sc_pd = kzalloc(sizeof(*imx_sc_pd), GFP_KERNEL);
+	if (!imx_sc_pd)
+		return ERR_PTR(-ENOMEM);
+
+	if (!of_property_read_u32(np, "reg", &rsrc_id)) {
+		if (rsrc_id > SC_R_LAST) {
+			pr_warn("%pOF: invalid rsrc id %d found", np, rsrc_id);
+			ret = -EINVAL;
+			goto err;
+		}
+		imx_sc_pd->rsrc_id = rsrc_id;
+	} else {
+		imx_sc_pd->rsrc_id = SC_R_LAST;
+	}
+
+	if (imx_sc_pd->rsrc_id != SC_R_LAST) {
+		imx_sc_pd->pd.power_off = imx_sc_pd_power_off;
+		imx_sc_pd->pd.power_on = imx_sc_pd_power_on;
+	}
+
+	imx_sc_pd->pd.name = np->name;
+
+	ret = pm_genpd_init(&imx_sc_pd->pd, NULL, true);
+	if (ret < 0)
+		goto err;
+
+	if (genpd_parent) {
+		ret = pm_genpd_add_subdomain(genpd_parent, &imx_sc_pd->pd);
+		if (ret)
+			goto err;
+	}
+
+	ret = of_genpd_add_provider_simple(np, &imx_sc_pd->pd);
+	if (!ret)
+		return &imx_sc_pd->pd;
+
+	pm_genpd_remove_subdomain(genpd_parent, &imx_sc_pd->pd);
+err:
+	pr_warn("imx_sc_pm: failed to add PM domain %pOF: %d\n", np, ret);
+	kfree(imx_sc_pd);
+	return ERR_PTR(ret);
+}
+
+static void __init imx_sc_pm_add_subdomains(struct device_node *parent,
+					    struct generic_pm_domain *genpd_parent)
+{
+	struct generic_pm_domain *pd;
+	struct device_node *np;
+
+	for_each_child_of_node(parent, np) {
+		pd = imx_sc_pm_add_one_domain(np, genpd_parent);
+		if (!IS_ERR(pd))
+			imx_sc_pm_add_subdomains(np, pd);
+	}
+}
+
+static const struct of_device_id imx_sc_pm_domain_of_match[] __initconst = {
+	{
+		.compatible = "nxp,imx8qxp-pd",
+	},
+	{ },
+};
+
+static int __init imx_sc_init_pm_domains(void)
+{
+	struct generic_pm_domain *pd;
+	struct device_node *np;
+	sc_err_t sci_err;
+
+	if (!of_machine_is_compatible("fsl,imx8qxp"))
+		return 0;
+
+	sci_err = sc_ipc_get_handle(&pm_ipc_handle);
+	if (sci_err != SC_ERR_NONE) {
+		pr_err("imx_sc_pd: can't get sc ipc handle\n");
+		return -ENODEV;
+	}
+
+	for_each_matching_node(np, imx_sc_pm_domain_of_match) {
+		pd = imx_sc_pm_add_one_domain(np, NULL);
+		if (!IS_ERR(pd))
+			imx_sc_pm_add_subdomains(np, pd);
+	}
+
+	return 0;
+}
+early_initcall(imx_sc_init_pm_domains);
-- 
2.7.4
