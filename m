Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735AA3CCFA3;
	Fri,  3 Apr 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232565; cv=none; b=A10uO5N7HSdO6MtFXD98/uWYtnEOlh2tF1WZg0RrdlrSyVf3VaVQgmNwQmxZxfKrSGPNwobkRZPlIx0e/bK9W/LKQCSyraJgUDQlIGSut/1uvWieAdYYOz6VSONEZosAWgq8Fo+OCPGl8n5QEnVeDQuj5hFSK6NIXhJsKF9xTrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232565; c=relaxed/simple;
	bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaWUs4EURrQklWxN9cPA+z4NudNgsOCA495GU/juj+WLLWCJiud+OiC/klLNgWb2D7/fgOr8JDe45wXg6H2sfCKMuQyrvKMWj+Vv38r+ESr/TiDgDfOv1k/76L8x29/XAwEQ1/23yQ4QVju1uqfilAKPbsAgO2BN6AebmXvzIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=ba+dg2Rj; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="ba+dg2Rj"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775232555;
	bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ba+dg2Rj/LoUI10tNBOgsrOpdo+R21DNRDlK5sH9pPq0UxTfjw+BcRTcQIf/v+H75
	 8TBl8to7QpxPqvIk0pU3Zdo+4SgIVZmOWrSz/VazoGfvBHJxY4qLOCRYh1dFmIWJ1e
	 iXcJTTuFhtl8LvW34+JVjmdoxYfOfcq1r9fL89y8=
Date: Fri, 03 Apr 2026 18:08:34 +0200
Subject: [PATCH v2 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-add-mcu-fan-khadas-vim4-v2-1-70536b22439a@aliel.fr>
References: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
In-Reply-To: <20260403-add-mcu-fan-khadas-vim4-v2-0-70536b22439a@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openssh-sha256; t=1775232551; l=1084;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN+HSpfVr3U76oMKxbTnvYCN4HQkwOpO+FuclfO5fOUGdk4TD1qkgOSRYaKTwmsfXofiiJi8mb2
 65R3L/cCxJg8=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

The Khadas VIM4 MCU register is slightly different
from previous boards' MCU.
This board also features a switchable power source for its fan.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
index 084960fd5a1fd..67769ef5d58b1 100644
--- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - khadas,mcu # MCU revision is discoverable
+      - khadas,vim4-mcu
 
   "#cooling-cells": # Only needed for boards having FAN control feature
     const: 2
@@ -25,6 +26,10 @@ properties:
   reg:
     maxItems: 1
 
+  fan-supply:
+    description: Phandle to the regulator that powers the fan.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg

-- 
2.49.0

