Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91302384CFF;
	Thu, 28 May 2026 16:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985122; cv=none; b=Ql37mVNxCbVNHqTzb/2ziZAxMSZhqUxNkAJKeXElYLVblfSfCvSWlBgFLIO7YjU5hOjjpz2xIJU5/y1gh9agHBwMGVMkP2VHknIm/9mdRlOBXY8j59nwVaOIGPzlVth/7wbozu7f5arj07kK2tAn6BgH08gNuEFiHBhGCZWJrV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985122; c=relaxed/simple;
	bh=iDKvaeDvnMyZNEDCO+iH5La4SPaeOS8gVVZsISM+/78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqtxTMHWdjbuiUDght0qQzi/43nO8pm1w88dvjVex+rPE1RFxGTQChFP4ehGpXpJiMOIhaOYedLdNjYRHwXItlLuyqfegY3LIlQ3Tsjykredml3G7XxKhwr9nl7AVYJVTdffpPzF8hRnBJ1K9mGrVR2fCctjJ+UxJRPYYqTYb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b=N4aSSXvY; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b="N4aSSXvY"
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde6:a200:bc59:4aed:9f3b:ec21])
	by srv01.abscue.de (Postfix) with ESMTPSA id 420A51C6B99;
	Thu, 28 May 2026 18:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1779985112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Vvz9BBCdCjmAKX3x6b5LHDmFkQb7BZeGItD0dshHTs=;
	b=N4aSSXvY+YCObEJwmn2HDFBfkTpNYXttAo/sWsphbTAx9/6gFiZ2ygdCBwO34ca4CjNBUE
	Lj2r5MAaoNe+OXo6/XrOta6t0qCxORptlhIm56mPaxNLyaeJ/W9QnhjOttp0xbP69ClIZL
	i03vmt76S729k+Bl5B/GD5v+VPOte+Lkt9d6QReDDSlkc5HOOOfRegxgsyMLxpR1+CeMX7
	Vlppvem0fYwgboIpSzbn+orY1gzD25oY89yhNBk9D8xCGPLDaS3ARQkeD/S+Mq5enHUizp
	HZbtiNEJeTgmIPUC/f7tJJNkpy4WHekeuPVuN83Evv04SQviXIc/5uKTDRrR8w==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Thu, 28 May 2026 18:18:25 +0200
Subject: [PATCH PARTIAL-RESEND v3 3/3] regulator: sc2731: Add
 platform_device_id table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260528-sc27xx-mfd-cells-v3-3-25cd685d2743@abscue.de>
References: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
In-Reply-To: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3

Make the regulator driver for the SC2731 PMIC probe automatically. Using
a platform_device_id table instead of DT compatible matching avoids the
need for a separate compatible property in the "regulators" node, which
simplifies the DT bindings and makes the parent MFD device responsible
for selecting the correct regulator driver for the PMIC.

However, this means that the regulator device is not automatically
associated with the "regulators" node. Tell the regulator core to
perform device tree lookups using the parent MFD device instead of
the regulator sub-device and set the .regulators_node member in all
regulator definitions so that the "regulators" sub-node is used.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/regulator/sc2731-regulator.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/sc2731-regulator.c b/drivers/regulator/sc2731-regulator.c
index 5447e1a47d15..93c8156c5110 100644
--- a/drivers/regulator/sc2731-regulator.c
+++ b/drivers/regulator/sc2731-regulator.c
@@ -131,6 +131,7 @@ static const struct regulator_ops sc2731_regu_linear_ops = {
 			  vstep, vmin, vmax) {			\
 	.name			= #_id,				\
 	.of_match		= of_match_ptr(#_id),		\
+	.regulators_node	= of_match_ptr("regulators"),	\
 	.ops			= &sc2731_regu_linear_ops,	\
 	.type			= REGULATOR_VOLTAGE,		\
 	.id			= SC2731_##_id,			\
@@ -226,7 +227,7 @@ static int sc2731_regulator_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	config.dev = &pdev->dev;
+	config.dev = pdev->dev.parent;
 	config.regmap = regmap;
 
 	for (i = 0; i < ARRAY_SIZE(regulators); i++) {
@@ -242,12 +243,19 @@ static int sc2731_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id sc2731_regulator_id_table[] = {
+	{ "sc2731-regulator" },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, sc2731_regulator_id_table);
+
 static struct platform_driver sc2731_regulator_driver = {
 	.driver = {
 		.name = "sc27xx-regulator",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = sc2731_regulator_probe,
+	.id_table = sc2731_regulator_id_table,
 };
 
 module_platform_driver(sc2731_regulator_driver);

-- 
2.51.0

