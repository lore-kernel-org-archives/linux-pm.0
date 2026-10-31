Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459131;
	b=sTq8uqRptIEquRfn6l/v0ewHPD4exBehUyi/nzFU1Y+e9QxTqJvaOxO/vF//UxQQNGWs
	 lAAnDqUdwhSukbvN28Sx69npualrUTzFPJCawhuhv06ITzIbkfB6WJHPVst6+wtuGeyw7
	 Ouv/OfuHUaYqLKZTRsb8y36fpGp0wVqVsQoZsI8kOgi1V8qyLHBBDutP6aG7tXyUVfdCN
	 exhV7qk0Y3jBa6HLumMENO8c9O9mBR4RfnCmdg0dum4Y6M74Gq1Q6XS7whOmsHYLnPcsJ
	 aZtKcmJRgEGtEObBDPUemO8/LMwCNlGEmOoFplEES9XxplzgN0zXTmCP7dOxsgQp0IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459131;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qXY4fJ4tgD+nshkl+/BLl0xVOtH6+j50yaehaAtwkZc=;
	b=ao+SMlGpUbp/INKanvpfgBAGy8CgCn7e70ZihlhWcB/1UuIi/qz7ly95vpGYuyY6mPLg
	 H99BlFCPIJn14MBM2Gk4HKhuT36RowiG7r25l6Q+DOqPn7EfHO5dbOY0uuBkqYBlwxjgd
	 f4byfrCWrb+9KXIzyWjQ+7aLcPmH2At1EvWIrS/ACRx9TSPvsXonHY4gHEIuSIbbOCxzK
	 paeY4QflMU5h1n81aEYQVEOR6tqGtjR9aJu+9m54tTv4rps2fcVX6Fo5HqZm66ZQHSXB7
	 AEdPBWV2hCufsTeVoHXorW930b+uoIZBmwYtb5+CDu3MBZQ4K8qCeAtCWQAxMwRsH0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leuy+NVN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176B606A336;
	Sat, 31 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=leuy+NVN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459125;
	b=2dOiBN3V0nW/qasQFI0jUGdW5VrBUTnVg6enaqx4QhGqkykb3SWhYwnvafcgU2+ENnI1
	 wVqcN/031OWPWENnSbZBohAv9RL1eqFBJf47uXf7ZuwaCdUuu6WeniPf2x06qnqvY2na2
	 EJ7UbIqZvhbEynQaENQy2VJbC8r2VR6XGk5RePpvIgQtZsXrjX6OMdnf8D/TBc/HzOJsf
	 kOSnXqDUJ/V9szNtu0wNyVBrOO8fo2QrrEo7vcMee5QF6XY5It1MSRbR6lwjHBbUf7Cuo
	 MdqQoPNp7GzGgdtLgOuR2FZ/vMdssdt/k7iAINDjY8S6pEI9+yCfNFpADAYU4yZAozQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459125;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qXY4fJ4tgD+nshkl+/BLl0xVOtH6+j50yaehaAtwkZc=;
	b=aAr7xr4DHJus93Y6SqrRozYZZMG/X1OaM67oTEvwVxyygCcDgJUn/XRgH5/FjOUJLnJ6
	 I2oLzbU+UXbiL5HxfbnsJVPsKoKHuC7Bo5FB84uwNWggud0Y4Bss1vqZPuLZBw7IC2CF6
	 pJRsPDjAl8NfEjHfBnl95+WXGiUS89aiatSFtxOhV2SnQy8wFUE8P6d4FVQfowg7gHX9V
	 ePJ/7UpLtt9HSdxJSXZCuVsHyvDposcl6o1Ve1kGB9LdxJEvxihCewednZzeYUrbOmssN
	 QZsj1dtIBuZ47f3MuRveiP+Q90fUiua7MZohn4CAehnZV6sCdObZ4iS7Tm8Fl/ArhxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4202C1F00A02;
	Sat, 31 Oct 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459125;
	bh=qXY4fJ4tgD+nshkl+/BLl0xVOtH6+j50yaehaAtwkZc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=leuy+NVN/5FqgcaH+NtZ1qHZEdsMYnGmJuoHa+Fh+5en4nqzCkZuZZkgliBqQu2gx
	 JduEC2iVXc9pmKKIDfXgIVkv0uZDQXukG3uyrwkpWeXnYmztw+JSQd+m1xfiX8NcOw
	 2duHMn9qRN+jxls5j9lriyBfivJMqsywB/ML1u0g3aN+3WN6wvXnvNb5QqXhZKw7O9
	 IwR6vLyrv8g6fEgkZUBz2umEHd+o1T8p53tH3JdPkO8Jsi9GhHrlcTavzbyXXNsdsg
	 TIUaj52Y1E/T8bou5s0Kkvi0V54eUKSiJ168wy6/Qhz25o7eDN/kSH+p5UTDEZYHVw
	 eSM9V4H6T7G6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D1F1D45F2B;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:08 +0100
