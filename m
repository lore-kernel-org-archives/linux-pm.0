Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53A548541;
	Thu, 17 Sep 2026 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652971; cv=none; b=nI8I2FmFIgskp5OwYvg2KAYS5qKB7HEewkaigPsrQLzBYItuPqya5g2vaGoJbdlcvfLmDIe9aKHYatwmOVbj00pfO7YNMrHGgK42+eL61pqFQer6XjdG8k5NlsjMAk58ErDVTlLn28/LKHHp9Ll0geMFE7tCgC9UfK3i2YTbEFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652971; c=relaxed/simple;
	bh=I5wKmiysBTuYLPKycTb4r8SCqRgtc3YcQ663wjfvpFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IP8aBE9OgXXPETkHPynAak90OEYhfnB6WGuRgloIQiM5jg4BdWQlC8Y44TQ68BolasYAmjIzwGQGoxdM1XYk2rI45U/JiRmIU5OtV/hXZTxJpTLnL+kPzRfil6k5EkqdXTuy4e68Kuacn/XZUmIZe1DvW9T9IufzYA5FrqRifL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fmY0pZ0i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fmY0pZ0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789652961;
	bh=I5wKmiysBTuYLPKycTb4r8SCqRgtc3YcQ663wjfvpFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fmY0pZ0ijzex4HtptD/UaC0jxHsIKAnVKRmVtmxi+ObVR6pvnHypESo33jMrxO6xO
	 MYvtlyJTET0DxpBrQXjH66LFnmunjq/9HGnMvVB70Gg+7h5Gb9QHttNPNRIy7rQb6E
	 SR7/+6GvJUJaDrkjwFRcFenjuM5g0oFARGh6P63/l/ow9HQUjYcKmSVLVjfV1Uo8bf
	 W3tdUlvxr8gvH1uJ3sg/pOHZTBYw8ubsbnevItrQP6/c1sjeJBeTt6LOWIbT9GUHQ1
	 iROOd32glafkfuwh2hHJsQRuAxzRPte/qfVHnPFV2i6rhX6daaHnUKiFCGgWUYk8HY
	 s0OhYFuEns5Dg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C623017E07DB;
	Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 7BE6348002F; Thu, 17 Sep 2026 15:49:21 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 15:49:14 +0200
Subject: [PATCH 2/8] dt-bindings: devfreq: event: rockchip,dfi: add clocks
 to rk3588
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-rockchip-dfi-cleanup-v1-2-4f00a97a69a6@collabora.com>
References: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
In-Reply-To: <20260917-rockchip-dfi-cleanup-v1-0-4f00a97a69a6@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3824;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=CMJKlCe6bEkR7uYuohkbQVDQ2FF/s+dLQ5XKL7udDIg=;
 b=kA0DAAoB2O7X88g7+poByyZiAGqr7+GjOYD9XgQwPQo4FjhjYoSNVwOC73J35EGjf1ULcUn+T
 IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq+/hAAoJENju1/PIO/qaDRIP/iF+
 L3Z3wPL14QCK2IB9xToLK1Mqu5oCNh+8aeBgN0cywq5NCujKDyT6nFPngIeAKrHTee0vKdYNquf
 W5wOrwwwDtuMZIS9G5hkJLaqSOuClUNVlDvWay0uyIWh13cS3eMSdEEIs1R9xYziyHrS8kJC80w
 abkCpCRd+cDfBBGBdV+1Y6JRavDl8DzPbql91RUlinkTc8wr8eKGjBYTE6oHC2DqEzxddsGsPTx
 FNciqNMzXtrZxEu39JupEN2zgyuiEFp+2qde7JyBePmyuGsQ5RachDXkZi0TzrWfK88+S3/2rbV
 M7VD1Jyg3vYVRwcCAc1FeJXE3kBzgYUauA9eOGnQiWeg7Sj2a5b68SzuB6me1DgUqUG27aER3dB
 IK5o6U9kiGdnQ6FtFoS+aWnJJKMlUXdkjNTqxo1KNZD2KV9LdwnXs5vEcdtABI/CVc5BN9XGJUO
 RSWxIdjUh1bxSvGLk4lMD5Zt8phLTux5SmXDXZr1Metsdvul9HPTpPRHvz0QKkl2aJ6QTo4H+Hw
 EUysmUCFKzctrKPWPd55V0WZ8lIlXZROvTZueMEa7IVNiwl5yzvzCw2VmSw4sPnx3TvCCtEZKa8
 eyEfekjgjwYqxNTVFVC5i5eucnpugBF92jBzcMF8B1xj8+c1K4+FttqO6sa1KIhouZaCY3IDvkf
 TGz7p
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

