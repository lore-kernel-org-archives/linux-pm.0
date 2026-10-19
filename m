Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CE4F55A2
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413228; cv=none; b=WvhpZzT+EPIcE8W/6MlgD3rm+XsevigUXqJK8z/0kCj843VjH1yns9iiXYn3VuCLLnmYo/FQjp7IXWGoq6ENi5AHG1Ho0wo/NgPiSv+MvBZus+otYLZ4sOVej9G9vC3hnUytVO7FfHIhx+ibOJNr0n0pmbwu80Afv61rqGUhGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413228; c=relaxed/simple;
	bh=S946X7WmJOjDz/I1RnJitPucOmgiLmXzL4R7bahoimE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aohjuBDx0tUvrOMU0PFp2EubL9rXyzdcnNC2PnMQY+J1/Gq7hEn2/913kS+S4vmawp1GhTo6d9KV6S7hMr3ervOKoKt/J/UY0oBVY1bD+bZRUz37Ep0XwLaPNCLq/xlGlwA9sJ00uBka0tC9bS+lwvdiNYtQgIjqiKhcOFmvtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LSaJk6EK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LSaJk6EK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df54150dfso1560265f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 05:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792413217; x=1793018017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D510WMtJn6qt45zniahXCzgTs78JgIjBCMNt/1RZUFI=;
        b=LSaJk6EKbe9sCmhYSAUjs+PkAkqxObtdAH71xlPmg0IlDMw2+AaDfNzircbGhVVNbv
         IP47Xzsej6VJ8Jqg5+j8hMgHF6RbvkWRyi51Qu2RBSKjn0l7fdTP20leRaG4K0duC43s
         IoBvMaVJEinXc2c959Gs22oxVgv0ulBwJAM0sCJIGiIzyb0ZkWYEZIQGLUZ1vqMF3ZFJ
         iz8NCWRGNONziCDExFLJfYX511HAXXqDMSMqeiQuPMefSWqwY9kASbcVvDFHP+0jpkL9
         4cJvvijrojBez5OkjLRwpCmZfKQd1IJ8XBb0tD+nTvDRTEcRzCoWU0vlm5+ktZXFCFP7
         87yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792413217; x=1793018017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D510WMtJn6qt45zniahXCzgTs78JgIjBCMNt/1RZUFI=;
        b=0qtK6A55s+OU3prD8jneAF+6fi+e7dfMMxHBOzK7/1NQxNdnHvtFWG5M3/FTeF6/jF
         nmnj1nvbbUFTnkz96QiRtDdaBD43CZzeYzdx6e7IwIrn8MjzjkQbKXyQ5uAVh1EjJIvb
         M9wsCvFXrT19F828p1W2P0PDTdiN0ZJM2G4qIKBRQdu0l9RlhRsRf6zMjTzPaGRLIB3d
         7WiZdGLBKllPjzBYY1C9f2U/8xfAI1+dh6MIzEWm+T1Ty3RkxrRUf+uD72lbvjlZNE7c
         AfOlyFDsgG4Zae15la5wQutA/MPdgTnVlcRDwA/XWzD6hI4qQzNhpMXjx5Gw3AKxBaDG
         CcDg==
X-Gm-Message-State: AFq9FYLPfZNknCaHcRYVEAGOW3wI2GaAOOjE45OcSPCiBV2DS08txyXw
	lQWeKAKYuP94CPdgFzmGrzBjIiQsKDCE6+a3b7JIq/V964VYsuLqTR/m6H6nSi+JjU8=
X-Gm-Gg: AYBFou1X1zANtC+racASVL/imEUt2TGBQwNFrk/rJ4GYIrQq6KNIfQft9VhZwDDvhyL
	4V8u8SoHEDo3T1Gwg2RGB9ufwNZPBDsW/cjj9en4o4dRln7Iuabtyrw7qZ/N7pHI8V5H037L9HV
	OU+i3sojoQ5TS+sUsscXyUHurjbXvDjq0bKeDAuINGzNcc2UzfHYoRRU9fje92dGuVHZL6Yz3cX
	hfhi8ZJ2Gishc5xkYO6tx/sgTum1lZbUZB0zvbgay9/oG0Q4t0LK+hxuyod/MDK7jpR85YHnbVf
	vYtH5D9s+gpJRfw0ayJ48n9DNa+8Z/oI+Rnt/FkU9KXMBjNYgSVFQwjlNNVd4jlZd+4CWysYZzj
	xb1i8QqZAOb9dpM4Y9kYaosKh7bTQoe4OP+6gxqTXzR0TXl9iNVaq66V6y/mIfWF4Vk1jgD9ASX
	PFkA3Sukx2vkAcdoDKj2Bgt3dFno45sUo6TAWPs66aZlWmWowdy5dYTZ0jXd36Ag4P+FpsM23DI
	CBGhvdg3bNrRLtIlv32Lx9qo83Eb7u1FGlhA11p+C0d/6dbKIWW1oESm9M2Bf2nWFRpOtIkVDBs
	7v8M3u/hIOZyq91/6OnVqRxEeliEAREkGnEbR82TMiY5HSwnXhH/cSE=
