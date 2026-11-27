Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796905;
	b=f3GbaHCPauvCvJUpEr6uSajiRe6IEnMsRphcrG36clgwDwfU4m08oYTFA9Yx49iBk2oH
	 WrVEqUQn2biBzLDACZBqNF60nmwUR0oLT8d4+ovFmBTgBjV48vXUOtcJqAbFXy54VB7yN
	 hMere2j4tjCp8cQ1iHiY+v8YGbBJQr22ofHy2zNQH0W5+HFSzHO2y48t10VKYTsuFhCj6
	 l/ax1z2otATsn3+h/kh5nf5JG7TW5NnnVX9NwU5ibwewU06Cr6PXcF0RNfFLKsb5o4KEn
	 wvcJRMraom5fb/lQwBZ7qI4qQaU8Uvpulig3NEcHJjkiLxHXNrOdDeIfR3wB3pJUZcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796905;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oL+U9dFhRLllOBg44Q9RKrIXzFUpKGasw+T945Pn5H4=;
	b=uWpIIDlBCXYznNtZ3UAS2OZOYyDQi7XkqVF45xnUnb/8k5TfbgentK5G1Gji/vobrQ59
	 jIMr1COwqrin0MsmrnfzIuPCyfnreH8gnicD43JP4yHeji2u+b7DAL+ZtkmYAXJYJR3Rv
	 /8rPa0Z7Cz+y7MfbR+KGUT1CImhE61XD2lU5DjZ7kNM9ViCBhl1CNZuvqCXGRnq3Am2Vp
	 +9j/RtqZqqDEEKRxDqDK/NqCxsBrFoWGfOv7IDAJOQXNGPUB5WK+lOk6cB6TTkSfyVpPj
	 ysRIaw8oSaU0ABhNO18p65qS539+lu7kcXI8pZUqWsRe8FKGVhFf2Aj86sQmvSy7M8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kzmH5v/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA89606A31E;
	Fri, 27 Nov 2026 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzmH5v/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B421F00893;
	Fri, 27 Nov 2026 16:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796904;
	bh=oL+U9dFhRLllOBg44Q9RKrIXzFUpKGasw+T945Pn5H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kzmH5v/BO9stGYeZxMeFLlZY73eJEVoVV1sWlnbVBbyiuNqTcRzHQW/Zj7PqF4Xlp
	 h8L0xeXurprEkY4hOjjoURjDfRwASQZ8UyJtM+W5PtyKEUKAZQ2isWWHCouRoqCpeZ
	 d/m5TozkNlXdYkP9parSlV1A4JRACUzfgeIazqkoR4l5x9aK8HK43rm5eF8+RURtde
	 jXVCaFyo/tSYHmzr8o4Kf3xr8YB0JgjG7A+X0EahfplzCh8kfdtoS3pRc3ZE0HhssO
	 5h5TVn1d22x0sd6HDH1NHU+2fRbsZUXlIfevQqMas2vLUC5/K9pPJqTf4JiLmGVk3j
	 vQDjrU81Yfgfg==
From: Geert Uytterhoeven <geert@kernel.org>
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
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 13/14] pmdomain: renesas: r8a78000: Add SCMI remapping support
Date: Fri, 27 Nov 2026 17:26:58 +0100
Message-ID: <21bac4cbc704669700d62351ec8aefe1165b90ce.1795796064.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795796064.git.geert+renesas@glider.be>
References: <cover.1795796064.git.geert+renesas@glider.be>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

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
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v6:
  - Register devm_add_action_or_reset() callback in get_rstcs() so
    resets are released on subsequent failures,
  - Add "r8a78000_mdlc_"-prefix to get_genpds() and get_rstcs(),
  - Move local variables to loop scope where possible,

