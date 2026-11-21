Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288905;
	b=tuukJ+W3PGq1A4I/EDHgDKk4XI+FEUMmufsASgIXDU5O5KhVAVB9HBlMmCYdixUXRbuf
	 Be3rYBa8j3/3qXyCxG+o6wWHBDYK8WqBxcac878K9MrMZ4eQzYxD3AgzC7N9Ppg913p7K
	 xBQ3Y206WuwzKfkQLYbG7RAu1YeDNenmLOIX35E59FXQeEHJuZg34UVJYEPl4cDVusWab
	 hmsdEhad2eiyrrEQ57iTiQXk3YO/ttgB6fU9s4R2ChLxoEocbMZCBRSD1mtrovcDr9eA7
	 9BVLNGA0ddJeCyWBkr8bvE/QJ+5ZBkrWLXZ+jC1oZj/WFjvg1DLEKFrd0tZIeeCUoAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288905;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=1B6fA3WI7WlQ4zsUGg3BwB9R+J7tvxrjoEUgC/FSto8gfd1zai7EbumX9aXwVqxcJWPn
	 IbA9xix/6ckNjmZi/p+izIlfZUCU98i6dq2t9rE1DVD04yokS0BxIUFyte4zw/bWQCu8E
	 YB0Cvk+kxBbEwwsRHokfwXYuW1uujpMugUITVgLo4Np0lOpt50z+ZMCU21eBbZZjPorCo
	 Ps3ZOO5EYdR2PpkwmRLSc4LVeZqQn5CTgtba05JSixGG6iGFyACEhc2+uFvE7gb6PGPEI
	 rK5TYfO6NT0w5xHMivSudL9mtjNJpTqNYf6m90FAB1Mcp4PL9d83s5/0ULaskgmjKrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlS5o7jB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DA3606A680;
	Sat, 21 Nov 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlS5o7jB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288905;
	b=kUFGZtEIlXA2LJY46QjZo0ssuyzZGvNPZAfCV9JCz5/Mo4ix7VQwq/3VivpNw65dbXb6
	 sCk5UBC4427U8MPPzb5wcq0gHJ207qrefq8oJvd/2QZg917B5wY3sw3hdUMBoKfDhJqbn
	 CTf9cFlx5Nq6JbIZG6bK5T61SMQeDfVciWLQBwBfThISxmi/CXY4J0bYB/R5gn5nxnXoL
	 J0nSRtI7cdG0Gyvm/4QiRtUNqKexjbW7WDKW5Cv2GvRoSmU0bsZ9oIb/bKcveGMde0F18
	 OqPHg22xcBc2UILCiiD4Pes+HoI0ybQRZHkBgGNTNkjPRfJiP99Sk7qT9uL5Nanvv3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288905;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	b=CWmIlBofG1MWdxKZQ1rugt8XM4ZdjHk0QSdKJ7Yix0ik4lb9WR06E3CQZwAS65AlEFoe
	 nWuxdibKXHsJ9dKk9dI02dlpddi6Ve/iGjFpf5CqjszAG+gLl4DoMQ5ViHzHBSMs+7idw
	 nvRwMwyfujl0iTEXEzV0XW4/Y1FBEOex0s3hrP6svNrsBEPQ/0YuZmhiuKYLtYn1Ama8g
	 Rxo2CTaecxNd8nv/ZCTwoHc1HxT/z5fwPnv2AeOCjmKtxp1FOeT/m+UvHbE5aMyPIG6o3
	 JuI97LLzMF3e4+l4zLOn3VTCBNGXZN3nEgnTqErGhMrJoHc2Dqfxjq4GpAqSmF4TKYg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8910B1F000EF;
	Sat, 21 Nov 2026 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288905;
	bh=+vDV9gxuiMjIN5ig6o5fnYNWGsi3VvCcP9sIBt1qAlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HlS5o7jBtHyGSmkRa9+zD37aRmp0S+gOGzENtskYC055LDionUWsMPXRv7o9lMCAV
	 UfnVbEc4etG4NkafANpXlbtwqqQg/kMxdYRypNf5ZX6MWsaH/NqIbX7fMUGmgrIR3k
	 4IU2IbOB7s+3K2iXtxDZG1wXBzFkTCgQ6uKzaB7qJ3yaKgylpsbxglfOlpQI7cDC6o
	 9UNQYRnB7SwutHrB0+eaKU8Uxw9GF2Di7KiRjeVH7IDqdOmytqy60SmSML1iBbMJog
	 FPvsJ88VltS3ebNvXONo19Cwc6cz18Nty+luSsS712C5oGw0uABpja4NoOQJJxZ1Yw
	 PQ20pOJtTmdgg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7553D4BD86;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:11 +0100
Subject: [PATCH v3 09/11] arm64: dts: amlogic: Add HDMI TX PHY node for G12
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-9-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=96ezTxgocDNVGkQVkrXP3m6ZHN0B1G+z/JYBO9mFeTE=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbje6s3eSs+rFfO+xvj5qDPs4HzAMuy+VMu7Jl8JTv0L
 FPeuWqJjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiZr8Y/pl+uDEnwvjImgem
 m5qM735Tu1r94Vmak73cJfbzvh1uaZMYGV6IhG+YlrTpdpT9I+X3Skfqzu+9dtbs0urTb+eJnVv
 /vJ0RAA==
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


