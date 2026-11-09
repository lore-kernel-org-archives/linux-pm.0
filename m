Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231338;
	b=ChzmuYfmwzfbBM6hd1pkl0OlTs2trp1EgdOnq6qPIsybc2mDf8Z9tTVeDrvDPVJx3ayF
	 3CCih8z+zMzY9FhV0a8yorUViDemX0TzBLvNaQ/zlONXin3yzSI9bCEwkm8a7hrSPPl9K
	 rvcwpSwKYlQUyPtSRJRPfpxAwCow3iJqWogvE1ICNfzo1CHq3Vqg3ECU+Fj5mKefRnFqX
	 KJKa+5qXMxvoU0lo55PCqA7lEvYPjMfZ+VUpyvm/Y/5vWexITv0io3b291/Ww2XTHrELT
	 oqsVYm+a3LwLaSt/7iPKQrPcq8XAHfqfZZ54h6KMfmgZzjB7p38RM/qIncHTUy1ECZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231338;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=9K8uYEJy8zDJnmKvnOfGQ/4bdtkLuesJ/jbtGNWK4XQ=;
	b=kt6VsJmM6aAxY+VpCTH8VYICi3w2UW0PQ7c5ULGIN4dxn+yKZ5Cw4cDq9lSbhzuX65yr
	 BVOjmt9f2RcrXrEtG2h3bSsYRDMgcP/ZbD0BMpY7rEm9LtDvWiTfhXtrbzgmCqFJeVDlZ
	 msoInZx5qqOZ31b8WOqkx/r+2ug0tKGztPP+1lPoN9tx+IOyBgn0dE9xZ/gIKNVlnkGKX
	 6e9QL2F/0YbOx/ur/wth1OVTqTuWU5pl1m9C6/g1/6OKoDk3NKANIWoMcGXjlvfTQEV+W
	 2iYRNZnfMzXkEARzWN5N1AHW2uUv2oCZeC5BgJgoWwXYQHxg4ySR6VQXIqYLn6U8Epw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=vgcTdKdX;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41042606A32A;
	Mon,  9 Nov 2026 13:35:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41042606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=vgcTdKdX
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 060ED219;
	Mon,  9 Nov 2026 14:33:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231195;
	bh=LGEx83vefc/pWX+VWoLz6Ji2RM7eA+vsM4b/amDQLHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vgcTdKdXaHuS2RjTlyXr5NRyvY4gjIEhx+7aHQ2ludvGQVFwlJ0Ka+kp+dDVLTd69
	 NuZQtYmaYqoDZJPHpX5K0TJvqZTUSMnwODQHr/JE8khPWaF6lZgrTW7Pt0LR7iopZB
	 Cd+NzrzYNEN9G/aIiL35hfzUczbrwwqxcm1gHBRY=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:30 +0900
Subject: [PATCH v4 09/13] media: vsp1: Fix access to reserved registers
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-9-1b2072e8c37e@ideasonboard.com>
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
 Phong Hoang <phong.hoang.wz@renesas.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

From: Phong Hoang <phong.hoang.wz@renesas.com>

Some modules of VSP are not available in all instances,
so fix access to reserved registers.

Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Reviewed-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_drv.c | 34 ++++++++++++++++++--------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 6ec8c234ea29939e4aebdf56fc51ae1cc5c69156..819c5eda9171d8ef7c8fc88adc959019b6bed497 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -560,20 +560,34 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
 	for (unsigned int i = 0; i < vsp1->info->uif_count; ++i)
 		vsp1_write(vsp1, VI6_DPR_UIF_ROUTE(i), VI6_DPR_NODE_UNUSED);
 
-	vsp1_write(vsp1, VI6_DPR_SRU_ROUTE, VI6_DPR_NODE_UNUSED);
-	vsp1_write(vsp1, VI6_DPR_LUT_ROUTE, VI6_DPR_NODE_UNUSED);
-	vsp1_write(vsp1, VI6_DPR_CLU_ROUTE, VI6_DPR_NODE_UNUSED);
-	vsp1_write(vsp1, VI6_DPR_HST_ROUTE, VI6_DPR_NODE_UNUSED);
-	vsp1_write(vsp1, VI6_DPR_HSI_ROUTE, VI6_DPR_NODE_UNUSED);
-	vsp1_write(vsp1, VI6_DPR_BRU_ROUTE, VI6_DPR_NODE_UNUSED);
+	if (vsp1_feature(vsp1, VSP1_HAS_SRU))
+		vsp1_write(vsp1, VI6_DPR_SRU_ROUTE, VI6_DPR_NODE_UNUSED);
+
+	if (vsp1_feature(vsp1, VSP1_HAS_LUT))
+		vsp1_write(vsp1, VI6_DPR_LUT_ROUTE, VI6_DPR_NODE_UNUSED);
+
+	if (vsp1_feature(vsp1, VSP1_HAS_CLU))
+		vsp1_write(vsp1, VI6_DPR_CLU_ROUTE, VI6_DPR_NODE_UNUSED);
+
+	if (vsp1_feature(vsp1, VSP1_HAS_HSIT))
+		vsp1_write(vsp1, VI6_DPR_HST_ROUTE, VI6_DPR_NODE_UNUSED);
+
+	if (vsp1_feature(vsp1, VSP1_HAS_HSIT))
+		vsp1_write(vsp1, VI6_DPR_HSI_ROUTE, VI6_DPR_NODE_UNUSED);
+
+	if (vsp1_feature(vsp1, VSP1_HAS_BRU))
+		vsp1_write(vsp1, VI6_DPR_BRU_ROUTE, VI6_DPR_NODE_UNUSED);
 
 	if (vsp1_feature(vsp1, VSP1_HAS_BRS))
 		vsp1_write(vsp1, VI6_DPR_ILV_BRS_ROUTE, VI6_DPR_NODE_UNUSED);
 
-	vsp1_write(vsp1, VI6_DPR_HGO_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
-		   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
-	vsp1_write(vsp1, VI6_DPR_HGT_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
-		   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
+	if (vsp1_feature(vsp1, VSP1_HAS_HGO))
+		vsp1_write(vsp1, VI6_DPR_HGO_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
+			   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
+
+	if (vsp1_feature(vsp1, VSP1_HAS_HGT))
+		vsp1_write(vsp1, VI6_DPR_HGT_SMPPT, (7 << VI6_DPR_SMPPT_TGW_SHIFT) |
+			   (VI6_DPR_NODE_UNUSED << VI6_DPR_SMPPT_PT_SHIFT));
 
 	vsp1_dlm_setup(vsp1);
 

-- 
2.47.3

