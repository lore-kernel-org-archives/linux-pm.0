Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE3C270552;
	Sun, 25 Jan 2026 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368070; cv=none; b=AbDoBOqVK6tnFTWJafxXEYpg7OE78y9hRGkXBweF5oj7cfCC8/xEn9v1Rf9ypGQAGG/F0AeDqZzlpykHifZZLC5zxFsHaMPxtOwWRMLypIsXAf9SGoh/8cjVqoo8Iqp3nNirYKPxj7Bm/kzWfyZOlkBpg7vrA1gtKB7QSfOIpdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368070; c=relaxed/simple;
	bh=UGom5F2XoRj2ePCeHluZNCyK/VNDR585euzHO1No7lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fha1Dfja02odOwHNiBekpfDXuapXZ23+LjsZueCZeUDAbnQvqmpa/tOCQULcjftI09I1jBFLWzyeb54MZiwpAfJp0lC7gfRpLxTxKoB02uThvQMYtu0vfa2OkBv2gD3JA7RGQKISo8FY2BK9RIVrXHypgnJ4gMfUNb686rpiy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=QjdFFQiA; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="QjdFFQiA"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DA27427DEF;
	Sun, 25 Jan 2026 20:07:46 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4m-0iEfYHiDC; Sun, 25 Jan 2026 20:07:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368066; bh=UGom5F2XoRj2ePCeHluZNCyK/VNDR585euzHO1No7lQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QjdFFQiArJWA688VUBOFLqpAAEmB1ZW1lbmNv+tHBD+EDceMI6SmoMF1S/xnR4pJH
	 UG6heUnIxrH2+ylOEobor/Dw5FQQFwRBg7zYREIc7SPW61j6TJgZxqfap+qvESDaGY
	 wDpjGV8iomBbkf64LHHTIdjIyJsuDidJG182N14qmmI9ry401WqYPHSOtsoeZj8iqj
	 2Cq1/ZC/xWhkhOCqQN7kOcQpOv0eJDCwf6SXLKT1ND24V6aDxIwm5hzwk7cKFbYxXN
	 4OzYG5GdWYEzdlp5CYmU4fIKcGZ9i+eIF86vcNOSHh3Jg1+swNQhIBF/GTheQgnue1
	 G5HfULHOMu8fQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:08 +0530
Subject: [PATCH v2 01/12] dt-bindings: leds: document Samsung S2M series
 PMIC flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-1-78f1a75f547a@disroot.org>
References: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
In-Reply-To: <20260126-s2mu005-pmic-v2-0-78f1a75f547a@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Conor Dooley <conor.dooley@microchip.com>

Certain Samsung S2M series PMICs have a flash LED controller with
two LED channels, and with torch and flash control modes. Document the
devicetree schema for the device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../bindings/leds/samsung,s2mu005-flash.yaml       | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
new file mode 100644
index 0000000000000..36051ab20509f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/samsung,s2mu005-flash.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/samsung,s2mu005-flash.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash and Torch LED Controller for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC flash LED has two led channels (typically
+  as back and front camera flashes), with support for both torch and
+  flash modes.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-flash
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false

-- 
2.52.0

