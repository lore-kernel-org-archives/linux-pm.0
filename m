Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288902;
	b=lOhOru/yWPsbnLkkiOpwU2LypxQkLAZjYrvnJ8R+9/y7zFgcLNUEypVlZIe6pAqm4fhN
	 nTglPpRb+eXwsRnGcB8ZB+rxRWw1f0lMwMEkb+X6Fe4n4EcIawFJcyRHHZIFtpCFviebx
	 MZ16POPqKZqm8fiWLT47pAP4SIYVjRyZWyBRX4oTNgwLTh22k7SirLpf9BlYbU1NeB3lv
	 hsZwj0dIQey8Mmo/L1ah6NGTnZ1S7iZ4nZrvzTo0W5sCADznJudyM65KR4QE+hr+JPjCr
	 OcviwL9yKh0CqocWlzC2knHwCtOQF6E9IK4lRT5dVVuz2RD7h8d6RYQMgdk3H/w/VGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288902;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=fajZPnsquh3pPGVjHz3Qyo73JDr6Nbi63nT2M3oZE6uWac8pgsXp2whqs4yBAflHIKZm
	 Wc77Nu0nHbPdqaqkJnHA5fxN33az0LQrWImW/v8QzTY0TbS95mCbfKLPSrNGuZDrnMQGi
	 DQwYi9rqSOAajiWFlBfVtXHWmAc/psiiQNTNhzGZH+NfP1FLzjt+kRCtIgsvt1XPxpxBM
	 BRvIro3iD84SabQ6K4DBemPdsvThv9DK3NA0wEU5KjEzXLyqu3yOs8V5L6UQgs3UzqDAr
	 8OPjM7cZ4+/FTeSUHAjrd3Hv5Ae+eVb+nKZzhdJWcWPgBSEaFQzSjneSfU+PDm/raWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6Est+G7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43443606A339;
	Sat, 21 Nov 2026 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R6Est+G7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288901;
	b=ZREIm8TrY8QNp3yLufCD0O3BKDFXa2GPt/tGhJV9YGlND2iWSdOpLmS58zEI3tOqInAZ
	 9hxvKs7YOtY9XSJa72NxhIl14pKN080uSSOUDuIpZorgU7bdukB4XH8bGIIFXNpu/FrwT
	 BrssSM67LQT5mbgWkS/xJKDQ3VE1x3fBoeA1cjSq8W4VFw5t4Fek4cfxDVcqBj4nTwEHX
	 Eu97oS5HHgXqr2JwsrqhFs/XJWOP6+eMG8iGkMalIVXNApE/Sv/vhxZYi070FUjNo2KCA
	 SPqCtvsNvD6NAdAya5sLbKRElQWYv+VSZx6NHzzpJ62NzQRUWB1fQkcI5Ng6o/jqHzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288901;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=otuIG7GpyTA6fpbDEOF5ItzFN+f6UoT+OINaGPjUNUMkyQiUNxK4DfS/sHiua3uP5L4f
	 US0BIzV7N5b20dR9XOaw2Rgq98Vnog0RCrBD56WA43QyjLlt+Xkr97wr3xLpeKVmUTfqm
	 DfaskD75Xn/pXi8yWtOwu7GybOV6sB1F1heKQFjE3ApK5z3s9M4Lvm6lEq0pkEJB2PXtb
	 7T+tm1kXO4XvmQGHgRdi6EQegWyNdQZdz5b1lfZ9enoUNfFJ6bETPc6Z2Spf8nD7ux1bj
	 VLIAT6gC4fvu7xgvIOrSdF4Dj0iPSschu8vIi23ctKp6Rcr8Nywy57sB3tXSmy+r6JQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2C0AA1F000CF;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288901;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=R6Est+G7KrDFhHSM55VugifMP4VJU7JDcWgBusuOABODnLfACrNOQgAsowVDwr+BK
	 Qh+M3HjvvIhWGf5Vr6oIHfudvez7FdaAeV6wII2K6YjXuux4T524VhfC58oLm0fuBU
	 f0aOjVtEiERhfMS57t48Wny0Fy+6GjtZkyACiwvAUMe1oEIG4dGOvM/IaFGqpGT9lq
	 Z8+YWgs2x9ZtjKTXVTHTof8yXCgyaF/sOQPVmYCo+cTDPhZDjaDRajDgUG4CTp8WXS
	 WbV4WEj8zL4AEQTuvjIqcMrS27YRJwCnCHN4pbw0D9EQ8G2Pr5m2nEP7Xikx46lEwK
	 SiFIA11WbzrxQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A95E94BD6A;
	Sat, 21 Nov 2026 19:21:38 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:04 +0100
Subject: [PATCH v3 02/11] dt-bindings: phy: amlogic: Add Meson HDMI TX PHY
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-2-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OW3BQ47jww+fAV5FJlCwW3Kume/yYrBTmUUehPnw4ZU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje/X29e8uTX3MzW+8eiFz+8wXorFcO0X0v6tO/150Y
 vtGvhtbO0pZGMS4GGTFFFn651qeeHf56Jmve9RTYOawMoEMYeDiFICJLFjPyHDiYPPvrEmXyyM4
 jTf9j9rt8ivOvcVxUxxPwur6X11nX6QwMqysm5PxS8zQf0bO9syMmvOXys/+8tazu8kgPXNZSBF
 TBxcA
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


