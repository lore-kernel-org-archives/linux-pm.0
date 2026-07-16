Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F940863E;
	Thu, 16 Jul 2026 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202173; cv=none; b=R8K/cXhBt3jWLH+yARnP6L/um6eMA5NN8Z3BJ2ABghSafFHN8wxAPfc8Ia9YA7a88bRU1fakg8mg4NfU95jELTCs6OlD+aV1SD4STQIfb9u+iA3E0OQGYWhAcElu96++2U5X/68/GgrKXT8MKgr7nv7y0QfLHhlh3PewvRet/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202173; c=relaxed/simple;
	bh=mDnKGAlL+LyE5R2P+uLw2Xcb/nVKH7esWgNaCjxqEXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Du2EYxEtNkGgH/iciyMDEeW1+/zGg1ZtXovAiPrF1HJh0N7Hebr7iTOgcm3SpdjJpE2befrSUrxfx7dyhjbtiJsF+yRqpLPIGK0AsQBnqoZONveO9tGSbe46uALk9kTHjEhXBBJdxQwlIDQuW0Ev3rgkfNWXFcrS/06UxcQTUAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H5luRTYK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H5luRTYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784202170;
	bh=mDnKGAlL+LyE5R2P+uLw2Xcb/nVKH7esWgNaCjxqEXE=;
	h=From:To:Cc:Subject:Date:From;
	b=H5luRTYKA8DwTVT/KRQElee5w8BfA74MIde6ben8ccwdFKeqAuzIkjhsu6yILAFI7
	 lInog16e69UDbCH1+uzEUBq2ujGgZF3REytxZwsvYFNbLP2bEoIFN9ZS6Uc3NY86Xj
	 6wzD11eUVHrlHgUKyyhmNMTg+mi6/uWkOOIf2bwkxpYF6LKW439pHQiznRFlhyccYK
	 J7rwET4l+FZoMhEpGZcd8jcxzaRZgoYDRbgPqz13YdAIUnfGDhWJGIKxItOsktrWgZ
	 quM/qj383iDR3/aKyv/gz6n2Ynb5yuAauOl3WxN75/cCuG8iLDbVnvXZ549KS11wPE
	 SHJlGJjQXT92Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EAE7817E019E;
	Thu, 16 Jul 2026 13:42:49 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: ulfh@kernel.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	nfraprado@collabora.com,
	macpaul.lin@mediatek.com,
	irving-ch.lin@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] pmdomains: mediatek: Avoid setting RTFF's CLK_DIS before NRESTORE
Date: Thu, 16 Jul 2026 13:42:47 +0200
Message-ID: <20260716114247.49685-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the PCIE_PHY (also called PEXTP_PHY) type of RTFF hardware,
there is special handling setting CLK_DIS before performing the
NRESTORE sequence for resetting the RTFF and start sequencing
from a clean state.

That special handling, though, poses an issue in case the machine
specific bootchain (bootloader in particular) ends up booting the
kernel with both PCIe MAC and PHY enabled (not just power domains)
as doing so will partially corrupt the PCIe MAC/PHY registers in
an unpredictable manner, producing either an initialization fail
in the PCI-Express drivers, or even a hard lockup!

Resolve this by simply removing the special handling: in this case
the bootchain, or remote processors, setting is getting honored by
the later check for PWR_RTFF_SAVE_FLAG presence in the RTFF ctl
register.

Fixes: 9d02c94342b3 ("pmdomain: mediatek: Add support for RTFF Hardware in MT8196/MT6991")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pmdomain/mediatek/mtk-pm-domains.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pmdomain/mediatek/mtk-pm-domains.c b/drivers/pmdomain/mediatek/mtk-pm-domains.c
index f69cf69ba0f6..df8e93638e08 100644
--- a/drivers/pmdomain/mediatek/mtk-pm-domains.c
+++ b/drivers/pmdomain/mediatek/mtk-pm-domains.c
@@ -480,16 +480,8 @@ static int scpsys_ctl_pwrseq_on(struct scpsys_domain *pd)
 	if (ret < 0)
 		return ret;
 
-	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
-		regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RTFF_CLK_DIS);
-
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_CLK_DIS_BIT);
 	regmap_clear_bits(scpsys->base, pd->data->ctl_offs, PWR_ISO_BIT);
-
-	/* Wait for RTFF HW to sync buck isolation state if this is PCIe PHY RTFF */
-	if (pd->data->rtff_type == SCPSYS_RTFF_TYPE_PCIE_PHY)
-		udelay(5);
-
 	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_RST_B_BIT);
 
 	/*
-- 
2.54.0

