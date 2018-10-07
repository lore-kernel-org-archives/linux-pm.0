From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V4 2/2] firmware: imx: add SCU power domain driver
Date: Sun,  7 Oct 2018 21:10:07 +0800
Message-ID: <1538917807-1921-3-git-send-email-aisheng.dong@nxp.com>
References: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1538917807-1921-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: linux-pm@vger.kernel.org
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
ChangeLog:
v3->v4:
 * update firmware headfile patch from include/soc/imx to
   include/linux/firmware/imx
v2->v3:
 * name of structures/enums updated with imx_sc prefix
v1->v2:
 * move into drivers/firmware/imx
 * Implement sc_pm_set_resource_power_mode() API in the driver instead
   of call it via SCU API according to Sascha's suggestion
---
 drivers/firmware/imx/Kconfig  |   6 ++
 drivers/firmware/imx/Makefile |   3 +-
 drivers/firmware/imx/scu-pd.c | 167 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index b170c28..6a7a7c2 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -9,3 +9,9 @@ config IMX_SCU
 
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
+
+config IMX_SCU_PD
+	bool "IMX SCU Power Domain driver"
+	depends on IMX_SCU
+	help
+	  The System Controller Firmware (SCFW) based power domain driver.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 0ac04df..1b2e15b 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_IMX_SCU)	+= imx-scu.o misc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o
+obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
new file mode 100644
index 0000000..af5b9e4
--- /dev/null
+++ b/drivers/firmware/imx/scu-pd.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ * Implementation of the SCU based Power Domains
+ */
+
+#define pr_fmt(fmt) "scu_pd: " fmt
+
+#include <linux/firmware/imx/sci.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+struct imx_sc_pm_domain {
+	struct generic_pm_domain pd;
+	u32 rsrc_id;
+};
+
+static struct imx_sc_ipc *pm_ipc_handle;
+
+/* SCU Power Mode Protocol definition */
+struct imx_sc_msg_req_set_resource_power_mode {
+	struct imx_sc_rpc_msg hdr;
+	u16 resource;
+	u8 mode;
+} __packed;
+
+static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	struct imx_sc_msg_req_set_resource_power_mode msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	struct imx_sc_pm_domain *pd;
+	int ret;
+
+	pd = container_of(domain, struct imx_sc_pm_domain, pd);
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = (uint8_t)IMX_SC_RPC_SVC_PM;
+	hdr->func = (uint8_t)IMX_SC_PM_FUNC_SET_RESOURCE_POWER_MODE;
+	hdr->size = 2;
+
+	msg.resource = pd->rsrc_id;
+	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
+
+	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
+	if (ret)
+		pr_err("failed to power %s resource %d ret %d\n",
+			power_on ? "up" : "off", pd->rsrc_id, ret);
+
+	return ret;
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
+static struct generic_pm_domain *imx_sc_pm_add_one_domain(
+					struct device_node *np,
+					struct generic_pm_domain *genpd_parent)
+{
+	struct imx_sc_pm_domain *imx_sc_pd;
+	u32 rsrc_id;
+	int ret;
+
+	imx_sc_pd = kzalloc(sizeof(*imx_sc_pd), GFP_KERNEL);
+	if (!imx_sc_pd)
+		return ERR_PTR(-ENOMEM);
+
+	if (!of_property_read_u32(np, "reg", &rsrc_id)) {
+		if (rsrc_id > IMX_SC_R_LAST) {
+			pr_warn("%pOF: invalid rsrc id %d found", np, rsrc_id);
+			ret = -EINVAL;
+			goto err;
+		}
+		imx_sc_pd->rsrc_id = rsrc_id;
+	} else {
+		imx_sc_pd->rsrc_id = IMX_SC_R_LAST;
+	}
+
+	if (imx_sc_pd->rsrc_id != IMX_SC_R_LAST) {
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
+
+err:
+	pr_warn("failed to add PM domain %pOF: %d\n", np, ret);
+	kfree(imx_sc_pd);
+	return ERR_PTR(ret);
+}
+
+static void imx_sc_pm_add_pm_domains(struct device_node *parent,
+				     struct generic_pm_domain *genpd_parent)
+{
+	struct generic_pm_domain *pd;
+	struct device_node *np;
+
+	for_each_child_of_node(parent, np) {
+		pd = imx_sc_pm_add_one_domain(np, genpd_parent);
+		if (!IS_ERR(pd))
+			imx_sc_pm_add_pm_domains(np, pd);
+	}
+}
+
+static int imx_sc_pd_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	ret = imx_scu_get_handle(&pm_ipc_handle);
+	if (ret)
+		return ret;
+
+	imx_sc_pm_add_pm_domains(np, NULL);
+
+	return 0;
+}
+
+static const struct of_device_id imx_sc_pd_match[] = {
+	{ .compatible = "fsl,scu-pd", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx_sc_pd_driver = {
+	.driver = {
+		.name = "imx-scu-pd",
+		.of_match_table = imx_sc_pd_match,
+	},
+	.probe = imx_sc_pd_probe,
+};
+builtin_platform_driver(imx_sc_pd_driver);
+
+MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("IMX SCU Power Domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
