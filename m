Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793343;
	b=krgMYrS9iLewqGOKn5SohH7/q49oOa99i1hOjw2hYR9LTK0SUhGBGVtGKmrYXijA+ekE
	 VKV9KOB02kTsMb1zrPMIME81qPli5+l7P09E7uIkF74Q2m7+DqC0NxPj+s2Sz1yEJbiR0
	 mU/bSZqh4HcB5A75KkgLapd2UpZt9n3uNpGXPksBHMzBC7A0PcC9rata13gPByRFknUL+
	 Hak33YaPUJCRjXvBMgHi09XQRTN4NwxqCIRZRzeneg9/0+/P3Kc99AmwViVKAP6I/ZbK0
	 zDz+0i3WRFAA+OWG4ZbUDVeuC9k6h/l4V1EX/NUDUSz/LTscsfwIm4c4ik399Jh/IbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793343;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=WwxW8Pc/pPFvn5Yor6Cq2m/89h8M/v90HUflYCXr69VAXHuLm6DJ/88R/exTQLNEajna
	 6e1EvMeOfE6ZaEQZEcIp8YbudKTL75ivj6kvYr/iWrp7GO2GObQRBwTLzoOEmwLUCEvhu
	 Wa5kX56q1wBnAyF4GIgydXkQGy9QFq/WgdEUUUFckhow4YdbWdMN4cdz7BgF8UK9xC4Cf
	 E7bSLKBDqXq56/5nxBbKTRP1chEbK4raPv9U4/cVYL09WNvgQflDPJDE6iQBgTPzWI3da
	 Bo1njMpYmgHOyWGgq3qrNFqGC8ZYzErbijDf0IV/BMS8Jlu0/HvYfHdWIGR0bPT7kMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrPXvFEG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9879E606A6BC;
	Fri, 27 Nov 2026 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GrPXvFEG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793343;
	b=zvesmuWU4Ldxx+wZrp34zeJbKOuc1FB1+znX25zxRlS+yKrutyLgkpC9yArarUKvvED6
	 EuInqiBqDbwUA971xAV/wGAkdolBr0u1hq3jhtmwzXaq8H8F45WEAjXwVuLurz8arDJaE
	 tSAHDQTie350ANMVsBXe+AzCe83aW5pccksZDagI3TpJ3yH9MNjoYlSIBwrGwd99Sr2i2
	 rnYXI1h3J+lUh3E/StTGw+X+2Fac2Apvt1TGcIbEZvjJ9lGMaA5hNs6hILoy6pO2cJs5w
	 S4XHQilmOZb0s4uWZDx/JA/0OXvGfQPReol+Qt0Mcbp99rSXVosZk0M9cM/PWZe1LvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793343;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=HjxB+6OY7JRXw+gInZyamw/3rgol+k3ClXhXVvrpZ0aYH8DmvndVTuAukR/sxsmCjelQ
	 Ew/29X3XqSjQOGs2VWuUGGxwPX181xOv5nCN426PiQu66j7hBchENK28hvCqCRluo/OLT
	 tNGUiyogwEp48E/kFtshSAyClMIr+2OLk8yxizmnNEZWINNy+6wF14uUoAc67jCQcC1qN
	 A7ZaoCstM+eGPai0j44zRQ7vVuU7veuGnJB7JZ+zSAtrQ2P53cRO/amlDvswDC8QU1s47
	 IbEjHCjbnfT3Rdiv1qOEj1Y7Xel+plxfMAhMpVzNPgyQQToYQUD6FbmtM7z0xMm8ggA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0E1CF1F00936;
	Fri, 27 Nov 2026 15:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793343;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GrPXvFEGbK5PEgnjPJfQdWRRjdzZ32FnvFGcJSUQzGS+ugZMnpxChOgOWJs6r/lHv
	 XCh4foCO6oHjY46WPQEIjd6yuo3qmdkwO8EN7wtPbsazLGn+UGH9mD8QkjJS/TfdUE
	 7RVsHAzbXOtzf4+YoB1THsbZf7Y8ZJ8iYD7gwCi27smOiJSrRP5F4qiFR24y1CZMxi
	 R3lraOW9UcMxkJYXgmUr87Agpjxzzh+urJMTr7pIkcPuWBBxM7NMTgORgs7HVw1VZv
	 LbMYhjQWhxV0gHAaotSZQxEt8folt2o2acSDif/TX1QuZ03HlmvUHP1aaj5cPVe8yE
	 YmspgRiMxHbXg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4DE3D4DC98;
	Fri, 27 Nov 2026 15:28:30 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:12 +0100
Subject: [PATCH v5 11/12] arm64: dts: amlogic: Add HDMI TX PHY node for
 GXBB
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
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-11-88c43eb95468@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JfeJFGsdjuVYuSpN9bsRq2rmNT9JvKzwp64cluLxjAw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwhl/m7rnbtPZ+6fO2s2zqmTnv5d/Js9at+ek3asJL
 5K8i/ufdZSyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIZwsDFKQATYdnAyLBu7racmbfXWTSt
 0FCSTuwIDexfPGcz+/8Lp++7Rp/fyVrL8N/dwuLEd+sd+j9K/BQf8K/9f7880ejScud95/Yqe3z
 3aGYEAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-gxbb-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5c2fe9dc4f80..09ad9790ebc2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -316,6 +316,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -330,6 +331,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


