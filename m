Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EAA3D9DAC;
	Wed, 25 Mar 2026 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446904; cv=none; b=judxVH/ez2zYjKiZuCfyp0BHM2Ej+DgbV3d0KELrqg7/WjPjFf/nJA5K77hEOot+tbc4xSIRyRwiCCLMMG+mLb5EGmIinEuk3vL+/OXbL/EkCj79AfnMI9mzp/wS8XIfCMtFlAmZnF6RlBkBYi2QFf3ui0sofIT9Tt1pGcpgTW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446904; c=relaxed/simple;
	bh=MHHt2ANc8Qe7TWRx8Im5NLPa2izmN2X0SM9HOq6qFMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbTYxcBawB+2hZpmoDlwya3MihQMkxY8VwCokCy13DKRU9Io6HUgU9gfB+WMMzEJeiIuztk1iGQi3BjDWfNcYtF2sPjPQRveTMdBr+UkQ5sjdY1Dwy0h3Rune/86atjKDYd/mMrkbiOIM1dVLXKXsN4J4S+qSidYHRXlvt5W2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b=oDnO0ecr; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b="oDnO0ecr"
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde0:9600:8d27:ae39:1dce:2212])
	by srv01.abscue.de (Postfix) with ESMTPSA id 477E01C0070;
	Wed, 25 Mar 2026 14:54:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1774446893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHiWGAaKNrxwaOndt6yaXs1hWGrtAVLI4xI13GIu7Wg=;
	b=oDnO0ecrYR0J/FrYgYVtWmkcSwG6qHARik+Ul2lS3JLp5XkfteNTui5t9DOzy40L0Kvxk3
	6hjOCnfdN48U1pxh/jUU/j2m12YJ+InRPxkl5oQKWOoXQN8qNnApq42NiPbZOcK593OfIP
	k8cjRAymTLYeND+A2vUI3qMfVfysLGpYR3qV3YMKBCxRreT1d3CBLcxQGE33w7QHy3CVMe
	XW1g+Z+oO2wTyC7g803iWGZeAknCDMm+3KN97+/Cf2dEUpg8FYYgvLndyeVh5uJPmyNOGg
	5jPEIDAeaV/cFanaWLAT9+vqX9G8tHOWlgVpSyZBGsHAIMkA3AxhMOCpcsmt9g==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Date: Wed, 25 Mar 2026 14:53:44 +0100
Subject: [PATCH v2 2/5] regulator: dt-bindings: sc2731: Deprecate
 compatible property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-sc27xx-mfd-cells-v2-2-d0ebb60aa4a7@abscue.de>
References: <20260325-sc27xx-mfd-cells-v2-0-d0ebb60aa4a7@abscue.de>
In-Reply-To: <20260325-sc27xx-mfd-cells-v2-0-d0ebb60aa4a7@abscue.de>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
X-Mailer: b4 0.14.3

The node containing the regulators is always a child of the main PMIC
node, which already has a compatible property identifying the type of
PMIC. This makes the compatible in the child node redundant. Mark it
as deprecated and remove it from the required property list and the
examples.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml                | 2 --
 .../devicetree/bindings/regulator/sprd,sc2731-regulator.yaml          | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
index b023e1ef8d3c..12b3258daef5 100644
--- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -222,8 +222,6 @@ examples:
         };
 
         regulators {
-          compatible = "sprd,sc2731-regulator";
-
           BUCK_CPU0 {
             regulator-name = "vddarm0";
             regulator-min-microvolt = <400000>;
diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
index 9bd752bab68e..7af20a4781b7 100644
--- a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
@@ -26,6 +26,7 @@ description: |
 
 properties:
   compatible:
+    deprecated: true
     const: sprd,sc2731-regulator
 
 patternProperties:
@@ -39,8 +40,5 @@ patternProperties:
     $ref: regulator.yaml#
     unevaluatedProperties: false
 
-required:
-  - compatible
-
 additionalProperties: false
 ...

-- 
2.51.0

