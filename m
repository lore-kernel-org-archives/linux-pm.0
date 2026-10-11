Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFE93CFF6F;
	Sun, 11 Oct 2026 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744484; cv=none; b=H/6ozZD1PhfY/EGNTGSBaObU9w0C4xH4FG0eR3Zsd/u8lKWIo3qelxp0dEaT2PwKEnXMn2XN0PGY8x9A6ioIfjlXpVlM8fXUzILsoK8KqLJ2RVzRC0NK1xQsZZHBVtDNm4JM+T02M73A5sEVE4LHBSPDCzxM6YPTgJ5tOaMZkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744484; c=relaxed/simple;
	bh=FH8bZMiJ6yxewXkiwuWwjQxXXtQcnsOA7TnjlMRPRyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXOU96v1Zih4SATosHkN1ZU8safY7uHIUgYdHFKdF8oYD1dCHX7vQTbY06kzBIM4JU6xIGxene17mFtU9uBNJFUoP0ezt9hnEmYUQ9e1mn223+Kct8lg4sTIxFt1n9Zdl7TovQvvA68zmvd4u2ER9zIw2+bQYfj5bdbrsSzjeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=rDViF5s0; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="rDViF5s0"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791744481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBk6RvESsUkBNpRPMX5rC24GOsvOOpZPbOMsGvS5hwM=;
	b=rDViF5s02EchedYv9di9cRE9J3e4LCXOkFhpcC8/xaLiAJ0IvFCB6V0ihjrJBPzhdma77j
	24Dncz47e60EcX3cV+qNd17LaZ0H3xmf75Brt/kpYO9DKQJ/pmBHJ7sc3m/XQaCF+9JujK
	/qtM1es7L9aRlzmEll8bo58nTn0FaQyx46jin1uJOJVu/dmosxn7I4uKeGZNatpp74G990
	8yBrkZEfrmL3lVqws7QBa0y5KB9C1sOkbqvECvHjhq7DVJIGpivnYp/UQNlmVZjM1ZLhOe
	rrpMvq4PX5s3bJKjv9etyoaEKcW1NVOJeZ/T+Bx7CxRM4Ls3I5GkFqUKLjwOgQ==
To: ulfh@kernel.org,
	angelogioacchino.delregno@collabora.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
Subject: [PATCH v2 2/4] pmdomain: mediatek: Restore a register after powering a domain on
Date: Sun, 11 Oct 2026 20:47:53 +0200
Message-ID: <20261011184755.2058017-3-michal@nozomi.space>
In-Reply-To: <20261011184755.2058017-1-michal@nozomi.space>
References: <20261011184755.2058017-1-michal@nozomi.space>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some blocks lose a setting when their power domain is turned off, and it
has to be restored every time the domain is powered on again, before
the devices in the domain use it.

Let the domain data name such a register in one of the blocks listed in
access-controllers, and write it once the bus protection of the domain
has been released. Devicetrees that use the older per-domain phandles,
or don't list the block, keep working without the setting.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 19 +++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.h | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f0fa79e01f9c3..0585a663f48a6 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -72,6 +72,7 @@ struct scpsys_domain {
 	int num_subsys_clks;
 	struct clk_bulk_data *subsys_clks;
 	struct regulator *supply;
+	struct regmap *init_regmap;
 };
 
 struct scpsys {
@@ -79,6 +80,7 @@ struct scpsys {
 	struct regmap *base;
 	const struct scpsys_soc_data *soc_data;
 	u8 bus_prot_index[BUS_PROT_BLOCK_COUNT];
+	unsigned long bus_prot_avail;
 	struct regmap **bus_prot;
 	struct genpd_onecell_data pd_data;
 	struct generic_pm_domain *domains[];
@@ -755,6 +757,13 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		goto err_disable_sram;
 
+	if (pd->init_regmap) {
+		ret = regmap_write(pd->init_regmap, pd->data->reg_init->ofs,
+				   pd->data->reg_init->val);
+		if (ret)
+			goto err_enable_bus_protect;
+	}
+
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION)) {
 		ret = clk_bulk_prepare_enable(pd->num_subsys_clks,
 					      pd->subsys_clks);
@@ -900,6 +909,14 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	pd->hwv_data = hwv_domain_data;
 	pd->scpsys = scpsys;
 
+	if (domain_data && domain_data->reg_init) {
+		enum scpsys_bus_prot_block block = domain_data->reg_init->block;
+
+		/* Older devicetrees don't describe every block it needs */
+		if (scpsys->bus_prot_avail & BIT(block))
+			pd->init_regmap = scpsys->bus_prot[scpsys->bus_prot_index[block]];
+	}
+
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_DOMAIN_SUPPLY)) {
 		pd->supply = devm_of_regulator_get_optional(scpsys->dev, node, "domain");
 		if (IS_ERR(pd->supply))
@@ -1228,6 +1245,7 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 
 		bp_type = bp_blocks[i];
 		scpsys->bus_prot_index[bp_type] = j;
+		scpsys->bus_prot_avail |= BIT(bp_type);
 		scpsys->bus_prot[j] = regmap[i];
 
 		j++;
@@ -1268,6 +1286,7 @@ static int scpsys_get_bus_protection(struct device *dev, struct scpsys *scpsys)
 		 */
 		bp_type = soc->bus_prot_blocks[i];
 		scpsys->bus_prot_index[bp_type] = i;
+		scpsys->bus_prot_avail |= BIT(bp_type);
 
 		scpsys->bus_prot[i] = device_node_to_regmap(node);
 		of_node_put(node);
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 45da83e9d649a..4c2c56addb3cc 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -152,6 +152,18 @@ enum scpsys_mtcmos_type {
 	SCPSYS_MTCMOS_TYPE_MAX
 };
 
+/**
+ * struct scpsys_reg_init - register set up after a domain is powered on
+ * @block: The access controller block holding the register.
+ * @ofs: The offset of the register.
+ * @val: The value to write.
+ */
+struct scpsys_reg_init {
+	enum scpsys_bus_prot_block block;
+	u32 ofs;
+	u32 val;
+};
+
 /**
  * struct scpsys_domain_data - scp domain data for power on/off flow
  * @name: The name of the power domain.
@@ -165,6 +177,7 @@ enum scpsys_mtcmos_type {
  * @caps: The flag for active wake-up action.
  * @rtff_type: The power domain RTFF HW type
  * @bp_cfg: bus protection configuration for any subsystem
+ * @reg_init: register that loses its setting when the domain is powered off
  */
 struct scpsys_domain_data {
 	const char *name;
@@ -180,6 +193,7 @@ struct scpsys_domain_data {
 	const struct scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
+	const struct scpsys_reg_init *reg_init;
 };
 
 /**
-- 
2.56.0

