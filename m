Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE92F7F1B;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951902; cv=none; b=IISxaPI6sO5HhpBDThLMnRAKOE4//mPLgqGwIjY5djzMJDraHmtpTcwFy4MPDe6oegNMP8Xv3BVthOewT2yeGTTSJfBpKleXMEaAoImhSV6zAy1iWam2zUCMm1c8KsV1fqosrR9J6WreTU5t/yuCwbaxaPOJCbMdWKSeJdjckI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951902; c=relaxed/simple;
	bh=Jnv894IU9wblCqhm+wVe2Z5FBt6aG6TawzV3npnKdrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H23srvnEEwNA85UB91FB88j0WtnZqlPsOuaHj4SoE4qpVIDCu0N4rONfFKmlOsRjoY7pvJ8UEUl3P/A2/oWYPHbfl7zL3BN0PnsXUXUPJ2eAb8YiNJVl2cb8va1jxLC7dIRkvnOhzwJbbAOtvQTsF08QE+Do384hNWhIzoxzPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQGY2Gbm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQGY2Gbm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CB78C4AF0C;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951902;
	bh=Jnv894IU9wblCqhm+wVe2Z5FBt6aG6TawzV3npnKdrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RQGY2GbmRbfMXLB+jQ1nJotT8Kk/SRKJzgIcXaP74wd/3Dp1uF+dhb1Z9fc6MlQKK
	 yNVc10a5ZGWy2v2+tw3/f2YtXQSVhfniiokcJJq8u/I9bV6DVg/PMLA54uNOjJDm/C
	 zmolu8wNVGFrTdJb0c1yHPMD0XQoGTCZo3dL6yqwD0+Ke3sAw1RV3kFhE8hRhRoXtN
	 OZdFCBJCAeJzd00H6DZu9TVqtAFJ8rvvJWNvbZswxGlE49ByTBP++v06k2lSdvGCR4
	 PMo0nSSgbX1opJiE++QI38kUmCR4i6e4qbqs4epOfJWJy6qrOnxfdAvlJxggkHONgW
	 WRZ9+OeDxFAXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B564CD4F21;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 16 May 2026 19:17:02 +0200
Subject: [PATCH v6 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-add-mcu-fan-khadas-vim4-v6-2-cccc9b61f465@aliel.fr>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=dSGVBP6Kwid380fHwj/yvIcbmVkBngDKwALA0QzKSyw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQxbHskuPVK5/bflaERHSuDZrodorkz27U+ztuf9OMuFfd
 HVnrjxTRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAnCTORkZ7r1Tkn0+McCe/WPz
 X9e2c+84Pm4L4PFh3jPJQJN51ukKd4b/QQG6nQp/5heeDeL/Lmw5Rzp/D0Nqw6sV/tyKJ6Tn/vF
 lAwA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

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


