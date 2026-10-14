Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714204A3F14
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009217; cv=none; b=YT9hvz4nIaNb3CnzBDDAB80yOWBqM89fqkdw6pZNShOyUK9XTdatVp160+w2DbfVj2MRS5cozZK6ZMH011jmPEZx7FZIr84wVU91Wtmiz52jAloHbDP6tsOBPEUNvRNd8FDgUPd91XGW39YbGb9ONkHbaogEImsJA8J56Uvh5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009217; c=relaxed/simple;
	bh=Z5IOeuJqtsuApOh56K2gmn6MP5iOYZAa1ecbnWg4wdg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fzbiaZQ9rrHAMg/5WOwFLCySpIchjhDzePUEeStShUyCKRkTZyklVx+j86KDjO67ra9lUXtOKoH3U6wRcXrlSFkwEfDuimkB9oIbb7ND4jOWdCtKutH2R/htdcHD+bvmnME565X6+l1U0PxJa8VCh3+8HOo1Zr4JjqzF5PS2J3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mk2AzQ0V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UfkXS2dq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mk2AzQ0V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UfkXS2dq"
Date: Wed, 14 Oct 2026 20:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hykl9nba45a/jrNtQl9Yh3oIQqe2pEYD99dBkKc0ApI=;
	b=mk2AzQ0Va3sCOnKYnWoGM1LuODIBoNutUuxWSred2U4/acWB3m+5Ee+cc8q+QMzKgLVwr6
	FqIdpalWJwhliXEMUaW6EsvoqJbr+0iFA8rON2Ow8ciENBewtRTWeVjWF8oXxgV+3wJqHW
	XGWTH4v481alOsvtphM7fxRPGhP5pgYAY6jhjVXc35BULNYvrMf9hklJqehKf6w8CKebJh
	ypme5KOtrIZj3lL1V3BxQh7SLqABQ6R/qfyJHCSOOzCGkGWsDsZT1lyVCirhy41blf3yuO
	cgb1POyjE/o3ToPRjaIkleMnhh2rCBsFSd3IACiL2rP3ViAZSzxumG71jLd8wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009214;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hykl9nba45a/jrNtQl9Yh3oIQqe2pEYD99dBkKc0ApI=;
	b=UfkXS2dqQKYtyetEuvONHnmB9BhO+OCpf18QmE60uD/UwElbxAbNTO3yUgYXa+kO2NHzkt
	APkyWUAqNwzp+ADg==
From: "thermal-bot for Bhargav Joshi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] dt-bindings: thermal: ti,omap-bandgap:
 Convert to DT schema
Cc: Bhargav Joshi <j.bhargav.u@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>
References: <20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921318.2666337.9807164676923265387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     072c3e6ac8cd959b523fb589ad9ddf9d7d2a52b4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//072c3e6ac8cd959b523fb589ad9ddf9d7d2a52b4
Author:        Bhargav Joshi <j.bhargav.u@gmail.com>
AuthorDate:    Tue, 11 Aug 2026 00:19:28 +05:30
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 18 Sep 2026 12:18:33 +02:00

dt-bindings: thermal: ti,omap-bandgap: Convert to DT schema

Convert Texas Instruments OMAP SCM bandgap from legacy text to DT schema

Add "ti,dra752-bandgap" to compatible which was missing in text binding
but used and matched by same driver.

Document the "#thermal-sensor-cells" property, which was missing from
the original text binding but is required in practice by all in-tree
users via the common thermal-sensor.yaml binding.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20260811-ti-bandgap-v2-1-6fec2a71c394@gmail.com
---
 Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml | 177 +++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt   |  88 +------=
-----------------------------
 2 files changed, 177 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,omap-bandgap=
.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/ti_soc_thermal.=
txt

