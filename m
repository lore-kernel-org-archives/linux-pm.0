Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758722BF006;
	Sun, 25 Jan 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769368090; cv=none; b=iwJpfGRmHT1jWMWHRNKIt4QncdEYyGqwBFtF4yyaXtnB4BVoz4jgVHf7aJ8setGNKat3DXDrucvJ2tI3KhInONiRna3nyEzQ5UK0bD+oxedHphvFBxvdOvuVDpgC/DFqM0e8753L4zepTM5FEPShb4yFYgOil+Qp2ETU+lCQDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769368090; c=relaxed/simple;
	bh=v18ecyJjpRt8OYAuP8S1Zuke3HLjhsE22p1SX0Vty34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIYzvVEIg8uizo883LoHywAvWVy0xy4FtGAZ66GW87kHYdYoZzuoXF6h36sK3CEQI8/MNJ6znNSXKeuwvpWBu+W2aLIZMh+sEgGRNIww1IjOZkstyHuUjni0fLnzK+YRNokx6nUVJSnu9FXTIzYIsLgLpIueRBJ6BwvDtA3SCsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ezCqyN9o; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ezCqyN9o"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id BA42928091;
	Sun, 25 Jan 2026 20:08:07 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IRqWjFqTHowk; Sun, 25 Jan 2026 20:08:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1769368086; bh=v18ecyJjpRt8OYAuP8S1Zuke3HLjhsE22p1SX0Vty34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ezCqyN9oq1zLOId9gV+uNJ2YCfSC+38qpsNWLOp+XrWS7MBMRmkdHmpjRI5/q8mJ9
	 1TD73w2cdFXWQTvz/iywrn/xcPh84YUbcHnzGT2MT3JKLxba9qeLd6In/vSWZEmAw1
	 YA6r3u+jDJ4VQmIfB3SX/f0uF7N6wT2BNqDf4Di4meh1ZLqF48Qv1nIGu5lAFGpRna
	 BT35j+6g9vKGhftv5juaqRWwdhfu9RROC1B0MORbMGecLILpctD8k6KN1R7QzxLTt2
	 W2uB+5nm/ZA2zsWBQz+RUHXM1TJ2bHDRKVfw1kLuBUUrlHUEjFx7Ct7m5iQTHxWy1N
	 ycvPrU1s6K+9Q==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Mon, 26 Jan 2026 00:37:11 +0530
Subject: [PATCH v2 04/12] dt-bindings: power: supply: document Samsung S2M
 series PMIC charger device
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-s2mu005-pmic-v2-4-78f1a75f547a@disroot.org>
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
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Certain Samsung S2M series PMICs have a battery charger device which,
among other things, manages power interfacing of the USB port. It may
supply power, as done in USB OTG operation mode, or it may accept power
and redirect it to the battery fuelgauge for charging. Document this
device.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 .../power/supply/samsung,s2mu005-charger.yaml      | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
new file mode 100644
index 0000000000000..9159a15e77c61
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/samsung,s2mu005-charger.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/samsung,s2mu005-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Battery Charger for Samsung S2M series PMICs
+
+maintainers:
+  - Kaustabh Chakraborty <kauschluss@disroot.org>
+
+description: |
+  The Samsung S2M series PMIC battery charger manages power interfacing
+  of the USB port. It may supply power, as done in USB OTG operation
+  mode, or it may accept power and redirect it to the battery fuelgauge
+  for charging.
+
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - samsung,s2mu005-charger
+
+required:
+  - compatible
+
+unevaluatedProperties: false

-- 
2.52.0

