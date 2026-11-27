Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796852;
	b=19NEVFQmkMQgEcEkHNE+nwgL6K0024BYw480q33DQ2Lml6pUd9noeZ5PMY4GnKnFJs1X
	 /ElgSLrfZAXaLMJ77ajCEBnr5FhRwVnpTpJobQCl+Ow3oUarDiNVi3evPugiqZgfXlY9l
	 HdoXWOp07YsegXMODkxnWMamC1JRwqlpwwgZS/whecY7asxOe74J3v2eRk1NF74ijvNME
	 RE/DbneuHTIj+2rhoORhUFSq62voZPCECDmDhTA+fKrGlyFjSYP3T5806JD/UR5L81OFt
	 Okj/NMRN3YRxxeJtqk0oPuj3u5y9Kiwm1odwN7vUo6VdWBy94avcEiiXW+8XaYtNSKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=t6ghU7+w8ZZQBhZV5NOW+3+ho8RPpUPWDhr1iciv+sI=;
	b=Yp3P2yXXVxD04KuA1qnEl0+Apc8Sj3YVyKAxHwNIudIOVkL8DfeB/uTVZUb2zA3nQmIs
	 /potAtnc2R+cMt2YoiaPtO8ZkFcjq7dfHHMgfhvaUcRU0QlNKPMDmQ+FChDoZJAwBmyMX
	 gzquiTcRpXlXoJwrux1erXSValYl/nzKaRQ6b4Dxaon3SLDoH/bO4Zmhbk4uppSO4NOOt
	 GwMkTHPhV1MrHihFsd1QapREkk+IL9TlZvrLEwK5MstU3fUg35QsytFuehlCcjYwoJvfh
	 wWKyxqX5pWIMCTQtEfdLVlllmtIHL35eFCAavLGxltcurMep4/kG/PUqktmB2ZMYq6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhl79klk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD0606A31F;
	Fri, 27 Nov 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jhl79klk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF71F00935;
	Fri, 27 Nov 2026 16:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796852;
	bh=t6ghU7+w8ZZQBhZV5NOW+3+ho8RPpUPWDhr1iciv+sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jhl79klkv5ibslUF6dLshF9grA3jSxN1vozBX3PWAD4C4OBSoV1o7O3vD/wZoolZQ
	 zzXI3WdoBTa81eWijGwHD1HNfBCnbignDNrJBrDXjPrnbU3aG64dc6PdtBJVKdrgbs
	 TBKyH60AcGCjAqmHjqzhgOh3OrPQJyj9yzCfBBw/Mitxw3bYdsQWCpVAex4ASuhfch
	 Yl0EP94y4H0m3AuAgvWiz63xbzm968wiBRrpmC5QVU9Dgvqy55HTWbvZNhyPF0KUgo
	 Pl6k3lQGQxFRZkYQhP4T5liXbXMsK+zubdlQul8Y+dfEdk7PMGnbqFz1BtQT79qhQA
	 4ChDiCLdVl8sQ==
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
Subject: [PATCH v6 04/14] clk: renesas: r8a78000: Add clk_hw to clk_map
Date: Fri, 27 Nov 2026 17:26:49 +0100
Message-ID: <a976c06a183aec516e57b4413af26a8afdafaeb2.1795796064.git.geert+renesas@glider.be>
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

Prepare for mapping to other than fixed-rate clocks by adding an array
of clk_hw pointers, indexed by the clock map entry index, and populating
it up-front.

Move r8a78000_cpg_priv.fixed_hws into get_hws(), as it is no longer
needed afterwards, and drop NUM_FIXED_CLKS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v6:
  - Add Reviewed-by,
  - Move local variables to loop scope where possible,

v5:
  - Add Tested-by,
  - Rebase,
  - Use kzalloc_objs() and __free() instead of devm_k{calloc,free}() for
    the temporary array of fixed clocks,
  - Replace devm_kcalloc() by devm_kzalloc_objs(),
  - Replace unified clk_map by keeping the original clk_id_map and
    adding a separate array of clk_hw pointers,
  - Let clk_id_map_find() return an index,
  - Replace fill_clk_map() by get_hws(),

v4:
  - No changes,

