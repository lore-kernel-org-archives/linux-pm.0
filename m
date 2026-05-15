Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E544B662;
	Fri, 15 May 2026 10:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841578; cv=none; b=vEdG0uHQ8SzU3v461d4lVjGtzFjfAcP93uvxFyp1rVvDgEOeF0x4xAsf7D8ldoPMGM8pp7rwIW9aDfGsbsxTutb0UgS4ieITIVX4qD1ZL6zi+z7Aj4jmkdfo93+8VwDjyFC5YaovXcM51k5Iu4tuR3EsWJfpNfEkvK2MO0aIW9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841578; c=relaxed/simple;
	bh=yhg5gVajDM6Da2FgjY3mvjRRBtWbHEv5TqLXfC/zzJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iFXG2jqTH7eAJcgwKaM8pQ6xTbLPqMY4nTQiFC5iPVoXQRyEmNb/O0/jIce5obDQtB39H86DVyIRzBt/ELG9AVFVGrmsc1kJ3DBFwXyT819feFWmM8uTisVNygDtAhBce2rMyLulzxVHRdAlbLTG+Eg0rfRw6tjeJJmalCpEbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YVpHgBOV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YVpHgBOV"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 26D44270E5;
	Fri, 15 May 2026 12:39:36 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wjj7gnf8Rtim; Fri, 15 May 2026 12:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778841575; bh=yhg5gVajDM6Da2FgjY3mvjRRBtWbHEv5TqLXfC/zzJU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YVpHgBOV67hFyN5feFzsnSDTyHfwbL1RRFW86gNzc/0YAnZX0xmfntW7qjzgojNqX
	 a0FhynqSA1In3cf9TGwVCaK7H43eF6zzLeG9WJip4twNngZX8RWyRa7OTYQOMZ6YDE
	 MlcIp6wR7YQKyQBpmmKlUGqmV6ybWq22S3GafpUvFqP7+wNchqZWU7pq2MyYg7yjGL
	 20znp695La/JwOFvlrwA3eXHOQLmfpbwHInFhm0a+oo+GiObhV688Whn8Z2DCKRcA3
	 i7e7/nscXFPrt4OdMYnZBTKZhcOR8o8AMEzwtRijR/uys2zwZ96zFvAdg6sTNZXBwo
	 01SmM5RccU5ew==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 15 May 2026 16:08:57 +0530
Subject: [PATCH v6 01/11] dt-bindings: leds: document Samsung S2M series
 PMIC flash LED device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-s2mu005-pmic-v6-1-1979106992d4@disroot.org>
References: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
In-Reply-To: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>
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
2.53.0

