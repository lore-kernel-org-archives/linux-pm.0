Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02024DE712;
	Thu, 17 Sep 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646745; cv=none; b=TYYLp+TntYamvLMrW/4aCyANNso08emPdLLfh/6I+Iv1I/4xT0/WG8UimuKRuFMiC8oldi7fEpYmmUGnz4AXg5LyNK9QIS0Fnue06vb8G1QGz+0HOTGt9rkp2YaKz4+Jw2Ov9pK5LzeQb/e+0DmYMIXRmyfZyq0A3HI/jmz7GUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646745; c=relaxed/simple;
	bh=hURJEfDwAhVlfuAaZCvfS437Ibp/LYsuSioWtOtlwM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsBEGFg4WZEP0dhDOeUbABVhocwW+pkAJY0C5a1RbbWjJbENB1m+vboXbqajeQamT/PiQ0/tr4Pw8nayjfFt7FAmJ+/fXjHD2nAv0EAMjIgyDRBC6P2MnQB5U3o7wXUZ8T/no7GhX+PjodtiTfLz+Q8AG5KSRFAEiZcsxm6RjSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HyD7VnDP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HyD7VnDP"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 25024B2D;
	Thu, 17 Sep 2026 14:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646617;
	bh=hURJEfDwAhVlfuAaZCvfS437Ibp/LYsuSioWtOtlwM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HyD7VnDP7olyhm4vlof3sPHoV48cIC/hlkEU3ZLXfonXj9sooaYVIhCKgJgKawi9R
	 mknpc5cRenOzULN5CxaOtvcg/iA1naRfPQDeqP/d6PsCy6bQsKoosk09ZG4sAXpFct
	 E05kd8VoBG+EHdZY5Ix36FQ7tVfdZCTNO+84N86U=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:42 +0900
Subject: [PATCH 03/10] pmdomain: renesas: r8a78000: Add maps for VIO for
 SCP FW SDKv4.36
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-3-4c72d4e086dd@ideasonboard.com>
References: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
In-Reply-To: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-0-4c72d4e086dd@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Ulf Hansson <ulfh@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, 
 Paul Elder <paul.elder+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add maps for VIO for the VSP and FCP power domains and reset domains.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 34 ++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index a0d83f27735e7deacb060e4102e510726b34e62e..c8d34376800982000cfa1b1ae6c279edd749ec9c 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -861,6 +861,36 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_28_0[] = {
 	{ /* sentinel */ }
 };
 
+static const struct power_map_in r8a78000_mdlc_vio_power_fw_4_31_0[] = {
+	{ 0, 4 },	/* PD_VIO0 */
+	{ 1, 5 },	/* PD_VIO1 */
+	{ 2, 6 },	/* PD_VIO2 */
+	{ 3, 7 },	/* PD_VIO3 */
+	{ 7, 11 },	/* PD_VIO4 */
+	{ -1 }
+};
+static const struct mod_map_in r8a78000_mdlc_vio_mod_fw_4_31_0[] = {
+	{ 0xf9, 163 },	/* VSPB0 */
+	{ 0xfa, 164 },	/* VSPB1 */
+	{ 0xfb, 165 },	/* VSPB2 */
+	{ 0xfc, 166 },	/* VSPB3 */
+	{ 0xfd, 167 },	/* VSPB4 */
+	{ 0xfe, 168 },	/* VSPI0 */
+	{ 0xff, 169 },	/* VSPI1 */
+	{ 0x100, 170 },	/* VSPI2 */
+	{ 0x101, 171 },	/* VSPI3 */
+	{ 0x102, 172 },	/* FCPVB0 */
+	{ 0x103, 173 },	/* FCPVB1 */
+	{ 0x104, 174 },	/* FCPVB2 */
+	{ 0x105, 175 },	/* FCPVB3 */
+	{ 0x106, 176 },	/* FCPVB4 */
+	{ 0x107, 177 },	/* FCPVI0 */
+	{ 0x108, 178 },	/* FCPVI1 */
+	{ 0x109, 179 },	/* FCPVI2 */
+	{ 0x10a, 180 },	/* FCPVI3 */
+	{ -1 }
+};
+
 static const struct mod_map_in r8a78000_mdlc_pere_mod_fw_4_31_0[] = {
 	{ 0x30, 193 },	/* PERE_GPIODM0 */
 	// No CLOCK_ATTRIBUTES { 0x31, 194 },	/* PERE_GPIODM1 */
@@ -997,8 +1027,8 @@ static const struct mdlc_info r8a78000_mdlc_fw_4_31_0[] = {
 		/* FIXME .mod_map = r8a78000_mdlc_vips_mod_fw_4_31_0, */
 	}, {
 		.base = 0xc5000000 /* mdlc_vio */,
-		/* FIXME .power_map = r8a78000_mdlc_vio_power_fw_4_28_0, */
-		/* FIXME .mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0, */
+		.power_map = r8a78000_mdlc_vio_power_fw_4_31_0,
+		.mod_map = r8a78000_mdlc_vio_mod_fw_4_31_0,
 	}, {
 		.base = 0xc08f0000 /* mdlc_pere */,
 		.power_map = r8a78000_mdlc_pere_power_fw_4_28_0,

-- 
2.47.3

