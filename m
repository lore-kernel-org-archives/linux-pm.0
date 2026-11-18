Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031131;
	b=4NX/UvDPt58SxPxf1FAWZqbAAYYmx3x4kEvQvzTZxPjptz0WbMmQ4wBqCsvAYBQyFpIx
	 mpBxQL5zFz2wD66tif+aUBNydd75buRTIJSDZafsVu4EmF9Ax7dn5g2h/klCkH5u6SWyv
	 UGGsT+rp8rRhNxz6YGtOmRRL/tb/sCSF+EHZFi7FN/K0f/OeIYylOVuxINhPln//jpM3t
	 R3nFmtgbZy8gxXqGLZ/F4jj38qIGgdT6A2Nj/bvGeH4oYPEy2nYaoCVQnaGYzmGQ8Ek2z
	 pcoo6kBTx/4goEPx8FYD5xxr+QU/BaGcDH4pbOV53CF7W+LR2GX0Pa/wCCtwkIKlESA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031131;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=aJhECeGgt3WfPc6tZWDN/yMW7/ycK7xutD466yd9uE4=;
	b=ziQaVoGfsxyu2MXSWoBHINb/VlgZ41xiW2xZN29X35YyzojrQsPDYaRLV2PeDmqJnEuG
	 N4oT8PVjjMZeRGMfPrhRf/WIjr0tQ0O915+6lXOFWTxRUxEc4DoVKQFl0eGko3/7W2Vec
	 ZnBsfnCViPeTr1tmS2uScILjo+wgA2tNkD7h4Lpb24PcOHWvdRZ1mi0bzPnACasWFS9Du
	 IYdybUmuO/+KBR+jg5KSqk1MazZSiXGY1E/hUAMsYahYlPofxxt++R2FW2GkoamXR5cZm
	 XxC8fbE60opI914YugNhrUItIpXc53LZ2arC10FsiQ9wOGHCQ3gdCuFq7b8hT0XMw3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B2606A32A;
	Wed, 18 Nov 2026 19:45:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B982F1F000C4;
	Wed, 18 Nov 2026 19:45:25 +0000 (UTC)
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v5 02/15] clk: renesas: r8a78000: Replace sentinel by explicit ID map size
Date: Wed, 18 Nov 2026 20:44:50 +0100
Message-ID: <bf9d3d694fc06f29819b6883610c0e86c2d0066e.1795029012.git.geert+renesas@glider.be>
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

The use of a sentinel in the clock ID mapping array will become
cumbersome when the need arises to find out the actual number of
elements in the array.  Rework the mapping data structure to fix this,
also improving naming.  Add a CLK_ID_MAP() initialization macro for
brevity.

While at it, drop the check for "!map" in clk_id_map_find(), as that
pointer can never be NULL.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 45 +++++++++++++++++-------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 0e11ae139fbffd80..03fcd128d4293cfc 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -16,11 +16,21 @@
 
 #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
 
-struct clk_map {
-	int dt_id;		/* DT binding clock ID or -1 sentinel */
+struct clk_id_map_entry {
+	u32 dt_id;		/* DT binding clock ID */
 	u32 fw_id;		/* FIXED_CLK() ID */
 };
 
+struct clk_id_map {
+	const struct clk_id_map_entry *entries;
+	unsigned int size;
+};
+
+#define CLK_ID_MAP(_entries) &(struct clk_id_map) {	\
+	.entries = _entries,				\
+	.size = ARRAY_SIZE(_entries),			\
+}
+
 enum fixed_clk {
 	FIXED_CLK_66M,
 	FIXED_CLK_133M,
@@ -40,23 +50,21 @@ static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
  * struct r8a78000_cpg_priv - Clock Pulse Generator Private Data
  *
  * @dev: CPG device
- * @map: Mapping from DT clock IDs to fixed-rate clocks
+ * @map: Mapping from DT clock IDs to fixed-rate clock IDs
  * @fixed_hws: Fixed rate clocks
  */
 struct r8a78000_cpg_priv {
 	struct device *dev;
-	const struct clk_map *map;
+	const struct clk_id_map *map;
 	struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
 };
 
-static const struct clk_map *clk_map_find(const struct clk_map *map, u32 id)
+static const struct clk_id_map_entry *clk_id_map_find(const struct clk_id_map *map,
+						u32 dt_id)
 {
-	if (!map)
-		return NULL;
-
-	for (; map->dt_id >= 0; map++) {
-		if (map->dt_id == id)
-			return map;
+	for (unsigned int i = 0; i < map->size; i++) {
+		if (map->entries[i].dt_id == dt_id)
+			return &map->entries[i];
 	}
 
 	return NULL;
@@ -65,8 +73,8 @@ static const struct clk_map *clk_map_find(const struct clk_map *map, u32 id)
 static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 {
 	struct r8a78000_cpg_priv *priv = data;
+	const struct clk_id_map_entry *entry;
 	struct device *dev = priv->dev;
-	const struct clk_map *map;
 	struct clk_hw *hw;
 	u32 id;
 
@@ -75,13 +83,13 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 
 	id = spec->args[0];
 
-	map = clk_map_find(priv->map, id);
-	if (!map) {
+	entry = clk_id_map_find(priv->map, id);
+	if (!entry) {
 		dev_err(dev, "Unknown clock %u\n", id);
 		return ERR_PTR(-ENOENT);
 	}
 
-	hw = priv->fixed_hws[map->fw_id];
+	hw = priv->fixed_hws[entry->fw_id];
 
 	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
 		clk_hw_get_name(hw), clk_hw_get_rate(hw));
@@ -116,7 +124,7 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct r8a78000_cpg_priv *priv;
-	const struct clk_map *map;
+	const struct clk_id_map *map;
 	int ret;
 
 	map = of_device_get_match_data(dev);
@@ -137,17 +145,16 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
 	return devm_of_clk_add_hw_provider(dev, r8a78000_clk_get, priv);
 }
 
-static const struct clk_map r8a78000_cpg_default[] = {
+static const struct clk_id_map_entry r8a78000_cpg_default[] = {
 	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	FIXED_CLK(266M) },
 	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	FIXED_CLK(133M) },
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
-	{ -1 }
 };
 
 static const struct of_device_id r8a78000_cpg_match[] = {
 	{
 		.compatible = "renesas,r8a78000-cpg",
-		.data = &r8a78000_cpg_default,
+		.data = CLK_ID_MAP(r8a78000_cpg_default),
 	},
 	{ /* sentinel */ }
 };
-- 
2.43.0

