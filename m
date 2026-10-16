Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C624E73A9;
	Fri, 16 Oct 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166203; cv=none; b=MPuw7AVqyEAhiaMLZgtvG3w5rXuOgaGrbM0vx6fDP6xQUUrPO1WpHSoCUAiZu92L4VbjREj+6wgbgxBqu9rC1WjW78OrISSG5PgCQm9vnimQgEV+yUrw+TYIi6CgOrmxz9bDH6+u5f4WZqTEOTIbjQ2+3Rw0Kb5fBXKt5XDwxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166203; c=relaxed/simple;
	bh=BxggQroowMolhSGpLVTVhjyMSj26lJonVbMmmBYyQyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZAfUCH7Gxw2DE/YVA0cg7JsVb9yWkFf8fTzBgx0YbP7S6dkDPcVHlpftuiNChTtQdPkJalHUsQVmNkatd7sngluvY+p/RqGVR3H3rjRuRukb0ET7H/TaTATBkoHf/7BDDXCwmvfomoATYiF0cwE31y/HaN5htqJQYglK69P7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF611F000C4;
	Fri, 16 Oct 2026 15:56:36 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 7/8] pmdomain: renesas: r8a78000: Add SCMI remapping support
Date: Fri, 16 Oct 2026 17:55:46 +0200
Message-ID: <2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792163045.git.geert+renesas@glider.be>
References: <cover.1792163045.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the Module Controller driver for R-Car X5H with SCMI support, to
remap hardware power domain, module, and reset IDs to abstractions
(power domains, clocks, and resets) offered by the SCMI firmware when
running on a system with SCMI, and SCMI support is enabled.  Take into
account some peculiarities of the current SCMI firmware implementations,
like missing handling of gateable functional clock parents.
Support for power domains, and module clocks and resets used by serial,
I2C, and SPI devices is included.

Note that SCMI clocks representing hardware modules expose access to
Module Standby control: they are fake clocks, with a zero clock rate,
that can just be enabled and disabled.  Hence they are controlled from
the clock domain's start/stop callbacks, together with gateable
functional clock parents.

This lets us avoid putting SCMI IDs in DT, and allows us to use the same
hardware description in SoC DTS for systems with and without SCMI
firmware.

For now, it is assumed SCMI power domain, clock, and reset IDs are
stable, and match SCP FW SDKv4.31.0 and later.

Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Let r8a78000_mdlc_attach_dev() return success when the MDLC instance
    is not found, to avoid breaking users referring in DT to an SCMI
    power-domain directly,
  - Mark scmi_{reset,power}_np __free(device_node),
  - Extract scmi_get_clk(),
  - Add support for gateable fck parents,
  - Assume all SCMI clock IDs are stable, and drop support for handling
    different ID spaces,
  - Include initial mapping table for SCP FW SDKv4.31.0 and later,
  - Propagate all reset failures, as SCP FW SDKv4.28.0 which restricted
    HSCIF0 reset is no longer supported,
  - Drop renesas,scmi-firmware support, just find an arm,scmi node
    instead,
  - Fall back to the non-SCMI defaults when any of SCMI power domain,
    clock, or reset support is disabled,

v3:
  - Rebase to v7.3-rc1,
  - Consistently use /* sentinel */ for zero sentinels,
  - s/genpd_get_from_provider/of_genpd_get_from_provider/,
  - s/firmware/renesas,scmi-firmware/,
  - Replace reset_controller_get_provider() by
    reset_control_get_from_provider_exclusive(),
  - Call reset_control_*() APIs instead of internal reset_control_ops
    methods,
  - Rename struct mod_map to struct mod_map_in,
  - Add struct mod_map, which also contains a reset_control pointer,
  - Add fill_mod_map() to obtain all SCMI reset_control structures
    up-front, as one can no longer use lazy look-up,
  - Prefix DEFINE_MDLC_RESET_WRAPPER() parameters with underscores,
  - Reword,

