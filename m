Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321523DC4A5;
	Thu,  2 Apr 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140062; cv=none; b=qp8dSIEDOHIwD+zBP9NGlVsxMHfBQeim8VADpDRyth7xmpJYXhCLSbIfws0ZV1yRpSke1Sm2QgnLeW8GM44zvYgSZDbEEl2J49S5s50oBdqfTtrvx7m2cG10dL+zBghcywwTXbdACDysEaNSBGVMCnFPSp0/27rdfsjAnOv8LKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140062; c=relaxed/simple;
	bh=/fmGQFbRzxXF36D4HUeJ6hELpl1p69vINpfqcmw5ok0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWMrKSdMby2Sn59ouYWGi4EEFJoW0Pv/u+yFgQ2zi6vHl3kxnqyKMJUuRFYtUCGUX0a0gKgiLBAoSx9v4wa/eWwEu00ENpX1YoDzt6Mec0vRt3AP8FUQtS45zBuOK6JCUV1G6HLV91+uPvXzhhnLxnILHXYipE+UVwhj9AYhf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=tLdRH7kS; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="tLdRH7kS"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775140054;
	bh=/fmGQFbRzxXF36D4HUeJ6hELpl1p69vINpfqcmw5ok0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=tLdRH7kSxa3HP44uhfEknVm15T0gIlNxjESGH0cAmTBX7EkYy0lTqZ6H/FcLHN/jC
	 B9R7SU/lHQLzY5OxENQB/SSF2yuVS2FQpPDt5H+Kjzag78GK5jj1MRjVxpyaRralp4
	 ro170MNssUfnQhOmljr9F4ty+papk70LiOP3Xghc=
Date: Thu, 02 Apr 2026 16:27:02 +0200
Subject: [PATCH 2/8] dt-bindings: i2c: amlogic: Add compatible for T7 SOC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-add-mcu-fan-khadas-vim4-v1-2-2b12eb4ac7b0@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775140049; l=1221;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=/fmGQFbRzxXF36D4HUeJ6hELpl1p69vINpfqcmw5ok0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPyTNUP4Nt6jyGT9Oby1/TaKZlI9pCKDP6UFTK7qrNBA5J2OufsBqRdi3n9biF5H0IvMUHwNHsJ
 cNpvKnm6R1Qc=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

Add the T7 SOC compatible which fallback to AXG compatible.

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

