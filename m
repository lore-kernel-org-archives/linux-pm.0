Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031188;
	b=kTBkLgL6p/PfxKusbq1gAaN7iG4kAEnvtrzhC+9joMHIa8ae7gU7Du3Z2+o89gKVB4A7
	 U8Cxg6x8N6WqKp9ZeLAsx99vtxJcXlAYmGxFIOaLBGQJ2aXidrHMItarAaO2fG4S23SBo
	 ORGfR7v6+uYwNmRmSFxwCOl7TlgcjdmbW9//afMetL+SsA3mI9Tgz9Zh9yeifj040JQMm
	 GsM8UyA6DYyr3ScdmlLeu0yVnMDIztSd42suyq3A/FFXWI07KlPdI83bxSfCu2x2uKXkm
	 VH4jacgq8TDrKBzlND5eIZAfB0DuIyD/qPwrQ1ggEgucxoHiiCvHFIMRTAi9PPwwcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031188;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=BTE2anEG9LPJErAH6uRm3+Ilwh8tw2gLhWmPz+1HGfo=;
	b=xmdDdQa44jLFjRrXRuDBrHGwYHL2t/OZAva2o0GlmuKTM2eOGKKqzx3sP0BK+Yf1eH6A
	 iOQSBdKSiDqmdU7hLqkUFy8InGDzn1G/tEJ2RCEPABjZJSfsnewA/2idHb0YliwzsQotR
	 zB3xjDft8WMo01hIhqa+7DqImYMaZ3a5f10VR1tMUl8Hitjm+wxlr34XD9vS/HK8S1key
	 m8YvKCUH0MugU6ZqAEPsOmBKcGJ2ZwMa0Y3RNTyvWYpwtrfthC3jM0dtv/465d5BO+F5z
	 Ccg4PCFhqV1MMyQgD5JVcWuGe807Wwy8G2kaLrFfEMOKdSicttJvDgeHK8LVVF38oLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4BF606A325;
	Wed, 18 Nov 2026 19:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50CF1F000C7;
	Wed, 18 Nov 2026 19:46:22 +0000 (UTC)
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
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 12/15] pmdomain: renesas: r8a78000: Replace sentinel by explicit ID map size
Date: Wed, 18 Nov 2026 20:45:00 +0100
Message-ID: <ee60a54c457af21277a13e8e1db36ce83209b3f5.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
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

The use of a sentinel in the module ID mapping array will become
cumbersome when the need arises to find out the actual number of
elements in the array.  Rework the mapping data structure to fix this,
also improving naming.  Let mod_id_map_find() return an index, to be
used for indexing additional mapping target arrays later.
Add a MOD_ID_MAP() initialization macro for brevity.

While at it, drop the check for "!map" in mod_id_map_find(), as that
pointer can never be NULL.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 49 +++++++++++++-----------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 1ace1fb10870f646..6477abe64511e880 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -16,13 +16,23 @@
 
 #include <dt-bindings/power/renesas,r8a78000-mdlc.h>
 
-struct mod_map {
-	int hw_id;		/* Hardware module ID or -1 sentinel */
+struct mod_id_map_entry {
+	u32 hw_id;		/* Hardware module ID */
 };
 
+struct mod_id_map {
+	const struct mod_id_map_entry *entries;
+	unsigned int size;
+};
+
+#define MOD_ID_MAP(_entries) .mod_map = &(struct mod_id_map) {		\
+	.entries = _entries,						\
+	.size = ARRAY_SIZE(_entries),					\
+}
+
 struct mdlc_info {
 	u32 base;
-	const struct mod_map *mod_map;
+	const struct mod_id_map *mod_map;
 };
 
 /**
@@ -41,7 +51,7 @@ struct r8a78000_mdlc_priv {
 	struct reset_controller_dev rcdev;
 	struct device *dev;
 	struct device_node *np;
-	const struct mod_map *mod_map;
+	const struct mod_id_map *mod_map;
 };
 
 static struct generic_pm_domain *r8a78000_genpd_always_on;
@@ -77,17 +87,14 @@ static struct generic_pm_domain *r8a78000_genpd_xlate(
 #define rcdev_to_priv(_rcdev)	\
 	container_of(_rcdev, struct r8a78000_mdlc_priv, rcdev)
 
-static const struct mod_map *mod_map_find(const struct mod_map *map, u32 id)
+static int mod_id_map_find(const struct mod_id_map *map, u32 hw_id)
 {
-	if (!map)
-		return NULL;
-
-	for (; map->hw_id >= 0; map++) {
-		if (map->hw_id == id)
-			return map;
+	for (unsigned int i = 0; i < map->size; i++) {
+		if (map->entries[i].hw_id == hw_id)
+			return i;
 	}
 
-	return NULL;
+	return -1;
 }
 
 static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
@@ -95,7 +102,7 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
 {
 	struct r8a78000_mdlc_priv *priv = rcdev_to_priv(rcdev);
 	struct device *dev = priv->dev;
-	const struct mod_map *map;
+	int idx;
 	u32 id;
 
 	if (spec->args_count != 1)
@@ -103,8 +110,8 @@ static int r8a78000_mdlc_reset_xlate(struct reset_controller_dev *rcdev,
 
 	id = spec->args[0];
 
-	map = mod_map_find(priv->mod_map, id);
-	if (!map) {
+	idx = mod_id_map_find(priv->mod_map, id);
+	if (idx < 0) {
 		dev_err(dev, "Unknown reset 0x%x\n", id);
 		return -ENOENT;
 	}
@@ -141,9 +148,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 	struct device_node *np = dev->of_node;
 	struct r8a78000_mdlc_priv *priv;
 	struct of_phandle_args pd_spec;
-	const struct mod_map *map;
 	unsigned int id;
-	int ret;
+	int ret, idx;
 
 	ret = of_parse_phandle_with_args(np, "power-domains",
 					 "#power-domain-cells", 0, &pd_spec);
@@ -166,8 +172,8 @@ static int r8a78000_mdlc_attach_dev(struct generic_pm_domain *domain,
 	id = pd_spec.args[1];
 	of_node_put(pd_spec.np);
 
-	map = mod_map_find(priv->mod_map, id);
-	if (!map) {
+	idx = mod_id_map_find(priv->mod_map, id);
+	if (idx < 0) {
 		dev_err(dev, "Unknown module 0x%x\n", id);
 		return -ENOENT;
 	}
@@ -292,15 +298,14 @@ static int r8a78000_mdlc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct mod_map r8a78000_mdlc_perw_mod_default[] = {
+static const struct mod_id_map_entry r8a78000_mdlc_perw_mod_default[] = {
 	{ 0x54 },	/* HSCIF0 */
-	{ -1 }
 };
 
 static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{
 		.base = 0xc05d0000,
-		.mod_map = r8a78000_mdlc_perw_mod_default,
+		MOD_ID_MAP(r8a78000_mdlc_perw_mod_default),
 	},
 	{ /* sentinel */ }
 };
-- 
2.43.0

