Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83493EFFAD;
	Thu,  9 Jul 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586806; cv=none; b=Zy7N2AeP47Xi0FrGi3BV7GWDLyMG8dyGe+f8rDwP/ISNTiLdvuBOSiTxx/9csomfQBF4CNSDJL9EqWluWRTrrQtrFUX6V7jEDMBy2ZRb7IjQmNX86SgI4lAFmO+TtD+jcenz5V5fU/nsZEgoavROXJCuTKStgKbqoi0kR/R7NXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586806; c=relaxed/simple;
	bh=6osRA33+od/IJfhhhozPKoxEL/b6MJlqtD85804PjE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPAYsQfTN1aVuRt6Gv5PhhuPMY91kCwCzpwwAc69RrFcAFcU7IqMOVoTymTT5AsOQK42UkkgC+B7am7Ewf8i5jCdYpFSYqA0yVfF49Lc48jmZbWSsz7AHskB/AmSiYwlHVTo0uC102ry2gSg1fDanstYW/qFUqv3cuKQsmkeOEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IKBtQCcn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IKBtQCcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783586803;
	bh=6osRA33+od/IJfhhhozPKoxEL/b6MJlqtD85804PjE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IKBtQCcn4ql/DDFU4vt3+X+5tttdqDrHOxqLoujeZu4ZEktvSuNuUZPsvNnVtrJSA
	 5e0/AclQQap3iFRu2IBytC/91V+B+TUudVoDMutLZ/G+0xkcSLQbPCbQR6x3QIahAw
	 /phRpWwjAFw0SiFzSee0/X8Ng0FIh8+FEOKrHuA1bGPopV0ZUUSG+glDy9gj9p4efr
	 Zg+30kx4Te7i/Rr14oB1bAncoylDkC8+OUgLRMHR5p4/ObvkshVCms5ymyH3G0x4EZ
	 I9yG/kvNifJdXhp4TDfsNazXUeg+hiIGL3V1kiLem2KUy0BSpFjhhB7dI4DwkYWvo/
	 afRs9M8xKAKzQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA1C517E0DFB;
	Thu, 09 Jul 2026 10:46:42 +0200 (CEST)
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
Subject: [PATCH v3 4/5] pmdomain: mediatek: Add support for Direct CTL simple power sequence
Date: Thu,  9 Jul 2026 10:46:34 +0200
Message-ID: <20260709084635.24912-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
References: <20260709084635.24912-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some new SoCs like MT8196, MT6991, and others, have got one
additional power controller (usually in the HFRP Multimedia
block) which needs a simplified power on/off sequence while
using Direct Control strategy.

Domains using the "simple power sequence" are not backed by
the RTFF hardware, have no Bus Protection mechanism, lacks
the ISO, PWR_ON, PWR_ON_2ND bits, and therefore get enabled
automatically after getting out of reset.

This simple power sequence is then a subset of the full one
as only needs the enablement of the specific power domain's
clock input and reset (where, again, after getting out of
reset, the ISO and PWR_ON bits are automatically internally
getting flipped) to enable or disable (power on or off).

Moreover, the simple power sequence power domains guarantee
that they always get enabled/disabled after executing the
relevant power sequence (on/off) so, differently from the
others, there is also no need to poll for a PWR_ACK.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 97 ++++++++++++++++++----
 drivers/pmdomain/mediatek/mtk-pm-domains.h |  1 +
 2 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 8d49d9ee3cd2..632c5dcdceda 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -555,9 +555,11 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 	return 0;
 }
 
-static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
+static int scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
+	bool tmp;
+	int ret;
 
 	switch (pd->data->rtff_type) {
 	case SCPSYS_RTFF_TYPE_GENERIC:
@@ -589,6 +591,41 @@ static void scpsys_ctl_pwrseq_off(struct scpsys_domain *pd)
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
+
+	/* wait until PWR_ACK = 0 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int scpsys_simple_pwrseq_on(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+
+	/* Enable subsys clock input and trigger power domain reset state */
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+
+	/* Wait for the hardware to stabilize */
+	udelay(1);
+
+	/* Get out of reset: set power on */
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+
+	return 0;
+}
+
+static int scpsys_simple_pwrseq_off(struct scpsys_domain *pd)
+{
+	struct scpsys *scpsys = pd->scpsys;
+
+	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
+
+	return 0;
 }
 
 static int scpsys_modem_pwrseq_on(struct scpsys_domain *pd)
