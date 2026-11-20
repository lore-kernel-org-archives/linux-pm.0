Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795198628;
	b=1tQEOz/iIql3wLz7NGN71Gjij+msglRvH8W4lmMQ1iKa36OHAqtvzrAZg4vlzufguIaW
	 jqnYEDcqaUGbnthdU6YpY8Hlzu43KZZ3BJJNUo2cJJTI8X8p4xrvzj1/QHYDimeVHHHCm
	 Ujz5DcZYZpyZ9Pwm0gNlrsfR/QCuKLnZJbhMBZ1KftddWhuOv9A2G6jFfOl7FbF5pJr3Y
	 eVLhYElC/wSlv+ixHYo9gmWMRNict4v0gSweARtk9tF9H0dgzkdF3Jl+M7EVCKzPOqkb4
	 cYHSHcoPaUUfWwUYOfbRucuI5kHDLaPeYEjeXBPF99PNUD2gaXaDUuOQYe0J8SOxiDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198628;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=WHDdEWJcHgw78+TbhWuwormUvTkBWG2h7kB92ZSNqgJ0Qd+K72T/QWwm5eP1O0owxDFW
	 /zVI/Pvm/92LguWHsFvhPSsnIDGSzdyv1Z2dOIhQq6idzjbRDHxKPIXdpdwu8MPISqOao
	 W84B4lxRQybtiLyKT98caq0KhtShXrNoG/Bn3lNAMjxsSxpw9nzgYRY/Ww+txGxKsIxyV
	 LkE5oIz+2lOtS2+4HbbxRzJdGnGRLMQL70KN0KuRhYTtUyeQ8ovVZoLfDdFaNXx9309EJ
	 OXyu3dNGQPqeVXn5KODTYmVRUbW49do9PbbZt721dwdrmW6sBR6uujPiWEdJGFlwM/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOLVLY64;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E57D6076348;
	Fri, 20 Nov 2026 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YOLVLY64
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795198628;
	b=gSJ3k2LR8Cn4jaX2cZQAMy0OrJ6DfNOOw1QxObkS/qkhxNAvaS9tqhW0MDOScoIpvMIF
	 BseZ9qWBBg7yqTUZFT/ZAfKmNqSKq1nKvMd+vA6ItqMfMHpuCE6bntqIel3p6Ra3WWgGJ
	 pehEJ7JXOzlFVFckapTP80WmDCd9TbwwFF2c2mJQUSsUoq3kj4+DH9LqWEoUfxvS7TRkA
	 6vjPc4551/zN+MKirK0l18UbZs1z74mxuVt/4IWfGjyzFIm97iNRoQaT5zRapHdniD//M
	 Qf27qWZkK0c5Y4zdborGuN1kvhB6tuYy/VRoMcMkQ0X0eHK7eyA1/EFlYWmOdrZwAeQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795198628;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=teF+uREmjPghyGaiC8YGB9FXad3xgcN+pDMWtJcLy+d6z3V838BGvjXThYrn69TitG8c
	 tdF+d1Mi0rkmwiZiafGk/+HcBt/u2H4eb2ntrhayJ3X6bjEHqwTJLWCwlq+ejmSNHKfQj
	 vxmFJ6rUIgXZOvyfiwLRpt/n0qyiErNZ6l5OD2q8K72VfYGY+oUS/JSTkK2yaBrSvmYIR
	 7ACgEaY8Qm589XUDOEOJIfin+oLksAs/wdyc4AF+N0eUvanTEVaS+nFEYJZyQ4Lyadh98
	 x3e6x9rzxLdnXC8dkd4J6UD+sQvy2YaCfzf0YV5gLkkFJSn0DjAVH5+K2TRC/e9PvqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB4E91F01566;
	Fri, 20 Nov 2026 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795198628;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YOLVLY6440/N1QBouAqGkpPtN97sQ7MPPWRwFuJE+7T0VQHkCAFH4dhzKzkoQe37B
	 c3hDb1XOft1OOxPrBNq82/603Tr4kI9dDYpxeCdxC+qcWRIKzgyOB2FqngLdTyi3B6
	 cJReh7vheDzQxeXNfCLTIsecinUi74Izwf/PGNBtLYtCvEerfERhbckB2fdxOXvnEY
	 eSC8uxWkaeP+5tiAp0OM1Jw3AL8z9mc/1nEvJc32o79FNvV/h+m3W8PyiNPCCPN9gx
	 hHuVYSN9241PGbopEdatiefCWE5ImcmozdDpdsQWX9E5FbZGPUBR93jmIRDdCDdrcF
	 aMx4Xj1XroHKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6662F4B955;
	Fri, 20 Nov 2026 18:16:33 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 20 Nov 2026 19:15:48 +0100
Subject: [PATCH v2 09/11] arm64: dts: amlogic: Add HDMI TX PHY node for G12
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
Message-Id: <20261120-meson-drm-create-hdmitx-phy-v2-9-93d622d9bb07@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=96ezTxgocDNVGkQVkrXP3m6ZHN0B1G+z/JYBO9mFeTE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzZDX+mZM1Pa9s0tPse8yXtBIc8ih2fxX8ujT5lMndA/Q
 UzvzEfNjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiNosYGb6effLzo9+WinT5
 j0FyohWO/S3tafosc8X7Wnz3BjGkzmL4X1JmskB47r6tSV/jIqqeOilJHORf0701Kvffhu/Loxq
 ruQE=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-g12a-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 3135566df880..7f9eda4298e9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -210,6 +210,7 @@ hdmi_tx: hdmi-tx@0 {
 					 <&clkc CLKID_HTX_PCLK>,
 					 <&clkc CLKID_VPU_INTR>;
 				clock-names = "isfr", "iahb", "venci";
+				phys = <&hdmi_tx_phy>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				#sound-dai-cells = <0>;
@@ -1683,6 +1684,11 @@ mipi_analog_dphy: phy {
 						#phy-cells = <0>;
 						status = "disabled";
 					};
+
+					hdmi_tx_phy: hdmi-phy {
+						compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+						#phy-cells = <0>;
+					};
 				};
 			};
 

-- 
2.56.1