v2:
  - Spin off from "pmdomain: renesas: Add R-Car X5H MDLC SCMI remapping
    driver".
  - Propagate error codes from scmi_get_base_info() now it can return
    -EPROBE_DEFER,
  - Improve error message on scmi_get_base_info() failure,
  - Check if SCMI firmware node is available,
  - Replace scmi_power_np and scmi_reset_np members of struct
    r8a78000_mdlc_priv by local variables in r8a78000_mdlc_probe(), and
    pass the former to fill_power_map(),
  - Move check for supported firmware version up,
  - Fall back to the default support when SCMI support or firmware is
    not available, or when the detected SCMI firmware version is not
    supported by the driver,
  - Drop mapping tables.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 410 +++++++++++++++++++++--
 1 file changed, 386 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 1fd71bb3da776eb1..af36d8229030f6c0 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -5,24 +5,55 @@
  * Copyright (C) 2026 Glider bv
  */
 
+#include <linux/cleanup.h>
+#include <linux/clk.h>
 #include <linux/dev_printk.h>
 #include <linux/device-id/of.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/reset-controller.h>
+#include <linux/reset.h>
+#include <linux/scmi_protocol.h>
 #include <linux/slab.h>
 
 #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
 
+struct power_map_in {
+	int hw_id;		/* Hardware power domain ID or -1 sentinel */
+	u32 fw_id;		/* SCMI firmware power domain ID */
+};
+
+struct power_map {
+	int hw_id;		/* Hardware power domain ID or -1 sentinel */
+	u32 fw_id;		/* SCMI firmware power domain ID */
+	struct generic_pm_domain *genpd;
+};
+
+struct mod_map_in {
+	int hw_id;		/* Hardware module ID or -1 sentinel */
+	u32 fw_id;		/* SCMI clock and reset IDs are identical */
+	s32 fw_fck_parent;	/* SCMI functional clock parent ID or -1 */
+};
+
 struct mod_map {
 	int hw_id;		/* Hardware module ID or -1 sentinel */
+	u32 fw_id;		/* SCMI clock and reset IDs are identical */
+	s32 fw_fck_parent;	/* SCMI functional clock parent ID or -1 */
+	struct reset_control *rstc;
 };
 
 struct mdlc_info {
 	u32 base;
-	const struct mod_map *mod_map;
+	const struct power_map_in *power_map;
+	const struct mod_map_in *mod_map;
+};
+
+struct mdlc_data {
+	const struct mdlc_info *default_info;
+	const struct mdlc_info *fw_info;
 };
 
 /**
@@ -33,7 +64,9 @@ struct mdlc_info {
  * @rcdev: Reset controller entity
  * @dev: MDLC device
  * @np: Device node in DT representing the MDLC
- * @mod_map: Mapping from hardware module IDs
+ * @scmi_clk_np: Device node in DT for the SCMI firmware clock protocol
+ * @power_map: Mapping from hardware power domain IDs to SCMI power domains
+ * @mod_map: Mapping from hardware module IDs to SCMI clocks and resets
  */
 struct r8a78000_mdlc_priv {
 	struct hlist_node link;
@@ -41,6 +74,8 @@ struct r8a78000_mdlc_priv {
 	struct reset_controller_dev rcdev;
 	struct device *dev;
 	struct device_node *np;
+	struct device_node *scmi_clk_np;
+	const struct power_map *power_map;
 	const struct mod_map *mod_map;
 };
 
@@ -49,12 +84,28 @@ static struct generic_pm_domain *r8a78000_genpd_always_on;
 static HLIST_HEAD(r8a78000_mdlc_list);
 static DEFINE_MUTEX(r8a78000_mdlc_lock);	/* protects the list above */
 
+static const struct power_map *power_map_find(const struct power_map *map,
+					      u32 id)
+{
+	if (!map)
+		return NULL;
+
+	for (; map->hw_id >= 0; map++) {
+		if (map->hw_id == id)
+			return map;
+	}
+
+	return NULL;
+}
+
 static struct generic_pm_domain *r8a78000_genpd_xlate(
 			const struct of_phandle_args *spec, void *data)
 {
 	struct r8a78000_mdlc_priv *priv = container_of(data,
 					struct r8a78000_mdlc_priv, genpd_data);
+	struct generic_pm_domain *genpd;
 	struct device *dev = priv->dev;
+	const struct power_map *map;
 	u32 id;
 
 	if (spec->args_count != 2)
@@ -69,9 +120,18 @@ static struct generic_pm_domain *r8a78000_genpd_xlate(
 		return r8a78000_genpd_always_on;
 	}
 
-	/* For now only always-on domains are supported */
-	dev_err(dev, "Unknown power domain 0x%x\n", id);
-	return ERR_PTR(-ENOENT);
+	map = power_map_find(priv->power_map, id);
+	if (!map) {
+		dev_err(dev, "Unknown power domain 0x%x\n", id);
+		return ERR_PTR(-ENOENT);
+	}
+
+	dev_dbg(dev, "Mapping HW power domain 0x%x to SCMI power domain %u\n",
+		id, map->fw_id);
+
+	genpd = map->genpd;
+
+	return genpd;
 }
 
 #define rcdev_to_priv(_rcdev)	\
@@ -109,18 +169,22 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
 		return -ENOENT;
 	}
 
