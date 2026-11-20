Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198608;
	b=WbVUqNtAB9DA9vjNYGepvUpyKvVqsu1WV5gM+KaQy/nR/9uf9M/VFC0xdqmRmmhIB7b2
	 Rkuw7x3wnOBcrqpTSaa/jiI/YUWOr6aH0bFc0JM57DvNZD98IcXQnAQ5AK80QZCLbBNGq
	 zj7rpVTuaYeNROeHXEl6TfWK9OxYXijhcoKlfEtlZ8IkV+PS1KRxT/5I/X4JJfw7UyF+n
	 P+jjTH2MAHd8p3bMEWCD93s4cJfUHuFKVcihRax0YCaoPnHKNRouT/yOEzesaH2oqGxkW
	 0drJ1tnS48KRAY/QAenGWcV3RPUEnCLfladtXxwaSJNC0atEYub9R81vh69/N3c1HdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198608;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=CZfqSckn75LJ0SGA1smydyOmCgQVdr2i52axj9Qx1zSXwSlfVEIk/TDKAPY2EKjCtnxX
	 Z0XYW9xbyYU+xiICApUrsdqn3POYMvav4ilpSyi88CFUK/yao+/zhRb8juZqgyQx6G/GI
	 3zaqz0CbpMRnd83VV9+VcqQLvATQp5dJJJZpHXlTfPcz0vL8WUAPW/wUEIdBIYQ/AtQr2
	 iaUH9rRbVMdhI9Fr7FY9h+WnB/gPMug7o1UvCD6H+dsykNw53sno8rKMFFJJ3hHetkww9
	 z8g1VsRyN6IY43VrOjUy4oo10G7FuiWfucbN9GpXHzrKqenukMy/IuYAjLmjLF00pDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTufJzgl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91560606B47F;
	Fri, 20 Nov 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTufJzgl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198608;
	b=iWwJqhjQjp5NydgGqJF/PbGm40olefTzkmuskjipDsvkHuQ+wNiAnfZZ4f2mScQm0C5d
	 G2pH7dTX40MGdQsJK6PIKkwuDjw3Z4j8c/7hXqOD/Ssvm61iRiCR7DPBTOoEuwaj4RcCj
	 YI7+ZCwdD+2GfMPy9Bmhks6OKOHJBgjIVLqZo6a7m3U9sQFr0GbgLtUODT705rcLLatze
	 IiB+G/zb35KkDDbjxreuVMiZe0Hjm/aVpi2rl/NYRdMYoC4zh1muZ/YfcWkygfSFEAno+
	 XorqfX+zFFrJLyLjtAx7uMKo2qKDotupyDzQ4GsMdXbqTV/wXQ1SsLpT92YaVV2jZhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198608;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=HFL/l5pieOrf1BOfXjEriodRWNlD64crQk5YpOk4ymJWRTM/7ZGjBbJwxcjdCsqcwU4s
	 JVwBSQiXq7A7MuwOaVs/is7J52YB9yz1W4flrAPLrzFp69cPcF1WxSIPYnOyLfHeRwbxi
	 oZWTn9hRU/sjc1WIUYOleEJjyXMeykRq/5daeemhjY59mABlW8Il744dk07B6ahuZoP1n
	 1apm4NfxghzBJ58HaS2qXS3fvvXJUmaULE1nunZ+4k3U4nmPXddxfGqkgvk+VApYWjYQx
	 61xpbsQN5MvZPohJV2LAv0NL3KwBnMqTcaozlba6EnZkd9SdMJ9EujgM1SWmWLEWKwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2FC4F1F000C0;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198608;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DTufJzglOCGU5ZIb87V0R/m62EngJrTAvtzZNvSyOyfjXAGnGbuHI6RLUXzEZMcaP
	 zoQayc4vDaY1ANTrhR0Ev5bw+rpmX/on6Lsu9ZV6Ay6DGP5m02xnYO6S2PPIeveC8l
	 0cJd6Y5RRqXjEt++9UxGgeKvA4uSHZnUGUXFuSoDgbt+kToUcpyTK+90BWfLrSYhGe
	 z6DwTLT8uqq5mLyd3MwZ03xVQfDwS5R2TMTvELolJ7FnWqhXkJqo+wuzrYhz+yO16P
	 O91513IqYPCv2pcpHVChwACqZ1MQJIPB5e053eGBoT5zLX0LgdQR7PbWeSv/zUIM3C
	 RSzOMqPvIDnJw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B15BB4B8E5;
	Fri, 20 Nov 2026 18:16:32 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:41 +0100
Subject: [PATCH v2 02/11] dt-bindings: phy: amlogic: Add Meson HDMI TX PHY
 binding
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-2-93d622d9bb07@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OW3BQ47jww+fAV5FJlCwW3Kume/yYrBTmUUehPnw4ZU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX1KtgONipUN/nlswbZVtPuhzgL2f+d/OyCU1/4PyG
 q/b9c/uKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACYydSYjw9qtgi7bC/9q75Bb
 aVP7J3Jnf43X+U9aCwJVvTSttFaq7mBkWGHW8OVvYvLWSX7TNX0iXN6mbj0oUfQwWi/qgmBki/l
 PFgA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add a YAML binding for the HDMI TX PHY found on Amlogic Meson SoCs.
It covers the GXBB, GXL and G12A variants, which are described by
their own compatible strings:

  - amlogic,meson-gxbb-hdmi-tx-phy
  - amlogic,meson-gxl-hdmi-tx-phy
  - amlogic,meson-g12a-hdmi-tx-phy

The PHY is a child of the HHI system controller.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/phy/amlogic,meson-hdmi-tx-phy.yaml    | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml
new file mode 100644
index 000000000000..c5dd1036c375
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-hdmi-tx-phy.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/amlogic,meson-hdmi-tx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic HDMI TX PHY
+
+maintainers:
+  - Ronald Claveau <linux-kernel-dev@aliel.fr>
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-gxbb-hdmi-tx-phy
+      - amlogic,meson-gxl-hdmi-tx-phy
+      - amlogic,meson-g12a-hdmi-tx-phy
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hdmi-phy {
+        compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+        #phy-cells = <0>;
+    };

-- 
2.56.1


