Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8AF481241;
	Wed,  1 Jul 2026 12:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908368; cv=none; b=CF5qOYiyHsyPF5VHBY7QXKKwDhLu6lloWBxR70+ZzH/WlhzCOFpK4r9eLk6UUIn9SzAHuJE9fPZj1TLEEFwVQ5bavIdXYE1dDKCaCYsABkpvHVhY/Jmo63uyuH7dzgTRv4XSTjTf1suZvqgmlGZ+H7uUbOkvntTCJvO6pFihw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908368; c=relaxed/simple;
	bh=TWooJiKjn16GH6/HEfDtjbdB7XRBrQNOtnBbpjNV8M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RberiZUo8CkVWiibOcxcADl652/TlqmlrUAoBQkpKBPxQvIZN7+RDVTrafjvfILvVWf6fQT6VlxPDwPZbxY/g9KHRYIBodoAkJ0L54fqJxTLwkf+86lt2DxWmF7EiTe9+eU62Z3jIPG7QhLwCkoC/+5YBoRhHVWC498krMc2Es8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MBcsVPFh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MBcsVPFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782908365;
	bh=TWooJiKjn16GH6/HEfDtjbdB7XRBrQNOtnBbpjNV8M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBcsVPFhYUxX+45W77QYy5+qffOC2+EOJZDoA6cbkQ2F27RRqZV42tHhNZxsoDXnu
	 FgLyOkA8WRm//t7P/ck7vQyRNLlMCJxpdsUb+muEv0gIOD8GkPenVGK8sdI1Luld3T
	 hBWajQPtb+Y5NO1RfHoSRqKJe6fApG3G+7Bv2Ai7xkCQZfc8PbjoKoca+ygQDeOWBG
	 mL2fp+DPLbEwucidmKPAdf1Zhgq5d8U+Gv5c03vTxZZ4CArn9HStRJJP6XNufdyUxn
	 e1vumAbLnmZx4BIIrnUeew2bksIQeRVn/L8IgPDa0bhZOOHle6mmYCeLaktcWREQmX
	 l7j2Ci9khreYQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D987417E0D72;
	Wed,  1 Jul 2026 14:19:24 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulfh@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	irving-ch.lin@mediatek.com,
	macpaul.lin@mediatek.com,
	aford173@gmail.com,
	mbrugger@suse.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	justin.yeh@mediatek.com,
	kernel@collabora.com
Subject: [PATCH 2/4] pmdomain: mediatek: Respect PD relationships during error cleanup
Date: Wed,  1 Jul 2026 14:19:18 +0200
Message-ID: <20260701121920.19347-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
References: <20260701121920.19347-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case any probe error occurs (usually, a probe deferral) the
power domains shall be cleaned up while respecting their child
to parent relationship, or the system may freeze.

In order to do that without any memory footprint impacts after
the fact, allocate a temporary array in the probe function and
use it to store the indices of the added power domains in the
correct order.

This will be used in the error cleanup path and will be freed
at the end regardless of the probe status as, when the probing
succeeds, the genpd API takes care of unregistering all PDs in
the correct order anyway.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 43 +++++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index e1cfd4223473..db543d4b1813 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -738,7 +738,8 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
 }
 
 static struct
-generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node)
+generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_node *node,
+					 u8 *domains_idx, u8 *num_domains)
 {
 	const struct scpsys_domain_data *domain_data;
 	const struct scpsys_hwv_domain_data *hwv_domain_data;
@@ -906,6 +907,7 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	else
 		pm_genpd_init(&pd->genpd, NULL, false);
 
+	domains_idx[(*num_domains)++] = (u8) id;
 	scpsys->domains[id] = &pd->genpd;
 
 	return scpsys->pd_data.domains[id];
@@ -917,7 +919,8 @@ generic_pm_domain *scpsys_add_one_domain(struct scpsys *scpsys, struct device_no
 	return ERR_PTR(ret);
 }
 
-static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent)
+static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *parent,
+				u8 *domains_idx, u8 *num_domains)
 {
 	struct generic_pm_domain *child_pd, *parent_pd;
 	struct device_node *child;
@@ -940,7 +943,7 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 
 		parent_pd = scpsys->pd_data.domains[id];
 
-		child_pd = scpsys_add_one_domain(scpsys, child);
+		child_pd = scpsys_add_one_domain(scpsys, child, domains_idx, num_domains);
 		if (IS_ERR(child_pd)) {
 			ret = PTR_ERR(child_pd);
 			dev_err_probe(scpsys->dev, ret, "%pOF: failed to get child domain id\n",
@@ -949,7 +952,7 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
 		}
 
 		/* recursive call to add all subdomains */
-		ret = scpsys_add_subdomain(scpsys, child);
+		ret = scpsys_add_subdomain(scpsys, child, domains_idx, num_domains);
 		if (ret)
 			goto err_put_node;
 
@@ -991,14 +994,16 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 	clk_bulk_put(pd->num_subsys_clks, pd->subsys_clks);
 }
 
-static void scpsys_domain_cleanup(struct scpsys *scpsys)
+static void scpsys_domain_cleanup(struct scpsys *scpsys, u8 *domains_idx, u8 num_probed)
 {
 	struct generic_pm_domain *genpd;
 	struct scpsys_domain *pd;
 	int i;
 
-	for (i = scpsys->pd_data.num_domains - 1; i >= 0; i--) {
-		genpd = scpsys->pd_data.domains[i];
+	for (i = num_probed - 1; i >= 0; i--) {
+		u8 pd_idx = domains_idx[i];
+
+		genpd = scpsys->pd_data.domains[pd_idx];
 		if (genpd) {
 			pd = to_scpsys_domain(genpd);
 			scpsys_remove_one_domain(pd);
@@ -1215,6 +1220,8 @@ static int scpsys_probe(struct platform_device *pdev)
 	struct device *parent;
 	struct scpsys *scpsys;
 	int num_domains, ret;
+	u8 num_added_pds = 0;
+	u8 *added_pds_idx;
 
 	soc = of_device_get_match_data(&pdev->dev);
 	if (!soc) {
@@ -1228,6 +1235,19 @@ static int scpsys_probe(struct platform_device *pdev)
 	if (!scpsys)
 		return -ENOMEM;
 
+	/*
+	 * Temporarily store the IDs of the power domains that are added as in
+	 * case of a probe deferral this can be used to correctly cleanup all
+	 * of what was added before.
+	 *
+	 * Note that this array is used only in the probe function and must be
+	 * freed at the end, regardless of whether all of the power domains were
+	 * probed successfully or any failure happened.
+	 */
+	added_pds_idx = devm_kmalloc_array(dev, num_domains, sizeof(*added_pds_idx), GFP_KERNEL);
+	if (!added_pds_idx)
+		return -ENOMEM;
+
 	scpsys->dev = dev;
 	scpsys->soc_data = soc;
 
@@ -1258,13 +1278,15 @@ static int scpsys_probe(struct platform_device *pdev)
 	for_each_available_child_of_node_scoped(np, node) {
 		struct generic_pm_domain *domain;
 
-		domain = scpsys_add_one_domain(scpsys, node);
+		domain = scpsys_add_one_domain(scpsys, node,
+					       added_pds_idx, &num_added_pds);
 		if (IS_ERR(domain)) {
 			ret = PTR_ERR(domain);
 			goto err_cleanup_domains;
 		}
 
-		ret = scpsys_add_subdomain(scpsys, node);
+		ret = scpsys_add_subdomain(scpsys, node,
+					   added_pds_idx, &num_added_pds);
 		if (ret)
 			goto err_cleanup_domains;
 	}
@@ -1280,10 +1302,11 @@ static int scpsys_probe(struct platform_device *pdev)
 		goto err_cleanup_domains;
 	}
 
+	devm_kfree(dev, added_pds_idx);
 	return 0;
 
 err_cleanup_domains:
-	scpsys_domain_cleanup(scpsys);
+	scpsys_domain_cleanup(scpsys, added_pds_idx, num_added_pds);
 	return ret;
 }
 
-- 
2.54.0

