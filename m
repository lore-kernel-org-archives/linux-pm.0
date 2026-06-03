Received: from outbound7.mail.transip.nl (outbound7.mail.transip.nl [136.144.136.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FCC286D7D;
	Wed,  3 Jun 2026 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470929; cv=none; b=Xwq9+5saE5HnMrHsH0BtbfjxHzb/iC/JlMnWggXWglYNUHPwnBlbMbY516gaYWAcIH44ZbonNR/iXfaTSY5WAw/YApCksrBEuLBBPnIw0wRHEf/9adljQdQaa5OpWGWEXUTAXScEs14ofyg3bIn3FYKSLjgR80UzlMose+MM7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470929; c=relaxed/simple;
	bh=CBox3QeLB8bD5zr5Zk/ou2hsAHr1V3tPZbRM4BFKHsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGP9QSW3CVVYo7yR72oHCofejITeFBMyKifOhBsMo4OaIC0k5L4nC4siXzN7ubeSNAbDy3Gvr4jyBa2CRr9/o4ECeHk2HeI5niOMLosvbgjdmdplKOj9TFHj813T4UmjGM9VWSPOyTnmmTDnvI/uqISubqD6du6VLnK5pssDV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=vweiJbfx; arc=none smtp.client-ip=136.144.136.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="vweiJbfx"
Received: from submission9.mail.transip.nl (unknown [10.103.8.160])
	by outbound7.mail.transip.nl (Postfix) with ESMTP id 4gVf9P3pr7zQvtGC;
	Wed,  3 Jun 2026 09:15:21 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission9.mail.transip.nl (Postfix) with ESMTPA id 4gVf9N71GPz3NZKgV;
	Wed,  3 Jun 2026 09:15:20 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: sre@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 1/2] dt-bindings: power: supply: maxim,max8903: add DC and USB input current-limit controls
Date: Wed,  3 Jun 2026 09:15:18 +0200
Message-ID: <20260603071519.807604-2-github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603071519.807604-1-github.com@herrie.org>
References: <20260603071519.807604-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission9.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780470921; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=etAnj7fgonFdKVbkoiHP4F3EeQb64hWRqIT01hc+eX4=;
 b=vweiJbfx0EdZUupXRNc053qs50nOGApHgUkaQzWHesG2QhLBI/TTfBsbDGR/u+SdI45jEG
 iIdlE7LTS5JfHkKq0cClDKAa8OTkfY8B42TZg9yCD3ZXculZ96nRFz3ipw17Y0zPx8GrO3
 4iPiAdSHZt+/V15TMzUvYmxsUucXcbP//4HYDiO2iVWoZX8aUljEJIWC400pntntNXDTWX
 Zc/738zbX5Nn/EdyQ1ekZNB8LjceSQcpBFr4U0+khC47dLugRsDopnW2jv4qydz6zaK1p9
 Jtf3LaRy9g3n0Uq4pl3El411Q9PfztpliP3pVfR227ja2sAYlH8BWrfPnv3zIA==
X-Report-Abuse-To: abuse@transip.nl

Add four optional properties to the MAX8903 charger binding to
describe board-level GPIO control of the DC and USB input current
limits:

DC input (TA / DOK pin):
  - dc-current-limit-gpios (1..4 GPIOs): mux control lines feeding
    the MAX8903 IDC resistor mux;
  - dc-current-limit-mapping (uint32-matrix of {microamps,
    gpio_bit_pattern} pairs): the available current levels and the
    GPIO bit pattern that selects each level.

USB input (USB / UOK pin):
  - usb-current-limit-gpios: a single GPIO driving the IUSB
    tri-state pin (low / high);
  - usb-current-limit-values: the two microamp values that the IUSB
    pin selects.

These let userspace clamp the input draw via the standard
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT power_supply attribute. The HP
TouchPad uses both: two TLMM lines select between 0.5 A, 1.0 A,
1.5 A and 2.0 A DC input current limits behind the MAX8903B
charger, and a third TLMM line picks the IUSB 100 mA / 500 mA
limit.

These are purely additive; existing platforms remain unaffected.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 .../bindings/power/supply/maxim,max8903.yaml  | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
index 86af38378999..5e970ebc08df 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
@@ -44,6 +44,41 @@ properties:
     maxItems: 1
     description: USB suspend pin (active high, output)
 
+  dc-current-limit-gpios:
+    minItems: 1
+    maxItems: 4
+    description:
+      GPIOs controlling DC input current limit via resistor mux.
+      Used with dc-current-limit-mapping to select charging current.
+
+  dc-current-limit-mapping:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 2
+    maxItems: 16
+    description: |
+      Array of (current_microamps, gpio_bit_pattern) pairs defining available
+      DC current limits. The gpio_bit_pattern is applied to dc-current-limit-gpios
+      to select that current level.
+    items:
+      items:
+        - description: Current limit in microamps
+        - description: GPIO bit pattern value
+
+  usb-current-limit-gpios:
+    maxItems: 1
+    description:
+      GPIO controlling USB input current limit.
+      Low = usb-current-limit-values[0], High = usb-current-limit-values[1].
+
+  usb-current-limit-values:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 2
+    maxItems: 2
+    default: [100000, 500000]
+    description:
+      USB current limits in microamps for GPIO low and high states.
+      Default is 100mA (low) and 500mA (high) per USB specification.
+
 required:
   - compatible
 
@@ -65,3 +100,26 @@ examples:
       chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
       cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
     };
+  - |
+    /* Example with DC and USB current limit control */
+    #include <dt-bindings/gpio/gpio.h>
+    charger-with-current-limit {
+      compatible = "maxim,max8903";
+      dok-gpios = <&gpio2 3 GPIO_ACTIVE_LOW>;
+      flt-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
+      chg-gpios = <&gpio3 15 GPIO_ACTIVE_LOW>;
+      cen-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+      dcm-gpios = <&gpio2 6 GPIO_ACTIVE_HIGH>;
+
+      /* DC input current limit via IDC resistor mux */
+      dc-current-limit-gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>,
+                               <&gpio1 1 GPIO_ACTIVE_HIGH>;
+      dc-current-limit-mapping = <750000 0>,  /* GPIO[1:0]=0b00 */
+                                 <900000 1>,  /* GPIO[1:0]=0b01 */
+                                 <1400000 3>, /* GPIO[1:0]=0b11 */
+                                 <2000000 2>; /* GPIO[1:0]=0b10 */
+
+      /* USB current control */
+      usb-current-limit-gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+      usb-current-limit-values = <100000 500000>; /* 100mA / 500mA */
+    };
-- 
2.43.0

