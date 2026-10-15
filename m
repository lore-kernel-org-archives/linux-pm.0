Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240738DC53;
	Thu, 15 Oct 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050768; cv=none; b=DphHYWsVZ0o/zWI/TuRh9sAmm34Susiap2K2lMEoi5P41Hy3mgwu5kWcNMTJ0SsIe+7VAGeW1dYn3drky1Ar2bTObCn85FTjEdsUzY4yntAJrUsSP5p8q1vHItKMrge7/Da10b/+bz+xpXzQIeu7jX8Ok1pSPGcCkYKrA+4kcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050768; c=relaxed/simple;
	bh=Y3MSPz3Zu1ICfoZtAYNad7HdhHLM52oYw1Qo7SnWzoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0JOq+I11/m5HYLMkwTKCUYcSLwrw1NmxYkn7HeEPimH7eP/5kun9MQ1HSfcMoSzWT/Bl5nkQWjF2e06ZWIgkc2xwzwInIQy82+P2lsYDuzv4j6t1+kyJYQHenxRtCOiYJ+E/IRoIl2mky9nuSw09PNxZlkvRxxcHLsF55jL+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NZbQ0Roi; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NZbQ0Roi"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 975221F8;
	Thu, 15 Oct 2026 09:50:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050636;
	bh=Y3MSPz3Zu1ICfoZtAYNad7HdhHLM52oYw1Qo7SnWzoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NZbQ0RoiuO61Epj/HNAcOu2Pwyp1X9Z9l7Li8Vf4mL03Syhy3bR6P7mWr6Uw08lkm
	 OiD9KNOfSM24ARKxO6X5hfmPKtv4MmHLli/Z7fGXvCKklrFA+0Aq9bemXtwz9NGwDU
	 dgZsP9jW5iZDwqJPgnBdyoEqpPXXbnjOY3U20SOQ=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:48 +0900
Subject: [PATCH v3 08/15] media: vsp1: Add device info entries for VSPD on
 X5H
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-8-e052903a3832@ideasonboard.com>
References: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
In-Reply-To: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-0-e052903a3832@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

Add device info entries for the VSPD so that the driver can match on the
VSPD on the X5H and handle its slightly different hardware configuration.

On the X5H there are two variants, the VSPD (a) and VSPD (b). As the (b)
version has a separate version number, add that as well.

The R-Car X5H uses 0x09 as the SoC ID in the version register. Document
is with a macro, as done for other R-Car SoCs.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
Changes in v3:
- fix IP version macro
- add comment about UIF
- squashed with adding the SoC ID
---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c  | 27 +++++++++++++++++++++++++
 drivers/media/platform/renesas/vsp1/vsp1_regs.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 5597595414fe787413c7daa5a3142faa9ced8408..6ec8c234ea29939e4aebdf56fc51ae1cc5c69156 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -860,6 +860,23 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 		.uif_count = 2,
 		.wpf_count = 2,
 		.num_bru_inputs = 5,
+	}, {
+		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
+		.model = "VSP2-D (a)",
+		.soc = VI6_IP_VERSION_SOC_X5H,
+		.gen = 4,
+		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
+		.lif_count = 1,
+		.rpf_count = 5,
+		/*
+		 * TODO This VSP has 8 UIFs but it is not supported by the
+		 * driver yet, and the driver hardcodes usage of one UIF per
+		 * LIF starting at UIF4. Declare just 2 UIFs here for now until
+		 * the driver supports more.
+		 */
+		.uif_count = 2,
+		.wpf_count = 1,
+		.num_bru_inputs = 5,
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPD_GEN4,
 		.model = "VSP2-D",
@@ -870,6 +887,16 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 		.uif_count = 2,
 		.wpf_count = 1,
 		.num_bru_inputs = 5,
+	}, {
+		.version = VI6_IP_VERSION_MODEL_VSPDB_GEN5,
+		.model = "VSP2-D (b)",
+		.gen = 4,
+		.features = VSP1_HAS_BRU | VSP1_HAS_EXT_DL,
+		.lif_count = 1,
+		.rpf_count = 5,
+		.uif_count = 1,
+		.wpf_count = 1,
+		.num_bru_inputs = 5,
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPX_GEN4,
 		.model = "VSP2-X",
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..cc4755354b7797a7a4e7592c262be2741477b81a 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
@@ -800,6 +800,7 @@
 #define VI6_IP_VERSION_MODEL_VSPBS_GEN3	(0x1a << 8)
 #define VI6_IP_VERSION_MODEL_VSPD_GEN4	(0x1c << 8)
 #define VI6_IP_VERSION_MODEL_VSPX_GEN4	(0x1d << 8)
+#define VI6_IP_VERSION_MODEL_VSPDB_GEN5	(0x20 << 8)
 /* RZ/G2L SoCs have no version register, So use 0x80 as the model version */
 #define VI6_IP_VERSION_MODEL_VSPD_RZG2L	(0x80 << 8)
 
@@ -816,6 +817,7 @@
 #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_V3U		(0x05 << 0)
 #define VI6_IP_VERSION_SOC_V4H		(0x06 << 0)
+#define VI6_IP_VERSION_SOC_X5H		(0x09 << 0)
 /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */
 #define VI6_IP_VERSION_SOC_RZG2L	(0x80 << 0)
 

-- 
2.47.3

