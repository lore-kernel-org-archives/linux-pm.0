Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E278442B1F;
	Mon, 14 Sep 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386900; cv=none; b=bHkbO/PyiVnQZbzFaRExj2F32/HpPPDMRExGoAOAW88qv/dyiNFPtPN8WH6Qvdfl/WmQSlhbzxyTbFSasizCnzx82qXzNFcJ+uG/5p+zbEyZSroort2abta4+2BWHk7zLPuZRvSA5qLboLTu1+GAPiBqvDJ0oN7eZGSOT/tbbxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386900; c=relaxed/simple;
	bh=+WLANnhbZRF09QmnM7cGWwtap5g3250lJMcWgIb0Kkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tBR8WNzr5rMxQaQ49t9ILCBfJ5uKX+vtrBMgJ+tBoaphTAwGB9mY1p5ORsiaM5ZmZDUF9yO0zryMyAUlWk2J6VhbdGPnBvlGNmlmt6bCAfZf+yOO5EWyqunU1PaXU+4PXWR57LjOh2bqNkmKBhzQElai8Q+h5XDRHfuhPsNAHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/qe+7Tq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/qe+7Tq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ECDB1F00893;
	Mon, 14 Sep 2026 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386897;
	bh=5PXwVT3mCA+YpecjXQdVelOjDLl8aO5/fm2KL71yj98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=P/qe+7Tq2Hg4z53wJUgNPPO9MrD+DLgbMFeAgEttz/tgjQwLtxoIE9zggyjrMrTWC
	 oG7682yvcChjBk/+45vxhaDqIcjtClRMvawrxXQfIfkywgd1ys///PKH9IWL7iC5kY
	 V2NMvOYmD/Ykri6bT7a5M2+SbszcgEwQDEbHhPJronq/iGWWznOYnSYNqLb4AgRjJQ
	 9UGG8QXc+3G45kk969wD7hnxoXaxL+4m2212ulAvDR2GtBTkMe0wNC1OjU8s2fkrcp
	 ude/XidK5ZqKV46r4EpCxCUc4vKYEu5Is7CQdTYxJVlBLhRJ2pF0G37G9AY8hiUgGQ
	 DF1LIVH2wcL/A==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:33 +0200
Subject: [PATCH v2 05/20] dt-bindings: display: ste,mcde: Allow power
 domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-5-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
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

Document the MCDE power domain.

Keep the legacy EPOD regulator binding unchanged for now.

Assisted-by: LLM
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

