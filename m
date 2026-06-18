Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6BD37E2E5;
	Thu, 18 Jun 2026 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781758899; cv=none; b=pX75BiaZXS9nWR6tOVFqYOFskGtldxzrWKWxyMl7uQHLmiLBp+GPdvQ0PtJUGi1j9O9cJw5g+5Oy9VV8oRCVMdLVeyrXBu3x+1gzYRALif22gDLpY+zh94S1IpfoRwlXaGLbDOMJYl3W0gyzCk6WXhPuGgKBJpwgYWuxkGc4mEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781758899; c=relaxed/simple;
	bh=wQUZmA9gVR4J6R20RJtTUIIgio0u5NXI8LieCf4Bcjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LKObvfSE2G65bLJpfnaCXAOmTRPBbxcsN/2thNgS6+99kHUx9S7FLDgiegaZA2YmxQEBKLnQLLgks1ujYVS8ONSuZ1ejdFALQXHstqrOiqQFiOH4INZwRTWfMOwiGDulmH22L2prhmSsVx3u/FL23cAkApAcJ4KfT6uD1eayQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktQDzQk1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktQDzQk1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1951F000E9;
	Thu, 18 Jun 2026 05:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781758897;
	bh=v49kaGKJ7F8z7qwGK3uEtynFroiakzFMAdI5bIyo0/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ktQDzQk1b//LhwRiiPzo/5koKRp2vnV1JkLmLeYjPNj9wlOwL3mz8294Qn/dPbUm0
	 C3sqJc/8cVhT1zZ8RovicFZWKB0+ttc/kJTC6547+q8HT63EnRYlxzhXlIm+ZdNhfh
	 zg4Wn8/Rm3vc5f4FbAMxxr7ylt+cASC6tH3HhSgM6h9+48OzH7j5EawccvVADpHRss
	 cvb+I8dTp0dzKIEWBdFG5AX90WLlyS/wgtSmo1V2eCTU94+1dhf02LdKe/SMhrBfuI
	 YUcogHj/Zb4dy/ragdg+FxqS3SJVUsmLoWeCYaMj2CrulqkCnaLPGE/SoQQSx3Fbrh
	 9uCuY6QXMik3w==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 18 Jun 2026 07:00:56 +0200
Subject: [PATCH 10/11] regulator: db8500: Add power domain regulators
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nodes.

Back the regulator enable state with the corresponding power domains.

This is done for off-chip consumers: the corresponding voltage rails are
routed out so they are used for powering different peripherals using
these voltages as supplies.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/boot/dts/st/ste-dbx5x0.dtsi |   2 +
 drivers/regulator/Kconfig            |  11 ++
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/db8500-regulator.c | 221 +++++++++++++++++++++++++++++++++++
 4 files changed, 235 insertions(+)

diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
index a6fef302c994..fd6a075e4c93 100644
--- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
@@ -673,6 +673,7 @@ db8500-prcmu-regulators {
 				// DB8500_REGULATOR_VAPE
 				db8500_vape_reg: db8500_vape {
 					regulator-always-on;
+					power-domains = <&pm_domains DOMAIN_VAPE>;
 				};
 
 				// DB8500_REGULATOR_VARM
@@ -693,6 +694,7 @@ db8500_vsmps1_reg: db8500_vsmps1 {
 
 				// DB8500_REGULATOR_VSMPS2
 				db8500_vsmps2_reg: db8500_vsmps2 {
+					power-domains = <&pm_domains DOMAIN_VSMPS2>;
 				};
 
 				// DB8500_REGULATOR_VSMPS3
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index acc698c17bd2..8db63d8d3fa4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -397,6 +397,17 @@ config REGULATOR_DA9210
 	  converter 12A DC-DC Buck controlled through an I2C
 	  interface.
 
+config REGULATOR_DB8500
+	bool "ST-Ericsson DB8500 power domain regulators"
+	depends on MFD_DB8500_PRCMU && UX500_PM_DOMAIN && OF
+	default ARCH_U8500
+	help
+	  This driver supports the DB8500 VAPE and VSMPS2 regulators.
+	  These supplies are represented by generic power domains in hardware,
+	  but the same voltage rails are routed out of the chip and used to
+	  supply external peripherals.
+	  Enable this driver to bridge those regulator consumers to genpd.
+
 config REGULATOR_DA9211
 	tristate "Dialog Semiconductor DA9211/DA9212/DA9213/DA9223/DA9214/DA9224/DA9215/DA9225 regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 96a02063b843..f4109549525a 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_REGULATOR_DA9063)	+= da9063-regulator.o
 obj-$(CONFIG_REGULATOR_DA9121) += da9121-regulator.o
 obj-$(CONFIG_REGULATOR_DA9210) += da9210-regulator.o
 obj-$(CONFIG_REGULATOR_DA9211) += da9211-regulator.o
+obj-$(CONFIG_REGULATOR_DB8500) += db8500-regulator.o
 obj-$(CONFIG_REGULATOR_FAN53555) += fan53555.o
 obj-$(CONFIG_REGULATOR_FAN53880) += fan53880.o
 obj-$(CONFIG_REGULATOR_GPIO) += gpio-regulator.o
diff --git a/drivers/regulator/db8500-regulator.c b/drivers/regulator/db8500-regulator.c
new file mode 100644
index 000000000000..c5a9a1baaf8e
--- /dev/null
+++ b/drivers/regulator/db8500-regulator.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Linus Walleij <linusw@kernel.org>
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/slab.h>
+
+struct db8500_regulator_info {
+	struct regulator_desc desc;
+	struct regulator_init_data init_data;
+	struct device pd_dev;
+	bool enabled;
+};
+
+struct db8500_regulator_match {
+	const char *name;
+	const char *supply_name;
+	const char *constraint_name;
+	int fixed_uV;
+	bool always_on;
+};
+
+static const struct db8500_regulator_match db8500_regulator_matches[] = {
+	{
+		.name = "db8500_vape",
+		.supply_name = "db8500-vape",
+		.constraint_name = "db8500-vape",
+		.always_on = true,
+	}, {
+		.name = "db8500_vsmps2",
+		.supply_name = "db8500-vsmps2",
+		.constraint_name = "db8500-vsmps2",
+		.fixed_uV = 1800000,
+	},
+};
+
+static int db8500_regulator_enable(struct regulator_dev *rdev)
+{
+	struct db8500_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&info->pd_dev);
+	if (ret)
+		return ret;
+
+	info->enabled = true;
+	return 0;
+}
+
+static int db8500_regulator_disable(struct regulator_dev *rdev)
+{
+	struct db8500_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_put_sync_suspend(&info->pd_dev);
+	if (ret)
+		return ret;
+
+	info->enabled = false;
+	return 0;
+}
+
+static int db8500_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct db8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	return info->enabled;
+}
+
+static int db8500_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct db8500_regulator_info *info = rdev_get_drvdata(rdev);
+
+	if (!info->desc.fixed_uV)
+		return -EINVAL;
+
+	return info->desc.fixed_uV;
+}
+
+static const struct regulator_ops db8500_regulator_ops = {
+	.enable = db8500_regulator_enable,
+	.disable = db8500_regulator_disable,
+	.is_enabled = db8500_regulator_is_enabled,
+	.get_voltage = db8500_regulator_get_voltage,
+};
+
+static void db8500_regulator_release(struct device *dev)
+{
+}
+
+static void db8500_regulator_cleanup(void *data)
+{
+	struct db8500_regulator_info *info = data;
+
+	pm_runtime_disable(&info->pd_dev);
+	dev_pm_domain_detach(&info->pd_dev, true);
+	put_device(&info->pd_dev);
+}
+
+static const struct db8500_regulator_match *
+db8500_regulator_match(struct device_node *np)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(db8500_regulator_matches); i++) {
+		if (of_node_name_eq(np, db8500_regulator_matches[i].name))
+			return &db8500_regulator_matches[i];
+	}
+
+	return NULL;
+}
+
+static int db8500_regulator_register(struct platform_device *pdev,
+				     struct device_node *np)
+{
+	const struct db8500_regulator_match *match;
+	struct regulator_config config = { };
+	struct db8500_regulator_info *info;
+	struct of_phandle_args pd_args;
+	struct regulator_dev *rdev;
+	const char *cells = "#power-domain-cells";
+	int ret;
+
+	match = db8500_regulator_match(np);
+	if (!match)
+		return 0;
+
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	device_initialize(&info->pd_dev);
+	info->pd_dev.parent = &pdev->dev;
+	info->pd_dev.of_node = np;
+	info->pd_dev.release = db8500_regulator_release;
+	ret = dev_set_name(&info->pd_dev, "%s-pd", match->name);
+	if (ret)
+		goto put_device;
+
+	ret = of_parse_phandle_with_args(np, "power-domains", cells, 0, &pd_args);
+	if (ret)
+		goto put_device;
+
+	ret = of_genpd_add_device(&pd_args, &info->pd_dev);
+	of_node_put(pd_args.np);
+	if (ret)
+		goto put_device;
+
+	pm_runtime_enable(&info->pd_dev);
+	ret = devm_add_action_or_reset(&pdev->dev, db8500_regulator_cleanup, info);
+	if (ret)
+		return ret;
+
+	info->init_data.constraints.name = match->constraint_name;
+	info->init_data.constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
+	info->init_data.constraints.always_on = match->always_on;
+
+	info->desc.name = match->supply_name;
+	info->desc.of_match = match->name;
+	info->desc.ops = &db8500_regulator_ops;
+	info->desc.type = REGULATOR_VOLTAGE;
+	info->desc.owner = THIS_MODULE;
+	info->desc.fixed_uV = match->fixed_uV;
+	config.dev = &pdev->dev;
+	config.init_data = &info->init_data;
+	config.driver_data = info;
+	config.of_node = np;
+	rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+	if (IS_ERR(rdev))
+		return PTR_ERR(rdev);
+
+	return 0;
+
+put_device:
+	put_device(&info->pd_dev);
+	return ret;
+}
+
+static int db8500_regulator_probe(struct platform_device *pdev)
+{
+	struct device_node *np;
+	int ret;
+
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		ret = db8500_regulator_register(pdev, np);
+		if (ret) {
+			of_node_put(np);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id db8500_regulator_match_table[] = {
+	{ .compatible = "stericsson,db8500-prcmu-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, db8500_regulator_match_table);
+
+static struct platform_driver db8500_regulator_driver = {
+	.driver = {
+		.name = "db8500-prcmu-regulators",
+		.of_match_table = db8500_regulator_match_table,
+	},
+	.probe = db8500_regulator_probe,
+};
+module_platform_driver(db8500_regulator_driver);
+
+MODULE_AUTHOR("Linus Walleij <linusw@kernel.org>");
+MODULE_DESCRIPTION("DB8500 power-domain regulator driver");
+MODULE_LICENSE("GPL");

-- 
2.54.0

