Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F051AFE8;
	Fri, 18 Sep 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751285; cv=none; b=LLu62YUDjJwrTsFmtHRPLWH5pMYmXmSyHZ8MgQJY6lCprXTNDgJDJe4hvmG96l3rTM31zFSNKIdcRGwLtIQN9kH1BL1KT0vW7XDgF3IS53yQwPdAclIWBUSRsWIGBRRtP5I8xrKmp0J5YIBwhPJygEQ83UKXE3XsuKpkVeg+4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751285; c=relaxed/simple;
	bh=BSGm1l1KB/Q83EO6eHgsRE1TDeHVoZ+R8SFP+nzEJMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ryi+dlzdIDnrgulCinE8bB6m5LJ/djBU+htyTguiuWkGcEqu/2AGk03LBxFHv0HyJL+oXgOphjsqR3iOEXH3iB6YJ7Nc3ykTqcIoK8YuOg08zOvuREv4V/5mSiwHBKjypEz8IqT8Q1Q/iiTThHfHUcfi20bvVQiODtF4hIjHmOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IgL9zVb1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IgL9zVb1"
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:e327:a298:3a5b:4b08])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9DDD04E46;
	Fri, 18 Sep 2026 19:06:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1789751179;
	bh=BSGm1l1KB/Q83EO6eHgsRE1TDeHVoZ+R8SFP+nzEJMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IgL9zVb1fefpta78YEnBkRKp0bGJS2wpExdybW6BXAJvJujqnEDYLhTE/ObeSvXMg
	 8Z4xulKTsuz2o/DI8F7bfowHJ6L5BNspRuIcw5tg3mQ4bfrQh7LDi0xOQzVKm8SpP7
	 B8GZSK7yt8wrbbaFZc7W/G8JhR3t5RnEUZbIp1Mw=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Sat, 19 Sep 2026 02:07:05 +0900
Subject: [PATCH v2 08/11] media: vsp1: Document X5H SoC ID
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-epaul-v7-3-rc1-x5h-vsp-fcp-v2-8-dbe9236bfd22@ideasonboard.com>
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

The R-Car X5H uses 0x09 as the SoC ID in the version register. Document
is with a macro, as done for other R-Car SoCs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>

---
Changes in v2:
- Fix the version register number: s/0x04/0x09/
---
 drivers/media/platform/renesas/vsp1/vsp1_regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/renesas/vsp1/vsp1_regs.h b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
index 4c0315656e9f81a9656b58fb6f0233f8a22ac0e1..8abf39bac6c2f333696ebf55de87586d2df3bed0 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/renesas/vsp1/vsp1_regs.h
@@ -816,6 +816,7 @@
 #define VI6_IP_VERSION_SOC_E3		(0x04 << 0)
 #define VI6_IP_VERSION_SOC_V3U		(0x05 << 0)
 #define VI6_IP_VERSION_SOC_V4H		(0x06 << 0)
+#define VI6_IP_VERSION_SOC_X5H		(0x09 << 0)
 /* RZ/G2L SoCs have no version register, So use 0x80 for SoC Identification */
 #define VI6_IP_VERSION_SOC_RZG2L	(0x80 << 0)
 

-- 
2.47.3

