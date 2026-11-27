Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796840;
	b=CVKCRwNjjQHQE8FHizfpmSaFrVOGR+2G9qakVn6MViMzMZMgehfwBvUmNXMrgwp1WwQs
	 hYGXayvCEQy2drhsvgYe54+WCsh1aiR7QZNughf3D0tjeom650dqJ0cgfb7iApIqbvu9Y
	 IU8eRfvXKun5kYJEl2huHB4tsr/xHE1FZWi644nKnvABPVUvSk9AOfh3SSmpn5kQCW/46
	 SZhyg98qF/3mDDZscInpc3Km3TAf+672nTSPmNH6ucL6Dx7B0NL5W/gqx+9V5VIRT+jnt
	 bq9KPWZqNHVcfvRwblFM+0rkJygzAXIgiiw9ShG2XlxdwxSdzTcB76rd/WDGTTSsYpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796840;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SVKTmiRcZK5gge1Bcjg+ljhAOeTuRfC/PtzcGvEBSTo=;
	b=l93doAby8OrM4BspxADQ1wUeWk/Ew+D/3P7F2AFiUV7dalFwPek3rkdX3nJNRThzWvJJ
	 ueeQeTiDhK0cIqUFRwnkvPQEt+V5fuXL+0e4hQFpGQlVJtkZG5aVVT9Vi1j+dZ8c4nZWB
	 +KNHJJw/d8YvfkQk34KV5Whlpb5UpzIRwa9GUydE9WwvF6B75hAaqXvvo4B5Brl9fZ3Wi
	 GG0VhYqeJfPKjWJdKSPMSlqcGaLN1Fhy/4DMAoRUb7+GxUukDuC8s0FC5LhD/evg2yS5Y
	 kr5dwsRf7otyYW81HzK/NHplNW4c5AkwB9TgiJRx6EpzHq7sDAywMcAZBVx7e6zhgLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmjucKFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB59606A31F;
	Fri, 27 Nov 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmjucKFi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623E01F00A18;
	Fri, 27 Nov 2026 16:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796840;
	bh=SVKTmiRcZK5gge1Bcjg+ljhAOeTuRfC/PtzcGvEBSTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GmjucKFiyelRcCY/2McSIf4Gl5lKw5dIZv4gnc2ZnF+ciDaUUqPJr2xpRq1uudVuj
	 QlVNUJdeO+BgeMOM4jC3G6jk8bwqPUEz6ooQ7sk9hDUZycbaGjua0W3tq/wYRTcATs
	 y25LdROusX1fan/CgJVqtP9o+lkZBfx4246JJVT2c1k+Zsj/YhU0AwF0xGJd3jPKVh
	 kfM0ZCbqA3EYmVOKiMdBY9B07345bMC5Zik/fJziqTPhKb8DWja+PmliUxJ/5XjC/B
	 fxqh4T0chEeDb09sBqE/7JMzB+ncnJn/ImULIzemhK7WsUQbKewc9UzZxVBEFXwbTp
	 mra95VLFcAQUw==
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v6 02/14] clk: renesas: r8a78000: Replace sentinel by explicit ID map size
Date: Fri, 27 Nov 2026 17:26:47 +0100
Message-ID: <31144bbe72ef37ff50234a8666bec0b091b913e4.1795796064.git.geert+renesas@glider.be>
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

The use of a sentinel in the clock ID mapping array will become
cumbersome when the need arises to find out the actual number of
elements in the array.  Rework the mapping data structure to fix this,
also improving naming.  Add a CLK_ID_MAP() initialization macro for
brevity.

While at it, drop the check for "!map" in clk_id_map_find(), as that
pointer can never be NULL.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,

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

