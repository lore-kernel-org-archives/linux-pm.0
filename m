Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A0E59573E;
	Thu, 17 Sep 2026 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653861; cv=none; b=eI2srEvrJ/XoycqFfKlkPvfbcezxNu4Pt/rtg4IA1Iyk9hR9BLbHcmKnBbDCP0kVSrVZHyaA5uik2DgBG+pGh2x2h3tJQggt4C77r0P+7H4w33H76/2AougBxVDspWh7Y7N9uSKMYVcJBpfNkYUVA9bvWIKCBLH7VwM6hV3hNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653861; c=relaxed/simple;
	bh=jfYcxTTge/XmKelpU+UmxaEpjwECbZ6NBqUYAgA9V9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbsW009wLceN/06Uew+85wWNXmthZHLKCOA+RaYiPRPwdbQ0dhKQZewe9A5YqlFMIyTNsiORIDHfznbfoFGgXsWqwSwRdtcwbyp+U2DWJyfz3IzHLNoTwBvCq7nAdP5q2rLRbHMZJEeEbG5KnlIY/OHxWhMpSc9M7c00xTnDin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WrtFawFI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WrtFawFI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=jfYcxTTge/XmKelpU+UmxaEpjwECbZ6NBqUYAgA9V9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WrtFawFIn/EhfWLxmpRthIry64McmcbFhmBPj/LpvgwnEleBbK4C5Ef5jTx1BkRO6
	 1OwkR4Mlq5kVbrHq5w2UO53vxVjEq2fpiFAWCIPWUb+WGjX42clLVnxvnnjQexD0X7
	 WzttJCXlfKMz8MceG2bYf+/r1MB7m9ZB3G0z7aDY9ig8Ur7adPvYemm18564c2VUAx
	 JYUtRZ0Y3ZQSZ+iOrC8csHWXniWcCB0PTIqwNAFHxcq0DGqj5kUro7E1Yyo43qcM93
	 fUWrLvzJF5oJZvdt68xaqx+LxVqCNS63vQdabA/0IMLSaSXCwhrRdHOia92JhQjiRp
	 BxYRHbIgdX+Xg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3205517E09B5;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id E743D480030; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:09 +0200
Subject: [PATCH 3/7] dt-bindings: devfreq: event: rockchip,dfi: add rk3576
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-3-a5752a29f7bd@collabora.com>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=gg15H4xn9mrUfnzUgOUkLrMFrsLYyUUofwQOjEIeUro=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82HzXT4+aqQkl8zg1fEYbZo9h3mwzv/Vb
 vMLy3g/aOV9rIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qanx8P/jFUMsYVr30zewv03SLoEdGbgd5WIVqWBI8bqMF2KCZLMBGff8SL3Vn1mBZ+vtXeujT
 ALRNU0DGLAOzsYjmuEPqhEIS+xl2+mAVBdH3qZSLlMEz8cK/+jtB1ypszZnlN7iLdc99c/U3AB1
 /dvUa/4cPg3m9mE/ZU/Bxp4m14zgu+kSUh2bQwjNuY+iRu0ItWd4CdOnKAmhCi8/KLJElY9LR/t
 EKUcK37jicRB0R9rIEipYKuNcguIsElXH7I1axKEvLIA/3C1/LtzA3OB/0SaxrKF1sUE9qYuEGN
 eOyGHlXgDRJR470bgWgGvXvTDAV//KKnmsz/m66J9R+g8VpFjbhYzBIRZoKEwy3HdiVm5M/EkKg
 WnSlL4NPcY5K78X3qTfnWcu0vi8MMlUyRDGr5oNetg2lWp4tY3mfFAbur6iOyQQTPv1RiTmKouf
 rbEtI7rmpZKLXcJKjnt3W160j6kLpDnhHIqUc3Jb6yscALUrZQZk+Zjv6BRnI6cgVWL8ODCzUbR
 No62VTiFT3HvcJB7OH/U06+63p4l7pkZrKM43nOVeA2S8xseNaIqOVsfszqS7pYU1q4dZirYBH5
 J/xbzDzxcffiBMvd2nT8UyPMwc9vi1ztV7T3c8NDZfoydU4q6yfVLysL3VggjMOK6nDedohVRkL
 RYHiBYMrIys2JbjB7vsI+SQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The RK3576 has DFI hardware for monitoring the DDR's bandwidth much
like other rockchip SoCs do. Unlike the RK3588 however, it only has two
memory channels, so only two per-channel pclks for DFI.

Add a compatible for this SoC's variant, and add it to the conditionals
at the bottom of the bindings file.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml       | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index d6e06a9bea19..964f1827496a 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - rockchip,rk3399-dfi
       - rockchip,rk3568-dfi
+      - rockchip,rk3576-dfi
       - rockchip,rk3588-dfi
 
   clocks:
@@ -68,6 +69,28 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3576-dfi
+    then:
+      properties:
+        clocks:
+          items:
+            - description:
+                clock driving the DDR monitoring logic for memory channel 0
+            - description:
+                clock driving the DDR monitoring logic for memory channel 1
+        clock-names:
+          items:
+            - const: pclk_ddr_mon_ch0
+            - const: pclk_ddr_mon_ch1
+      required:
+        - clocks
+        - clock-names
+
   - if:
       properties:
         compatible:

-- 
2.53.0

