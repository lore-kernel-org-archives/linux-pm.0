Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929787;
	b=IWRBzmPn4B4DQHjjBIg6NE7Z4+TFuGxgP+5R3kvPNKtmvkIjp+o5zs2/qEFqz6UpGJK/
	 xvRwJlxZJgKJjy6D8x5Hc7Zu1VrmXBdTQcpVNxaIm10CCm+Mbc0G82eNiAmtAe0SYk7x5
	 yazpucXgfxZ8rhyibfLjWW4gSnju1gXvVWXm3N265GQtG2uhyBrHqZ6MeTQ0mM95p5PAf
	 StTPD2T0JGW47pwi3rvYvfm+hkaNKPwahDFuVCATPIyj94j8GCiP3kLpYiM09K1UNHHYe
	 z6wLXJxhJtfaz2zwML4OznojysgTyjzCZOVqO565m00iXiLvUqaTyxIUQhB1MJsegug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929787;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7zvz6EwRvliAsRCkw906N658FyGeoANenSjHZoKASfA=;
	b=EMni6Lw6Ti4yPaHSh9Mokxuazbp2YW3dJe1IQhtBmRGorp21FdvRJwJcS7PYvBIxEHKa
	 p0FioCfh82WB9DC1CuhhUjwmeswJA/dc0Gv8Rkd2533/HIOaIZYE/rzZtQcuuElgh9rmT
	 SZXilYzXEIDTdHTfwQWDpo/OFKNTYYjtDxZVoMbg4KqTiGDlqEje+3Ge2cDlBorOgfuHI
	 q+qRIQlxf6E/WvUMp9t+KbjKhGJm5jsstSwUiKc6vwqVyOcvWIJHe3PxOKA6tv8nfuqMR
	 REyo/tztNHftJIL5UNJlM7qPavRHcVA40EfIOSSVw+brh+br9Lp8zfLwx1ZqG3Ge9nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cJDYfDfB;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C975D606A330;
	Tue, 17 Nov 2026 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C975D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cJDYfDfB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=ujlHVjQMDz4YaqkKi9GBL+L1DFCVvWW0bFq+wVcPWFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cJDYfDfBOCf2V7AmWZngEB6Rh0JgeISkmkaZOuUEs95LL3GEBw48Zp22nJH7nWyJw
	 kBNwYABi6hSDPvGpxMnheg+dUbX7gkPllIvkSX5ZMQ4XJyUShWhK7nZcfbFQlLvEBN
	 HpGO5Cbj1OUUg782F+tt0MgyFV2tTI46kwZNZQQi3ypVU6oFycPURtzSVV2C55MpCU
	 1F3VaGB4t4UuIn2v9IxdmqBKXGtP1S8pxGMkcdkKLWb7KX9D7I+mQk20iCeBURG9vD
	 jUpYJn03aNj6+b+7yZ0TC2lyhMwwZZUQx4zdxKho26tJnnh6WY20I55PiT8uTOkJW5
	 JH2tGAKl7Ts/Q==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DF2C317E0BCC;
	Tue, 17 Nov 2026 16:36:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9B80248002B; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:37 +0100
