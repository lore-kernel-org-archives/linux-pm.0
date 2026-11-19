Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093411;
	b=RYklreqsky2xFjtc401i3dqnk01a9hWcpd8VjEobg6GfTg05W4aru3qV37qznAIIjLnj
	 SLUPPABxVSB3c8qUcYHzeojrJ5NLyRCL2J+P5PwJ28YEjjUMPJRiMz+4r0hrjzbCxxRWj
	 /rnn+c15+AmGeo9zzj+QQLioxDcgvRwDXZf8AEtvAUAZfBqiBQQhd43dKbNxtM0A0n1MQ
	 0UTd8zCBRpaPA3r2QbozxnpeUAlGm4kuoTmdeeAAdbuxxbO2fj5wM7JZPQiBWNBsXKQ6b
	 n2hhv7RFXnhMcMW07TQllARYXzoI7euED3EY3/elENd+We79oQYhBl7h3eCPMikuGiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093411;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SSpOCmv0tLBnDCt4+psDGHOiZSF3sd/Wc9Gm8wuymOU=;
	b=WuwoG6Nkz905jhV/UNmTEKdjFjQrkD/ixAAr1ctDKxx0DvNarEnkwTfy+L2KMDoaYDdI
	 2JUXpKbXDoVZJTYYTys2xSEYM/5xXPL3pfnEnlR5rD5eHR1XWAIjp4RmF7Pg94zSujZ8I
	 238I6IM1nGxdNnTM+mCpbNTL1wp+v24dcipe5r4mxQS7GvrN45+0c3ZU6aDSbO0jRiKgV
	 ZfcWGEQMhMGMYgnGo7/sLblKy8chM9eHfZunb/NqxOwtcP/T+lyP/RvEHJynogQYoZ9Or
	 hlqPr0Wfz64PQTcmxxNPIXCZ11TUtaxdiktL6BtwwKUCjuD6kXpNnkOFVndywC2BjlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HBXcnSKu;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42773606A325;
	Thu, 19 Nov 2026 13:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42773606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HBXcnSKu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=jo3nCflY99PJQS3l0ROT5/iJaEglvr9vdCeiMlh4QAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HBXcnSKuXpigViXWu71/Ilw9X8CBhIM54qdSWCiu1Zgod3Ew3rXfI6mj6jmNjftkM
	 cEGOS9U3wJs2qnv+zFyuHjJTY2OPvm1LWnE0owIOoZGXttRtEjCrS3sXeuU4cS3Mrd
	 LI6ne35oo5scnWmYd2qov+1MD1PQPsScwfnOqJP9C7M+AG/OjrDVJav7Toee/QLm60
	 NReTtPzTFaJZZnHaWc2jdAFSgPCEwylli8/qD+jcjLqBHTz2VSSJc/d64+fnG+upji
	 V2GmswlufzIcwX303u3bzHjyCblBpjYWGjNFM0FqXuiLnD0t4jQ6q86g8ydUBLtsyu
	 qR+WyrKmsag3w==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D2FA817E0311;
	Thu, 19 Nov 2026 14:03:22 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 8FEB148002B; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:51 +0100
Subject: [PATCH v4 01/11] dt-bindings: devfreq: event: rockchip,dfi: add
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-1-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3196;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ZBKcYRMvGhObvY8W1+zIgAuybma3qErauP+lHK7ErAg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85rC5zp+q9Kk3t11KLkC9KBrSV0A4/cN0
 SwUa0BEuTkNoYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaSnQP/ig/NqPWDyqLreQ+wXjTu0hw72W9L/5n+t9Kg4+GcUj58zOH79IILmgI8ZhwDexyoyj
 7HjvTPFQgdEHygotqBEkeRzDV3mbvMRCpiQO36yRRgiRwcRcjjbQ+fG3A2cJNsGiz2LfJTOj+rC
 tP+13NFrWMEIIPWZih+zuhJx7JYBNSSkYZK5P1q/QigTFZSx+vOYavLHExOaaskJSNBAjXxUrqT
 XuCzzwim2GGNytZ8jPzjjJbbVxl8Ee5OCflTxz2THYUS842zCWxQkXCpCsFr6vbjSsGKkBBby20
 BbceLnBWg+Myxvxea/TOHdu2fu22h2eM5fFV9jpRdy8VJqZB1bjyJiSt4Y/zTp1bt0ThjahKudG
 cNxfZNTT9bj7sOh/OVo1S89a4M9N0kClQaX/H6ctdo+uS632mCEnwBZfUpEe76yw1AOx/l/oE4R
 1rcol+n+6kyEQoL3kQkOQPXF0NkNaQo8d282aFRERXx1cpJbyvZTnH/rghiuBNr9JntpOkHFERW
 37t010cyaYuy4EUj3aEJpCjgrkgb+X5x9PAkMF+nCEsZLo2ao12akFZdyMfYvZeYYFOYHvtu7M2
 XUtuS4Jr5kCv74v5PTnTv08Fmu6Vw300Ot9lxigKHuwl8XvsLXjgFpvIF+IsnoGVCOGB0XEi+xj
 CR+2jEHBobA8Lb/cVHv8scA==
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/devfreq/event/rockchip,dfi.yaml       | 70 ++++++++++++++++++----
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
index 50d3fabe958d..3450e28b4020 100644
--- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
+++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
@@ -17,11 +17,18 @@ properties:
       - rockchip,rk3588-dfi
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
 
   clock-names:
+    minItems: 1
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
@@ -40,17 +47,37 @@ required:
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
+          maxItems: 1
+        clock-names:
+          maxItems: 1
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
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          minItems: 4
+          maxItems: 4
 
 additionalProperties: false
 
@@ -72,3 +99,22 @@ examples:
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

