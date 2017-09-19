From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V10 4/7] soc: qcom: rpmpd: Add a powerdomain driver to model cx/mx powerdomains
Date: Tue, 19 Sep 2017 15:32:20 -0700
Message-ID: <5bab3b8f9601bc76c73e0c4154a0f5dcfba0cffc.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:47624 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdISWco (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2017 18:32:44 -0400
Received: by mail-pg0-f42.google.com with SMTP id d8so610318pgt.4
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2017 15:32:44 -0700 (PDT)
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1505859768.git.viresh.kumar@linaro.org>
References: <cover.1505859768.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

From: Rajendra Nayak <rnayak@codeaurora.org>

THIS IS TEST CODE, SHOULDN'T BE MERGED.

The cx/mx powerdomains just pass the performance state set by the
consumers to the RPM (Remote Power manager) which then takes care
of setting the appropriate voltage on the corresponding rails to
meet the performance needs.

Add data for all powerdomains on msm8996.

Not-signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Not-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../devicetree/bindings/power/qcom,rpmpd.txt       |  10 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   5 +
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmpd.c                           | 307 +++++++++++++++++++++
 5 files changed, 332 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmpd.c

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
new file mode 100644
index 000000000000..8b48ce57a563
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
@@ -0,0 +1,10 @@
+Qualcomm RPM Powerdomains
+
+* For RPM powerdomains, we communicate a performance state to RPM
+which then translates it into a corresponding voltage on a rail
+
+Required Properties:
+ - compatible: Should be one of the following
+	* qcom,rpmpd-msm8996: RPM Powerdomain for the msm8996 family of SoC
+ - power-domain-cells: number of cells in power domain specifier
+	must be 1.
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 887b61c872dd..0be1db559d61 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -496,6 +496,11 @@
 			status = "disabled";
 		};
 
