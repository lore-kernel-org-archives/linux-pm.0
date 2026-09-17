Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED24DD3C9;
	Thu, 17 Sep 2026 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646782; cv=none; b=c8oFabSjq8ZXmRq4UR4iyYKvjqfZTwBQ0O54hEWUxoNqNUc8r9WP4PDwZo+Z6Ca9w8Cq8MzPaM18Cn286jXg5gcXL2YB+4PX6Gry7rkzGEahxgacuKdDo1YW3S3lq5BnfgZanlE/0RSzjjlUgWCUbMbM4L//XEdFzCbDNLITpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646782; c=relaxed/simple;
	bh=XE/kIKXDjq9aLnucPLevWwdXnU/hvwyHUcz44vPsmSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2HVQ8p1AAh7RyE5Jc0d2g3/T8wmOVET8TazMCNEw3qC/qCqgDPsr8CwWmGBHjaZwxQ6xM0c+c+D6yfWq9xoHuj9rrCvUjKlxitD9arnEKyzF84LY6Q5rHgXvSfP6CcCxq0QLezqrZLGbS+j4Ffu13uOPikvumsG2ZgMOnKLstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ryjZMe9N; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ryjZMe9N"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:a4f1:7e05:2192:a835])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 037181CF8;
	Thu, 17 Sep 2026 14:04:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789646654;
	bh=XE/kIKXDjq9aLnucPLevWwdXnU/hvwyHUcz44vPsmSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ryjZMe9NmhWK77N8oC3bM3uJq7hjFM9GSTxtSb77oCF7ivPupRBKj+AgKy86plBGe
	 NI+uFUd41T12qOEMIaGbCQ4FqEhOb1XX8pKrdDHXi8wnJ+Jj6E2Zrr+Nm7JKlR53DV
	 vmaftvSi88vo8YmaMocV9/yXSjnYj5oe7dpTjCqM=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Thu, 17 Sep 2026 21:04:48 +0900
Subject: [PATCH 09/10] media: vsp1: Document X5H SoC ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-epaul-v7-3-rc1-x5h-vsp-fcp-v1-9-4c72d4e086dd@ideasonboard.com>
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

The R-Car X5H uses 0x04 as the SoC ID in the version register. Document
is with a macro, as done for other R-Car SoCs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
---
 drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..c5066aa17f0139fe7072687325beaa0e04ba260a 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
@@ -814,6 +814,7 @@
 #define VI6_IP_VERSION_SOC_D3		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_M3N		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
+#define VI6_IP_VERSION_SOC_X5H		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_V3U		(0x05 << 0)
 #define VI6_IP_VERSION_SOC_V4H		(0x06 << 0)
 /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */

-- 
2.47.3