@@ -611,14 +648,24 @@ static int scpsys_modem_pwrseq_on(struct scpsys_domain *pd)
 	return 0;
 }
 
-static void scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
+static int scpsys_modem_pwrseq_off(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
+	bool tmp;
+	int ret;
 
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
 
 	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SKIP_RESET_B))
 		regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
+
+	/* wait until PWR_ACK = 0 */
+	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
+				 MTK_POLL_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int scpsys_power_on(struct generic_pm_domain *genpd)
@@ -641,6 +688,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
 		ret = scpsys_modem_pwrseq_on(pd);
+	else if (MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
+		ret = scpsys_simple_pwrseq_on(pd);
 	else
 		ret = scpsys_ctl_pwrseq_on(pd);
 
@@ -668,9 +717,11 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 			goto err_pwr_ack;
 	}
 
-	ret = scpsys_sram_enable(pd);
-	if (ret < 0)
-		goto err_disable_subsys_clks;
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ)) {
+		ret = scpsys_sram_enable(pd);
+		if (ret < 0)
+			goto err_disable_subsys_clks;
+	}
 
 	ret = scpsys_bus_protect_disable(pd, 0);
 	if (ret < 0)
@@ -688,7 +739,8 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 err_enable_bus_protect:
 	scpsys_bus_protect_enable(pd, 0);
 err_disable_sram:
-	scpsys_sram_disable(pd);
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
+		scpsys_sram_disable(pd);
 err_disable_subsys_clks:
 	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_STRICT_BUS_PROTECTION))
 		clk_bulk_disable_unprepare(pd->num_subsys_clks,
@@ -703,16 +755,17 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 static int scpsys_power_off_internal(struct scpsys_domain *pd)
 {
 	struct scpsys *scpsys = pd->scpsys;
-	bool tmp;
 	int ret;
 
 	ret = scpsys_bus_protect_enable(pd, 0);
 	if (ret < 0)
 		return ret;
 
-	ret = scpsys_sram_disable(pd);
-	if (ret < 0)
-		return ret;
+	if (!MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ)) {
+		ret = scpsys_sram_disable(pd);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
 		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
@@ -725,15 +778,21 @@ static int scpsys_power_off_internal(struct scpsys_domain *pd)
 		return ret;
 
 	if (MTK_SCPD_CAPS(pd, MTK_SCPD_MODEM_PWRSEQ))
-		scpsys_modem_pwrseq_off(pd);
+		ret = scpsys_modem_pwrseq_off(pd);
+	else if (MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
+		ret = scpsys_simple_pwrseq_off(pd);
 	else
-		scpsys_ctl_pwrseq_off(pd);
+		ret = scpsys_ctl_pwrseq_off(pd);
+
+	if (ret < 0) {
+		/* Re-enable clocks so that next power off doesn't break the refcount */
+		int r = clk_bulk_prepare_enable(pd->num_subsys_clks, pd->subsys_clks);
+
+		if (r)
+			dev_warn(scpsys->dev, "Could not re-enable clocks: %d\n", r);
 
-	/* wait until PWR_ACK = 0 */
-	ret = readx_poll_timeout(scpsys_domain_is_on, pd, tmp, !tmp, MTK_POLL_DELAY_US,
-				 MTK_POLL_TIMEOUT);
-	if (ret < 0)
 		return ret;
+	}
 
 	clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 
@@ -1109,6 +1168,12 @@ static int scpsys_get_bus_protection_legacy(struct device *dev, struct scpsys *s
 		regmap[2] = NULL;
 	}
 
+	/* If no access controllers are needed, don't allocate and don't fail */
+	if (num_regmaps == 0) {
+		scpsys->bus_prot = NULL;
+		return 0;
+	}
+
 	scpsys->bus_prot = devm_kmalloc_array(dev, num_regmaps,
 					      sizeof(*scpsys->bus_prot), GFP_KERNEL);
 	if (!scpsys->bus_prot)
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index a5dca24cbc2f..092403de66fa 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -17,6 +17,7 @@
 #define MTK_SCPD_MODEM_PWRSEQ		BIT(10)
 #define MTK_SCPD_SKIP_RESET_B		BIT(11)
 #define MTK_SCPD_INFRA_PWR_CTL		BIT(12)
+#define MTK_SCPD_SIMPLE_PWRSEQ		BIT(13)
 #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data ?		\
 					 (_scpd)->data->caps & (_x) :	\
 					 (_scpd)->hwv_data->caps & (_x))
-- 
2.54.0

