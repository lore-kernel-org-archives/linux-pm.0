Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462692;
	b=DD6J/2KJy0wqyXUaxe2gm5l+XJ7D0moLXoLOUSD+NiRF3V0uXEsDlsArIc2miVlugWyo
	 4ia8GPG99mHAOtXN/8uZWur4F2R40NWazHr5eX7U+tUv1VgIUQvbjZAlLb9nq4RhJ3gHm
	 mY7Zy7ObY8rSVzM61Y7o40JWrfEG8ahnBUlTO6XvPr502GLTQeVZU3r+GF64gKbN3fW2Y
	 ty01UQRP6+rveL1E+hgvTZvFfDUG1bVStwCPV/WOOkHiDGmTP6bMjaddBFVD7lGJ//HT6
	 Q+m32/aCExlEeM1SK6Wqkg026p8WlE/qgUpcr10ieghq5qKimUkC8TPy7/zy8GNFhnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462692;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	b=kbzP6d6JETJroNgZRPDZNpkiWLa69hihQlFJyFAFjHR9DBkHm4Zub6YcrzzteVLDGJtl
	 dGoBaVMyPJYbDah2ZEvJDQP4EKvXGIXk2p/oTJ9y3n3nFjdx9MVXrIHgTn/g03acE3FYQ
	 z0dPzYgFOCRkNFXEKo3NCJ2qzcplcQMHf3ZlQd98mQrIExBob1asahds0eQOizAFRIX+p
	 BCUNXGHU742sDJ7tEC5VEx6ipLtlEVQ0u/GwyPaZyju2SVF6rcGIS0l4YpppOl8hvI1MN
	 EKAwsP3GHQ64NoUlc2HFViwTyL+uzpgpejD9YxTJfOd030cZ0fJzP2uX3ypUn7i1bDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTr6omkI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB7606A685;
	Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTr6omkI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462690;
	b=3WON6jWbveOba1sR71S9i+MmHPHiA782rYlFQ372TIxD7NjOuTtKpNKfbCTQBjYX25Rd
	 BKfDw9pesFoxhDocMGuxyYphS0EodvRQYKqzMTIGZS2boEOBZdHs7sXebtdz9RSXEyjR6
	 JYbESV5FbVoZFALKx8s4nvzkwM1NGGz88RM0lPSZy7Fwqw2bftlrOhFhGR2EAOsJ5/lEV
	 7xdPJ3jkoMjv/QGmw8WN6FoJ77pu2l/lPuvHttd+yMZV0WdW5PGCuRy5IzAjqioK94O+I
	 L5DCJm/D4UyiHiVLTaP4La99wckwmFTZNlv7fw9YiTAD4ccA+vsdza1t5NomncfKreA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462690;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	b=wev9q6RTNjXoWCmw2ZfYUoPH7bnhN511BUnV4ZxdkQNYi9iMUSVX4eAsi9kY+fLxM12G
	 DBRiO/pTjyRHfkqFz7OY2Z/oFR8B194MO6UFYVSZDlownVcUHHnOCymAwRSGwy614zA41
	 uVEIbVb1tsYF71LGTGe1Oyh2iARhYmspWeWz7jCOp8Vrg0drwX8R7GdHpAag3ZaspDUU5
	 z17Gf52RsWFFoD5IKkOukPOnQiXPgb4MVfCLtKEXGkIAjdW8TFmWEwnIem0kf4rGu0ZcQ
	 B/gnDnkeFzHtUsS84YwwTsunUJ2aSFF3Odl7SGlwrfDAQu9gGosQ0PTB9r5otoOMDvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 766A21F0089E;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462690;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lTr6omkIeZZzCAyoLNTsOJkt0oPHEV+71NBV2O0Ubt7f7rme8RQWEStUbHn1GhlER
	 ZQiK6Ck1uOTFVeXBvMPxK3YEh5eRBOKsAGrmDNFYo6YKtZejWxiaAuHH0HatQ8VsVK
	 RkBxySLabDLVMIH67ERJD0F5n6q7otO1L8eL1sD6n6ZOWKVbeKJovKONMMRFE/JDxm
	 XdGjNt+BUdGwyxySu719kFb9AYecTxAbjVautwX3QWQ6FK7z8diMZPuWs8ilFKymoK
	 8ymAn91xPrVcoyPKaBlNxUN/JRxKmOw+8oiZY240iA25MugnLRNX0JitAeBDDuIzfD
	 kMWJtk8mR70Rg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F40EE4C695;
	Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:35 +0100
Subject: [PATCH v4 03/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Add hdmi-phy child node
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-3-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=GJIY+ibCECHLmuzGiUiB/LupTZ5nNvm+rMxqh5qXGxg=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNK6/ITdMEzl4Vtf6yXxZpW4ryJ7ecebS0RO3Ngfr9
 fHu953ZUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEzEsZXhf2mIisZd1Y91C36U
 rHrtx9SY1SPgkK9+NZO7wNxadJ6+AsM/u4OR0Qc3N73hDlLmTDZv+VVXLsgZrXPxoSbblL4vq0v
 ZAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY found on Amlogic Meson SoCs is a child of the HHI
system controller.

Add an optional "hdmi-phy" child node referencing the
amlogic,meson-hdmi-tx-phy binding, and add it to the example.

The node is forbidden for the other system controller variants.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index 285edac4c082..97e47592aff2 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -36,6 +36,9 @@ properties:
   phy:
     type: object
 
+  hdmi-phy:
+    $ref: /schemas/phy/amlogic,meson-hdmi-tx-phy.yaml
+
 allOf:
   - if:
       properties:
@@ -50,6 +53,7 @@ allOf:
 
         pinctrl: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -80,6 +84,7 @@ allOf:
 
         power-controller: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -104,6 +109,7 @@ allOf:
           oneOf:
             - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
             - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+        hdmi-phy: false
 
 required:
   - compatible
@@ -155,6 +161,11 @@ examples:
                 clocks = <&clk_vpu>, <&clk_vapb>;
                 clock-names = "vpu", "vapb";
             };
+
+            hdmi-phy {
+                compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+                #phy-cells = <0>;
+            };
         };
     };
 

-- 
2.56.1


