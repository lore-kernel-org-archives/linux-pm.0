Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA7364943;
	Tue, 21 Jul 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784631164; cv=none; b=tV1uwP46+OwKOEuv1kc9etNLWfqFExVy407SFq8MdHfc7aIz4z7iw+NPOygubk6czp6RuStxdcajFdhNTaqKECu0L30agio/Xnj1a4ljlmTtbk8hkdpBFu4VpmhQ1UJoauWH58c/atFlRZ77aPwjFSYodNvatFwbVjFwRJWBWkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784631164; c=relaxed/simple;
	bh=YiA5DltXNq9O0aocs7NhApObemt4it0eOdh1BVE1948=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JSzJ/JRozk/F5SYjtV6g4BQlUxYcgRUbwLs2/1rC+jCF+XMjSMtc7DnrIvz7KiS9Ugx7t22Z/hvoH062UHw9Ak7DgzD7dsoaH7qMf+FebC+w2A2qu6imeQ9BHFMqTajxyvhAuGFM+azmilUYYHyAEMgrY6j5Pz5TevHONVBQ1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CrUB0g5R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CrUB0g5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784631160;
	bh=YiA5DltXNq9O0aocs7NhApObemt4it0eOdh1BVE1948=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrUB0g5R0gNqQ1XeAxlQBuDcN2qdwJuJPNk1NNojT/f4bWop5OSCidwv+3lZeY+wB
	 sgtMu7s3erMIqYmrsHMHkBC3Y0n2r3DXdwQmiXQbFf4p/7lI56sZULil1t4PXmBkI9
	 x4plD8PgM/2fQRBpQXw3zyFuRTI9wAZlv/BeZMucysFzfbra6HLXdVvHS51uauurMm
	 ZwlyZA6Aucd4E9falGuBsNJOn7fLBR6TbeUAzNt/n63f+zgUGNdEpU3w0cnrre7Pig
	 MIC2Gj14tK4DYRRjVrX5mr1dZ+c+rDD3a1VTkVgf0+NnSCjkl/zIqdSF0jm7u34Esr
	 fE6TJIXL96enw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C45E717E1066;
	Tue, 21 Jul 2026 12:52:39 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	fshao@chromium.org,
	wenst@chromium.org,
	jiapeng.chong@linux.alibaba.com,
	frank-w@public-files.de,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 2/2] thermal/drivers/mediatek/lvts_thermal: Make reset optional for MT8196
Date: Tue, 21 Jul 2026 12:52:30 +0200
Message-ID: <20260721105230.101906-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
References: <20260721105230.101906-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the SoC+Firmware combination, the LVTS hardware may be
may be actively used by one or even multiple concurrent MCUs!
In this case, resetting it may produce either a severe slowdown of
the entire system, or even a thermal protection AP reset, as some
MCU(s) may be reading a very high or very low temperature while the
LVTS is being reset.

On those, don't fail if no reset is found as that may be omitted on
purpose, but still check if there's one, because some board(s) may
be running on a different bootchain with reduced firmwares or using
firmwares with reduced functionality.

So, use devm_reset_control_get_optional_exclusive() instead, as the
LVTS controller always had only one reset and retrieving that by
index, specifically, always made little sense anyway.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 92711896ce24..8b779fc5e970 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -1473,7 +1473,20 @@ static int lvts_probe(struct platform_device *pdev)
 	if (IS_ERR(lvts_td->base))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
 
-	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
+	/*
+	 * Depending on the SoC+Firmware combination, the LVTS hardware may be
+	 * may be actively used by one or even multiple concurrent MCUs!
+	 * In this case, resetting it may produce either a severe slowdown of
+	 * the entire system, or even a thermal protection AP reset, as some
+	 * MCU(s) may be reading a very high or very low temperature while the
+	 * LVTS is being reset.
+	 *
+	 * On those, don't fail if no reset is found as that may be omitted on
+	 * purpose, but still check if there's one, because some board(s) may
+	 * be running on a different bootchain with reduced firmwares or using
+	 * firmwares with reduced functionality.
+	 */
+	lvts_td->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(lvts_td->reset))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
 
-- 
2.55.0

