Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C044684C;
	Mon, 21 Sep 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022796; cv=none; b=os0HX+fXucrjz2+C0/KXqmPtvTpdYRZeLNUcrRm4mbr4THHDqnUWyfTSA2be/MhkjlulbOPU1zIm7hqVlkunlGQVhLIXncH4GBLfM4kttdpf6TAq88UopIvPohXYSeIL5p2tjuz6QqdPWlYmva4GlHMpMghQrSn8VrVQLPkAyZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022796; c=relaxed/simple;
	bh=xkdZXgZBeMQfg9bw8euImJNfedaGSSuo8RfHpYMY53o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsLzrp3Vy0Uxn7V7Q9JBU1PlSuQdUPy+S7TqSalcU/clXkg4xxyKfDmYC9635DSKX8EfF8exkIx8DS46Sho5U3U7SzVFGFZNSCQcql/JdHAYbhiOECYTV8j9Op/RXK/NgKCY9uYzGp86YDo4X+5gVzWlh4TrpRVN/eMz7nOQ1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bvazzeHt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bvazzeHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=xkdZXgZBeMQfg9bw8euImJNfedaGSSuo8RfHpYMY53o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bvazzeHtjktHVice5e4Szz/xLKrfIEdG7DFTSqgo5lMe4pw8zPrNncav5XZoW5dIn
	 ZrcK678BYydbNYAxF5iUHm+vdXGv210mL8sMqeppgfLamdXxDg9w/4hOdDmIhCWBHS
	 Yq4R4ZBDDF/JkGMCVZY1XP9OvHaEf2MLj2XLFBdD8j1G1To2H0HRdja8CZiG8f4cNL
	 6HSlm1ol6uB6KZ342iZpsO0/uhfZsJlhXk2ogqNzxMz3YF2x75KehVlh8gLHvnZH0/
	 uGBjWhIHVqqfExvl79NKKl09SVpf3dVqPj/htiZg4XZGOdvr3L8qFKGF9syjr+YJIk
	 +tCy7tlKg4pNg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3ED6017E047B;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EB4D548002F; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:45 +0200
Subject: [PATCH v2 2/8] dt-bindings: devfreq: event: rockchip,dfi: add
 clocks to rk3588
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-2-43ff34ac8599@collabora.com>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3146;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=tZQHxgmi8rv9SrnmtJ/AL6km1DCw9SsRcOafmoSEYv4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIdjhzE4P0rt8c+tngsmBiBiAsbq+myhl
 1CdQ6h6HK6seokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qa5bQP/2W9ylsqOSSGj9HO7KNPdI07M1IapJPg1kCDl8xt8RKELt80pj1CMcu5hQ0II1mhTwy
 NOxIokvWJBCw392cH6qXPHzEhbGeqIOnROXeEFadidO1uEMW8iNvpSvu4EorUuh67Cgr++o+ndX
 LqA7HxmGaeRO2Nz/0GbC5IOjk/eUwvjeeWg54rSpj1PA1TvReNZgFKj3nu7+dFwHFrkA3S5uwob
 7NXvs0+nuyOdH5s7sVyngVxnf8TJV4eVqETGMKgCp57NgTRWJCD1z23zNfYvxaONO/mOtIifgHE
 98HYvtymnxLJfUBjfII4pNJX8wzG+NyW9/aksUvyv2Of4yLgYLTBTfJKwjSKJFlhwehyMBBKfPM
 49HvdoaygmV42N6V5JJijuyX18DnIg6LTrkpgehuL1+smdDRixFxLImTcXtCJms7fXWd1rbid+X
 biFxugE42yVKzRDZHnNPuWgcQ4G0D3H9Uw2M7GDXelD92b+AfHT8gR0Tgk8wU1TSccCdTDe3Qst
 Aa/3HNBbh4LCB5yagiqZC2EZrkEO7Bi6yP58HOFqeOkFaKaABcUkGrxDcHb8AN4OH0MdhLQ9Pqi
 Nyp2ZpxqrzwnQTD/kS4cQgI/Taa/VvfawaI9iGaWRb0NFsL+UugTbuI/Qfin1uRx5/hIfdDFUWG
 Z2I9ubn5RURJNleJnX0Ev+A==
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

