Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826601C68F;
	Mon, 13 Apr 2026 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077796; cv=none; b=MvMxHVGGuv3Jqd4lE6RMJNlD7c0D7030B44ABhANPScOpb3N4RCNjMQt0Qxh6TptGDS6JcV7xWzLTUImbokhw8+0L/KcUSBykzCFNu1IlGdXNaoyalpMTZjGygaUKxIb1ZBQ7lm4a+JWnBwRXHqQ70B5Z2kgehV3dH6dAiuV7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077796; c=relaxed/simple;
	bh=4rF5v0oH3zHajGhcO+pdY8F+zBXF1taTiSXYiRiU680=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOF6Ds4ak2MKgfsgMpnaQFqaCJEi9OfIX57GWYwNmU14EdTo385iOsPKQRQtnzHYsEvs4/OF6fV54ZjEcqU0jM7jDHTA0kBbpQWlBoVz++US9GGhLRKKXEhgXqH7QAH0TC73+DRz0h2W/RUdPMl436cvAj1FwakI3GxbVcgGpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=rDAM+h6C; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="rDAM+h6C"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776077792;
	bh=4rF5v0oH3zHajGhcO+pdY8F+zBXF1taTiSXYiRiU680=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=rDAM+h6CxOhKLlZm3w/dr9qoS6MCuu9J9cdybhcgUfXwU+OCXOfS3OhKRofo4Sb9Q
	 8DZ3mKdIKEj0kG/lQsgFEYe71Vbw1YHCyMyq+sNao6fB1LJckmjT8ufTIMegl7JnLH
	 /WWYf3b+zwFsU4N4kgnuWgRyP9heDoMVyN7dqKbQ=
Date: Mon, 13 Apr 2026 12:52:42 +0200
Subject: [PATCH v2 1/8] dt-bindings: thermal: amlogic: Add support for T7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-add-thermal-t7-vim4-v2-1-1002d90a0602@aliel.fr>
References: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
In-Reply-To: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776077789; l=2935;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=4rF5v0oH3zHajGhcO+pdY8F+zBXF1taTiSXYiRiU680=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEE005bjIEBZUsZ5Fz2BGTRjbXUvqOu0vjSYpQ+sNaSLQOz0OIfmWamV47fF3NnfGQ438XoFROk
 z20K2YX+Rmwo=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.

Unlike existing variants which use a phandle to the ao-secure syscon,
the T7 relies on a secure monitor interface described by a phandle and
a sensor index argument.

The T7 integrates multiple thermal sensors, all accessed through the
same SMC call. The sensor index argument is required to identify which
sensor's calibration data the secure monitor should return, as a single
SM_THERMAL_CALIB_READ command serves all of them.

Introduce the amlogic,secure-monitor property as a phandle-array and
make amlogic,ao-secure or amlogic,secure-monitor conditionally required
depending on the compatible.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/thermal/amlogic,thermal.yaml          | 42 ++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
index 70b273271754b..1c096116b2dda 100644
--- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
@@ -21,7 +21,9 @@ properties:
               - amlogic,g12a-cpu-thermal
               - amlogic,g12a-ddr-thermal
           - const: amlogic,g12a-thermal
-      - const: amlogic,a1-cpu-thermal
+      - enum:
+          - amlogic,a1-cpu-thermal
+          - amlogic,t7-thermal
 
   reg:
     maxItems: 1
@@ -42,12 +44,39 @@ properties:
   '#thermal-sensor-cells':
     const: 0
 
+  amlogic,secure-monitor:
+    description: phandle to the secure monitor
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to the secure monitor
+          - description: sensor index to get specific calibration data
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
+              - amlogic,a1-cpu-thermal
+              - amlogic,g12a-thermal
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