Subject: [PATCH 11/11] arm64: dts: qcom: sdm670-google: Enable vbus support
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
Message-Id: <20261031-pmi8998-vbus-v1-11-4d805e5a0f27@ixit.cz>
References: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
In-Reply-To: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pBRLO5rZ3Rm5tJrcNsGBLN6OjgyMlOuDvEjF7+il+L0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOwhLDb/48orJirTu7/94yDF3J9cj4MK58qB
 gzwA9lAJPaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDsAAKCRBgAj/E00kg
 cjElEADLWvkkUZnThiqp7xjD5OiyhyBOHmbh4/dUJl97peX0+9x3PZ+tdgXmxqRz2t/1SsOj577
 2KsQdL9+OfMrXvnjZN618mRGROr6yM3k6pGxunLNACnlMiob7pWRjL+uHdS8I+Au8Yq+KJkD4c4
 RvmnaJ39XXDj2NTUfH4fiZnIbfO3vYORGIH8Dd6eTxZr8nr2A99V7RhfZGz0e5lUcnHhhKuEyA9
 yajcezPXRZMYzlDQo3xZ8A30TzJQ6UZAJiY2puGPr7jE9p0BQJwsHgwloI38gRSm8xCmi4WWSLz
 RynkeFrypRgD5c/ssJ5o+ZqlVE1uFkJoFaQF+y/Ou2iatbB6pTJ94je36x7gXs803yN6Gh4r/yk
 aiBoUjNkcYdn+CNN60kKzntlTrs0knq4Dd2djgoEulANMBMSz85n1EkOT+IhMcD9JfmDhacg+/E
 Mo96L42wOCPEMGjg/GsKNEY+COBzTJ1z67mR51jgVawqTqWJ2B8QqhC0OhcKgspuUV3OxkRzTFj
 jRix8tJT5RHtmugWGCQT/5Mx2AUGmQ40+bbBfFy+Z8Sb4l92X5O8P+yGMD2fc5185gAkEaqlKAD
 +HYvX2c9Xxcob3nWMPKFQb4tk9J3fAMyN+LfnRmZKDF422igi6jD72zcL3BFWXBg4RRcpIfHfM4
 I4Gk/3hVrj2jkdg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

On this device, vbus was setup and switched off by the charger driver.
Enable proper driver.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
index 4ce9b62abe53f..94590cccc590f 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
@@ -602,16 +602,23 @@ cam_vio_pin: cam-vio-state {
 		power-source = <0>;
 	};
 };
 
 &pm660_rradc {
 	status = "okay";
 };
 
+&pm660_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &pm660l_flash {
 	status = "okay";
 
 	led-0 {
 		function = LED_FUNCTION_FLASH;
 		color = <LED_COLOR_ID_WHITE>;
 		led-sources = <1>, <2>;
 		led-max-microamp = <500000>;

-- 
2.55.0


