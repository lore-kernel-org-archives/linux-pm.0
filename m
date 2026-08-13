Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333AF29A309
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580652; cv=none; b=GJv78Fxi2QuWjzpH4ON5ThcraQNLcqyNGh745FOkbGzKVjV2ekzH3btT9u+vhzfDpp/fgL76z74ANZ0Oh0z90OXZtgUzCC5wreK841RxtLH/bgDnjEjsONMfziesgss4uPq9XZ+9rTi6DMktHIXvKE6SFi+rzWQjtigEg+VnNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580652; c=relaxed/simple;
	bh=KKhbaM4BxrQAo99VUNbaxK5TbHK9MBI5zEqik+L6/eg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gq791W8XXTmh/etHuS5WeKXgLn3Ypal8UNNChv8TzlCBDPLnjtDt2scB9T+qdSMd0j/GD/5a3o5ivXqtu7d+uVoqlUWA3tf1Pl/T0TigpHLPnMdVwmpwuenfKgbkpW9se+eW5iEaiC354FTOSxZAghYDgaaBA27mVIcajZnaVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWxgwHgx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWxgwHgx"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf420670bbso3623845ad.1
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786580650; x=1787185450; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NKCLFuxWFMT16xVoGG+Whvfm+fbrPxkhcIeAiIoBa7w=;
        b=oWxgwHgxCv9nonA/gPWu3q/GHr808vZFjXwYo+6c622vQzs944229HPra58SfeC58C
         Sih1XoepeR4ri8Fll7JR4FolkqK6ITkoerr4qsQ8StdhUx7kFuBDBBOtB1xbyLlR7Lbd
         Qj2tlbf4Irhcxj767QsQYX2zEpBFk7vHlPiw2/eesQ087+OmDMr4QTJmaRSksg7Y7UEi
         aauJVgPr67wnkNcq5TU4201Te0YMKrc3clULY6qauKku9WZaGRxkYhEbfq9wZaE3B62B
         +mnzL4zACIFCNoarZ4IzOovsyCVaY+zhqK5JY7xN7lEsEbS6hC710CFwQhGXj6T30D/t
         u94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786580650; x=1787185450;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=NKCLFuxWFMT16xVoGG+Whvfm+fbrPxkhcIeAiIoBa7w=;
        b=mBcF5ETpiHt2DASQ3xPLKqhB10mXv4aRfPhvNLKi3Q9qhan+oyG0WFnVceXZRc5zca
         SkHbYM9ksDqkoeb2uDVWpCuNuyV9f1pRCFXnem/Mt48EZJCW3v4uHmVaI7U6QG5u2GPl
         xLXFQsk94EXEOjdEL6f9tQDFwWm5ad7tcpgEUdZyQ1F8OOINqDr+rQ9ZmDntyoyvfB5p
         lV3HYpKM0joGk8huoXOV10yF/LF3sD9exvnMKs+rIQim3ZOpnXtYvVbohFNBM1i3Ddsf
         k2N+6IO3uyxpau7CFHk2MbCvrQqpPKU50uN4/Ff0XQAeHBPPIbUEVG+9bRDgUhvPqwTY
         E7eQ==
X-Gm-Message-State: AOJu0YzxzCpe6Al8MwkEwOo1MyYgrKfuRZea8Em1yQ34K762wj2wnev9
	/slPpmqWfGfSLAznIZPDG5ZsEbV8y2njJDTxcAttoFksu6hIdtI1JKaZ
