Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288900;
	b=Wzumc+BsBuiJSqm2A6whhfDgv0ljkDRH25QoTIoDEZ7iNOv7/D9MtvFWG3Tiks07KERj
	 DjBeloy4XASb2AJ6pU7v1L4zm9SrWiiTpymhk6oPT2mRlbHloJdpm2c8ORTgC4px/i5eE
	 u0NqdVRztzc9GetMGkgs7P659mzq2nfFOBJCVdfljLu/hygsrkZILlvGq2dDuzehXyRSa
	 zEnispj5PVtpaETavAjvw/XDoUg0wJR1fvElu0nnsrs3g6mEBRScrWTMgPcjs7DatXt0r
	 +C+nX3aJTC0VvKTX61D4Rv1/kLQMou+5jPptAzT8RsSUTxBgBO8hc5sdPRJ8RJse+Uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288900;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=baB7IULtQva7/sOLvjn4Mk+zjtiF0/6f1q4AafPFXtNZPum1T3l8VTGMfDcWk4RjhNOs
	 JX8vn2AcBAnXv7k5M3uHkCzUd/8/mZl9zfGkB2Hl2x8yMfK8cUT6odSyxAkfrn/bcZBXn
	 eeDprJWy1LFDGWYYl7u91FM3X8i5aTBAj8JQY48bVvEN6KOFWsTTEJXMx1BO1VC2Y2jTd
	 W/xAOqfTgwBavmeTm/TfTANbnR0Mv4b7gg1YZzVSuPtyxOxTzcHDBTCJoGs7wq6W05wbL
	 p2ryuH7sMCbt3FpxYlG7YnDKdNC+w1ZDbL/7DI0SUqA0eWWSMLStn06PJlHsZThEd/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu2qiCQM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2731B606A32A;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bu2qiCQM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288899;
	b=hkRQjjwfqaITcKXXTCcNyD3CuZKzrXPr8wJvTIKIjDP3gUTgZs/dD2KyklRY9jasA2XA
	 5BUx8BFcgoCcXrThTvtHGjx9DcC2X4BZSXudVG86SnxqExZslwq94KVT3ymM+oWqP9UhR
	 nKfoO6iNm9seOBQbD8qbuWhp2p2OqMoQ5H3yLCvazHv61qnxbRH2p4dEERKI3hqtfJROe
	 ZYoDruhfR7pACI3p8GB1/JpdPqAoBJJI6ML0G9pWMQpI/W8eJxCQ1ozqJdSJ08OgsPQuI
	 nRIhS2ag0PsCC8mQ+LORNGgh7J3PiA2SHdC6O/5tuBLNZ8q3gUOixyuWGyqV4yXsi7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288899;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	b=x6kbJgYgR2u9/OctG1nPvc0uqD0+ZkUJRcWhQn5Pbn7HwjUQ7+n5wxinLNb1Mpr7kolM
	 rB6ooRK5mnvw5b+YXTPcIXF83wWNW66j7kOBJBluPtvIR0iKi5DLhMf8hSCwPuBtWELg4
	 KC7Win2+Bcsy1FP1iuVMSrC1E/9eW/4vhDIUOkJr5fzwN/F7HXdwyFYHAcriIcf0gjzQY
	 ESUcydJ/p6bfbOLqbt9USTm6OCCgrVj9kPjKWvm+kVU1gjvsK9p/+yd3RarorY7X1OA3a
	 +7c8qMH57Qixu+fyJabY8b+uwd9hdhN1+ZHQqZP5XzXSWXTtmMCSEg8b/num/tlngTQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1A99A1F000C0;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288899;
	bh=NgtfBGZW6JnOX8QXxkHMy03vg6zeloIYXjLXT43yxao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=bu2qiCQMU1osHOpdUN2on0rAgOTnfShprejvu04fJbqGwFJlFzfbj8nPbmXN7Z/Pp
	 jPibZooHoMmF3x3b2mTz6Gzwx1LV6agSRsYJF0e/t7icIhubJ34J6DVBLsT4wwbQRv
	 AUmcKQusTMbQvfKnCl7tqoNK+ETlEGSWf3+UcrOvqB/c0jg6/Wv5tWax0lWZYEldod
	 ZzjXZudB7icOcceTZJMM6fanLfNKo496ki6yfZw2sIQabXaS7P177K3KNAwEGsjrX/
	 TAfH7eDjKlW12WIJi9ulBbzlOKSvosvTwqU8uMBPo1+QF3lX+0ATEvu/TGcQgntHxQ
	 ugVabyE8GSAAw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E5194BD60;
	Sat, 21 Nov 2026 19:21:38 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:03 +0100
Subject: [PATCH v3 01/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-1-f8f471788076@aliel.fr>
References: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
In-Reply-To: <20261121-meson-drm-create-hdmitx-phy-v3-0-f8f471788076@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje1XfldbHf9f21s259Mfgxdld5jw8bXvcZQwXbn9Wr
 FtYe8i8o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZhIKzcjwxTtg+futHWkzJzD
 ePpq54OJN5YubGy58Vv5V+OX56KVLlcZ/sdozeLY5T631v2Zwrbqkk0cV1s65nv+itJRnTu/ffv
 GbH4A
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


