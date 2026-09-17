Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD148CD55;
	Thu, 17 Sep 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646775; cv=none; b=u980JkCmSDzZTOHgVScSCMULINm4HblD7xjM3YsNkbGSvuKkfCo5z9HAwhTTMontpzPRjvv6dzgV3NSbgyr8DtT/+4H05YRyRIU6U1uez6QD56DLjeJoGDQRxFg3DdhY9KD7EiGxDrJgomVTlZdHQws1X7XPLv0IJBIU9ZhFBr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646775; c=relaxed/simple;
	bh=Ld2et9+CdQWAkLboCA7CCO3uMvouMZYV2c0u8i8MrOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2QIEVOq9TP0uwJiArDyN16wEdt4vfFUCHJhKqA/Jb4/jamFmvmmKw/LaDOseZeuo5vQh2TYGf2Vpq58vegab4e7kIEcuvxg+qhS9Z2sXw89qlLLXViphi4JiM5HJMDR2mGY4Mbc/B3PdF1d6zv91+MqwM7IQov9QG1h4xC+rTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SOi3NQQ3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SOi3NQQ3"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C2FE41CE5;
	Thu, 17 Sep 2026 14:04:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646648;
	bh=Ld2et9+CdQWAkLboCA7CCO3uMvouMZYV2c0u8i8MrOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SOi3NQQ3lKx5BA38rEfXSSk5zyaJlrpS32pG6sPqC3XJ4dbfNC5nnoIO/uyD7JAVt
	 fi2Qkftp7yJbt7DB35psJffmLchLuryyeuxWZ2S7GnpqehpSgUJxyAtJeo2l8EdMky
	 TFVbDH7NaE4QAMEdPE0Z5rb1P8LIeL7t6Kq87ncA=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:47 +0900
Subject: [PATCH 08/10] media: vsp1: Support full VSPB on R-Car M3-W, M3-N
 and E3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-8-4c72d4e086dd@ideasonboard.com>
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
 Paul Elder <paul.elder+renesas@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

The M3-W, M3-N and E3 SoCs integrate a VSPB that reports the same
version ID as the VSPBD in the H3 and H3-N, but includes additional
entities compared to the VSPBD. The VSPBD device entry in the driver
matches on the version ID only, which results in the VSPB being handled
as a VSPBD. The driver therefore doesn't support the CLU, LUT and HGO
entities in the M3-W, M3-N and E3 SoCs.

To fix it, split the device entry in two, one for the VSPBD with an
additional SoC ID match, and one for the VSPB. The VSPBD entry needs to
be listed first, otherwise the VSPB entry will match on H3 and H3-N as
well.

The VI6_IP_VERSION_MODEL_VSPBD_GEN3 macro is renamed to
VI6_IP_VERSION_MODEL_VSPB_GEN3 to indicate that the VSPBD is the special
case.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c  | 13 ++++++++++++-
 drivers/media/platform/renesas/vsp1/vsp1_regs.h |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 762a9e776a94d50accad070068f92f6dabb81035..5597595414fe787413c7daa5a3142faa9ced8408 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -781,14 +781,25 @@ static const struct vsp1_device_info vsp1_device_infos[] = {
 		.wpf_count = 1,
 		.uapi = true,
 	}, {
-		.version = VI6_IP_VERSION_MODEL_VSPBD_GEN3,
+		.version = VI6_IP_VERSION_MODEL_VSPB_GEN3,
 		.model = "VSP2-BD",
+		.soc = VI6_IP_VERSION_SOC_H3,
 		.gen = 3,
 		.features = VSP1_HAS_BRU | VSP1_HAS_WPF_VFLIP,
 		.rpf_count = 5,
 		.wpf_count = 1,
 		.num_bru_inputs = 5,
 		.uapi = true,
+	}, {
+		.version = VI6_IP_VERSION_MODEL_VSPB_GEN3,
+		.model = "VSP2-B",
+		.gen = 3,
+		.features = VSP1_HAS_BRU | VSP1_HAS_CLU | VSP1_HAS_HGO
+			  | VSP1_HAS_LUT | VSP1_HAS_WPF_VFLIP,
+		.rpf_count = 5,
+		.wpf_count = 1,
+		.num_bru_inputs = 5,
+		.uapi = true,
 	}, {
 		.version = VI6_IP_VERSION_MODEL_VSPBC_GEN3,
 		.model = "VSP2-BC",
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
index 10cfbcd1b6e0b3a9c0a8daaa990babfaeb8dde0c..4c0315656e9f81a9656b58fb6f0233f8a22ac0e1 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
@@ -792,7 +792,7 @@
 #define VI6_IP_VERSION_MODEL_VSPS_V2H	(0x12 << 8)
 #define VI6_IP_VERSION_MODEL_VSPD_V2H	(0x13 << 8)
 #define VI6_IP_VERSION_MODEL_VSPI_GEN3	(0x14 << 8)
-#define VI6_IP_VERSION_MODEL_VSPBD_GEN3	(0x15 << 8)
+#define VI6_IP_VERSION_MODEL_VSPB_GEN3	(0x15 << 8)
 #define VI6_IP_VERSION_MODEL_VSPBC_GEN3	(0x16 << 8)
 #define VI6_IP_VERSION_MODEL_VSPD_GEN3	(0x17 << 8)
 #define VI6_IP_VERSION_MODEL_VSPD_V3	(0x18 << 8)

-- 
2.47.3