-	dev_dbg(dev, "Ignoring HW reset 0x%x\n", id);
-	return id;
+	if (!map->rstc)
+		dev_dbg(dev, "Ignoring HW reset 0x%x\n", id);
+	else
+		dev_dbg(dev, "Mapping HW reset 0x%x to SCMI reset %u\n", id,
+			map->fw_id);
+
+	return map - priv->mod_map;
 }
 
-#define DEFINE_MDLC_RESET_WRAPPER(op)					    \
-	static int r8a78000_mdlc_ ## op(struct reset_controller_dev *rcdev, \
-					unsigned long id)		    \
-	{								    \
-		struct r8a78000_mdlc_priv *priv = rcdev_to_priv(rcdev);	    \
-									    \
-		dev_dbg(priv->dev, "%s: Ignoring\n", __func__);		    \
-		return 0;						    \
+#define DEFINE_MDLC_RESET_WRAPPER(_op)					     \
+	static int r8a78000_mdlc_ ## _op(struct reset_controller_dev *rcdev, \
+					 unsigned long id)		     \
+	{								     \
+		struct r8a78000_mdlc_priv *priv = rcdev_to_priv(rcdev);	     \
+									     \
+		return reset_control_ ## _op(priv->mod_map[id].rstc);	     \
 	}
 
 DEFINE_MDLC_RESET_WRAPPER(reset)
@@ -135,11 +199,45 @@ static const struct reset_control_ops r8a78000_mdlc_reset_ops = {
 	.status = r8a78000_mdlc_status,
 };
 
+static struct device_node *scmi_find_proto(struct device_node *scmi, u32 proto)
+{
+	for_each_available_child_of_node_scoped(scmi, child) {
+		u32 reg;
+
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg == proto)
+			return_ptr(child);
+	}
+
+	return NULL;
+}
+
+static struct clk *scmi_get_clk(struct device *dev, struct device_node *np,
+				u32 id)
+{
+	struct of_phandle_args scmi_spec = {
+		.np = np,
+		.args_count = 1,
+		.args[0] = id,
+	};
+	struct clk *clk = of_clk_get_from_provider(&scmi_spec);
+
+	if (IS_ERR(clk))
+		dev_err(dev, "Cannot get SCMI clock %u: %pe\n", id, clk);
+	else
+		dev_dbg(dev, "SCMI clock %u is %pC\n", id, clk);
+
+	return clk;
+}
+
 static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 				    struct device *dev)
 {
 	struct device_node *np = dev->of_node;
 	struct r8a78000_mdlc_priv *priv;
+	struct clk *clk, *parent = NULL;
 	struct of_phandle_args pd_spec;
 	const struct mod_map *map;
 	unsigned int id;
@@ -158,9 +256,10 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 	}
 
 	if (!priv) {
-		dev_err(dev, "%s: MDLC %pOF not found\n", __func__, pd_spec.np);
+		dev_warn(dev, "%s: Ignoring non-MDLC %pOF\n", __func__,
+			 pd_spec.np);
 		of_node_put(pd_spec.np);
-		return -ENODEV;
+		return 0;
 	}
 
 	id = pd_spec.args[1];
