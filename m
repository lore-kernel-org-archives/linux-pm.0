Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231327;
	b=SL4BjHGoXHKAwN9MsGnJi0WcsjFqd8r+p55ckYlWdembRvtkVi8Ni1SUsLcv+uptjuOw
	 CNxZ5VINdmCoNrrlN7xqGJ7aPjldEow570QEaRmxwqzD35bqJFtVVoik2C4k48SQFiq2L
	 45ZGqfqhF2Jii7szUrs8OznkVqy8Mk2HlYN0uVh7UvZ7DE9cGPQtdLMdrs+8ZdIqpKqB7
	 2GfKvmJ+XpVpoY/jcrnS1k1N2TPlcvLXwYUIc4W1cQUkYy9nzWGJUdOYwBzcFWLdtZqzM
	 dPAMWaMz5/nt7pLbL1eIcUPLKzNMcfOZKDuMy6cqNERiCRBO6/XstPAK/OOqUzf7ocw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231327;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=MxLhj0+2ZYHX6Zr+4IBo3HuSmLXo+JIyNmE2GMsF52c=;
	b=ybwOTwS9zMU2BGVL6FaQqteVHQFkv4qfKs7pxZPkfGVK6HPYh5LZSEZrwhOYJyeRqLpP
	 lVsegNIBRc+NjuN5jyKHV5GWJs+cSXGXbMzDeqGLyazaa6GHwGpGgY/ijIAJynu5dt6ZF
	 741WP7fxkJjcUfeQBWSumiD+7RvlVG+4zJyV5M3aKVNKUvW46Y7XNZtM7m48+vvLtlC13
	 woARiglhYjvD+iVWlBUolBpiN/2CFvzHCdhSnszBcp1wuE/tld9qLtOa8AjGZGsPRhoY5
	 B4D55k7/Khy9sYXM39JUHyUBQEAa3W5r53IHpvtD6fh7+J9Pth7bwrk0Z/CsFvfsThA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Y1maYOl1;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37F606EE86;
	Mon,  9 Nov 2026 13:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D37F606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Y1maYOl1
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 79350219;
	Mon,  9 Nov 2026 14:32:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231183;
	bh=Y3MSPz3Zu1ICfoZtAYNad7HdhHLM52oYw1Qo7SnWzoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y1maYOl1vmlEM3qXC+8qG2HPmQ+ZvGjibAIYiR+PAAlIIOqQLW5WvSe5SZ1Br2v8U
	 LPT+N9x0oz7iRi3C4ngg9MQJJ55USw9zuJcZ6HKUA+8IwzIiKXx7x1DRbUwCYnazZw
	 XOCGbMhF0Psb6q2IxVJF9rFJvkJsKF8U82vi0hN8=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:28 +0900
Subject: [PATCH v4 07/13] media: vsp1: Add device info entries for VSPD on
 X5H
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-7-1b2072e8c37e@ideasonboard.com>
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

