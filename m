Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F651C348;
	Fri, 18 Sep 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751280; cv=none; b=ZwD6uJp2fhUkt0aqsNJc6+TXpLuUgAj4tKoNc3FMtpG83B48lPm2qr1JvHZZXWopW9tMn6T92b9jEpidEn1m9+TZ3PFhz6HLpvz0rS/TI2Lfn505f2fU+vtHqvDiMl5dynnRoC/I+/ughnL/G07DWwnwlzqOUktvTdHojSN4TNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751280; c=relaxed/simple;
	bh=bpXqtsWqrM7gLL19B+WOY0IajzWlW8W1W+pHV9t3RfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TIOvF/dI/KAOhWalVWY9kOcfHTg9UdLTWFv4GxMjlsSQRvV9M8pBkzVHxcanSMgfzs7FCyIgRCY+JUGra9HqEBnTfCkHHt9z7gMv8tmO6PRPyqyOclaKkGscE9szOR7d+3PDcPnT7vCwGybrvmkas0NhxZo1m29hsCZFD0vgZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=AVHOlWQ4; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AVHOlWQ4"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EB01E417F;
	Fri, 18 Sep 2026 19:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751174;
	bh=bpXqtsWqrM7gLL19B+WOY0IajzWlW8W1W+pHV9t3RfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AVHOlWQ4sOr+4tbCn0ruZ0LvqLXPSMNz5PZpnmI9vg/kTKoUr23eGh58O/K/wgQAZ
	 NWZsldr2eMEbtUHlz4TW8+oCymeSRSVBfjQ2cVjfh0yfmfJ7eilz3pN80DHSf0ICAB
	 AoMTowQD4EbYQrbb+acjXqziC7YIwJ1Ep7rzji9s=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:04 +0900
Subject: [PATCH v2 07/11] media: vsp1: Support full VSPB on R-Car M3-W,
 M3-N and E3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-7-dbe9236bfd22@ideasonboard.com>
References: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
In-Reply-To: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-0-dbe9236bfd22@ideasonboard.com>
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

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

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

