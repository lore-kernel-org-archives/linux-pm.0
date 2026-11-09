Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231350;
	b=Ci0NFfK4IInezYuV28q0Jwcsl4VDx//C6LPVwu6gOPkuXdY2F/SvLzOXj3c5p7BJY2ij
	 13sBRyt7L9jpgG8WGixD8Sn/eywpyLN3qyASQr4McOSS5SW+puVD6vlYb1QhKGn8Gf6+d
	 E06qXOXOlyEssI3vp8YfQeP0nHuS8sDwj/HxtHwidYYInlWGhQ/cAtp167FkjkR9QCx6s
	 /NqKa96fRlIvqgqwt9dRvuDatnoJg/SAsIvthEoesE2G3mKdVSmz1uGOV/nbt0wdXIWIR
	 bYObtY6ucFcjDAXEJUoOkDV3XZALe+Zr3kZQL6jTnsk+Msjl3AhF2t8L5p87EKTeTXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231350;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=En7rOUlVkmNlgfz9dqtxzpXGlTvJLZuF2h0CzMGmFKM=;
	b=OWKOa2BkBEqGQ7YyDeuyYIgQA2eCF+C28qBGAoji+TNiSnoyT/N5C3H71GW694pqF6eI
	 iDDovCj5a0aM55KKh0NcLsSCxDfFpffvC5id4z+A4ePTHVgztrFiw5jyBfxWLbbR4EkXm
	 xVES/DIe8iZSVRg5hEQ13g/dhq2lwmnEX96LGlWE3hYmJp0tcTNwBjLbFneBKWxgm9wmm
	 PXESpeOuE8padz3ylfaJu8lBm4sc+xGN+ZOHeSibynFB0DBGawgKr1a8ce160VleobirV
	 hPi1l6ASJTt/M2I2gyNIq8Iv2lk/byxm9OGyzITOIEpbynCL807AGOwbZHP1R+djTnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=MENg00mR;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32253606EE82;
	Mon,  9 Nov 2026 13:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32253606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=MENg00mR
Received: from neptunite.rasen.tech (unknown [IPv6:2400:2411:160:2f00:7074:f4f4:e983:bf17])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C64F9219;
	Mon,  9 Nov 2026 14:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1794231207;
	bh=dtS38vh8eQcOqsJ7hPxmurijuftuuT55xDrui/drJBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MENg00mRXehjOhsO0wuLo+Fh4xGEppDY/HasQv6Kxeh/1CCrNqERUsnmdpAhPSfeX
	 7iqAcK3+uVGCu8WQFWLGz+HFPlD1TZLkVyDESrwbF4qOusW7W5tN3Km+6VpjWDZXj9
	 mwJsQX3uN4ctTagEzXcM8nOLjEYyY3l/z+dqEaVo=
From: Paul Elder <paul.elder+renesas@ideasonboard.com>
Date: Mon, 09 Nov 2026 22:34:32 +0900
Subject: [PATCH v4 11/13] dt-bindings: Increase Renesas X5H MDLC PD
 specifier bit width
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
Message-Id: <20261109-epaul-v7-3-rc1-x5h-vsp-fcp-v4-11-1b2072e8c37e@ideasonboard.com>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2

In the Renesas R-Car X5H, the module controller's power domain specifier
cell's bit width has been increased. Update the bindings documentation
to reflect this.

Signed-off-by: Paul Elder <paul.elder+renesas@ideasonboard.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

---
I'm guessing that the maximum number is now 512 but I can't find
definite proof of this.
---
 Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
index 1dba1e1b1c5b52d058d0128dc7d7bb9ad943f935..fac22c9c9cebfe22dc7045c1903889ec60357839 100644
--- a/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,r8a78000-mdlc.yaml
@@ -12,7 +12,8 @@ maintainers:
 description:
   Each instance of the R-Car X5H Module Controller (MODULE CONTROL) provides
   Power Gating for up to 64 Power Domains, and Module Standby and Reset for up
-  to 256 modules in the Power Domain of each Module hierarchy.
+  to 256 modules in the Power Domain of each Module hierarchy. Recent hardware
+  versions have increased the number of supported modules.
 
 properties:
   compatible:
@@ -32,14 +33,14 @@ properties:
         are always on, and for which there are no MPDG bits to control them.
 
       - The second power domain specifier cell is the module standby part, and
-        must be the module number (0x00-0xff), composed of the Module System
+        must be the module number (0x00-0x1ff), composed of the Module System
         Reset (MSRES) register index in the high nibble, and the Module Reset
         Destination bitfield index in the low nibble.
     const: 2
 
   '#reset-cells':
     description:
-      The single reset specifier cell must be the module number (0x00-0xff),
+      The single reset specifier cell must be the module number (0x00-0x1ff),
       and thus identical to the second power domain specifier cell.
     const: 1
 

-- 
2.47.3