diff --git a/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml b=
/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
new file mode 100644
index 0000000..091b7be
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,omap-bandgap.yaml
@@ -0,0 +1,177 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,omap-bandgap.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments OMAP SCM bandgap
+
+maintainers:
+  - Eduardo Valentin <edubezval@gmail.com>
+
+description:
+  In the System Control Module, OMAP supplies a voltage reference and a
+  temperature sensor feature that are gathered in the band gap voltage and
+  temperature sensor (VBGAPTS) module. The band gap provides current and
+  voltage reference for its internal circuits and other analog IP blocks. The
+  analog-to-digital converter (ADC) produces an output value that is
+  proportional to the silicon temperature.
+
+properties:
+  compatible:
+    enum:
+      - ti,omap34xx-bandgap
+      - ti,omap36xx-bandgap
+      - ti,omap4430-bandgap
+      - ti,omap4460-bandgap
+      - ti,omap4470-bandgap
+      - ti,omap5430-bandgap
+      - ti,dra752-bandgap
+
+  reg:
+    minItems: 1
+    maxItems: 6
+
+  interrupts:
+    maxItems: 1
+
+  gpios:
+    maxItems: 1
+    description:
+      used to inform which GPIO line the tshut signal is routed to. The
+      informed GPIO will be treated as an IRQ;
+
+  "#thermal-sensor-cells":
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: thermal-sensor.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap34xx-bandgap
+              - ti,omap36xx-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+
+        interrupts: false
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 0
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,omap4430-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        interrupts: false
+
+        "#thermal-sensor-cells":
+          const: 0
+
+      required:
+        - gpios
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,omap4460-bandgap
+              - ti,omap4470-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 3
+          maxItems: 3
+
+        "#thermal-sensor-cells":
+          const: 0
+
+      required:
+        - interrupts
+        - gpios
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,omap5430-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 1
+
+      required:
+        - interrupts
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,dra752-bandgap
+
+    then:
+      properties:
+        reg:
+          minItems: 6
+          maxItems: 6
+
+        gpios: false
+
+        "#thermal-sensor-cells":
+          const: 1
+
+      required:
+        - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bandgap@48002524 {
+        compatible =3D "ti,omap34xx-bandgap";
+        reg =3D <0x48002524 0x4>;
+        #thermal-sensor-cells =3D <0>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bandgap@4a0021e0 {
+        compatible =3D "ti,dra752-bandgap";
+        reg =3D <0x4a0021e0 0xc>, <0x4a00232c 0xc>,
+              <0x4a002380 0x2c>, <0x4a0023c0 0x3c>,
+              <0x4a002564 0x8>, <0x4a002574 0x50>;
+        interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>; /* talert */
+        #thermal-sensor-cells =3D <1>;
+    };
diff --git a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt b/D=
ocumentation/devicetree/bindings/thermal/ti_soc_thermal.txt
deleted file mode 100644
index 6299dd8..0000000
--- a/Documentation/devicetree/bindings/thermal/ti_soc_thermal.txt
+++ /dev/null
@@ -1,88 +0,0 @@
-* Texas Instrument OMAP SCM bandgap bindings
-
-In the System Control Module, OMAP supplies a voltage reference
-and a temperature sensor feature that are gathered in the band
-gap voltage and temperature sensor (VBGAPTS) module. The band
-gap provides current and voltage reference for its internal
-circuits and other analog IP blocks. The analog-to-digital
-converter (ADC) produces an output value that is proportional
-to the silicon temperature.
-
-Required properties:
-- compatible : Should be:
-  - "ti,omap34xx-bandgap" : for OMAP34xx bandgap
-  - "ti,omap36xx-bandgap" : for OMAP36xx bandgap
-  - "ti,omap4430-bandgap" : for OMAP4430 bandgap
-  - "ti,omap4460-bandgap" : for OMAP4460 bandgap
-  - "ti,omap4470-bandgap" : for OMAP4470 bandgap
-  - "ti,omap5430-bandgap" : for OMAP5430 bandgap
-- interrupts : this entry should indicate which interrupt line
-the talert signal is routed to;
-Specific:
-- gpios : this entry should be used to inform which GPIO
-line the tshut signal is routed to. The informed GPIO will
-be treated as an IRQ;
-- regs : this entry must also be specified and it is specific
-to each bandgap version, because the mapping may change from
-soc to soc, apart of depending on available features.
-
-Example:
-OMAP34xx:
-bandgap {
-	reg =3D <0x48002524 0x4>;
-	compatible =3D "ti,omap34xx-bandgap";
-};
-
-OMAP36xx:
-bandgap {
-	reg =3D <0x48002524 0x4>;
-	compatible =3D "ti,omap36xx-bandgap";
-};
-
-OMAP4430:
-bandgap {
-	reg =3D <0x4a002260 0x4 0x4a00232C 0x4>;
-	compatible =3D "ti,omap4430-bandgap";
-};
-
-OMAP4460:
-bandgap {
-	reg =3D <0x4a002260 0x4
-		0x4a00232C 0x4
-		0x4a002378 0x18>;
-	compatible =3D "ti,omap4460-bandgap";
-	interrupts =3D <0 126 4>; /* talert */
-	gpios =3D <&gpio3 22 0>; /* tshut */
-};
-
-OMAP4470:
-bandgap {
-	reg =3D <0x4a002260 0x4
-		0x4a00232C 0x4
-		0x4a002378 0x18>;
-	compatible =3D "ti,omap4470-bandgap";
-	interrupts =3D <0 126 4>; /* talert */
-	gpios =3D <&gpio3 22 0>; /* tshut */
-};
-
-OMAP5430:
-bandgap {
-	reg =3D <0x4a0021e0 0xc
-		0x4a00232c 0xc
-		0x4a002380 0x2c
-		0x4a0023C0 0x3c>;
-	compatible =3D "ti,omap5430-bandgap";
-	interrupts =3D <0 126 4>; /* talert */
-};
-
-DRA752:
-bandgap {
-	reg =3D <0x4a0021e0 0xc
-		0x4a00232c 0xc
-		0x4a002380 0x2c
-		0x4a0023C0 0x3c
-		0x4a002564 0x8
-		0x4a002574 0x50>;
-	compatible =3D "ti,dra752-bandgap";
-	interrupts =3D <0 126 4>; /* talert */
-};
