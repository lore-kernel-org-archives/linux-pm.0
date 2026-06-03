Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7334E771;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509967; cv=none; b=bBNpl6r2BaWBEux12gYXOhPDa/YJi1lw57MscnsRgkZsoJwyiPWtfa344Q92wAOMPK5sKk5a6vaVh2wRHs1HOWj2sLIAzfpnVzxw9Tk9XPANVFZN8z/4bkIm2HDFuUn62TMWLX4/sheYvlSttwbvunn8Sl24WugZlXC3KToq34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509967; c=relaxed/simple;
	bh=Jnv894IU9wblCqhm+wVe2Z5FBt6aG6TawzV3npnKdrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LU6cf6uYp5rXZ+B2UH2V5dql4Yt/T7o01CdMxz7PcLwBnkMREKPs4/6PU+6uL6PigOqlh4PscZNJz0R3eS6jZ3pMMI7wfbtkLrxwpw9M9TN2H/F4iXOZMg1Dqi/bDUMABEfSWTyXLSsm9bJYaJHga/ZT8mB/ySzNUL0nV/CR/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omT9t5aV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omT9t5aV"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2858EC2BD00;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780509967;
	bh=Jnv894IU9wblCqhm+wVe2Z5FBt6aG6TawzV3npnKdrc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=omT9t5aV3FqpPk2vE2T1OO4o5VVxq90MDGSB+FbAB71h+gQV+YljZI09Wf/O9updd
	 qWDga0OGZ5AbfnEbTkEr4KNIZmmKvkPti6yEdLpv3AOmAyLny7CHKtzLRsKgoFXn0I
	 T17ovOt7j9TF9CH1YmcTVJG62qdlm0hBdOCGHQGHIxpC43komoDdtCcnNasBN6vTHq
	 mSN1t1WbidRxvL28/g8NTT3lBIunwGNjyXtFmS7nHMNqmklnMSci8xPRH5KZx9XjwZ
	 YoaUVaPrP3rqysJI1PBbkAGRMl4uMQ7+zr3hxseUp0QB6cpoIBQb4iISEWsUFkfVSm
	 PJvaQPbAHVfgw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14643CD6E57;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 03 Jun 2026 20:05:24 +0200
Subject: [PATCH v7 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-add-mcu-fan-khadas-vim4-v7-2-594ba8a965d8@aliel.fr>
References: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
In-Reply-To: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ZCLkvEl4QN1eqKBstn2AWrbNUqn/t24aNXqnl7rPOEb
 nz0fvi9o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiI5naGfzo7Hovd4zTm2nDV
 xWOZnGOfyfH4Nzv+KRk9+Zi/uPdrTjLD/7qrBwNtpbJiP1qLqip8yr11jvHXVeGGv8WLr0nfU9i
 ezgEA
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