v5:
  - Add Tested-by,
  - Rebase,
  - Shrink hardware power domain IDs and firmware IDs to 16 bits,
  - Replace unified power_map and mod_map by keeping the original
    power_id_map and mod_id_map, and adding separate arrays of genpd and
    reset_control pointers,
  - Let power_id_map_find() and mod_id_map_find() return indices,
  - Unify "Mapping HW power domain 0x%x to ..." debug prints in
    r8a78000_genpd_xlate(),
  - Move check for non-existent SCMI clock inside scmi_get_clk(),
  - Add support for missing SCMI firmware IDs indicated by -1,
  - Fix double clk_put() in pm_clk_add_clk() error handling,
  - Replace devm_kcalloc() by devm_kzalloc_objs(),
  - Fix reset control leaks in fill_mod_map() error path,
  - Replace fill_power_map() and fill_mod_map() by get_genpds() resp.
    get_rstcs(),
  - Fix scmi_clk_np reference leak by marking it __free(), and
    retaining it explicitly on probe success.
  - Drop unneeded mdlc name comments from r8a78000_mdlc_fw[],

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
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 426 +++++++++++++++++++++--
 1 file changed, 401 insertions(+), 25 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 733bf68dab2ce6dc..654c46f581478004 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -5,19 +5,41 @@
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
 
