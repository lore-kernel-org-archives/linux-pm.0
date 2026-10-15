Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847E4B512D;
	Thu, 15 Oct 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792050787; cv=none; b=W8I26dNOLjxHnuOkBPxRhjU0w0TNgHCq65s3IPIMcYj3Y3XzFsfr1DijDxOohQ1s4pgqEhXMbo3Fj5ULuh5uEcaO04HNcLEKtpih/yOwlW8SP8b33bNbwZAtavPWVAkwbyPjUGXSwdjmtcMVIPBQVhKf+Lcxwc1Cmng4px64cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792050787; c=relaxed/simple;
	bh=pkP1t0uKz5USnQRJS/PFldbmpwSeVMl61CPQZcO+gMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OmVWl2f/tDWxr4vo+mlf2d+2SWiX9BtWn/LLDrFGYzlgqhMtX8M8/AUVzRlhIxocE3oOa4tssQ6MQ+zDJlDdOkVZqYWO3V8IIDIsvGc+h+rmOo5/pJW/cnpOjWpCeCEwx+NCpwTd/u8CaXzI9iBftdEUZwqm2+CDCVKNdeYYl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qC+v9tlh; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qC+v9tlh"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:6f1c:794c:1e6c:a09b])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 58D9122B;
	Thu, 15 Oct 2026 09:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1792050659;
	bh=pkP1t0uKz5USnQRJS/PFldbmpwSeVMl61CPQZcO+gMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qC+v9tlhRe9VAmPNZPj96XBxKGHk1vS3R2onK1OnOA6shM5Y2tz1bFvq9WnYKBR4y
	 /pxgjDhiY1cYpx5Mlow25iC5JC28mpBLPdar0xKW26pUV4gF2ioIRPb4gd8wAau7RY
	 VYhwAMG31rHNLG/dOvnoWZsd/AJx3qrlfQnyu61g=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 15 Oct 2026 16:51:52 +0900
Subject: [PATCH v3 12/15] media: vsp1: Fix setting control register by
 display list
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-epaul-v7-3-rc1-x5h-vsp-fcp-v3-12-e052903a3832@ideasonboard.com>
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
 Phong Hoang <phong.hoang.wz@renesas.com>, 
 Paul Elder <paul.elder@ideasonboard.com>
X-Mailer: b4 0.14.2

From: Phong Hoang <phong.hoang.wz@renesas.com>

According to R-Car Hardware User's Manual, VSP HW does not
support to download register settings for the control registers
by display list, so set those registers by APB interface instead.

This limitation is especially enforced within the VDK.

Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Reviewed-by: Paul Elder <paul.elder@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_wpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
index 821887815eb2e38d3a51791161de8cd3c135ef3c..4a5ad8e4903e99d5a522af2239889d7899f629cd 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_wpf.c
@@ -332,9 +332,8 @@ static void wpf_configure_stream(struct vsp1_entity *entity,
 	vsp1_wpf_write(wpf, dlb, VI6_WPF_SRCRPF, srcrpf);
 
 	/* Enable interrupts. */
-	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_STA(index), 0);
-	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_ENB(index),
-			   VI6_WPF_IRQ_ENB_DFEE);
+	vsp1_write(vsp1, VI6_WPF_IRQ_STA(index), 0);
+	vsp1_write(vsp1, VI6_WPF_IRQ_ENB(index), VI6_WPF_IRQ_ENB_DFEE);
 
 	if (pipe->iif)
 		return;

-- 
2.47.3