X-Received: by 2002:a05:6000:4b1a:b0:48d:f034:7fcd with SMTP id ffacd0b85a97d-48e07fa2f48mr13222112f8f.51.1792413216789;
        Mon, 19 Oct 2026 05:33:36 -0700 (PDT)
Received: from [192.168.1.100] (2a02-8434-7c41-c701-8278-849f-666b-c282.rev.sfr.net. [2a02:8434:7c41:c701:8278:849f:666b:c282])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f576asm24677930f8f.32.2026.10.19.05.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 05:33:36 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 19 Oct 2026 14:33:55 +0200
Subject: [PATCH 1/2] pmdomain: mediatek: mt8365: fix defines
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-1-dfd445dc3763@baylibre.com>
References: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
In-Reply-To: <20261019-pmdomain-mtk-mt8365-fix-defines-v1-0-dfd445dc3763@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0

Fix the names of some defines for MT8365. Looking at the datasheet, some
names were not aligned with the datasheet. While at it, also fix some
indentation issues.

No functional changes expected.yy

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/pmdomain/mediatek/mt8365-pm-domains.h |  8 ++++----
 include/linux/soc/mediatek/infracfg.h         | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mt8365-pm-domains.h b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
index 33265ab8ce76..3775e4dc2c91 100644
--- a/drivers/pmdomain/mediatek/mt8365-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8365-pm-domains.h
@@ -52,7 +52,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1),
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
 				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0 |
-				MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1 |
+				MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1 |
 				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0 |
 				MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1),
 			MT8365_BUS_PROT_WAY_EN(
@@ -92,7 +92,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.sram_pdn_ack_bits = GENMASK(17, 13),
 		.bp_cfg = {
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
-				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_S |
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M),
 		},
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
@@ -129,7 +129,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI(BIT(25)),
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI(
 				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0 |
-				MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG),
+				MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1),
 		},
 	},
 	[MT8365_POWER_DOMAIN_CAM] = {
@@ -183,7 +183,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.bp_cfg = {
 			MT8365_BUS_PROT_INFRA_WR_TOPAXI_1(
-				MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB |
+				MT8365_INFRA_TOPAXI_PROTECTEN_1_DSP_EMI |
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M |
 				MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S),
 		},
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 9956e18c5ffa..d2cfa09f81ba 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -6,29 +6,29 @@
 #define MT8365_INFRA_TOPAXI_PROTECTEN_SET				0x2a0
 #define MT8365_INFRA_TOPAXI_PROTECTEN_CLR				0x2a4
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M0				BIT(1)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_MDMCU_M1				BIT(2)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MM_M1				BIT(2)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MMAPB_S				BIT(6)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_0		BIT(10)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MM2INFRA_AXI_GALS_SLV_1		BIT(11)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_AP2CONN_AHB			BIT(13)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_CONN2INFRA_AHB			BIT(14)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M0				BIT(21)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_INFRA2MFG			BIT(22)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_MFG_M1				BIT(22)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_STA1				0x258
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_SET				0x2a8
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_CLR				0x2ac
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU2AP				BIT(2)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0	BIT(16)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1	BIT(17)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST	BIT(18)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_0		BIT(16)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_MM2INFRA_AXI_GALS_MST_1		BIT(17)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_CONN2INFRA_AXI_GALS_MST		BIT(18)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_CAM2MM_AXI_GALS_MST		BIT(19)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_APU_CBIP_GALS_MST		BIT(20)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV	BIT(21)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_INFRA_GALS_ADB	BIT(24)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_PWRDNREQ_MP1_L2C_AFIFO		BIT(27)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_INFRA2CONN_AHB_GALS_SLV		BIT(21)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_DSP_EMI				BIT(24)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_S		BIT(27)
 #define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_AUDIO_M		BIT(28)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M		BIT(30)
-#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S		BIT(31)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_M			BIT(30)
+#define MT8365_INFRA_TOPAXI_PROTECTEN_1_AUDIO_BUS_DSP_S			BIT(31)
 
 #define MT8365_INFRA_NAO_TOPAXI_SI0_STA					0x0
 #define MT8365_INFRA_NAO_TOPAXI_SI0_CTRL_UPDATED			BIT(24)

-- 
2.56.0

