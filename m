Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D5480DFD;
	Wed,  1 Jul 2026 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908370; cv=none; b=Q+d+iEjnm+acZMTqnz1KgMfOMoo+WjrXGqTAY9N9s+Zcgcljv5cW6uuesh70vMieHCZYwhJYxwhvxxPxgjIBxF5wJydAdTH8pVdoHj2ukgkOLQh615vc8E37x/oFDG5UHm9NXITcEVb3jt3CCju6lp+eYmMRuTdpGDbJ1w1qIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908370; c=relaxed/simple;
	bh=nFaHAQDWvz/QYHBbsjAstFu2Yh0VdHVUTI4SPQHE5lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqzBNf0an2SXuKoKaTwBAELiW8fMGvTI1ctILwyuuRBwI6QHU3FZxjNNerRZ3Le0zCO51+q9e3jUXgI2/98hMJbCbAB5EHbX/toIwiWVmcmKjC01bFFeuUcqyZ7W0IC5Sv4ZD8AIPtfud/EhBm9AzjLq5Uiyo+cyQOvTfvKil7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OZqsj0bV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OZqsj0bV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1782908367;
	bh=nFaHAQDWvz/QYHBbsjAstFu2Yh0VdHVUTI4SPQHE5lU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZqsj0bVFvsIXSdjZIFcl0e8Or8atOk2QqGzlp/Z42eqkmHtz44e2bf+VOIWbE9E1
	 cqhly5hVX7T6B33F5PfpGQTT1jpuzOyFpMTGbcreSY1gDovvwoxK49QIhVjP9zRzmy
	 hTjfkWfwL6ecDO0mm1W3CsR0lyCVuQpOZAMfoYovHLbUsBYu0lqoEXQVxyhWZacri0
	 ORDkQoz6l/mx4zKrtrat+fTs+Ev+cJ6MpI8jp2qj3Kw1apySAefZeKPZJMNqoPPdeL
	 vUSeIGP2511zH5bjRTyzjKJaUJdRt+xY0T9ew+fsydQnOVrYzinbDvZkwZk77AcylN
	 TzeBGYVUHqQWw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9733217E0FAA;
	Wed,  1 Jul 2026 14:19:26 +0200 (CEST)
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
Subject: [PATCH 4/4] pmdomain: mediatek: Add support for MT8196 HFRP DirectCTL domains
Date: Wed,  1 Jul 2026 14:19:20 +0200
Message-ID: <20260701121920.19347-5-angelogioacchino.delregno@collabora.com>
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

Add support for the power domains provided by the HFRPSYS Power
Controller of the MT8196 SoC.
Those control power to the eDP and DP Transmitter IPs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mt8196-pm-domains.h | 27 +++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c    |  4 +++
 2 files changed, 31 insertions(+)

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
index 5276adea1d04..f69cf69ba0f6 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -1252,6 +1252,10 @@ static const struct of_device_id scpsys_of_match[] = {
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

