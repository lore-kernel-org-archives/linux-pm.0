Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A34231A3B;
	Fri, 16 Oct 2026 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166170; cv=none; b=FRltpuqLH1MHq3sHfujc+1jtG7t7rhxDlBltNNjaX5cPHY1tKP9qxeRwNJY7bV5virZbpV3RO8FClgeYwTZ8tcpNZPu3YF69fccDjjbgHS6GNcJTckhtZ20kv/0I0mtCFB9Fy6/IyCE1gt+0xVIGZIL80d4rVpkF7dOIC/de0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166170; c=relaxed/simple;
	bh=3oz/WhyBD4VJ6iAkY1tMSQTIOq8KWYct+4aZGXCZhH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9XhtBX8sCsxEXpL3xKTkX3bPd0VHWvfZT19V8JvlfZJcUr0ctYevEE3Ip/kTbrkJu9yHofVqCDcEq+fn7GSmRbNotQ74UDEQlsw0OfLQ/YncRkuNANyz2tMIYUZ0mtdf2fQF7Qbn09nsEQoWi1jRmJ3bDl1hw4/QNLA9Yd7jGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF51F1F000C6;
	Fri, 16 Oct 2026 15:56:03 +0000 (UTC)
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
Subject: [PATCH v4 1/8] clk: renesas: r8a78000: Add clk_hw to clk_map
Date: Fri, 16 Oct 2026 17:55:40 +0200
Message-ID: <1d7da50cfb58232c6dd4c4afefb938fd7e62fdcd.1792163045.git.geert+renesas@glider.be>
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

Prepare for mapping to other than fixed-rate clocks by adding a clk_hw
pointer to the clk_map structure, and populating it up-front.

Move r8a78000_cpg_priv.fixed_hws into fill_clk_map(), as it is no longer
needed afterwards, and drop NUM_FIXED_CLKS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,

v3:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 78 +++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index b8024e76743ea53d..5ffd7b89cb48e41c 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -16,19 +16,24 @@
 
 #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
 
+struct clk_map_in {
+	int dt_id;		/* DT binding clock ID or -1 sentinel */
+	u32 fw_id;		/* FIXED_CLK() ID */
+};
+
 struct clk_map {
 	int dt_id;		/* DT binding clock ID or -1 sentinel */
 	u32 fw_id;		/* FIXED_CLK() ID */
+	struct clk_hw *hw;
 };
 
 enum fixed_clk {
 	FIXED_CLK_66M,
 	FIXED_CLK_133M,
 	FIXED_CLK_266M,
-	NUM_FIXED_CLKS
 };
 
-static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
+static const unsigned long fixed_clk_rates[] = {
 	[FIXED_CLK_66M] = 66666000,
 	[FIXED_CLK_133M] = 133330000,
 	[FIXED_CLK_266M] = 266660000,
@@ -41,12 +46,10 @@ static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
  *
  * @dev: CPG device
  * @map: Mapping from DT clock IDs to fixed-rate clocks
- * @fixed_hws: Fixed rate clocks
  */
 struct r8a78000_cpg_priv {
 	struct device *dev;
 	const struct clk_map *map;
-	struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
 };
 
 static const struct clk_map *clk_map_find(const struct clk_map *map, u32 id)
@@ -83,8 +86,7 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
 	}
 
 	dev_dbg(dev, "Mapping DT clock %u to fixed clock %u\n", id, map->fw_id);
-
-	hw = priv->fixed_hws[map->fw_id];
+	hw = map->hw;
 
 	dev_dbg(dev, "clock %u is %s at %lu Hz\n", id, clk_hw_get_name(hw),
 		clk_hw_get_rate(hw));
@@ -92,35 +94,69 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec,
 	return hw;
 }
 
-static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
+static struct clk_hw **register_fixed_clks(struct device *dev)
 {
-	struct device *dev = priv->dev;
+	unsigned int n = ARRAY_SIZE(fixed_clk_rates);
+	struct clk_hw **hws, *hw;
 	unsigned long rate;
-	struct clk_hw *hw;
 	const char *name;
 
-	for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
+	hws = devm_kcalloc(dev, n, sizeof(*hws), GFP_KERNEL);
+	if (!hws)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned int i = 0; i < n; i++) {
 		rate = fixed_clk_rates[i];
 		name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
 		if (!name)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 
 		hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
 		if (IS_ERR(hw))
-			return PTR_ERR(hw);
+			return ERR_CAST(hw);
 
-		priv->fixed_hws[i] = hw;
+		hws[i] = hw;
 	}
 
-	return 0;
+	return hws;
+}
+
+static const struct clk_map *fill_clk_map(struct r8a78000_cpg_priv *priv,
+					  const struct clk_map_in *map_in)
+{
+	struct device *dev = priv->dev;
+	struct clk_hw **fixed_hws;
+	struct clk_map *map;
+	unsigned int i;
+
+	fixed_hws = register_fixed_clks(dev);
+	if (IS_ERR(fixed_hws))
+		return ERR_CAST(fixed_hws);
+
+	for (i = 0; map_in[i].dt_id >= 0; i++) { }
+
+	map = devm_kcalloc(dev, i + 1, sizeof(*map), GFP_KERNEL);
+	if (!map)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; ; i++) {
+		map[i].dt_id = map_in[i].dt_id;
+		if (map[i].dt_id < 0)
+			break;
+
+		map[i].fw_id = map_in[i].fw_id;
+		map[i].hw = fixed_hws[map[i].fw_id];
+	}
+
+	devm_kfree(dev, fixed_hws);
+	return map;
 }
 
 static int r8a78000_cpg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct r8a78000_cpg_priv *priv;
-	const struct clk_map *map;
-	int ret;
+	const struct clk_map_in *map;
 
 	map = of_device_get_match_data(dev);
 	if (!map)
@@ -131,16 +167,14 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->map = map;
-
-	ret = register_fixed_clks(priv);
-	if (ret)
-		return ret;
+	priv->map = fill_clk_map(priv, map);
+	if (IS_ERR(priv->map))
+		return PTR_ERR(priv->map);
 
 	return devm_of_clk_add_hw_provider(dev, r8a78000_clk_get, priv);
 }
 
-static const struct clk_map r8a78000_cpg_default[] = {
+static const struct clk_map_in r8a78000_cpg_default[] = {
 	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	FIXED_CLK(266M) },
 	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	FIXED_CLK(133M) },
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
-- 
2.43.0