X-Gm-Gg: AR+sD115Nl14nZ33olpX6MsRQsIweWYNeoAI+0txzgKNUJ3yLdQt6FlokfTplG/KIR+
	/gg2wCs61yapnuN5OPrREPacxHX4Q8oKdk3mL0H8PO6AxVavjxVMjVCCoPjanzaYLypxGlFQFpG
	bDdLNgQ5wRxBoZ/QCDdyoN4CtogJD7eENULTU03qd3eII2asI5U4Nzs1p9Hu4/1w9H4Iz5gjuJ8
	LIJq2POZ06tpXA8jaN6s5Z8TQ8ddCEsY1xOm5H7M0OXTHLQRGuJwI8iQNH24Z+wsoT8T3aEYnAH
	lk/jXRcshyj7ER0pVM6V+5jw5OMQKmFk1zcgT/iVOL7ZfZmO1D7SNZTyEH4AyG2cfHlvK1nMJBz
	7Y8GvKoj29XM2LQRfmyL6JwKQ6NsmSEEIXKoTvljX3MUAu0cw/bwnED75Mfxilx4t2uaLVAuHTW
	YQGabIkLK+NlLXmM78jrJkNwY+I5NJBhjO54uCjfZ74h7OFDXY446LE+5OA0s8YYH03dI1wg==
X-Received: by 2002:a17:903:2c50:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2d37d19f10fmr16271005ad.0.1786580650275;
        Wed, 12 Aug 2026 17:24:10 -0700 (PDT)