Subject: [PATCH v3 1/9] dt-bindings: devfreq: event: rockchip,dfi: add
 clocks to rk3588
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-1-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3871;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+1y02qlNP8Qcrhbmptr/ShMc6O9Y5XCldvuGMgDLz8Q=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHj5yv8PYpd62mYOtn3eTpX0Tjtrd0Dl3
 +X2UJuyvB1zXokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaQBYQAII7WBcoe4n233SX+alTezfNo7/77s7PrDAZWC5YKTTWUc7vZd/xqO11/J4pk/vNcPS
 UeXmBQ/JLf2HOOgwR86e74nnkUQZeWaZg07pDe29xNfv/9kfp7ds+tr/uzslk+37vaSY5n4cK43
 J5XkUcmC+AXbYyXPOX8JV4pQ1dJ8GhsaBuRFpaI05oPcl9NJ6x5PGmbIIGCANIdWRbs6eYlD91R
 A+s3EHz3aHcffcXJZ0wmGbGCe3U0Iyk2XECqHNRHjPfcXuT6yhU9PfgLsT8ty9dlPh7KL1wK9YL
 OI+TRtZ45W52uENsC5B/p13aOb9haoAA4YeEE1HKtOhQa1vKmjERP+xCtM5HqGWJbSPJjBPUpaF
 vOqWkArfiGdzfdkVEdsBDtQj3r1KccCMuBDp55nqFlirf9ge7a5iFUP7PIXG0odLuYWS3EqIrOH
 5BLppN2LbYSICn/5S0KYspn+XRpGqX47LRMu2JFIFMRWNWvgOhjlZng9bu88OSafJEClORonjLy
 HY1zwlxwcoc8HLbODf7QYZRiyID4MxQyzxQV312gTcLS5LDnaz9MttjegX9pxu8A+40IMu6PhhE
 JqEdGtI56IRSQT9vKbmBkj9CykYIK5s0eqk3+ynpbwU2VC/j65al5vjikWcrtKLDORlvJKVADOB
 gkBmLDbwiV8y8UZU/EM40vA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

RK3588's DFI has pclks for each channel. They just weren't noticed as
missing until now because nothing ever gates them, and they're ungated
by default on power-on.

The RK3399 clock situation needs no changes, as there the hardware
really just has one monitoring unit for both channels.

Add these clocks to the binding, so that drivers for this device can
properly know about their existence.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml       | 84 ++++++++++++++++++----
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index 50d3fabe958d..d6e06a9bea19 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -17,11 +17,19 @@ properties:
       - rockchip,rk3588-dfi
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clock-names:
+    minItems: 1
+    maxItems: 4
     items:
-      - const: pclk_ddr_mon
+      - enum:
+          - pclk_ddr_mon
+          - pclk_ddr_mon_ch0
+      - const: pclk_ddr_mon_ch1
+      - const: pclk_ddr_mon_ch2
+      - const: pclk_ddr_mon_ch3
 
   interrupts:
     minItems: 1
@@ -40,17 +48,50 @@ required:
   - interrupts
   - reg
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - rockchip,rk3399-dfi
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3399-dfi
+    then:
+      properties:
+        clocks:
+          items:
+            - description:
+                clock driving the DDR monitoring logic for all channels
+        clock-names:
+          items:
+            - const: pclk_ddr_mon
+      required:
+        - clocks
+        - clock-names
 
-then:
-  required:
-    - clocks
-    - clock-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-dfi
+    then:
+      properties:
+        clocks:
+          items:
+            - description:
+                clock driving the DDR monitoring logic for memory channel 0
+            - description:
+                clock driving the DDR monitoring logic for memory channel 1
+            - description:
+                clock driving the DDR monitoring logic for memory channel 2
+            - description:
+                clock driving the DDR monitoring logic for memory channel 3
+        clock-names:
+          items:
+            - const: pclk_ddr_mon_ch0
+            - const: pclk_ddr_mon_ch1
+            - const: pclk_ddr_mon_ch2
+            - const: pclk_ddr_mon_ch3
 
 additionalProperties: false
 
@@ -72,3 +113,22 @@ examples:
         clock-names = "pclk_ddr_mon";
       };
     };
+
+  - |
+    bus {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      dfi_rk3588: dfi@fe060000 {
+        compatible = "rockchip,rk3588-dfi";
+        reg = <0x00 0xfe060000 0x00 0x10000>;
+        clocks = <&cru 0x53>, <&cru 0x48>, <&cru 0x49>, <&cru 0x54>;
+        clock-names = "pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1",
+                      "pclk_ddr_mon_ch2", "pclk_ddr_mon_ch3";
+        interrupts =  <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH 0>,
+                      <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH 0>,
+                      <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH 0>,
+                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH 0>;
+        rockchip,pmu = <&pmugrf>;
+      };
+    };

-- 
2.53.0