@@ -172,8 +271,158 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 		return -ENOENT;
 	}
 
-	dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
+	if (!priv->scmi_clk_np) {
+		dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
+		return 0;
+	}
+
+	dev_dbg(dev, "Mapping HW module 0x%x to SCMI clock %u fck parent %d\n",
+		id, map->fw_id, map->fw_fck_parent);
+
+	clk = scmi_get_clk(dev, priv->scmi_clk_np, map->fw_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	if (!clk) {
+		/* Ignore missing SCMI module clocks */
+		return 0;
+	}
+
+	if (map->fw_fck_parent >= 0) {
+		parent = scmi_get_clk(dev, priv->scmi_clk_np,
+				      map->fw_fck_parent);
+		if (IS_ERR(parent)) {
+			ret = PTR_ERR(parent);
+			goto fail_put_clk;
+		}
+	}
+
+	ret = pm_clk_create(dev);
+	if (ret)
+		goto fail_put_parent;
+
+	if (parent)
+		ret = pm_clk_add_clk(dev, parent);
+	if (!ret)
+		ret = pm_clk_add_clk(dev, clk);
+	if (ret)
+		goto fail_destroy;
+
 	return 0;
+
+fail_destroy:
+	pm_clk_destroy(dev);
+fail_put_parent:
+	clk_put(parent);
+fail_put_clk:
+	clk_put(clk);
+	return ret;
+}
+
+static void r8a78000_mdlc_detach_dev(struct generic_pm_domain *domain,
+				     struct device *dev)
+{
+	if (!pm_clk_no_clocks(dev))
+		pm_clk_destroy(dev);
+}
+
+static const struct power_map *fill_power_map(struct r8a78000_mdlc_priv *priv,
+					      const struct power_map_in *map_in,
+					      struct device_node *scmi_power_np)
+{
+	struct of_phandle_args scmi_spec;
+	struct generic_pm_domain *genpd;
+	struct device *dev = priv->dev;
+	struct power_map *map;
+	unsigned int i;
+
+	if (!map_in)
+		return NULL;
+
+	for (i = 0; map_in[i].hw_id >= 0; i++) { }
+
+	map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; ; i++) {
+		map[i].hw_id = map_in[i].hw_id;
+		if (map[i].hw_id < 0)
+			break;
+
+		map[i].fw_id = map_in[i].fw_id;
+
+		scmi_spec.np = scmi_power_np;
+		scmi_spec.args_count = 1;
+		scmi_spec.args[0] = map[i].fw_id;
+
+		genpd = of_genpd_get_from_provider(&scmi_spec);
+		if (IS_ERR(genpd))
+			return dev_err_cast_probe(dev, genpd,
+					"Failed to get SCMI power domain %u\n",
+					map[i].fw_id);
+
+		dev_dbg(dev, "SCMI power domain %u is %s\n", map[i].fw_id,
+			genpd->name);
+
+		map[i].genpd = genpd;
+
+		/* Hook up clock domain support */
+		genpd->attach_dev = r8a78000_mdlc_attach_dev;
+		genpd->detach_dev = r8a78000_mdlc_detach_dev;
+		/* Setting flags this late has no impact, but does not hurt */
+		genpd->flags |= GENPD_FLAG_PM_CLK;
+		genpd->dev_ops.stop = pm_clk_suspend;
+		genpd->dev_ops.start = pm_clk_resume;
+	}
+
+	return map;
+}
+
+static const struct mod_map *fill_mod_map(struct r8a78000_mdlc_priv *priv,
+					  const struct mod_map_in *map_in,
+					  struct fwnode_handle *scmi_reset_fwnode)
+{
+	struct fwnode_reference_args scmi_spec;
+	struct device *dev = priv->dev;
+	struct reset_control *rstc;
+	struct mod_map *map;
+	unsigned int i;
+
+	if (!map_in)
+		return NULL;
+
+	for (i = 0; map_in[i].hw_id >= 0; i++) { }
+
+	map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; ; i++) {
+		map[i].hw_id = map_in[i].hw_id;
+		if (map[i].hw_id < 0)
+			break;
+
+		map[i].fw_id = map_in[i].fw_id;
+		map[i].fw_fck_parent = map_in[i].fw_fck_parent;
+
+		if (!scmi_reset_fwnode)
+			continue;
+
+		scmi_spec.fwnode = scmi_reset_fwnode;
+		scmi_spec.nargs = 1;
+		scmi_spec.args[0] = map[i].fw_id;
+
+		rstc = reset_control_get_from_provider_exclusive(&scmi_spec);
+		if (IS_ERR(rstc))
+			return dev_err_cast_probe(dev, rstc,
+					"Failed to get SCMI reset %u\n",
+					map[i].fw_id);
+
+		map[i].rstc = rstc;
+	}
+
+	return map;
 }
 
 static void r8a78000_mdlc_unlink(void *data)