v3:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 79 ++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 236c638834703f95..b68fd7cd89c994df 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 Glider bv
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/dev_printk.h>
@@ -35,10 +36,9 @@ enum fixed_clk {
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
@@ -51,31 +51,30 @@ static const unsigned long fixed_clk_rates[NUM_FIXED_CLKS] = {
  *
  * @dev: CPG device
  * @map: Mapping from DT clock IDs to fixed-rate clock IDs
- * @fixed_hws: Fixed rate clocks
+ * @hws: Clocks, indexed by @map entry index
  */
 struct r8a78000_cpg_priv {
 	struct device *dev;
 	const struct clk_id_map *map;
-	struct clk_hw *fixed_hws[NUM_FIXED_CLKS];
+	struct clk_hw **hws;
 };
 
-static const struct clk_id_map_entry *clk_id_map_find(const struct clk_id_map *map,
-						u32 dt_id)
+static int clk_id_map_find(const struct clk_id_map *map, u32 dt_id)
 {
 	for (unsigned int i = 0; i < map->size; i++) {
 		if (map->entries[i].dt_id == dt_id)
-			return &map->entries[i];
+			return i;
 	}
 
-	return NULL;
+	return -1;
 }
 
 static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 {
 	struct r8a78000_cpg_priv *priv = data;
-	const struct clk_id_map_entry *entry;
 	struct device *dev = priv->dev;
 	struct clk_hw *hw;
+	int idx;
 	u32 id;
 
 	if (spec->args_count != 1)
@@ -83,13 +82,13 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 
 	id = spec->args[0];
 
-	entry = clk_id_map_find(priv->map, id);
-	if (!entry) {
+	idx = clk_id_map_find(priv->map, id);
+	if (idx < 0) {
 		dev_err(dev, "Unknown clock %u\n", id);
 		return ERR_PTR(-ENOENT);
 	}
 
-	hw = priv->fixed_hws[entry->fw_id];
+	hw = priv->hws[idx];
 
 	dev_dbg(dev, "Mapping DT clock %u to %s at %lu Hz\n", id,
 		clk_hw_get_name(hw), clk_hw_get_rate(hw));
@@ -97,27 +96,54 @@ static struct clk_hw *r8a78000_clk_get(struct of_phandle_args *spec, void *data)
 	return hw;
 }
 
-static int register_fixed_clks(struct r8a78000_cpg_priv *priv)
+static struct clk_hw **register_fixed_clks(struct device *dev)
 {
-	struct device *dev = priv->dev;
-	unsigned long rate;
-	struct clk_hw *hw;
-	const char *name;
+	unsigned int n = ARRAY_SIZE(fixed_clk_rates);
+	struct clk_hw **hws __free(kfree) = kzalloc_objs(*hws, n);
+
+	if (!hws)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned int i = 0; i < n; i++) {
+		unsigned long rate = fixed_clk_rates[i];
+		struct clk_hw *hw;
+		const char *name;
 
-	for (unsigned int i = 0; i < ARRAY_SIZE(fixed_clk_rates); i++) {
-		rate = fixed_clk_rates[i];
 		name = devm_kasprintf(dev, GFP_KERNEL, "cpg-%lu", rate);
 		if (!name)
-			return -ENOMEM;
+			return ERR_PTR(-ENOMEM);
 
 		hw = devm_clk_hw_register_fixed_rate(dev, name, NULL, 0, rate);
 		if (IS_ERR(hw))
-			return PTR_ERR(hw);
+			return ERR_CAST(hw);
+
+		hws[i] = hw;
+	}
+
+	return_ptr(hws);
+}
+
+static struct clk_hw **get_hws(struct r8a78000_cpg_priv *priv)
+{
+	const struct clk_id_map *map = priv->map;
+	struct device *dev = priv->dev;
+	struct clk_hw **hws;
+
+	struct clk_hw **fixed_hws __free(kfree) = register_fixed_clks(dev);
+	if (IS_ERR(fixed_hws))
+		return ERR_CAST(fixed_hws);
+
+	hws = devm_kzalloc_objs(dev, *hws, map->size);
+	if (!hws)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned int i = 0; i < map->size; i++) {
+		u16 fw_id = map->entries[i].fw_id;
 
-		priv->fixed_hws[i] = hw;
+		hws[i] = fixed_hws[fw_id];
 	}
 
-	return 0;
+	return hws;
 }
 
 static int r8a78000_cpg_probe(struct platform_device *pdev)
@@ -125,7 +151,6 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct r8a78000_cpg_priv *priv;
 	const struct clk_id_map *map;
-	int ret;
 
 	map = of_device_get_match_data(dev);
 	if (!map)
@@ -138,9 +163,9 @@ static int r8a78000_cpg_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->map = map;
 
-	ret = register_fixed_clks(priv);
-	if (ret)
-		return ret;
+	priv->hws = get_hws(priv);
+	if (IS_ERR(priv->hws))
+		return PTR_ERR(priv->hws);
 
 	return devm_of_clk_add_hw_provider(dev, r8a78000_clk_get, priv);
 }
-- 
2.43.0

