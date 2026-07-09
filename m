Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86083E63B2;
	Thu,  9 Jul 2026 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586807; cv=none; b=gTq25x6JtQd3c0STbdCdwi7eOaPDxPODK9eW/lD0QAfSKbxbDWPc/phMTyTaIj9Ix7SZ1OtGeEwg3W7YSjKfGP4shsdLgS0wkFZiVeVH4+9rzZy5hFZKxq2ieZJGg+OP99Ty2IrHt5BNPvOe3D3x70cnenyB2KA5WgML/uFTJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586807; c=relaxed/simple;
	bh=qzkG82fCo2yCvES8L+QvDNPl1CSrAGsEROUCjOB7JQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guA22G+oD+61mJN739dVVA+ZQcuxZsSgDdgdYw4i1UxFLTTSLUV7fL0k1iN+76f4mRrdNtL7LqEUObUIJzQTcWVOMUBXKFI4UxhVSceC2nzcM75EzlyxHH/cA3QRFLbdQrnCGo9Cc+K1EgbInRyE9Yvyt6Cu/+dMhczvyy0+h1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QGdBVPxu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QGdBVPxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783586804;
	bh=qzkG82fCo2yCvES8L+QvDNPl1CSrAGsEROUCjOB7JQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGdBVPxufFk462JAQ3czVGczYRbRWJoJcyK9oeyrd7tQZehU2lWJzExKr1kq6xcY3
	 UWJSfNNWG89PQCWrZaVvDEN0ZwcIpfhNF96wFuDQO2aDBZcura4cK4gyGrDBwx3R8S
	 VOuWu4TB2riIZ2vCG0hwKpnQDdzdzUpHffydrdJHV4qjOnoK8IVuBGHFT9PfZtAzg3
	 EqeBIgimodbuRSKZuEUIQKhgzPvROpesd07wLUVYH/iiX1FlrFOgUfhjzI+2Gy8+Im
	 JESRQ5J8RmRA/XOl22mYpYlz5YzA/l2m5HM/ODSz8yrRAxVQ9tYbs276YSWHf/qROV
	 7AfqpbThMxlHg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0F1017E0E04;
	Thu, 09 Jul 2026 10:46:43 +0200 (CEST)
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
Subject: [PATCH v3 5/5] pmdomain: mediatek: Add support for MT8196 HFRP DirectCTL domains
Date: Thu,  9 Jul 2026 10:46:35 +0200
Message-ID: <20260709084635.24912-6-angelogioacchino.delregno@collabora.com>
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

Add support for the power domains provided by the HFRPSYS Power
Controller of the MT8196 SoC.
Those control power to the eDP and DP Transmitter IPs.

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 27 +++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  6 ++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mt8196-pm-domains.h b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
index 2e4b28720659..d704c9fa9337 100644
--- a/drivers/pmdomain/mediatek/mt8196-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8196-pm-domains.h
@@ -602,6 +602,27 @@ static const struct scpsys_hwv_domain_data hfrpsys_hwv_domain_data_mt8196[] = {
 	},
 };
 
+static const struct scpsys_domain_data hfrpsys_domain_data_mt8196[] = {
+	[MT8196_POWER_DOMAIN_EDPTX] = {
+		.name = "edp-tx",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0x74,
+		.pwr_sta_offs = 0x74,
+		.pwr_sta2nd_offs = 0x74,
+		.caps = MTK_SCPD_SIMPLE_PWRSEQ,
+	},
+	[MT8196_POWER_DOMAIN_DPTX] = {
+		.name = "dp-tx",
+		.sta_mask = MT8196_PWR_ACK,
+		.sta2nd_mask = MT8196_PWR_ACK_2ND,
+		.ctl_offs = 0x78,
+		.pwr_sta_offs = 0x78,
+		.pwr_sta2nd_offs = 0x78,
+		.caps = MTK_SCPD_SIMPLE_PWRSEQ,
+	},
+};
+
 static const struct scpsys_soc_data mt8196_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8196,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8196),
@@ -616,6 +637,12 @@ static const struct scpsys_soc_data mt8196_scpsys_hwv_data = {
 	.type = SCPSYS_MTCMOS_TYPE_HW_VOTER,
 };
 
+static const struct scpsys_soc_data mt8196_hfrpsys_data = {
+	.domains_data = hfrpsys_domain_data_mt8196,
+	.num_domains = ARRAY_SIZE(hfrpsys_domain_data_mt8196),
+	.type = SCPSYS_MTCMOS_TYPE_DIRECT_CTL,
+};
+
 static const struct scpsys_soc_data mt8196_hfrpsys_hwv_data = {
 	.hwv_domains_data = hfrpsys_hwv_domain_data_mt8196,
 	.num_hwv_domains = ARRAY_SIZE(hfrpsys_hwv_domain_data_mt8196),
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index 632c5dcdceda..8309a4b46afb 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1071,7 +1071,7 @@ static void scpsys_remove_one_domain(struct scpsys_domain *pd)
 		if (scpsys_hwv_domain_is_enable_done(pd))
 			scpsys_hwv_power_off_internal(pd);
 	} else {
-		if (scpsys_domain_is_on(pd))
+		if (scpsys_domain_is_on(pd) || MTK_SCPD_CAPS(pd, MTK_SCPD_SIMPLE_PWRSEQ))
 			scpsys_power_off_internal(pd);
 	}
 
@@ -1288,6 +1288,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8196-power-controller",
 		.data = &mt8196_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8196-hfrp-power-controller",
+		.data = &mt8196_hfrpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8196-hwv-hfrp-power-controller",
 		.data = &mt8196_hfrpsys_hwv_data,
-- 
2.54.0