@@ -207,6 +456,8 @@ static int r8a78000_genpd_always_on_singleton(struct device *dev)
 
 	genpd->name = "always-on";
 	genpd->attach_dev = r8a78000_mdlc_attach_dev;
+	genpd->detach_dev = r8a78000_mdlc_detach_dev;
+	genpd->flags |= GENPD_FLAG_PM_CLK;
 
 	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
 	if (ret) {
@@ -221,8 +472,13 @@ static int r8a78000_genpd_always_on_singleton(struct device *dev)
 
 static int r8a78000_mdlc_probe(struct platform_device *pdev)
 {
+	struct device_node *scmi_reset_np __free(device_node) = NULL;
+	struct device_node *scmi_power_np __free(device_node) = NULL;
+	struct device_node *scmi __free(device_node) = NULL;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct mdlc_data *mdlc_data;
+	struct device_node *scmi_clk_np;
 	struct r8a78000_mdlc_priv *priv;
 	const struct mdlc_info *info;
 	struct resource *res;
@@ -232,10 +488,12 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	info = of_device_get_match_data(dev);
-	if (!info)
+	mdlc_data = of_device_get_match_data(dev);
+	if (!mdlc_data)
 		return -ENODEV;
 
+	info = mdlc_data->default_info;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -243,6 +501,47 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->np = np;
 
+	if (!IS_ENABLED(CONFIG_ARM_SCMI_POWER_DOMAIN) ||
+	    !IS_ENABLED(CONFIG_COMMON_CLK_SCMI) ||
+	    !IS_ENABLED(CONFIG_RESET_SCMI)) {
+		dev_dbg(dev, "SCMI pmdomain/clock/reset support is disabled\n");
+		goto fallback;
+	}
+
+	scmi = of_find_compatible_node(NULL, NULL, "arm,scmi");
+	if (!scmi) {
+		dev_dbg(dev, "Cannot find SCMI firmware node\n");
+		goto fallback;
+	}
+
+	if (!of_device_is_available(scmi)) {
+		dev_dbg(dev, "SCMI firmware node is not available\n");
+		goto fallback;
+	}
+
+	scmi_power_np = scmi_find_proto(scmi, SCMI_PROTOCOL_POWER);
+	if (!scmi_power_np) {
+		dev_dbg(dev,
+			"Cannot find SCMI power domain management protocol\n");
+		goto fallback;
+	}
+
+	scmi_clk_np = scmi_find_proto(scmi, SCMI_PROTOCOL_CLOCK);
+	if (!scmi_clk_np) {
+		dev_dbg(dev, "Cannot find SCMI clock management protocol\n");
+		goto fallback;
+	}
+
+	scmi_reset_np = scmi_find_proto(scmi, SCMI_PROTOCOL_RESET);
+	if (!scmi_reset_np) {
+		dev_dbg(dev, "Cannot find SCMI reset management protocol\n");
+		goto fallback;
+	}
+
+	priv->scmi_clk_np = scmi_clk_np;
+	info = mdlc_data->fw_info;
+
+fallback:
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENODEV;
@@ -257,7 +556,22 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv->mod_map = info->mod_map;
+	/*
+	 * We cannot do lazy look-up in r8a78000_genpd_xlate(), as that
+	 * function is called with of_genpd_mutex already held.
+	 */
+	priv->power_map = fill_power_map(priv, info->power_map, scmi_power_np);
+	if (IS_ERR(priv->power_map))
+		return PTR_ERR(priv->power_map);
+
+	/*
+	 * We cannot do lazy look-up in r8a78000_mdlc_reset_xlate(), as that
+	 * function is called with reset_list_mutex already held.
+	 */
+	priv->mod_map = fill_mod_map(priv, info->mod_map,
+				     of_fwnode_handle(scmi_reset_np));
+	if (IS_ERR(priv->mod_map))
+		return PTR_ERR(priv->mod_map);
 
 	scoped_guard(mutex, &r8a78000_mdlc_lock) {
 		hlist_add_head(&priv->link, &r8a78000_mdlc_list);
@@ -292,8 +606,8 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
-	{ 0x54 },	/* HSCIF0 */
+static const struct mod_map_in r8a78000_mdlc_perw_mod_default[] = {
+	{ 0x54, 0, -1 },	/* HSCIF0 */
 	{ -1 }
 };
 
@@ -305,10 +619,58 @@ static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{ /* sentinel */ }
 };
 
+static const struct mod_map_in r8a78000_mdlc_perw_mod_fw[] = {
+	{ 0x40, 205, -1 },	/* SCIF0 */
+	{ 0x41, 206, -1 },	/* SCIF1 */
+	{ 0x42, 207, -1 },	/* SCIF3 */
+	{ 0x43, 208, -1 },	/* SCIF4 */
+	{ 0x44, 209, -1 },	/* I2C1 */
+	{ 0x45, 210, -1 },	/* I2C2 */
+	{ 0x46, 211, -1 },	/* I2C3 */
+	{ 0x47, 212, -1 },	/* I2C4 */
+	{ 0x48, 213, -1 },	/* I2C5 */
+	{ 0x49, 214, -1 },	/* I2C6 */
+	{ 0x4a, 215, -1 },	/* I2C7 */
+	{ 0x4b, 216, -1 },	/* I2C8 */
+	{ 0x4f, 220, 1667 },	/* MSI4 / MSOCK_PERW_BUS */
+	{ 0x50, 221, 1667 },	/* MSI5 / MSOCK_PERW_BUS */
+	{ 0x51, 222, 1667 },	/* MSI6 / MSOCK_PERW_BUS */
+	{ 0x52, 223, 1667 },	/* MSI7 / MSOCK_PERW_BUS */
+	{ 0x54, 224, -1 },	/* HSCIF0 */
+	{ 0x55, 225, -1 },	/* HSCIF1 */
+	{ 0x56, 226, -1 },	/* HSCIF2 */
+	{ 0x57, 227, -1 },	/* HSCIF3 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_scp_mod_fw[] = {
+	{ 0x50, 776, 1459 },	/* MSI0 / MSO_SCP_MAIN */
+	{ 0x51, 777, 1459 },	/* MSI1 / MSO_SCP_MAIN */
+	{ 0x52, 778, 1459 },	/* MSI2 / MSO_SCP_MAIN */
+	{ 0x53, 779, 1459 },	/* MSI3 / MSO_SCP_MAIN */
+	{ -1 }
+};
+
+static const struct mdlc_info r8a78000_mdlc_fw[] = {
+	{
+		.base = 0xc05d0000 /* mdlc_perw */,
+		.mod_map = r8a78000_mdlc_perw_mod_fw,
+	}, {
+		.base = 0xc1330000 /* mdlc_scp */,
+		.mod_map = r8a78000_mdlc_scp_mod_fw,
+	},
+	{ /* sentinel */ }
+};
+
+static const struct mdlc_data r8a78000_mdlc_data = {
+	.default_info = r8a78000_mdlc_default,
+	.fw_info = r8a78000_mdlc_fw,
+};
+
 static const struct of_device_id r8a78000_mdlc_match[] = {
 	{
 		.compatible = "renesas,r8a78000-mdlc",
-		.data = &r8a78000_mdlc_default,
+		.data = &r8a78000_mdlc_data,
 	},
 	{ /* sentinel */ }
 };
-- 
2.43.0

