Received: from mail.nozomi.space (mail.nozomi.space [139.162.184.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C3451982;
	Sun, 11 Oct 2026 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.162.184.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791744485; cv=none; b=I5h6dHmGfx+xS4J0221s4CIN/E38tRRGPJcP1xwSCngy0rGih1X4vBgoxaJjlHti9ivHts9h2sBOqsdnr6M+f10+19lpR4rzwWuZFZgpLcGkiYqP7Ln69G6QE2S9ZDTHxCj/1ygudGIFen4tPWGhZADUNTgrb4Xe36qFvywRPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791744485; c=relaxed/simple;
	bh=V/9xrX4FLy0i9fZ27bIpP+4mrin04SrHqaukfqiDcEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm7CG7q446PVkK3jpZEbn2BEHzRXWlBLQdaohTIuP+dqgRO9mjgSrCaeGg8ggcCphcTT/xMjsfEfRX4j+9GoP1c54L4S0Z8w797fCzOs7SB7d+HlBRiQDQBgp5AplalhHz8zMfCQ9W5kA2eqMrP6wa0phId8WfBus6G0wvfmcow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space; spf=pass smtp.mailfrom=nozomi.space; dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b=NL3Lv06R; arc=none smtp.client-ip=139.162.184.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nozomi.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nozomi.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nozomi.space header.i=@nozomi.space header.b="NL3Lv06R"
From: =?UTF-8?q?Micha=C5=82=20Kope=C4=87?= <michal@nozomi.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nozomi.space;
	s=mail; t=1791744482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u009rK8NBkfDo1e7Yz5QlxEzEoGCc9HxaXbQXCuXZqs=;
	b=NL3Lv06R2LADRYVeayP35rIkdbbC1D51GheIAHVayAoaf1logy/9PFsdeq7V9yl9tPaXg9
	U9dp1YBiX4eKdkZhiQJc4CGj93yL4s2C/Wu1NzHkaqN27ovWcjSC1myyVUilWAEkLj/9qw
	J5DJlBjFItleFfQppkvsht5Si95azAIAAyOIQFv6nHYaxpfArWwZUBi/QUImTfUMTjhdu6
	N6tIlGRdmqKOwSRUw90NPzouIVR7vIQ0T110/hvDQyjwJIH07fjD8Uf9tWCZDqx4aYGK6e
	jzxGBVMyohQp6rR3O2PPZKkB4bDNPwmr2iHg1DcM636aitVeT0XmEm1QtiHKzQ==
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
Subject: [PATCH v2 3/4] pmdomain: mediatek: mt8188: Enable the GPU timestamp counter
Date: Sun, 11 Oct 2026 20:47:54 +0200
Message-ID: <20261011184755.2058017-4-michal@nozomi.space>
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

The GPU timestamp counter only counts once the TOP_TSVALUEB enable bits
in MFGCFG feed it the SoC system timer, and MFGCFG loses them whenever
the MFG1 power domain is turned off. Without them GPU_TIMESTAMP reads
zero, so timestamp queries in userspace drivers and the timestamps
written by GPU jobs are always zero.

Add MFGCFG as the second MT8188 access controller and set the bits every
time MFG1 has been powered on.

Signed-off-by: Michał Kopeć <michal@nozomi.space>
---
 drivers/pmdomain/mediatek/mt8188-pm-domains.h | 16 +++++++++++++++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h    |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/mediatek/mt8188-pm-domains.h b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
index 3a989e83e9b79..88035cc6a808b 100644
--- a/drivers/pmdomain/mediatek/mt8188-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mt8188-pm-domains.h
@@ -14,8 +14,21 @@
  * MT8188 power domain support
  */
 
+#define MT8188_MFG_TIMESTAMP			0x130
+#define MT8188_MFG_TIMESTAMP_EN			GENMASK(1, 0)
+
 static enum scpsys_bus_prot_block scpsys_bus_prot_blocks_mt8188[] = {
-	BUS_PROT_BLOCK_INFRA
+	BUS_PROT_BLOCK_INFRA, BUS_PROT_BLOCK_MFGCFG
+};
+
+/*
+ * The GPU timestamp counter only counts once MFGCFG feeds it the SoC system
+ * timer, which MFGCFG forgets whenever MFG1 is powered off.
+ */
+static const struct scpsys_reg_init mt8188_mfg_timestamp = {
+	.block = BUS_PROT_BLOCK_MFGCFG,
+	.ofs = MT8188_MFG_TIMESTAMP,
+	.val = MT8188_MFG_TIMESTAMP_EN,
 };
 
 static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
@@ -70,6 +83,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8188[] = {
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
 		},
 		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+		.reg_init = &mt8188_mfg_timestamp,
 	},
 	[MT8188_POWER_DOMAIN_MFG2] = {
 		.name = "mfg2",
diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.h b/drivers/pmdomain/mediatek/mtk-pm-domains.h
index 4c2c56addb3cc..191d5cfb60fe7 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.h
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.h
@@ -71,6 +71,7 @@ enum scpsys_bus_prot_block {
 	BUS_PROT_BLOCK_CAM_SUB0,
 	BUS_PROT_BLOCK_IPE_SUB0,
 	BUS_PROT_BLOCK_VLP,
+	BUS_PROT_BLOCK_MFGCFG,
 	BUS_PROT_BLOCK_COUNT,
 };
 
-- 
2.56.0

