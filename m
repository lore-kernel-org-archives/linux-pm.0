Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36301329C66;
	Fri, 17 Apr 2026 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443824; cv=none; b=KTyi0AxCdWAHSu92RUxAsQYpSt8Z+WBHbX0grKfGq98O0GZFWlrqrhkWa/u+5I315H+q80u1IxZiJGRm9FEwquxHOVC6O/NKI+h61byTHY7dStist8/fX8GanQOmpu/YwZ66qdpd84AlBjujUVXxOwr0yZoXg0tGAVovVoN0NuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443824; c=relaxed/simple;
	bh=dSGVBP6Kwid380fHwj/yvIcbmVkBngDKwALA0QzKSyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vjg1+11voVRpI3gjvJmhOpYFjSaDL643SneXMsu+nI9R403nkMsJwbj4O+E2b0KxBQAUyB7peDxyHDzxhSY54LkSC/kBGYYQZl9LchZTKOQgEo57cfbYCWaz0DLDR5JJCZfP4l31e+Ia53TvGCriHk69fEbE/m6jKo2AMsDrE2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=sOC+/nc9; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="sOC+/nc9"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776443821;
	bh=dSGVBP6Kwid380fHwj/yvIcbmVkBngDKwALA0QzKSyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=sOC+/nc95HwQ3If8FUGI/tkBtJLHsXdQnLbO7PiFt9lj0UA2hMwm3RZQ6KJKdCUqp
	 ysXkOG4oYCUPTjrF4sDoS2oWo3kaA7rdITvI5XHCLsjSs+zSt2huR5idMSgkqrwGpr
	 SaxJYKLQCoL5JYVRChH4SBObGEjI0TD/2aMKiN8U=
Date: Fri, 17 Apr 2026 18:27:18 +0200
Subject: [PATCH v3 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-add-mcu-fan-khadas-vim4-v3-2-a6a7f570b11b@aliel.fr>
References: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
In-Reply-To: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776443816; l=1268;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=dSGVBP6Kwid380fHwj/yvIcbmVkBngDKwALA0QzKSyw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIJzFTKW3rJkbI8G4HNHwG/SaKlPKhhf1BMkq9mNhnjhgPsdVTXoHB5c3luaopWfZXt2ICwrk5L
 wQkituZfWtAU=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add the T7 SOC compatible which fallback to AXG compatible.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/i2c/amlogic,meson6-i2c.yaml         | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
index c4cc8af182807..7b59b60b62e5b 100644
--- a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
@@ -16,10 +16,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson6-i2c # Meson6, Meson8 and compatible SoCs
-      - amlogic,meson-gxbb-i2c # GXBB and compatible SoCs
-      - amlogic,meson-axg-i2c # AXG and compatible SoCs
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,t7-i2c
+          - const: amlogic,meson-axg-i2c
+      - enum:
+          - amlogic,meson6-i2c # Meson6, Meson8 and compatible SoCs
+          - amlogic,meson-gxbb-i2c # GXBB and compatible SoCs
+          - amlogic,meson-axg-i2c # AXG and compatible SoCs
 
   reg:
     maxItems: 1

-- 
2.49.0

