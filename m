Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288901;
	b=EKFvViafxmve7Xvdm8mC2EbM2nk8j4uV3igv+e/ihWYXDsUyBwpO0liHsE6Lst9qztg0
	 810cQF/VJ1nm0UKSN4xByN9KtyK5WhmLtkuhP69tL4iUpUWpiSnhKCXIfBTQ8H5KcHgC3
	 p6X1in+sxQVPsyYUVdqoFK8Tdu3H3+7qBnFzBOxbcdME5RH3cSSKSej5995gtAdbgvF4g
	 QWNgtZoWffXbjcrE8mcIWaCvJr78pD3nmXazMUQh0bu8IvNRCMCK0DEFgbGkXr2KwvFLI
	 4upb6cKsFob70mFRMpmnycvenKjAEM10jh2Y6lU5a+fA7j7MNfGiYmgevlpz+ZKTD0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288901;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	b=4sHmgi4zX282t0leJkQTyJM0C7GtFO/7z4CsQAnBbjSdTa+W5iDe+QMf4HdT1P/VCad3
	 DRA9ihgzzsGRJGDo+GOZK4rOQl92fsuS9sJgrXjvU8DG7rESmwFMz7Evjd97gPOXGvaC5
	 CvJR1ajofCS/cOrnBPPQGTpSBf0417dvczZzPSMBklg+FSyHDouU6Yz8H4k3uaEoLBOxQ
	 Isj4I3Mg6yapvkVv8W7qy/3DTJhntFI5kOwQUNrMbxhDYBcSZSbvA+S5U7OFkfRkqb7VF
	 tpf2jVdtFxB8wtykYEUO/59R01YfB2AzaBGuhr9sGiB+pluyJcqtR65QtsAIqF8gqfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9T0n7IL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B142606A33F;
	Sat, 21 Nov 2026 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9T0n7IL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288901;
	b=DFpZFEvP5W0VCOAIJ3jvoB8PE0qjY550ztIkeX4pY8CONifm2QA87PnCl/G2ToEkFMS3
	 xEeQyAicIxtY+kzPHF4n6+lGjaQBvJ9MkSFoij6HQTzpwpdCFdzgzoUeUKnKcPcTaa71w
	 Uybm/wsfqqqYoJiBOdoClXedaulYvCR45KO2/1d8P+dGvC5K5KmZ6DPtpruJIUB7R1R4c
	 ybsdwwVlP2G1KaVjFmPB+qnvxEvJdEBX6vwmHGA7LMVZSkM9Q5YNP7YW2HEGtLePeh9NN
	 tLRyo5nItq4E8usSEyTdqY8FlgUULyMAATiC4KhLsRDlnwPH+WPm1lfaopWHZjQUSrg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	b=Z1PkIG7/S3egqNJqNzzmFMirqr4c+JDiMmnTvIr8xWQHme2j2gc2Z4y/SsYxJHIsHhRd
	 qB7B8NBWkQLMgGVB4/baYkEA4NcwkexIE/8XRe/s5V9RYDVsyE1JgN6PxOGN4AI5wFcN2
	 562shxQh0ttmqWtrSujFDmx5n/maNwGPRAwMu97VksAJsKHYt4NJBtNGvyldOmRaQ681n
	 htnQg+UxSG1gkA64JK31bPP7LCuSON0le/0KIQeXrXORdpB4WNtZAhNz7RtsoCgOjGMR4
	 Au74AJUyMyju0y3vltye8KGJRWiQUM3Sh1UXenWl5d2+pzNbrl99WrOgaahYvEdjzww==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4B7FB1F000D1;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288900;
	bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=L9T0n7ILVUT6EB2yM3CMfU+Kk1IwrRsFvRZi4hZLGyz8tHeP7Ji6i5FTy4FxvbbjZ
	 b86KftNO2v4Pt3kwKF2zLWjfNgC+tuoVemiHIKNN2Y5mzFzfHKN+RZPgcqJuN5E9bH
	 89EEd0y4RZWWjGZBbWP0RFojy1u3BCRfydbzRYbbENf+a3EnKZJEDI45kCu+lcB0pW
	 EYpWN/6XplC2Ln2ARZNXsGT7aSc3hyFvSThafUvIJCKP6enW671vu/+U+77wd+xWA1
	 p+71ibPtuIMGny8xlwlD/4HnsO2xVciQZ4g86t/sidC3rPHCuS7/OYRCRNBz6mVDdJ
	 NqO+bWwJLXXBA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C9A434BD6E;
	Sat, 21 Nov 2026 19:21:38 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:05 +0100
Subject: [PATCH v3 03/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-3-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=GJIY+ibCECHLmuzGiUiB/LupTZ5nNvm+rMxqh5qXGxg=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje80d/FtEYmd5rJNivWZyumRCmVnul90/8j68ZPEyW
 74pweRKRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCRe2GMDLulD2opPdQ8W3n6
 icL0f7aW82M/6y3ZWLhRLqhHN7X/tQLDf9/NlyY8bXExslhWGX36I7fq3CMRDvn1jZJLtZyfWtt
 kMgEA
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