Received: from [10.219.45.252] ([2409:40c2:504e:6b:b46f:70e9:d340:f24c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebc75d8casm1281289eec.3.2026.08.12.17.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:24:09 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Thu, 13 Aug 2026 05:53:55 +0530
Subject: [PATCH] dt-bindings: power: reset: ti,keystone-reset: Convert to
 DT schema
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-ti-keystone-reset-v1-1-189389503324@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nj3ZJM3ezUyuKS/LxU3aLU4tQSXcvEJKNkC2MLQzNTQyWgvoKi1LT
 MCrCZ0bG1tQAIMI4MYwAAAA==
X-Change-ID: 20260813-ti-keystone-reset-9ab2c8381651
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, goledhruva@gmail.com, m-chawdhry@ti.com, 
 daniel.baluta@gmail.com, simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786580640; l=5960;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=KKhbaM4BxrQAo99VUNbaxK5TbHK9MBI5zEqik+L6/eg=;
 b=rfvimOCvmz/n3PG+Z4uohyIHgOufEyjXp0KoHzEkCWj2NIX5R2s6a2f2YKxUyHeuQXlP+pTZC
 lPH/5tSSLhIB9fsXouPWuNxQi94GKXS4u6AxUL5QhbimD1uBPThRp33
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

Convert Texas Instruments Keystone SoC Reset Controller from text to DT
schema. no new functional changes.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 .../bindings/power/reset/keystone-reset.txt        | 67 ------------------
 .../bindings/power/reset/ti,keystone-reset.yaml    | 81 ++++++++++++++++++++++
 2 files changed, 81 insertions(+), 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/reset/keystone-reset.txt b/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
deleted file mode 100644
index c5c03789ed1e..000000000000
--- a/Documentation/devicetree/bindings/power/reset/keystone-reset.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-* Device tree bindings for Texas Instruments keystone reset
-
-This node is intended to allow SoC reset in case of software reset
-of selected watchdogs.
-
-The Keystone SoCs can contain up to 4 watchdog timers to reset
-SoC. Each watchdog timer event input is connected to the Reset Mux
-block. The Reset Mux block can be configured to cause reset or not.
-
-Additionally soft or hard reset can be configured.
-
-Required properties:
-
-- compatible:		ti,keystone-reset
-
-- ti,syscon-pll:	phandle/offset pair. The phandle to syscon used to
-			access pll controller registers and the offset to use
-			reset control registers.
-
-- ti,syscon-dev:	phandle/offset pair. The phandle to syscon used to
-			access device state control registers and the offset
-			in order to use mux block registers for all watchdogs.
-
-Optional properties:
-
-- ti,soft-reset:	Boolean option indicating soft reset.
-			By default hard reset is used.
-
-- ti,wdt-list:		WDT list that can cause SoC reset. It's not related
-			to WDT driver, it's just needed to enable a SoC related
-			reset that's triggered by one of WDTs. The list is
-			in format: <0>, <2>; It can be in random order and
-			begins from 0 to 3, as keystone can contain up to 4 SoC
-			reset watchdogs and can be in random order.
-
-Example 1:
-Setup keystone reset so that in case software reset or
-WDT0 is triggered it issues hard reset for SoC.
-
-pllctrl: pll-controller@2310000 {
-	compatible = "ti,keystone-pllctrl", "syscon";
-	reg = <0x02310000 0x200>;
-};
-
-devctrl: device-state-control@2620000 {
-	compatible = "ti,keystone-devctrl", "syscon";
-	reg = <0x02620000 0x1000>;
-};
-
-rstctrl: reset-controller {
-	compatible = "ti,keystone-reset";
-	ti,syscon-pll = <&pllctrl 0xe4>;
-	ti,syscon-dev = <&devctrl 0x328>;
-	ti,wdt-list = <0>;
-};
-
-Example 2:
-Setup keystone reset so that in case of software reset or
-WDT0 or WDT2 is triggered it issues soft reset for SoC.
-
-rstctrl: reset-controller {
-	compatible = "ti,keystone-reset";
-	ti,syscon-pll = <&pllctrl 0xe4>;
-	ti,syscon-dev = <&devctrl 0x328>;
-	ti,wdt-list = <0>, <2>;
-	ti,soft-reset;
-};
diff --git a/Documentation/devicetree/bindings/power/reset/ti,keystone-reset.yaml b/Documentation/devicetree/bindings/power/reset/ti,keystone-reset.yaml
new file mode 100644
index 000000000000..ecc68d37f07e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/ti,keystone-reset.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/ti,keystone-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI Keystone SoC Reset Controller
+
+maintainers:
+  - Andrew Davis <afd@ti.com>
+
+description:
+  This is intended to allow SoC reset in case of software reset of selected
+  watchdogs. The Keystone SoCs can contain up to 4 watchdog timers to reset
+  SoC. Each watchdog timer event input is connected to the Reset Mux block. The
+  Reset Mux block can be configured to cause reset or not. Additionally soft or
+  hard reset can be configured.
+
+properties:
+  compatible:
+    const: ti,keystone-reset
+
+  reg:
+    maxItems: 1
+
+  ti,syscon-pll:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The phandle to syscon used to access pll controller registers and the
+      offset to use reset control registers.
+    items:
+      - items:
+          - description: phandle to pll controller syscon
+          - description: offset within pll controller register space
+
+  ti,syscon-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The phandle to syscon used to access device state control registers and
+      the offset in order to use mux block registers for all watchdogs.
+    items:
+      - items:
+          - description: phandle to device state control syscon
+          - description: offset within device state control register
+
+  ti,soft-reset:
+    type: boolean
+    description:
+      Boolean option indicating soft reset. By default hard reset is used.
+
+  ti,wdt-list:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      WDT list that can cause SoC reset. It's not related to WDT driver, it's
+      just needed to enable a SoC related reset that's triggered by one of
+      WDTs. The list is in format- <0>, <2>; It can be in random order and
+      begins from 0 to 3, as keystone can contain up to 4 SoC reset watchdogs
+      and can be in random order.
+    minItems: 1
+    maxItems: 4
+    items:
+      minimum: 0
+      maximum: 3
+
+required:
+  - compatible
+  - reg
+  - ti,syscon-pll
+  - ti,syscon-dev
+
+additionalProperties: false
+
+examples:
+  - |
+    reset-controller@328 {
+        compatible = "ti,keystone-reset";
+        reg = <0x328 0x10>;
+        ti,syscon-pll = <&pllctrl 0xe4>;
+        ti,syscon-dev = <&devctrl 0x328>;
+        ti,wdt-list = <0>;
+    };

---
base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
change-id: 20260813-ti-keystone-reset-9ab2c8381651

Best regards,
-- 
Bhargav

