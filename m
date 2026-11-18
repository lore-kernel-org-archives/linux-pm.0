Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999146;
	b=nNiR1AQBt5Ha2vc5L5P2R7PSKK0YTczyhgNWaykJOH4icRqp7A0BqYobKnEogw0XfhWF
	 oW2lOGamrlvlx2CxdlWdD8Aha8YwGY/h/rHpvySxXqyAti85Bj9s/BA0mlcAm+zps9ayl
	 eUMnN7HhxKUF7Rky22PkfUkCMqDP80KLzLwITheZsgpTL9AEh/nPjXRsAvflDBjaVKKtm
	 CMpeSVEfiC3TekzXOA83RXGpdG+CA6paJBNyvLekI5ROz7NYAzNaI2/L9NFG7St6VJ9/Y
	 PXiHmlyeogfBh0SYqPryImYXfal7/S5TqkBx3bIBlHu5cWgLgYjGyce9syWa/uUcHtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999146;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7gsWmvqHjORY7K1m06+fKawyHuEa0Hrt5rL694njs3E=;
	b=ZNaizuzCjGqAZQPLbhNFUE3AsevMhVr9rNqHsqlgY3gIM1aPrDzi6ObuGbyeUQ5DD+SF
	 CxCfzH6pLiEAMn1fvFUuy3wYBgAymXQ/a0U9hL1PuJ+u3W8Lz3M7Oi/2fLTzt1LU7QqRW
	 M9hjix0brIOfDx3bYEhbBwoRnmzJJ3jhEmuG3Prh/YoRoSJW+hekVdoOf8US90EgYsEZV
	 XC2mDarQ6MflTano5ibBAt/83ZJowEvlkF54ER7b4qcWqFs4JGR5G4Dx+G9JhBfF7dvlB
	 /7HTpbnTMfhLKfIh18RhAWXbvWHhxJ1uhfEESiPGp+1E0FKpY50SfvBoaD8Ybx5dVjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJlr6Yjt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC31606A31C;
	Wed, 18 Nov 2026 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJlr6Yjt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999146;
	b=OInwZ1SS1WMPlSC/VhRWGKIGRSxDHkfx/7cnGbPP8b/Nx1VQ5lP+Gu1KY2JoInLQETVh
	 hbnvzH01M0TmymWzEGr+JKiTMgDb59MI+9U/Lf6RS37cra25Mu2l9i/1sna/n4jnCBupg
	 TeO+WKqvkxWMgDRvuXVfiJht4WZ/z4M4IVgtqWR2DSVfc4jf40LbwraLLGF3mmBNz06Sg
	 MVifEzCuU2/REqqcc2PhxzjxpoUG28ZOzSuvD2mQBaTGCw1OkLolEbAvGnhaQbvhz7H0S
	 /VrpgTmKnweawoYMNdF8MiPhcVe5ElS8TnLgtGCjdYG/IvO+sqUsPj79SK6XwZRgLNA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999146;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7gsWmvqHjORY7K1m06+fKawyHuEa0Hrt5rL694njs3E=;
	b=UaEfz8RCmR/YO56PJcgeFX+JauR+Ie3t4217F5XNPPStGX3JNTUQJ4Y65iNrRnGMEMIW
	 c/M7kpglmP97K1oCkYJ+g4Ek77bBEx6jPUyl41ZhzEkFEvs1+vPPUw+pNGHps1b58PcnO
	 YwA2FRmGT9hrdFUQxQAdmfxN0n6X7NUdxGPI2WBQhXXRu+ZY+ZRvBHx28DtuHDAUWP0Wx
	 Jea3IVgBW8CgOhZTVhiW9UAbVN/CidMPfL4AlFer7LVY9cRMI62qbA04hpVJd/XqFo9UD
	 W4qOFVHI3nS5UsLvhLruV/+r5o4lspV5VQLy3TEOUNWCq1zGcTd5AgAlKQb4uPp7nSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E33121F000C5;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999146;
	bh=7gsWmvqHjORY7K1m06+fKawyHuEa0Hrt5rL694njs3E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EJlr6Yjty1SPLK9BRj7k1c6KYMpBSMsHX7PFgWZPs4Gi3QF1NkvHFRjAtK1iFYHYd
	 rvicB05dCV34uSyXIJ9/O6bjueE+4PDIJ7Gp2jxQ1CGD59uTJAJnMrwR/C9Jt2arOI
	 KGMgzeP3QGv0GWFDw827/bftGeWwErtMoZQm/hxqBAraFhXPffnTKWIMGtK5jwWFyT
	 KFFZ14MqPqZqZZNRVZAkcZocQQwb2pfI9sYvpH0jDsVOpRcMsSZ0vVjYQYp+mErGaw
	 NW9SI1MGIg8AErKWdn+uokrrb3kwpSrxDNPGWTSHhHtbfbx5EpvyDw/JG0tpuXTrWP
	 FPWNHbdkvQk4Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 614834AD0C;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 04:52:24 -0600
