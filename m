Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6930FC2E;
	Thu,  2 Apr 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140062; cv=none; b=Sg4nB///pimwcrWmcCeN+tLeNqfd4fIjvoOpzWDeA+Fc8tHbIu259wyuDpQACrb5HMitRj5WFmVgKjUsUX93BybqjW+o1Ciw0qpXvchy9ao6dPeBfdCNqVMlM3CktWZpdbTCVj1b20BqB75Y6JR1pTLTueN0mdduNzhAb0o0GcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140062; c=relaxed/simple;
	bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0YMPaHXxnTkhXiGbfK0JowlzEC+dYjrB20KfWjmi+HdjRc0uBopICg0TsRtbnZYEj/Ft4pqlGXnl9673UfPMKgsmKMUTdxnoK0nxCCnUe/iBckJ3xJjuLEMiUW3HpHL1V08X2lZroYU+psrr8zqd+DonnPtAtW9B/Z8LOqAK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=sBe80RIl; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="sBe80RIl"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775140053;
	bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=sBe80RIlj8hq/fmHgN9x6nKuMk04V03duI2bCAK5aoOcCR8XJHG+LVCOQsRapJLrp
	 647rtzNJpf82hPvHB9PydrRRiY5WeHUcxIXQypuwku2QqqHE/3zvIKENc+yWA7FavL
	 Dbg9ML1MJZMnfv+Se5cPoOTec4NKh1qU4Uw3ug/o=
Date: Thu, 02 Apr 2026 16:27:01 +0200
Subject: [PATCH 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-add-mcu-fan-khadas-vim4-v1-1-2b12eb4ac7b0@aliel.fr>
References: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
In-Reply-To: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775140049; l=1084;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=Q8ByvFFPbagYCfBbxUtAun76d9Q2AZFAwBqZPLsNOk4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO9kC86Uy7mx3d8oNkTfYjfhMeV7EpSJ/5fh9o0tItxJoBZWoPkEV9/c9SnRCRv/XaJgs1GNnTf
 lkcDN+/hL7wg=
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

