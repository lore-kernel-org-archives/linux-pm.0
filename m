Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9143E024C;
	Fri, 10 Apr 2026 16:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839747; cv=none; b=Ud8f1qiVhl1c7AlrjPlbYhqqcqaKtbdAhUYxTRaNOmYITgJQVQK+P4DKnd42uXohuYPKhMHA9aakPqWrSqIJz80iMl9WuyNt66Q1/goX8SDXTMgS/NUbbtED1Xc2z3Vo9xd1QxeplMCgQDLJ27q54JylyFfspmQdMV0FgOKJ8ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839747; c=relaxed/simple;
	bh=JnH9zOxJRNagemiQv9oYzRiv1ojhPKXvc6QjWfgg8M8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qHnTKGE3WJJdf0GLd6mzA5O4+OkNEeyXTxemPEWH+A/d2NweFMTFC6ZA7I+QAgH9VyDVICaPAPxYtWIz4SZCRbO/8uwnMhNQw9cHogtgTzXyLLgfRkIjS5vPrTf62tSvCNRpaA9aYfEwnf0tgg4tS/mdYwT0HfVJI8DN737HX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=SCs982he; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="SCs982he"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775839733;
	bh=JnH9zOxJRNagemiQv9oYzRiv1ojhPKXvc6QjWfgg8M8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SCs982hejK1UFmNVnWr8K/Cbi6sBubCOwkRe+97Q0ApaylbdBtBf8rC7Gkn9X3Jjo
	 /lxvY38e3TlgjNq3HyjS7cBYBV171K9g36SJ8xzxIKlBrevwQgkiNfX0qwE868SZBI
	 OC3TD5CHkDkrlf1yQTgOn/mdwxpULIW/ObwTHcEE=
Date: Fri, 10 Apr 2026 18:48:02 +0200
Subject: [PATCH 1/8] dt-bindings: thermal: amlogic: Add support for T7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-add-thermal-t7-vim4-v1-1-19f2b8da74d7@aliel.fr>
References: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
In-Reply-To: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1775839730; l=2587;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=JnH9zOxJRNagemiQv9oYzRiv1ojhPKXvc6QjWfgg8M8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIown5ndRspw9U+KORP1wl++iWagf/WHOEUwIGEnUXSIOxnigvlQa9Dxfaq2ppb6l2j+JeBWAwO
 W7lGJSZi92Qk=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.

Unlike existing variants which use a phandle to the ao-secure syscon,
the T7 relies on a secure monitor interface described by a phandle and
a sensor index argument.

Introduce the amlogic,secure-monitor property as a phandle-array and
make amlogic,ao-secure or amlogic,secure-monitor conditionally required
depending on the compatible.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 40 +++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 70b273271754b..85ee73c6e1161 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -22,6 +22,7 @@ properties:
               - amlogic,g12a-ddr-thermal
           - const: amlogic,g12a-thermal
       - const: amlogic,a1-cpu-thermal
+      - const: amlogic,t7-thermal
 
   reg:
     maxItems: 1
@@ -42,12 +43,40 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  amlogic,secure-monitor:
+    description: phandle to the secure monitor
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the secure monitor
+          - description: sensor index
+
 required:
   - compatible
   - reg
   - interrupts
   - clocks
-  - amlogic,ao-secure
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,g12a-cpu-thermal
+              - amlogic,g12a-ddr-thermal
+              - amlogic,a1-cpu-thermal
+    then:
+      required:
+        - amlogic,ao-secure
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: amlogic,t7-thermal
+    then:
+      required:
+        - amlogic,secure-monitor
 
 unevaluatedProperties: false
 
@@ -62,4 +91,13 @@ examples:
         #thermal-sensor-cells = <0>;
         amlogic,ao-secure = <&sec_AO>;
     };
+  - |
+    a73_tsensor: temperature-sensor@20000 {
+        compatible = "amlogic,t7-thermal";
+        reg = <0x0 0x20000 0x0 0x50>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clkc_periphs CLKID_TS>;
+        #thermal-sensor-cells = <0>;
+        amlogic,secure-monitor = <&sm 1>;
+    };
 ...

-- 
2.49.0