+struct power_id_map_entry {
+	u16 hw_id;		/* Hardware power domain ID */
+	u16 fw_id;		/* SCMI firmware power domain ID */
+};
+
+struct power_id_map {
+	const struct power_id_map_entry *entries;
+	unsigned int size;
+};
+
+#define POWER_ID_MAP(_entries) .power_map = &(struct power_id_map) {	\
+	.entries = _entries,						\
+	.size = ARRAY_SIZE(_entries),					\
+}
+
 struct mod_id_map_entry {
 	u16 hw_id;		/* Hardware module ID */
+	s16 fw_id;		/* SCMI clock (= reset) ID or -1 */
+	s16 fw_fck_parent;	/* SCMI functional clock parent ID or -1 */
 };
 
 struct mod_id_map {
@@ -32,9 +54,15 @@ struct mod_id_map {
 
 struct mdlc_info {
 	u32 base;
+	const struct power_id_map *power_map;
 	const struct mod_id_map *mod_map;
 };
 
+struct mdlc_data {
+	const struct mdlc_info *default_info;
+	const struct mdlc_info *fw_info;
+};
+
 /**
  * struct r8a78000_mdlc_priv - Module Controller Private Data
  *
@@ -43,7 +71,11 @@ struct mdlc_info {
  * @rcdev: Reset controller entity
  * @dev: MDLC device
  * @np: Device node in DT representing the MDLC
- * @mod_map: Mapping from hardware module IDs
+ * @scmi_clk_np: Device node in DT for the SCMI firmware clock protocol
+ * @power_map: Mapping from hardware power domain IDs to SCMI power domain IDs
+ * @mod_map: Mapping from hardware module IDs to SCMI clock and reset IDs
+ * @genpds: Power domains, indexed by @power_map entry index
+ * @rstcs: Reset controls, indexed by @mod_map entry index
  */
 struct r8a78000_mdlc_priv {
 	struct hlist_node link;
@@ -51,7 +83,11 @@ struct r8a78000_mdlc_priv {
 	struct reset_controller_dev rcdev;
 	struct device *dev;
 	struct device_node *np;
+	struct device_node *scmi_clk_np;
+	const struct power_id_map *power_map;
 	const struct mod_id_map *mod_map;
+	struct generic_pm_domain **genpds;
+	struct reset_control **rstcs;
 };
 
 static struct generic_pm_domain *r8a78000_genpd_always_on;
@@ -59,12 +95,27 @@ static struct generic_pm_domain *r8a78000_genpd_always_on;
 static HLIST_HEAD(r8a78000_mdlc_list);
 static DEFINE_MUTEX(r8a78000_mdlc_lock);	/* protects the list above */
 
+static int power_id_map_find(const struct power_id_map *map, u32 hw_id)
+{
+	if (!map)
+		return -1;
+
+	for (unsigned int i = 0; i < map->size; i++) {
+		if (map->entries[i].hw_id == hw_id)
+			return i;
+	}
+
+	return -1;
+}
+
 static struct generic_pm_domain *r8a78000_genpd_xlate(
 			const struct of_phandle_args *spec, void *data)
 {
 	struct r8a78000_mdlc_priv *priv = container_of(data,
 					struct r8a78000_mdlc_priv, genpd_data);
+	struct generic_pm_domain *genpd;
 	struct device *dev = priv->dev;
+	int idx;
 	u32 id;
 
 	if (spec->args_count != 2)
@@ -73,15 +124,22 @@ static struct generic_pm_domain *r8a78000_genpd_xlate(
 	id = spec->args[0];
 
 	if (id >= R8A78000_MDLC_PD_AON) {
-		dev_dbg(dev,
-			"Mapping HW power domain 0x%x to always-on domain\n",
-			id);
-		return r8a78000_genpd_always_on;
+		genpd = r8a78000_genpd_always_on;
+		goto found;
 	}
 
-	/* For now only always-on domains are supported */
-	dev_err(dev, "Unknown power domain 0x%x\n", id);
-	return ERR_PTR(-ENOENT);
+	idx = power_id_map_find(priv->power_map, id);
+	if (idx < 0) {
+		dev_err(dev, "Unknown power domain 0x%x\n", id);
+		return ERR_PTR(-ENOENT);
+	}
+
+	genpd = priv->genpds[idx];
+
+found:
+	dev_dbg(dev, "Mapping HW power domain 0x%x to %s\n", id, genpd->name);
+
+	return genpd;
 }
 
 #define rcdev_to_priv(_rcdev)	\
@@ -116,18 +174,22 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
 		return -ENOENT;
 	}
 
-	dev_dbg(dev, "Ignoring HW reset 0x%x\n", id);
-	return id;
+	if (!priv->rstcs[idx])
+		dev_dbg(dev, "Ignoring HW reset 0x%x\n", id);
+	else
+		dev_dbg(dev, "Mapping HW reset 0x%x to SCMI reset %d\n", id,
+			priv->mod_map->entries[idx].fw_id);
+
+	return idx;
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
+		return reset_control_ ## _op(priv->rstcs[id]);		     \
 	}
 
 DEFINE_MDLC_RESET_WRAPPER(reset)
@@ -142,12 +204,51 @@ static const struct reset_control_ops r8a78000_mdlc_reset_ops = {
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
+				s16 fw_id)
+{
+	struct of_phandle_args scmi_spec = {
+		.np = np,
+		.args_count = 1,
+		.args[0] = fw_id,
+	};
+	struct clk *clk;
+
+	if (fw_id < 0)
+		return NULL;
+
+	clk = of_clk_get_from_provider(&scmi_spec);
+	if (IS_ERR(clk))
+		dev_err(dev, "Cannot get SCMI clock %d: %pe\n", fw_id, clk);
+	else
+		dev_dbg(dev, "SCMI clock %d is %pC\n", fw_id, clk);
+
+	return clk;
+}
+
 static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 				    struct device *dev)
 {
 	struct device_node *np = dev->of_node;
+	const struct mod_id_map_entry *entry;
 	struct r8a78000_mdlc_priv *priv;
 	struct of_phandle_args pd_spec;
+	struct clk *clk, *parent;
 	int ret, idx;
 	u32 id;
 
@@ -164,9 +265,10 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
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
@@ -178,8 +280,165 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 		return -ENOENT;
 	}
 
-	dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
+	if (!priv->scmi_clk_np) {
+		dev_dbg(dev, "Ignoring HW module 0x%x\n", id);
+		return 0;
+	}
+
+	entry = &priv->mod_map->entries[idx];
+	dev_dbg(dev, "Mapping HW module 0x%x to SCMI clock %d fck parent %d\n",
+		id, entry->fw_id, entry->fw_fck_parent);
+
+	clk = scmi_get_clk(dev, priv->scmi_clk_np, entry->fw_id);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	parent = scmi_get_clk(dev, priv->scmi_clk_np, entry->fw_fck_parent);
+	if (IS_ERR(parent)) {
+		ret = PTR_ERR(parent);
+		goto fail_put_clk;
+	}
+
+	if (!clk && !parent) {
+		/* Ignore missing SCMI clocks */
+		return 0;
+	}
+
+	ret = pm_clk_create(dev);
+	if (ret)
+		goto fail_put_parent;
+
+	if (parent) {
+		ret = pm_clk_add_clk(dev, parent);
+		if (ret) {
+			pm_clk_destroy(dev);
+			goto fail_put_parent;
+		}
+	}
+	if (clk) {
+		ret = pm_clk_add_clk(dev, clk);
+		if (ret) {
+			pm_clk_destroy(dev);
+			goto fail_put_clk;
+		}
+	}
 	return 0;
+
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
+static struct generic_pm_domain **r8a78000_mdlc_get_genpds(
+					struct r8a78000_mdlc_priv *priv,
+					struct device_node *scmi_power_np)
+{
+	const struct power_id_map *map = priv->power_map;
+	struct generic_pm_domain **genpds;
+	struct device *dev = priv->dev;
+
+	if (!map)
+		return NULL;
+
+	genpds = devm_kzalloc_objs(dev, *genpds, map->size);
+	if (!genpds)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned int i = 0; i < map->size; i++) {
+		u16 fw_id = map->entries[i].fw_id;
+		struct of_phandle_args scmi_spec;
+		struct generic_pm_domain *genpd;
+
+		scmi_spec.np = scmi_power_np;
+		scmi_spec.args_count = 1;
+		scmi_spec.args[0] = fw_id;
+
+		genpd = of_genpd_get_from_provider(&scmi_spec);
+		if (IS_ERR(genpd))
+			return dev_err_cast_probe(dev, genpd,
+					"Failed to get SCMI power domain %u\n",
+					fw_id);
+
+		dev_dbg(dev, "SCMI power domain %u is %s\n", fw_id,
+			genpd->name);
+
+		genpds[i] = genpd;
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
+	return genpds;
+}
+
+static void r8a78000_mdlc_put_rstcs(void *data)
+{
+	struct r8a78000_mdlc_priv *priv = data;
+
+	for (unsigned int i = priv->mod_map->size; i--; )
+		reset_control_put(priv->rstcs[i]);
+}
+
+static struct reset_control **r8a78000_mdlc_get_rstcs(
+					struct r8a78000_mdlc_priv *priv,
+					struct fwnode_handle *scmi_reset_fwnode)
+{
+	const struct mod_id_map *map = priv->mod_map;
+	struct device *dev = priv->dev;
+	struct reset_control **rstcs;
+	int ret;
+
+	if (!map)
+		return NULL;
+
+	rstcs = devm_kzalloc_objs(dev, *rstcs, map->size);
+	if (!rstcs)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned int i = 0; i < map->size; i++) {
+		struct fwnode_reference_args scmi_spec;
+		s16 fw_id = map->entries[i].fw_id;
+		struct reset_control *rstc;
+
+		if (!scmi_reset_fwnode || fw_id < 0)
+			continue;
+
+		scmi_spec.fwnode = scmi_reset_fwnode;
+		scmi_spec.nargs = 1;
+		scmi_spec.args[0] = fw_id;
+
+		rstc = reset_control_get_from_provider_exclusive(&scmi_spec);
+		if (IS_ERR(rstc)) {
+			while (i--)
+				reset_control_put(rstcs[i]);
+
+			return dev_err_cast_probe(dev, rstc,
+					"Failed to get SCMI reset %u\n", fw_id);
+		}
+
+		rstcs[i] = rstc;
+	}
+
+	ret = devm_add_action_or_reset(dev, r8a78000_mdlc_put_rstcs, priv);
+	if (ret)
+		return dev_err_ptr_probe(dev, ret,
+					 "Failed to add reset put action\n");
+
+	return rstcs;
 }
 
 static void r8a78000_mdlc_unlink(void *data)
