Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896E440A16;
	Mon, 14 Sep 2026 11:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789386920; cv=none; b=lyma9SGU92Z/VEtKm4UONygqTesbokrT4d3/irF2tcrPkk8Tj/qfjva3AkkF1ie3JrcN7C1vPWgASHDO/rzwX9iLIlxGS0Nqaiexpq1MWnk1fj7w+/tjYidBj0mZAIxQPiglX/qWq4KTFRyHoAYwUpMgiXXFloxyMM/khX54YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789386920; c=relaxed/simple;
	bh=JCtGi8Xd8CdMx90mL0Zstfc0goDPP2kgntVgk8rhesI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MdiapkdIn+ZvjE3G0mHD2HvFg26Vt62uDefuJgvgdDUtiglfeJtGKZ677JlOIz2oE90f1qmKYzrGDQfAQ0a/C44ieE3/sBe76eSpLPwhyGEVinrXet/X8sk2DiZ937bhxPgsEU6m0f6oX750FVqdBkFWhpEtXYtdf+e3l7h9G5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+pXoVrB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+pXoVrB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268CA1F000FF;
	Mon, 14 Sep 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789386918;
	bh=nZfA2xieEUIJBM7jxEmReWHO6XeJGm+rvXsQz6l0PLY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c+pXoVrBe1scPfMAU7rXW9YdPlCrC59UcQm5t4P9EWPe+fwSlG0vOBTXkG8xEIMgy
	 0K1YNBsXvzApFdPqTbNyMN61fiFJ1VKg5EZ/5NwDsTQJ74iPqR8u/akB2AqQO/lJsd
	 PmwDx3t+OaitWs37i/8SGc/xmcFFXeB4F4/ixDN88eoBorclTkMTqbgVgLuU1vxRFx
	 u+c+9KEMBMtbwlJfVzICmXNALChUu3EyCyI0SOfIeBzqvSVC6yOfJ6arbCLK9e6EBH
	 /gzmgSCD0hQcohkrGMNK+05fEIrBgOYxZs9zX1RRJseDR7fCxWcNJn+MCGvmmGC2oX
	 uavDoya7cBpJg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:38 +0200
Subject: [PATCH v2 10/20] dt-bindings: clock: stericsson,u8500-clks: Allow
 power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-10-9d0c17e1f816@kernel.org>
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

Allow the DB8500 clock controller node to reference its power domain.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
index 4ebfa5a8d524..75e5e1107ebb 100644
--- a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
+++ b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
@@ -34,6 +34,9 @@ properties:
       - description: PRCC 5 register area
       - description: PRCC 6 register area
 
+  power-domains:
+    maxItems: 1
+
   prcmu-clock:
     description: A subnode with one clock cell for PRCMU (power, reset, control
       management unit) clocks. The cell indicates which PRCMU clock in the

-- 
2.55.0

