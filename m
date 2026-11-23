Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462693;
	b=Cty9ekH7a5rBuIUQ4d0QvlB+2O9pIRiidvGhR+sRg2i+FN7QP60iXCvkdjRHIhjcs48t
	 HOgH4B5Ghn3gAIm1XEX0SKv/5J6NP1ibWePDK/Pce5hzuOhalbRJacwl/KljjNUfvk5Xn
	 gbObBi2HiV5WyeXeYiz1rUcOgdQxrEUP3UEBtvQUNY4nPU9za82wGDUyHZQgyX71sPOA5
	 ZGRww6OhWM/WDpaavLmzHjA9p8GgNohG+UARvcjQWyfM8vnZyT1tx8wswL7EQI7Utlela
	 8NWwapH4slBOMHkDovkfkMRbMoaO4N63V3agVoZaDvFrDaKfES7Tr2/KcYWoHEM3zOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462693;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=wZqD2XbRdxg3wQ0VftyMSdaBJ9dnfzX7JqhmoftuziTecR/2gSeIzQ1sNtnJG7ORxjI7
	 RXtOc1KzOYVl1GugLYCn+25Pkaegazwr5TMYF/Kl/HGYAxIt9cGWmvMfOG7TSMfF0S6Yc
	 NAdYjpAHjKE1X68/1xrdUIiXKGBvKutk9Vz4o3Elzn2G48BwH28+X+TVR4ShxLb3z4GYn
	 67EUdzL6CRGfgal7Wlm7l4P9iU76FsaSoMBPCWLwpVy4T5ylsRhgRoiFqRpZVN6J7naX4
	 PbfsNasPi/gppur3/F3WkTawXcJcNGP224qvNhLtbSmuq+T03+uOhRpe0ihidik3XGw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJAVg+eq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DF606A6A8;
	Mon, 23 Nov 2026 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JJAVg+eq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462693;
	b=n3+/rrp18FUVCHC6Oh8e9F/y7nbL+KpvK22nmNwjVOwGXjmU13CuFVwzo3lxcnYMDgKF
	 ridJ2Rk43iVmS/xBIXoCVktpzgD6u5iyZJGxa1y7hwq4o8W1AbN0cokTY8MSNyTfmJMOv
	 /ur0JDjnUCQ8EtOujglQyuRckjRv3+/A+IHplQ8P2EqGqfL1Ikuf7iElSbCvIVCXu5kw6
	 EJdbH9r9KGE3FZ9WJCzvqwWGfCnqkqmYLXBY+2JgiuuewOjXc9msBLX7P4m/s1msP8RBX
	 peY/NnpjflOZFDX64Bz1FOmBBwY4aetOMrlUfAs4U/UB+E4ltiykH1f61tcnPxQM+FA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462693;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=g5bYXM3emvZ4jKXnzo+SkVg81zeS1YZ5oAtzcw0t4uGtOZBbFK8QfnjmTOZMLk++kbgC
	 C5GK125BhmSZm/24/vWQTwhNWaADScloZilhqbIQkhC0nu6Pbm5svQWDFVxM6Gd9HP4Nv
	 FgXNVpC2ha/dovYZyOkReZlog8aiD+OS1b4LtRJr4VF40wR19cyupvrDQ2/DCxa4PXvbP
	 6DEtRWwrMA0YDX4DLR9q2ld+PWFP9xVwrY87zo7gYIaoa6R8Koml2srO1w3hILXMeNbHe
	 1mRilUOcUsm1ms7rUQuGOaibhO5WdWQH9c5upL8jR2J06THj/S2lD9TG8ERvYzXDSGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F2BF1F000D2;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462693;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=JJAVg+eqK3xuUrAdKlxpECPFojPb9jlpNoroGKqxsoeVGxStdlEW8ocKvJSY1pGNp
	 DXNDY5I7UiNbchqMyyQsa68D9KhnU4oruQRbRsHK51GcRCJhrTDXlGVR1upsN56QWJ
	 76UkY2AYkeaWpp+Tb8V6cPoLR1zTI3oMc+WIF8wgu1WqynFBD55LHnio9U/S7Gq2X0
	 hYjVfT57WvY7s9P8q8PY1Hg6TTquBrL9ma1AoDUizX9OhGelFLF59T/qpNHp4JDKPp
	 PR33mO0YXEcDXok1UeZalnJxg6fsp8J/f6XcfFGTqkLeLdLVzEuD2tQJZofu9VzIm+
	 OJhpct1pLqVUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BA95A4C680;
	Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:33 +0100
Subject: [PATCH v4 01/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Fix compatible matching in conditionals
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-1-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3283;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=PVKFWIK5TVZ+BrIG2D/sPckomoO1CwEMBpgyzjwKon8=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNLYmrzWx6xesXXrHp0OJb+JkngevKnfdfl3Qvjdfq
 mz3Z4nDHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEJnky/OHtWfkk//PzqSd6
 OyeETfyYP/158dq4CnkxkcOCVzsivrIwMiwz7bwht3NXW+43V5HJbY88wr4dW/Dtqpg3+8f1B6u
 OirMAAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The conditional schemas select on "compatible" with a bare enum. On a
list such as:

  compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";

an enum applied to the whole array only matches single-entry lists, so
the if: blocks never match as intended and the per-variant constraints
are not applied reliably.

Wrap the enums in "contains" so that the conditions match on any entry
of the compatible list.

Doing so exposes the "phy" child node of "amlogic,meson-gx-hhi-sysctrl":
it was forbidden (phy: false), but some DT legitimately describe an
"amlogic,g12a-mipi-dphy-analog" PHY node under this system controller,
which resulted in dtbs_check warnings such as:

  system-controller@0 (amlogic,meson-gx-hhi-sysctrl): False schema does
  not allow {'compatible': ['amlogic,g12a-mipi-dphy-analog'],
  '#phy-cells': 0, ...}

Allow the phy child node for amlogic,meson-gx-hhi-sysctrl by referencing
the amlogic,g12a-mipi-dphy-analog binding instead of rejecting it.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml  | 32 +++++++++++++---------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index f3a85c67ce8a..285edac4c082 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -40,8 +40,9 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -53,9 +54,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         clock-controller:
@@ -67,9 +69,10 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-ao-sysctrl
-            - amlogic,meson-axg-ao-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-ao-sysctrl
+              - amlogic,meson-axg-ao-sysctrl
     then:
       properties:
         clock-controller:
@@ -81,17 +84,20 @@ allOf:
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-gx-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-gx-hhi-sysctrl
     then:
       properties:
-        phy: false
+        phy:
+          $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
 
   - if:
       properties:
         compatible:
-          enum:
-            - amlogic,meson-axg-hhi-sysctrl
+          contains:
+            enum:
+              - amlogic,meson-axg-hhi-sysctrl
     then:
       properties:
         phy:

-- 
2.56.1


