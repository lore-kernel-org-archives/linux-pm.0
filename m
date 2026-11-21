Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795288905;
	b=4rqwP5UI2Jwz07poPJxDqwO5B8+dH09GFB/A5UsqxPfFYi4e5UMXyOMwESs587vvIlJX
	 WHu665mTtEKyUq6iW3e2FJ7IlT4Av3j1oHIC/u0Xh+dU6KIf8OMvHBVg8l4iDf42qBFZQ
	 YjyG8wzEmuShB4UB3ABpchF5aDm9c74PlToSK9QVGzA/L/cfgFiQfYd1kQjI2SXv1eLE3
	 j+D+dCEmLOZ9qjY9gIQGdn0mfXykvu3k/hxp2XLLUxrM8anJCMLBCBQLGfGmizjqs2hOa
	 S/CGz32v5EI3FxujscBSshf40EWJ+zxAVEv8btXxFAZjioqxr2vtov30dn+nDDo30dA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288905;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=0U900PFU693uIwStPKm5mWQAPwmRObXFyXQcMfuBj8WbTLgeswacP3DElg1Pn1syTY+c
	 Zty5TRyghf8ibkB4vJomuTmW3S7uTN/BLyUQVQJH3rngp47UkztOLQcUg4aoaBYqGYcuP
	 j/YYKr+peFK7hPiEWrmP8q1ucZvTiRdUzqYc0fmizDkTmd/EZ9zqmSdN6+4+sl3AfI+XA
	 QphGfA6jF+KvZSjknIZN7rAKdLhVnpW1VbVMqomZjOMF5xjhru7v99wffAhrQ9FI9ROOB
	 nPE8alEyzrJVwFd1wN5Jf3QnXkw59epRSdXhgVu9FCbrV6eZQitgkwy87QqBgMfJO0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hVQ2M/3a";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0C0606A32A;
	Sat, 21 Nov 2026 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVQ2M/3a
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795288905;
	b=FTqmv7xXu5KoR7vT1jAs381zFySbfC07WF4ReSniJIKMiFqxuj8Y6CzkIRsl2LwNucTi
	 6Ajy22+EFAoo7nT9Bvftpr9KBj6NYg9eqNX2xCjoG1nE59aFj8LNuT228bFN5oo/MhmyW
	 0rxDQss/N5n8B3cORS+i2BxzPO+7o7E7nhtD4cpmi6dTioOP0xTZD/Agr+Q9gMLR8XxMk
	 lt98URQinG6AeRKvOXh0r5qreJr90KdmTr1hWfeg7NDfuD2f5gAhgwDJqoN89R5oAJJgr
	 fmQoOycTdoWUtM4n8N4SQAlPVT31GA+kjXQUyrmQ7fkTHkpKkfA88yDDuA7Zp7WEptA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795288905;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	b=JnW7O6tuoyVon476HuVcX5KBdISibR0N++q0wST71UXN8vmkkKSuRginkZQMQ3vgrRAH
	 amSUJKjxvyLREQBKZzWJHf2p6nZcR78QrCNAbFjOSsMDFh868vDYX+mJpuiSPBQlW+HhY
	 baWpSb9xvc6dz2g4p6s9+ckSovPwJsycYLgIxp3s5f6JhvqLw5Irm5uHuc12zbrsBEIQq
	 ox64/XVrtGkrS3nO5xTY2xoHjF4nJEsNI4jFczh1JRpiTrYHa5e3Q49oVw1mhj4uoZVVG
	 OezXmtI9LZpbBzJRMCe4oMrK6wHl9S1eKpBvZ2OP8s1Jh3083KEW5beossKRuX+OI7w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8CC451F000F0;
	Sat, 21 Nov 2026 19:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795288905;
	bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hVQ2M/3an1gy3dwMYRx86ngxB0d3A2zET589l3fVIJVLmkA2w5IaeYLKtNU4nQ6a1
	 6NBsKc16nv4WN9aan6y+kdSSy4DUY1U4sB14r2N5oCyQCgVTRbPXcGAyynfI6gH1w/
	 EcsFIie4wPPULctzD913ripoibO0GhQxPN+1wZqp5B08jMQBRmmRgX6LHc+2vRepXz
	 5XMfLyBcgkpTWScLB4ArW5ZwTuiRPRTWZlujAs+oik1YHQAjYTQkXl9qFj9bQl/KOn
	 MK/hjc9T0VHxuKlKtw6kOKBp22148htcmcbGhHXlxKk92soDn0RQtDOLUFideVUNLJ
	 wurQ7J274rBPg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8FE674BD8A;
	Sat, 21 Nov 2026 19:21:39 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 21 Nov 2026 20:21:12 +0100
Subject: [PATCH v3 10/11] arm64: dts: amlogic: Add HDMI TX PHY node for
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
Message-Id: <20261121-meson-drm-create-hdmitx-phy-v3-10-f8f471788076@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JfeJFGsdjuVYuSpN9bsRq2rmNT9JvKzwp64cluLxjAw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbjexud9MiJPwNeik2vrV3seiZ2naau0WM95Z1rb5r9y
 bqmsv56RykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCRI2cY/jvZCote//An5d3J
 2ct+KOmw+r/3Sj/axD9zQ/vvNfOXKggz/BU3vST5flL1rkrLKG0+mwlSv5QL97nEK+R96EpbcN+
 umAcA
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


