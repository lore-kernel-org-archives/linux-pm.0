Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B7F3815F5;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772222; cv=none; b=iAodQQSWC5tgs2r2Krdzc+i9LrdqXPwgTUZoIte63DDXfwugNi6Mxl+79AfHeBbGLbprAuqQ95OzIPmkPm7/tyuUgbGyhm22UqQACwBaCpKg0sNNVTxyhySF6g/joD6L6PAET/xO8J8P5s6UbtbEzz0Y0mpBZCFhO2L2FdU3vaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772222; c=relaxed/simple;
	bh=8mEtZw+TxoouXpA9/fAD2qX1pxDekWyJvS7D2tvreNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KgWTlhoU/gJ35DAMLFJCIxcSp5Q4McdeDkPJy1XL6nDt5IvyTrK1KQq4SuM9ocU07SRi0Mv1oqoZ2VtXTbHwIl98fFKOLO9VI8SpEAB5TY4XxTzvjQ6I0K4riAOszGkU9DEYjQL59rIafKJ1K9rHtep15TYzwSleNzaOdfVxhKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4Qpeh8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4Qpeh8A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D9A2C2BCB3;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772222;
	bh=8mEtZw+TxoouXpA9/fAD2qX1pxDekWyJvS7D2tvreNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V4Qpeh8AntPhluG9pt2YJTE+gwXG8IoGi+Dt2ZiLLSbk7PVdQ7llCf7uuSslLOCMV
	 jrm7qtZd+AVIH4Q0JnNDi9tzr7LZLkibD7+oAKWSIQ5vGlZVFrqzNCm+FIiz7OdevD
	 kb95S0SYeHknJ/WZoYwnAUl104mBWRXIwZkc/s6nx3FEK+0BY+V2kZR3wzYnhM5cEI
	 QPFWZsDukcaIZvf2WDrKYZl97c4p1w6FyOcDARkSpTAWaEg6FQinjoOhmIs9VzRT7+
	 +NWK/3sfbuKwJcHiuzCzMmDipi6TopVsBRpeHQXeFVCYxg04evX1WsvJulAmK2HPgd
	 Q4DH5QS3qLctA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22F7F8FA61;
	Tue, 21 Apr 2026 11:50:21 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 21 Apr 2026 13:49:18 +0200
Subject: [PATCH v4 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-add-mcu-fan-khadas-vim4-v4-1-447114a28f2d@aliel.fr>
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=NEIvA2L6y4otwyymsGTvUWGx1Runlk0F5PI2/57WLQQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+bzlOzIzyqlEm98eWdN8lFe+ORaT8UBN485Ju9O55Zt8
 mf9fOZLRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCR7WaMDFtD3Fj10iafZA2O
 Xe1g+nVl4dovlalLkv3Pc88sW368/hgjw9S1z/35Vj3JeTSXWWupXHi6wPeuU+JxL35ndfb7T5x
 cyQcA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The Khadas VIM4 MCU register is slightly different
from previous boards' MCU.
This board also features a switchable power source for its fan.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
index 084960fd5a1fd..1f135618e3b6f 100644
--- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - khadas,mcu # MCU revision is discoverable
+      - khadas,vim4-mcu # Different MCU variant, not discoverable
 
   "#cooling-cells": # Only needed for boards having FAN control feature
     const: 2
@@ -25,10 +26,27 @@ properties:
   reg:
     maxItems: 1
 
+  fan-supply:
+    description: Phandle to the regulator that powers the fan.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
 required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: khadas,vim4-mcu
+    then:
+      required:
+        - fan-supply
+    else:
+      properties:
+        fan-supply: false
+
 additionalProperties: false
 
 examples:

-- 
2.49.0


