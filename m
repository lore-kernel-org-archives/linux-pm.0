Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231321;
	b=NnRI276VAcNqtmK6d2NHzlzCPoNfJMNYbusiI6y8MYzaaVcHJ5wRct6ZomJtvTo/0ROz
	 AKp3r9OIfpMi7GMUVXESrEkICbkAQxT1ft08dywIdK4s51BwBBu593432DZSbFc/brJWm
	 qait2YGW/M6+pizj9PBzt50fTfY3vgXXnMrqUpjRZgVOWis0pVApuMPO4j9aKoPGZf4Er
	 Xt5yO998g0eAxtx+hu8yhTF6E8MiekQxunvn2vYLLNPZhxSJojd/23yxNRDvISlcB8x9f
	 n0DHRzzks2gcT7MY79KQmng2G6J9bnOvuEtOs6R2Qwr9+uAf1ZejZ9D+Hf82mVVZ7mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231321;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=RHbobrqtkCfVlo6cAi/46bOTcxdKLYt7G6907V67RpU=;
	b=2o9/j51pM4kAiRxHq/2yI2z31oCeHTTVZpwNB0mh/I85loJzwL7c1xrlurXK337TKrt+
	 F2anHLwAa/Sacr+4xhDFk3JSUFzCZknyF1UjmajI/CT2cqCQJ7HmbqEpL0Ej0IDYiPUkJ
	 eF5qNFw8xCZ5MivcJNXG1gS040sjPS62Te4LWs/uljAJ4aFS63YyiyzJKRRrSCmaB5z0e
	 wK2RXjM04K5ReWtHwgTGcNwlD6tUcyYIU+HUshevAe7e5PC93T4gg7X/dwN8xW5SXxKTu
	 J23gut6dpZ/Zc9b7BjyMFmqIxAHFqQ2Mhtc2VeMq3auVTfubTi3Dkx237OLAdViQXuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b="nfO+R05/";
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF8606D806;
	Mon,  9 Nov 2026 13:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCDF8606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=nfO+R05/
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B551ADA8;
	Mon,  9 Nov 2026 14:32:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231177;
	bh=bpXqtsWqrM7gLL19B+WOY0IajzWlW8W1W+pHV9t3RfU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nfO+R05/8lny3xwqOQq7VCdtcyJajKfIR+ijISm1FDsptMAeOGKEpDnpNd4fhqkKx
	 dDQmecBTrZBN6gOaTBZqT2IKGs8SFgtttOdrz6VXZZfR7HGIT5jW80C9mDL1xuUKOL
	 LEVWozrhYmP9SORQDTuUurcUYhmpRsr0pD2lcCTI=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:27 +0900
Subject: [PATCH v4 06/13] media: vsp1: Support full VSPB on R-Car M3-W,
 M3-N and E3
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-6-1b2072e8c37e@ideasonboard.com>
References: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
In-Reply-To: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-0-1b2072e8c37e@ideasonboard.com>
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

