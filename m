Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795796893;
	b=MVYxnNMDmjZzR3vVenf7mU9lCGIP5Ct9TQ+yFX4GmiYXKsE5pjRNspUBDTTkAAGXAdO4
	 bEuyXf6Acls86WFlndNhiFsNTuPU8Ih1DIupA9Cmqr+pyaNTkZP6Hw0JYjLnimkkk4zXT
	 kixDNhn74/jqePF/O9on07XbpW6UtgN7WCsxx+ZHNgV0V1hp20TK2YxC+jSMTKXai3Hr5
	 QjpFxHTf+fvcAgS2CaawABJyIk8/MJCkgrMrWvtQ7PHpTlticQ5anSc1fUrqjc6AA6CmW
	 ErgQc63wswiIQCPgaO71uUFxeYVloYx9O/y/Yth2MnZYO7h/6oELfA04SvJNieB/LUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795796893;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EHMJCGny0SlEPLRB/7EtciCvXajGZ6KI86ky29nscL4=;
	b=OVWj8oGF1n261gT1plVKJarv5R+3/gr6XZgYFjqKnAGd01xJEw5LmGnjpPOD+/4UxKDt
	 AF/NMwhrMThVRD3FUoePYVLGk+pbncybOpwKe+u4KN9F1bpnvsZYQklubF86f+NXbQyLX
	 gxMk7lnY5l6oyRY+77R6IAtNRMEF/yIw50NUIQ0MbuwXAcN4BYIRsTfrglsUHX3QsuoLo
	 YTaIToHyAKBB8xxPrf/CLElgqw8i0UOaZPUZz9C0WmVouInqYpayhRRV9M/Y322O2fYSL
	 363GJ+PUuGnwdYHUeyJNBEmRUO9Fh/kVKXONLGeLVB9pKMCLQ8fAlS3OOyjD5zU6htg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIEkHrcf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E1606A31F;
	Fri, 27 Nov 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MIEkHrcf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB291F00A1E;
	Fri, 27 Nov 2026 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795796893;
	bh=EHMJCGny0SlEPLRB/7EtciCvXajGZ6KI86ky29nscL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MIEkHrcfKu24jV8uUf0eYZ3KgMfQEdN/tQ+Fo5d4RGgvEzc7PzJlbHHnrWlM4borN
	 4r+i5XgslamR9IfJ5/EzNilVDYxdCOTt/iGonDSYUO88re3ikpcFyS+zS84MDIxJUz
	 TGCJxXcuIO668XoNB/2OvaEokU3GjSBNaHhT2FGSrE6Cv1EaMxIEkHRUS8mYonYZ6K
	 iwUp1rEem/nAyQ2HhEoJjyRk8jf6QjMH4BbERLp3hFcLaGBQgzdHPefMDLYtZeifPD
	 kzxiTDnywtd5/Z+A3xaQUNEEbLV88IDW4x7kuobhCKQse1InqPiYj99HeHh1Ug+xQ0
	 TFtfepcKfJYew==
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
Subject: [PATCH v6 11/14] pmdomain: renesas: r8a78000: Replace sentinel by explicit ID map size
Date: Fri, 27 Nov 2026 17:26:56 +0100
Message-ID: <9b8db98f9d203fd1659c86a1be4f74f83fccf2b5.1795796064.git.geert+renesas@glider.be>
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

The use of a sentinel in the module ID mapping array will become
cumbersome when the need arises to find out the actual number of
elements in the array.  Rework the mapping data structure to fix this,
also improving naming.  Let mod_id_map_find() return an index, to be
used for indexing additional mapping target arrays later.
Add a MOD_ID_MAP() initialization macro for brevity.

While at it, drop the check for "!map" in mod_id_map_find(), as that
pointer can never be NULL.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v6:
  - Add Reviewed-by,

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