@@ -213,6 +472,8 @@ static int r8a78000_genpd_always_on_singleton(struct device *dev)
 
 	genpd->name = "always-on";
 	genpd->attach_dev = r8a78000_mdlc_attach_dev;
+	genpd->detach_dev = r8a78000_mdlc_detach_dev;
+	genpd->flags |= GENPD_FLAG_PM_CLK;
 
 	ret = pm_genpd_init(genpd, &pm_domain_always_on_gov, false);
 	if (ret) {
@@ -227,8 +488,13 @@ static int r8a78000_genpd_always_on_singleton(struct device *dev)
 
 static int r8a78000_mdlc_probe(struct platform_device *pdev)
 {
+	struct device_node *scmi_reset_np __free(device_node) = NULL;
+	struct device_node *scmi_power_np __free(device_node) = NULL;
+	struct device_node *scmi_clk_np __free(device_node) = NULL;
+	struct device_node *scmi __free(device_node) = NULL;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	const struct mdlc_data *mdlc_data;
 	struct r8a78000_mdlc_priv *priv;
 	const struct mdlc_info *info;
 	struct resource *res;
@@ -238,10 +504,12 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	info = of_device_get_match_data(dev);
-	if (!info)
+	mdlc_data = of_device_get_match_data(dev);
+	if (!mdlc_data)
 		return -ENODEV;
 
+	info = mdlc_data->default_info;
+
 	priv = devm_kzalloc_obj(dev, *priv);
 	if (!priv)
 		return -ENOMEM;
@@ -249,6 +517,47 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
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
@@ -263,8 +572,26 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	priv->power_map = info->power_map;
 	priv->mod_map = info->mod_map;
 
+	/*
+	 * We cannot do lazy look-up in r8a78000_genpd_xlate(), as that
+	 * function is called with of_genpd_mutex already held.
+	 */
+	priv->genpds = r8a78000_mdlc_get_genpds(priv, scmi_power_np);
+	if (IS_ERR(priv->genpds))
+		return PTR_ERR(priv->genpds);
+
+	/*
+	 * We cannot do lazy look-up in r8a78000_mdlc_reset_xlate(), as that
+	 * function is called with reset_list_mutex already held.
+	 */
+	priv->rstcs = r8a78000_mdlc_get_rstcs(priv,
+					of_fwnode_handle(scmi_reset_np));
+	if (IS_ERR(priv->rstcs))
+		return PTR_ERR(priv->rstcs);
+
 	scoped_guard(mutex, &r8a78000_mdlc_lock) {
 		hlist_add_head(&priv->link, &r8a78000_mdlc_list);
 	}
@@ -295,11 +622,14 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to register reset controller\n");
 
+	/* Retained in priv->scmi_clk_np */
+	retain_and_null_ptr(scmi_clk_np);
+
 	return 0;
 }
 
 static const struct mod_id_map_entry r8a78000_mdlc_perw_mod_default[] = {
-	{ 0x54 },	/* HSCIF0 */
+	{ 0x54, -1, -1 },	/* HSCIF0 */
 };
 
 static const struct mdlc_info r8a78000_mdlc_default[] = {
@@ -310,10 +640,56 @@ static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{ /* sentinel */ }
 };
 
+static const struct mod_id_map_entry r8a78000_mdlc_perw_mod_fw[] = {
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
+};
+
+static const struct mod_id_map_entry r8a78000_mdlc_scp_mod_fw[] = {
+	{ 0x50, 776, 1459 },	/* MSI0 / MSO_SCP_MAIN */
+	{ 0x51, 777, 1459 },	/* MSI1 / MSO_SCP_MAIN */
+	{ 0x52, 778, 1459 },	/* MSI2 / MSO_SCP_MAIN */
+	{ 0x53, 779, 1459 },	/* MSI3 / MSO_SCP_MAIN */
+};
+
+static const struct mdlc_info r8a78000_mdlc_fw[] = {
+	{
+		.base = 0xc05d0000,
+		MOD_ID_MAP(r8a78000_mdlc_perw_mod_fw),
+	}, {
+		.base = 0xc1330000,
+		MOD_ID_MAP(r8a78000_mdlc_scp_mod_fw),
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

