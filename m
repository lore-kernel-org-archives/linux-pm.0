Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198604;
	b=40AjTbNuPrDTNxONEqFy9TwqjCbakFImeXV7+6y9tqbOfT/TbsfGODTYaBKXljUzu8B0
	 puR1GL5IG5tDh/PAaTWqmQhoLvCNo/IJ2DO2tiS+RvqCvpoZDqPUWDRvIMI73taVVds/s
	 /ffbvBA0Skw9szbElxQrqrHIw/O4UUK7Bvk8tv/sKCLzbiyI7Dv4z/bepX4cnMViij31I
	 /0mj9AgpHr2qr+auZVQBin82mB8CRx+fFr92VsZSV9OK7iJ+CmLV5uIk+N8+bzWboSzz+
	 qdk53PKMPa/8c1kdU/FxgmgPU92nG/a2/P7oCbsDp5szaq7+xJ/zyTo2PzJxZTmZeuw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198604;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=T1yHxfAyxwkr5xwGwJW9iCMO+4k/FvesyzqpK4Zl0wiTJq6mA1KOAdOW9xfmI71j+T+J
	 EWhDgpbr5zu1gk3Hu76mNnO3tEG9EJvjozXyNqxoewc4cjKyaWywZlw7pkg9ohBeAtzCg
	 RNGl3kflATcbNLTyjgJEYGh5w6RqBwJY1CQ9hf7COatJ8t1irUCeaJ48G9iGHd96L+54D
	 p5aZdum/3DqKYMGImH8v20X1ge8g3YrmPgeKicy9YxiW2OkPQY9Id9aOkiKQsZrBs/CnK
	 cbSR2Uj6FGBXaQH/XNVvKF2dkD8OhTjXB66NYKknhCeNg0L6Hf+oaRHQtGu65G9yiqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6WCBBoa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D62D606B21D;
	Fri, 20 Nov 2026 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6WCBBoa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198603;
	b=YsewN1oc9NJj88r+yrxzo9lBxy43+Ike3gZLAkXgcB3Hq4I5/sY+J1jA33sDza+p01L3
	 /b2WYV1llfQzFAp1K4pGDuOfzgDF8tdvN8Z9ZBijbzOolzH5ib4jj+57m/Q2VrfDG6/u6
	 BuuXwz+zufd0LD/p5QplHKzWR+DlTwYqmeQO3SAawcA1Xei8q5VMH0X6lbvYLIAVJEHrt
	 5etG54RLl09BVT4UotsE8ek7CXcxxlXC+lj8U4n1FeDw5w3RIwpEuAK0JowWmHz4ByhQc
	 GRXX/OC4bYGNJ+BPO+U5FbOoToBdWXBcPo9d5fiT7BLX+z0OZHFag400R+ofwgNJyuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198603;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=MkSJczvOKZ43svAg9jpMJzTOnZsq6DlrBC3GkOBWZJZs6kPvB0nRWcFElwC5c79PnLr6
	 nXBSeYClasHaY7JHxlZE77I6RCc9rk6hIBQv0wyW99CsclSkoP4BMpx1U88LJd4FBQoLT
	 3wujODchD4J/+o4XghnvY5c/TXyeChc8DTc7W2et7i0Wkjnds/K4iFBVrKCNA5kU0f06M
	 nMS2QL9UAg4jjipkRJ6clpItvAiarLP0SIjjkbzV93ilvMvKhzvd60Bqa0j6nO5POdIwE
	 86GpmppgFvi38bjmy8Z/aYoKrrcSX2JbMwrKzOhiHrPEFLidYjevhJhNIq+1tqf3EVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 150321F000D1;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198603;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=P6WCBBoaODogK1oiOfyknN0KQhTPIYA3HkXqA28oi7PE2MimBoPK0Jga13YHTS4Am
	 UUXWSbsUWQkUeOuxK4r4lQVHTQ/tPJE5BTQcAhjixtGzSyVhZEhhRDLLQKGyyarqri
	 reYeyZ9Bekv8lOgw0RQbcs+8Ji2D5BBgp53LqTHvkZEu8tuRoU2scXFo62RGK7/ZuK
	 ZPXgVDJJQKyNBIPe9Va1OTfk/wFMFAqeOwiuC4e40vxhIqRFceyD3QpgL17mr9/xoM
	 D3V/vl31VYH6LaY+vt0KuP8AJZej+mkrcSQolPoSML/6vjnsmuRU9wiorYEQ1iKG0a
	 GUuEZUwrmEBQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 966B24B8E9;
	Fri, 20 Nov 2026 18:16:32 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:40 +0100
Subject: [PATCH v2 01/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-1-93d622d9bb07@aliel.fr>
References: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
In-Reply-To: <20261120-meson-drm-create-hdmitx-phy-v2-0-93d622d9bb07@aliel.fr>
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
 b=kA0DAAoWKo0VA3vnMSIByyZiAGsAjl2gc+A73nw8nDiss0yhR7CCqM5seJvXwnFgTmkdi9zrG
 Ih1BAAWCgAdFiEEj505yO7Txcz1vCdkKo0VA3vnMSIFAmsAjl0ACgkQKo0VA3vnMSIbmgEA419l
 Bi3BwNS582iiCOSxaCIK1FyUDQq43Mu3N1MNqMwBAKyL4iW/6R2TxR5maW4SjF7i00AcnjWDoMk
 1yIbJO0IM
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


