Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210CC370D6E;
	Sun, 20 Sep 2026 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944518; cv=none; b=s+V3iXzfAAVXFeHddfz17VIS+7a6zXTyMHwfwGLpSLQ/JtP7q7uMG1wFvjraJ08XOxmhzfa17BAmzEjWopmBn7SgARtnau8WzdfJILkXjsmFR8qf23txlTlWEJAkzBiLUT5jciPAwiAQRu7VCHt0mOgkFJgCMCQB/2mv8bWyoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944518; c=relaxed/simple;
	bh=OCP4r7hRWKzkvgnqAlOEJEXUV1dx2le3B1Xn4C9CRQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/8KMXh1gZaQTZlN/WI05nYPPaH4ZsioCKEG1VFBsW2aEvueU6z05mLRdoRan/XsOEDeVuRreDruF70FkCnryIAhJuOx/UKC/O8kzfmBWc87F8xBIzz1PduGoBARWsdmkVklm4aVETTgE9NQnAyMmLjYz+c8mmSyRGlXrS3ftGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3iIUc+v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3iIUc+v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81381F000FF;
	Sun, 20 Sep 2026 22:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944516;
	bh=82Lpl4esNr0fEGBNe2yBIcFrhWe1VJjlH0m9toI3nWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K3iIUc+va9bzkt86uUyVRkUYGpRVZ9KUHkX7587vB55OzJIRGyKJlQYuIItOG6xPl
	 D0cyts3cGHJ69d3NpTDdt4GA1Oi/KYg1OhDAsUq2qx513NW9k7VX8bSK+opNyYT95L
	 UoB2K8ZwcZhTt9Nijx3sjlNg8ZvzEyT0M5Dw7baxofOCpkYNUWyP0mvEMvqFssTeKe
	 u/+4MELq9IKdFgx9jEyvYem3909pnRCS0tALop6TsZmi85oZ/aA2YlvKNZfagLHruM
	 n0dd3zqj97V8zfnHpJPSbVIgJwirgBMYLdV+CWGu95ugeGsrMIITLQBAxkMKef3zcO
	 4KdQ4JFw6zbYQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:11 +0200
Subject: [PATCH v3 05/18] dt-bindings: display: ste,mcde: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-5-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

Document the MCDE power domain.

Keep the legacy EPOD regulator binding unchanged for now.

Assisted-by: LLM
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index 7a12d0b817e6..05e7e4ebc882 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -35,6 +35,9 @@ properties:
   resets:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
   epod-supply:
     description: a phandle to the EPOD regulator
 
@@ -109,6 +112,7 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/arm/ux500_pm_domains.h>
     #include <dt-bindings/mfd/dbx500-prcmu.h>
     #include <dt-bindings/gpio/gpio.h>
 
@@ -116,6 +120,7 @@ examples:
       compatible = "ste,mcde";
       reg = <0xa0350000 0x1000>;
       interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+      power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
       epod-supply = <&db8500_b2r2_mcde_reg>;
       vana-supply = <&ab8500_ldo_ana_reg>;
       clocks = <&prcmu_clk PRCMU_MCDECLK>,

-- 
2.55.0