Subject: [PATCH v2 1/6] dt-bindings: opp: h6: Add A133 operating points
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
Message-Id: <20261118-a133-series-v2-1-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
In-Reply-To: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alexander Sverdlin <alex@sverdlin.org>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999144; l=6454;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=t1FpjYwSX+5T/HhM/HdhDFg5tta8TvLt0nYNWKvJh/Y=;
 b=s/+eOpb58cAPqfEPoRIndBMnjW5N+hQVNtb5yB7TgCrvO8dxB3q8zH55rGPr+O+5mLo8WdCJb
 n6oj4pWjl3MDvSbHtUcjNY2mL5SZTWLcmNVOG5j6EiPwwquLn5YXLyu
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

The vendor BSP for the A100/A133 family (sun50iw10) selects the CPU
speed grade from four efuse fields and the die revision: the speed bin
(SID offset 0x1c, which also holds the ICPU current), the chip marking
ID (0x00), a value programmed at production that the BSP calls PCPU
(0x20) and a bin extension bit (0x28). It knows 11 grades, a0-a6 and
b0-b3. The A100 operating points describe only three speed bins, taken
from 0x1c.

Add allwinner,sun50i-a133-operating-points for this. In its tables the
N of opp-microvolt-speedN is the vendor grade: 0-5 are a0-a5 (a6 has
the same OPPs and voltages as a5) and 6-9 are b0-b3. The four cells are
named, with the speed bin first. The meaning of the PCPU field is not
documented; the name follows the vendor BSP.

Indices 0-2 are the vendor grades a0-a2, which have the voltages of the
three A100 speed bins. So allwinner,sun50i-a100-operating-points is a
valid fallback: software that knows only the A100 compatible reads the
first cell, selects one of speed0-2 with the A100 rule and gets the
OPPs and voltages of the A100 table today, with 1008 instead of
1080 MHz. That is the A100 selection, not the vendor's; the new
compatible adds the vendor's. The binding requires indices 0-2 to stay
usable this way.

The new compatible is SoC specific, like the root compatible
allwinner,sun50i-a133; the A100 compatible stays as it is for existing
DTBs. The schema now also limits the other compatibles to the single
unnamed cell that all in-tree users have.

Claude Code (Anthropic) drafted this change and its message from the
vendor BSP sources (field layout and numbers only, no code copied); I
reviewed it and checked it with dt_binding_check and dtbs_check.

Tested-by: Alexander Sverdlin <alex@sverdlin.org>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
---
 .../opp/allwinner,sun50i-h6-operating-points.yaml  | 94 ++++++++++++++++++++--
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index 75ab552f6ec..5fa6a1074da 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -16,24 +16,70 @@ description: |
   Voltage Scaling Tables define the voltage and frequency values based
   on the speedbin blown in the efuse combination.
 