+		rpmpd: qcom,rpmpd {
+			compatible = "qcom,rpmpd-msm8996", "qcom,rpmpd";
+			#power-domain-cells = <1>;
+		};
+
 		sdhc2: sdhci@74a4900 {
 			 status = "disabled";
 			 compatible = "qcom,sdhci-msm-v4";
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index b00bccddcd3b..38ff424bdebe 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -35,6 +35,15 @@ config QCOM_PM
 	  modes. It interface with various system drivers to put the cores in
 	  low power modes.
 
+config QCOM_RPMPD
+	tristate "Qualcomm RPM Powerdomain driver"
+	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
+	help
+	  QCOM RPM powerdomain driver to support powerdomain with
+	  performance states. The driver communicates a performance state
+	  value to RPM which then translates it into corresponding voltage
+	  for the voltage rail.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f151de41eb93..3fa9af1e2c93 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
+obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
new file mode 100644
index 000000000000..d34d9c363815
--- /dev/null
+++ b/drivers/soc/qcom/rpmpd.c
@@ -0,0 +1,307 @@
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_domain.h>
+#include <linux/mfd/qcom_rpm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include <dt-bindings/mfd/qcom-rpm.h>
+
+#define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
+
+/* Resource types */
+#define RPMPD_SMPA 0x61706d73
+#define RPMPD_LDOA 0x616f646c
+
+/* Operation Keys */
+#define KEY_CORNER		0x6e726f63 /* corn */
+#define KEY_ENABLE		0x6e657773 /* swen */
+#define KEY_FLOOR_CORNER	0x636676   /* vfc */
+
+#define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)		\
+	static struct rpmpd _platform##_##_active;			\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = {	.name = #_name,	},				\
+		.peer = &_platform##_##_active,				\
+		.res_type = RPMPD_SMPA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	};								\
+	static struct rpmpd _platform##_##_active = {			\
+		.pd = { .name = #_active, },				\
+		.peer = &_platform##_##_name,				\
+		.active_only = true,					\
+		.res_type = RPMPD_SMPA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	}
+
+#define DEFINE_RPMPD_CORN_LDOA(_platform, _name, r_id)			\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = RPMPD_LDOA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	}
+
+#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)		\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = r_type,					\
+		.res_id = r_id,						\
+		.key = KEY_FLOOR_CORNER,				\
+	}
+
+#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)			\
+	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
+
+#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)			\
+	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
+
+struct rpmpd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+struct rpmpd {
+	struct generic_pm_domain pd;
+	struct rpmpd *peer;
+	const bool active_only;
+	unsigned long corner;
+	bool enabled;
+	const char *res_name;
+	const int res_type;
+	const int res_id;
+	struct qcom_smd_rpm *rpm;
+	__le32 key;
+};
+
+struct rpmpd_desc {
+	struct rpmpd **rpmpds;
+	size_t num_pds;
+};
+
+static DEFINE_MUTEX(rpmpd_lock);
+
+/* msm8996 RPM powerdomains */
+DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
+DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
+DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
+
+DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
+DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
+
+static struct rpmpd *msm8996_rpmpds[] = {
+	[0] = &msm8996_vddcx,
+	[1] = &msm8996_vddcx_ao,
+	[2] = &msm8996_vddcx_vfc,
+	[3] = &msm8996_vddmx,
+	[4] = &msm8996_vddmx_ao,
+	[5] = &msm8996_vddsscx,
+	[6] = &msm8996_vddsscx_vfc,
+};
+
+static const struct rpmpd_desc msm8996_desc = {
+	.rpmpds = msm8996_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
+};
+
+static const struct of_device_id rpmpd_match_table[] = {
+	{ .compatible = "qcom,rpmpd-msm8996", .data = &msm8996_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmpd_match_table);
+
+static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
+{
+	struct rpmpd_req req = {
+		.key = KEY_ENABLE,
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(enable),
+	};
+
+	return qcom_rpm_smd_write(pd->rpm, QCOM_RPM_ACTIVE_STATE, pd->res_type,
+				  pd->res_id, &req, sizeof(req));
+}
+
+static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
+{
+	struct rpmpd_req req = {
+		.key = pd->key,
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(corner),
+	};
+
+	return qcom_rpm_smd_write(pd->rpm, state, pd->res_type, pd->res_id,
+				  &req, sizeof(req));
+};
+
+static void to_active_sleep(struct rpmpd *pd, unsigned long corner,
+			    unsigned long *active, unsigned long *sleep)
+{
+	*active = corner;
+
+	if (pd->active_only)
+		*sleep = 0;
+	else
+		*sleep = *active;
+}
+
+static int rpmpd_aggregate_corner(struct rpmpd *pd)
+{
+	int ret;
+	struct rpmpd *peer = pd->peer;
+	unsigned long active_corner, sleep_corner;
+	unsigned long this_corner = 0, this_sleep_corner = 0;
+	unsigned long peer_corner = 0, peer_sleep_corner = 0;
+
+	to_active_sleep(pd, pd->corner, &this_corner, &this_sleep_corner);
+
+	if (peer && peer->enabled)
+		to_active_sleep(peer, peer->corner, &peer_corner,
+				&peer_sleep_corner);
+
+	active_corner = max(this_corner, peer_corner);
+
+	ret = rpmpd_send_corner(pd, QCOM_RPM_ACTIVE_STATE, active_corner);
+	if (ret)
+		return ret;
+
+	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
+
+	return rpmpd_send_corner(pd, QCOM_RPM_SLEEP_STATE, sleep_corner);
+}
+
+static int rpmpd_power_on(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	ret = rpmpd_send_enable(pd, true);
+	if (ret)
+		goto out;
+
+	pd->enabled = true;
+
+	if (pd->corner)
+		ret = rpmpd_aggregate_corner(pd);
+
+out:
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+static int rpmpd_power_off(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	ret = rpmpd_send_enable(pd, false);
+	if (!ret)
+		pd->enabled = false;
+
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+static int rpmpd_probe(struct platform_device *pdev)
+{
+	int i;
+	size_t num;
+	struct genpd_onecell_data *data;
+	struct qcom_smd_rpm *rpm;
+	struct rpmpd **rpmpds;
+	const struct rpmpd_desc *desc;
+
+	rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!rpm) {
+		dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmpds = desc->rpmpds;
+	num = desc->num_pds;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	data->num_domains = num;
+
+	for (i = 0; i < num; i++) {
+		if (!rpmpds[i])
+			continue;
+
+		rpmpds[i]->rpm = rpm;
+		rpmpds[i]->pd.power_off = rpmpd_power_off;
+		rpmpds[i]->pd.power_on = rpmpd_power_on;
+		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
+
+		data->domains[i] = &rpmpds[i]->pd;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+}
+
+static int rpmpd_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+	return 0;
+}
+
+static struct platform_driver rpmpd_driver = {
+	.driver = {
+		.name = "qcom-rpmpd",
+		.of_match_table = rpmpd_match_table,
+	},
+	.probe = rpmpd_probe,
+	.remove = rpmpd_remove,
+};
+
+static int __init rpmpd_init(void)
+{
+	return platform_driver_register(&rpmpd_driver);
+}
+core_initcall(rpmpd_init);
+
+static void __exit rpmpd_exit(void)
+{
+	platform_driver_unregister(&rpmpd_driver);
+}
+module_exit(rpmpd_exit);
+
+MODULE_DESCRIPTION("Qualcomm RPM Power Domain Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-rpmpd");
-- 
2.7.4
