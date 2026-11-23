Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795462686;
	b=VoTAcLaCy2tUfb64m/i7k6VFAhplG16v00sFZNmGDLWNkoJ4xBi1VmI0+B6cm3WRgJ3W
	 oMFjbfsA4FZ7aYCKNvDwis57lmfBj0apj98ZHggfc/eLPusUlQapozIKws1RTACpbmB/B
	 dxzToabhJ6/ggoKEgZjQUQPiYZn5TcBXlozSCqpwZTU0Yo5anfQokRjmXlMbmxepYPOdT
	 iFp/oKPxqqwRshUVUSPhT2haxAJPtlVBkQGSHZ0/Zh8T5MG98wE3OB281vVTgbILUV9jH
	 1+fzbjyb9Ty8dTW1aGumngy2eAY74rLYs8yeW3bg/XJGyBs6b7MZO9Bc8Ytjk2up+uQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795462686;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=Lpd9yyApYC4fiFOZr3BF6f86J+yX6TGMd+IHx/IATJpeCZKvxA/24PV3ToEKmGgHCAN1
	 pGE8Sx5tpyWNN6dEcUmTUy+Byf6Q7X0dv+UcdSiVczlWeQNHSb00+f/dpSi9RlnrAYOMI
	 2LUzim2ZT/0ONFBNBnHvNt/2+MlYl7L2ygBgNZ2T7mynMRMEv/0n6yvR73rCIVsnFqyXo
	 DOSQh0Fq+cSN+S80YnWkfDQtnwbD+lobycaLa0hlwGX/geH6rcPgTPUEEb1OxNKaPPVUd
	 kBo4AjY9vvaK7XwfiYyrgjXvmaVmRWO3n5V/wKReNAIZxRKmvkNpv8/nSQODgQMQIWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvOF7v5K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035E606A31F;
	Mon, 23 Nov 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nvOF7v5K
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795462685;
	b=pibZ8y0oohBd1zCUOTTNwmdWyOVIaoimFh0swhKFmr5i/gpMI+dlO7DwGb68ylkbAwvS
	 ckPFZLBQPK4rrfzTk3XxaFDhW109koA3bDq0mapGFCEEYw0L09C0ENsDHWcz8DBeAxCcr
	 +lGeg3m4OzvkWrNBl8br/5S7hCe+5kaEStEv1+PPxvapgRpshq92webPaFCl3UaC0gU6v
	 u+qzGL4yXAtwf3hLpqUo8IMmCaPso4lIoCrA+TyFqnCRlylpfAtoMHLoY2sHuCrbSd7/Y
	 yJ1/lCr81E14AT+vKWrd1n8QB0ohFEFNH3dHmmgML25DRdMUR9D4dqWMpYRDaDF+7zQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462685;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	b=drNHsZDMYMKb8eGuPVh+b73Bwhrh9TUE2WHj1fhj0Ht3uazGilSZDodRjVPxXjUDKAbB
	 c7qdskHAlotSkxC/OiJMHIcHg/bGFeoadwMyeNFYpuRX54RVYd2WS8vpwsX1ivOzHmhHz
	 pFPiTUsYWfurCmGkK5/fX0Of0jHf4su4qTi6Z0RiLXpNykzb4pgzDQC/XsIDypNXOBNPv
	 lRI/KNpGt+u4mGaT/CdSL++hPZXgVVDt3XXdjur0h4QCN22mmQP1AOP5RgNZfqTGm6gyr
	 pu71H/2Kloj0KmEnHTkogas2w3xxZane7B7BMCUbMz1ebUOAp+u5B2iO98nnpdaWSKg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5F3211F000E0;
	Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795462685;
	bh=xA1P8zsvk6kqc3xIgg8qAOvV3prxwK2TGoWpI0Dqwlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nvOF7v5K28Nk6gDFlP1vOrDKmKUNi+/tPywjRqPht8gol+7sOAguD1ARWZYRaEfLc
	 eHO4Zd6FzA/yl1dBIxpD0NRoMSDVKWtMt7IQjrVr1AbfSovmYcVHswzd+nHwLRk4rN
	 6sXChLPmN8SYBeGBQVc52Aksf2aiHW8eg7Nlx3wMgjlEnen69Ekgy5Wu0BJiK/d0S/
	 z743k7HZfdsHdHKK0nC9em0pt5xMIap6apjDHns2kpyFetbRq9wUNSOrFP6AcfRaWh
	 SEAeB0yec/ZtHR84oknA8ElWGN/y6Qe1e4RMXLe/7zn+ZIB5XKcoQQf+0QZLN5/LVF
	 j68znT2FC8bUg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D60E14C691;
	Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:34 +0100
Subject: [PATCH v4 02/11] dt-bindings: phy: amlogic: document the Amlogic
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
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-2-3fb94f5534ca@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OW3BQ47jww+fAV5FJlCwW3Kume/yYrBTmUUehPnw4ZU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNI7KCe1XNXqWXzV+0yNy7H7pgpC6/xOcpuYckKia2
 DC9teRPRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjAR4eeMDAsPqXUnewa+V5ZT
 lD/UfrH0Yd3Jp7sCzi1ibzn095Djch9Ghvlt+eG7ZXy03Kyl+llYlOvObfKZueWdSswc1Rb9t/M
 bGQE=
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