+  With allwinner,sun50i-a133-operating-points, the speed bin index N of
+  opp-microvolt-speedN and opp-supported-hw is the speed grade of the
+  Allwinner BSP: 0-5 are a0-a5 (a6 uses the a5 values) and 6-9 are b0-b3.
+  Indices 0-2 must be usable as the A100 speed bins 0-2, because software
+  using the A100 fallback compatible selects only these.
+
 allOf:
   - $ref: opp-v2-base.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-a133-operating-points
+    then:
+      properties:
+        nvmem-cells:
+          minItems: 4
+      required:
+        - nvmem-cell-names
+    else:
+      properties:
+        nvmem-cells:
+          maxItems: 1
+        nvmem-cell-names: false
 
 properties:
   compatible:
-    enum:
-      - allwinner,sun50i-a100-operating-points
-      - allwinner,sun50i-h6-operating-points
-      - allwinner,sun50i-h616-operating-points
+    oneOf:
+      - enum:
+          - allwinner,sun50i-a100-operating-points
+          - allwinner,sun50i-h6-operating-points
+          - allwinner,sun50i-h616-operating-points
+      - items:
+          - const: allwinner,sun50i-a133-operating-points
+          - const: allwinner,sun50i-a100-operating-points
 
   nvmem-cells:
     description: |
-      A phandle pointing to a nvmem-cells node representing the efuse
-      register that has information about the speedbin that is used
-      to select the right frequency/voltage value pair. Please refer
-      to the nvmem-cells bindings in
+      Phandles pointing to nvmem-cells nodes representing the efuse
+      registers that have information about the speedbin that is used
+      to select the right frequency/voltage value pair. Please refer to
+      the nvmem-cells bindings in
       Documentation/devicetree/bindings/nvmem/nvmem.yaml and also the
       examples below.
+    minItems: 1
+    items:
+      - description:
+          Speed bin, or the chip marking ID on the H616. With the A133
+          compatible, bits 15:12 are the CPU bin and bits 11:0 the ICPU
+          current in units of 0.1 mA.
+      - description: Chip marking ID.
+      - description:
+          Value programmed at production, called PCPU by Allwinner. Bits
+          11:0 are used together with the ICPU current to select the speed
+          grade; their unit is not documented.
+      - description:
+          Bin extension. Bit 31 is used to select the speed grade.
+
+  nvmem-cell-names:
+    items:
+      - const: bin
+      - const: marking
+      - const: pcpu
+      - const: bin-ext
 
   opp-shared: true
 
@@ -132,4 +178,36 @@ examples:
         };
     };
 
+  - |
+    opp-table {
+        compatible = "allwinner,sun50i-a133-operating-points",
+                     "allwinner,sun50i-a100-operating-points";
+        nvmem-cells = <&cpu_speed_grade>, <&chip_marking>,
+                      <&cpu_pcpu>, <&cpu_bin_ext>;
+        nvmem-cell-names = "bin", "marking", "pcpu", "bin-ext";
+        opp-shared;
+
+        opp-408000000 {
+            clock-latency-ns = <244144>; /* 8 32k periods */
+            opp-hz = /bits/ 64 <408000000>;
+
+            opp-microvolt-speed0 = <900000>;
+            opp-microvolt-speed1 = <900000>;
+            opp-microvolt-speed2 = <900000>;
+            opp-microvolt-speed8 = <940000>;
+            opp-supported-hw = <0x107>;
+        };
+
+        opp-1512000000 {
+            clock-latency-ns = <244144>; /* 8 32k periods */
+            opp-hz = /bits/ 64 <1512000000>;
+
+            opp-microvolt-speed6 = <1180000>;
+            opp-microvolt-speed7 = <1130000 1130000 1140000>;
+            opp-microvolt-speed8 = <1100000>;
+            opp-microvolt-speed9 = <1080000>;
+            opp-supported-hw = <0x3c0>;
+        };
+    };
+
 ...

-- 
2.34.1


