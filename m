Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE27E486624;
	Sun, 20 Sep 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944569; cv=none; b=awmXMErjXHsb4J585T4kf8APd7x91i15lMMjpOV5NmQfcoSUDvBEBcdTGk31uU+UzHeZdF1zVy2vIsS6FGefOL1AeCGTUubbanLQQHGUKPM4aXByD4+T5C44dI5H9qT1LlLE+MD5fedW6Q20w9aYxpqzFQko6gyaAJDDlnbF29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944569; c=relaxed/simple;
	bh=icNwHLajbzMDsEv6IMQ26xMlwh8qcRQgJPPaLaYGm6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M+5kic1V3h0qc+rKcyTEggAL/VN5XIOOiaud/RWx7W/VFjO9tKf5Bu70cSpDxUH5hdZqBNahToNStuQUfqOl/iXID9LT/69eidX4txrjF4hANZIIaBe6GG5C8juCU6dphZvCgV+FZQrgVlldaWF1Lt6a0vIKU2enQM1zdq3WLQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPdAwA+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPdAwA+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39BC1F00898;
	Sun, 20 Sep 2026 22:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944568;
	bh=BBt2COgZu3DKoXFiTxSfzYVzTp4HEeS23YJYmLbXFsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPdAwA+WFHsFuibI/41J1UZgWYnVQi5rXXbznrbKfF7lz0pllL9qvOtz/NC7FL85x
	 Kt5LOLVa8zP/qUbp52uqbfOOc5PklICC5Zqhcr6ioA1CyOBPWwIAQwsOU7FnlK7d+A
	 KE0WQ5r1SmE8/M9HbzcNC1HplXcrp2eAMWT4h6tRk3/QgTwr+2qylW1O48M2IeWpX/
	 Ntc1Gv5F9NNEDwhayWDGw208EoBgUz3pttnI0vWJJPgWp4AByP3FlaqbkGWqrB0aVJ
	 /UNk9xeQpZXxwKccdlO/rfF+Wv1J0CsBPcb4DubMLUgPJFnKQ/SzFdw31L2rvjqJ41
	 0Y8mW/4zrY+pg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:23 +0200
Subject: [PATCH v3 17/18] dt-bindings: display: ste,mcde: Deprecate EPOD
 supply
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-17-9352be6b86b1@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Make epod-supply optional and mark it deprecated.

The MCDE should use its power domain instead.

Assisted-by: LLM
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/display/ste,mcde.yaml | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ste,mcde.yaml b/Documentation/devicetree/bindings/display/ste,mcde.yaml
index 05e7e4ebc882..ee34b65dd13b 100644
--- a/Documentation/devicetree/bindings/display/ste,mcde.yaml
+++ b/Documentation/devicetree/bindings/display/ste,mcde.yaml
@@ -39,7 +39,8 @@ properties:
     maxItems: 1
 
   epod-supply:
-    description: a phandle to the EPOD regulator
+    description: a phandle to the legacy EPOD regulator
+    deprecated: true
 
   vana-supply:
     description: a phandle to the analog voltage regulator
@@ -103,7 +104,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - epod-supply
   - vana-supply
 
 additionalProperties: false
@@ -121,7 +121,6 @@ examples:
       reg = <0xa0350000 0x1000>;
       interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
       power-domains = <&pm_domains DOMAIN_B2R2_MCDE>;
-      epod-supply = <&db8500_b2r2_mcde_reg>;
       vana-supply = <&ab8500_ldo_ana_reg>;
       clocks = <&prcmu_clk PRCMU_MCDECLK>,
                <&prcmu_clk PRCMU_LCDCLK>,

-- 
2.55.0

