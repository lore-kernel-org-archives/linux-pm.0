Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793321;
	b=E2eCCdnpRHt/cty2Asl5KjWC8+QnNPoy40etMgBPDIeyDCwczJ9KqJ6ecsKsdiMBZujs
	 efmCw82YqXgK8ubrYkzSzIw6QRuNAmRInxpX8YY9bLBis9rVFMlJTyTZJLXEW0LCRIPFj
	 o5HSNd6KpPVGIs1ZbHRRTJA2Hbam5AeUOgdMIeDX1dixM1W1DgBVC6UAueasMHhcHO4Eo
	 zIS1L8EKO8TCk94S8qfLMClUD8mE3oHq2WCxwWy4fcHPgrBEgQTUDZNlaNdWUihTPC5Uf
	 HuByxvROzdlogyN+ew1De9nv1Rl6r6sG0ZTR+YuV40X521bAqF6SodQMPH0Wim7RE1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793321;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=E59qbdfKKm1BTHGZzmdq8KmOew8ooUoL4kUFO1pt36ggkIXXy/x1dhZ99t0bw0c1iBjl
	 emHdwJxAvh9YlBdOlLlMw4Po/kJhaUMSDAHriY1HzPluIuZKD53CotL1SHr4l0jAmEKEV
	 QIz+y8DkR2CmYuuY57OhOg4pFEmBUto/PcRPUDKV0O0Rm5keeN+c2vDFjyApysOxEdDIi
	 prXf+kWH+aSeZJXxjVbaSltLdjojckHQ2VU+oPJUPCVJC98YwcKOq6kurDbupwKt7hJH1
	 IPKpAwlL+/UcCQdWCZNrrdkIR6G88Yc5khimyDWwcoeGTkz8nfSvKLh3GbU0JazRUSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QivLnBNh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C518606A33E;
	Fri, 27 Nov 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QivLnBNh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793320;
	b=x1u+HvkTRV7pQCn30ijeNDVOFwx/s2Ab8mjhU4cgpS/XX3mcdbLeBWY4n0EnRp4sECa7
	 4Xq2vQKSkysgOy4AcRRBldFLv6F+q7ZFKucj4FtI05UpOycjpEirGCQLN22ncjQ5XKjc5
	 dR7CMG0kSo+GILH+KsMsk/htqWbh8RZ/XUw1wFMmCpe9PS1R6qIFR2opv2z8WzfuJa/zd
	 gTkLIlA1bgN78i2lI+xf4XZgpTXX23CisAiITgslkBrQNJDM9a85pzoli2MO+pKgnsePV
	 tOKUSai+PlIki5uyqgdxx8Ymwskl5a+OFiCfcvKh+U1GvMOZ7WcmYt9F2csq+OjHFSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793320;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=Teq/g81JdKHqlRG6dl2lojZZPLoWLayewrt7cmb9f5U14Xyx9uekxcth/FQ7cCIFvGsg
	 +pIgvExQjuX//zNbujQ/EHqCsEbn+RES73Lh9PD/3YyplqSgtSjEBadL/MXQhKom+XXA2
	 Q8vQQF0ZcSF77AlJGzTW97t8ffwMkayAJz2XOw3F+yLpPaJ9IudQzJBtz1ZrvjJhR3svM
	 P+P9jVt8jeuvavbzNszWT1q8hYrnmMh7eqNxoix2IkCeRiJ4RCuyoYvlHUqswiPbweYIZ
	 vlCQEKMMPvYvrGjUt3QisKGV/W5KrsByPMx/h9/VYdBBPZsSuekvYA6ljYkZMzNsHnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 82DDE1F00925;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793320;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QivLnBNhiMzxXUOjG6eFswtuFOujFnSgfQkFwxVt9a6PQLKzQmQ9SXceWkuUoLw0w
	 oPyaMwjPHHcUpfgTC+cQJXpbDIeDRwFDZWXAk9X7xP4FLAU0LsRboBSCyhRIX++JCh
	 Ynj7QqHubMlu2YG2E3dCvTGUAt6RTmMdcBngL5uf8DVDVPyengY1k/mkbjPTjaBvBw
	 gbKwnfa3cIv9DJfI4oDAz+Okpt3HvoCa6BpSH25wSdYHXBoWXvFKwMeBvJu32zc0zx
	 XRzScMqzKTk/1VNPQc9sZHEGlaHLIyfFkLwFWzsrra2TOjk1TKUkg08j/r0c8w6vsF
	 58gSQuCH7OYZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B4164DC74;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:03 +0100
Subject: [PATCH v5 02/12] dt-bindings: phy: amlogic: document the Amlogic
 Meson HDMI TX PHY
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-2-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
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
 b=kA0DAAoWKo0VA3vnMSIByyZiAGsJoYqgdP4ixlMGt68w/7JHX+T6LwogY1XiH3s65K6JsY/GI
 oh1BAAWCgAdFiEEj505yO7Txcz1vCdkKo0VA3vnMSIFAmsJoYoACgkQKo0VA3vnMSIokQEA4ji/
 hyimu+igPEf+nD7CqtTuNAQP7T9dmBXw+lLANQsBAP7RkKIZXfk9Di//hBJ0iiNTSCITYiAFo4k
 LME2uoQAI
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


