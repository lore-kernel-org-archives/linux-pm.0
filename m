Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022748;
	b=QCoUOI7K72GGdii1na0kSoCm2N4a7V1p6bp5emAe8v/faQu9v+SRVpX1ndTUFfGvfpkk
	 yAc2OaRaWD2NmQGVIgXkj+lyq2BIlfn+/wV0xej6NAjHjP2fq+5vXwFRQBoV1zAnu4OO/
	 tXNMxbQIBPH51+uLR4un7GqTSwzVcwhkS9Ea6HFb/6+tR47gEZbw4JkCod49oW++YAAbR
	 RbOESgSQ7Wl7Dg5XObS30lTuBrTYg7x7s0pNv3aKJRgmX1PJo+l89XwnrLCbcHMoRgbK/
	 1/+krmWoTC0rEThLDODj5ou7n7gjwmbax6fvbJKdXpLP4d0MLu/MkRu1JhCUYwVmbvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022748;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MNzZxP15leU2I6mMVxBO0HS7wWLWzLgRBjo6S8kI+MM=;
	b=rUFzgrN0ZGaKBsl1uTh/kc3j1fr9qAD4U7x5HvfIkWpL220s4m1KMb0NIS+tV/2Z1yKP
	 hn0CfxDnhH3EF8cdjPpsyZI+RzE1SkZ6UaniYic7fGenCEHzUFpj1wKVRe7E4LcdJUXbO
	 bQC1nj89mw6Mhqy9u5wFlCrCOVo+MZwc7EHEWWhS+fPEEjylCDCCraYfdjMB8YcPxvOKf
	 bUyfwbf99bmQVQjpdE9H6G3wyuepM+SKIAi3gVqwypEpY0TefjHCcVo4YGETQF4MuiiFG
	 1LVCLIlRU+3zdhv0hIIeAVQ96UmZ6vLIybIhqcpiul/oyl7/S+G5Fq+QmUBSgaD0m1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP6+Fwpn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B5660A5BD7;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nP6+Fwpn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022748;
	b=HpH5+oe1qll8nX40r5zGZH5M432eRdNB45pEQCeAnQUdpXOZ2pGuxwOTa+7lP3tboWUf
	 XslLwyFIgLlLs+XJ2+aE4MToXTrkZS82cVUSvRejyzQTwraBC7jWCtc2Y69f/6hSNLHzS
	 +J3Ej4ZlEA06KARX1lS2pp+d3xbqYAKE+F9Rq9y7hW8t/OxoRIt9TY5lgc6TB8wqRM2sz
	 uww5KX8xKhuP3TCypLp+pK/m+37yKrtIIN+auIHIPehXJ2pwQr/n6ic+yCerP5Wo307oc
	 Mm7TJmFXzNivD7OrOJTZwY52mSvj1lyOCfZ2N+TNuIzEqf90DLS53nmhuoLPmHGcYRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022748;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MNzZxP15leU2I6mMVxBO0HS7wWLWzLgRBjo6S8kI+MM=;
	b=dpqYaMGoLo/PF/z1VZKWQR/cVn3DBs0wlMASKkU7y2JoTJjvZRqZEbBgar/EI2kgnBKY
	 5zKOt19gvWfQHtYw0qcv6Z4i8jwhAaSJCtWBSaA2mCrXSQfTdQuLCUsG6SFBEwVW6sL/p
	 yz/NNv7RWa92ZBpkLCQi9oxd91EdBxjC9RE0Zd9jRBUkKVsUIX11jJbmEuyYuvktbEJQl
	 DTAgzQWPcauW7zg64cT6kA9aNIJLGgu7sE5AdmbDNKjdlex72OsiSP58XHfHwDnWDI7yb
	 PSI6Ap7EtijpOe0AgKgd+b1X8N1y8ZyQSeN1ub/3dza/leitBQbcVJ4YZzwkbIJACJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4A2BD1F0092A;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022748;
	bh=MNzZxP15leU2I6mMVxBO0HS7wWLWzLgRBjo6S8kI+MM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nP6+FwpnuM2Ph/juqK7T/LLsVBMVX1riDtFxJsUZjr0SMnGr//qhvOacwBst6ln93
	 PyNN3b9wcNRVtKGzSh1W/8WlXHoZySINNJXk8NwzCm0Zc9xPDHbBjwC8dMg4B4rVcy
	 L11KWMcuckM8NKW0qXNO493gl0J2RgkygW4/7U4FDDAZTKCPVwDVMh05xi/HiF3XfS
	 u61Zl9Mo0OmJGfgPJnGhbrtqH9g6C4uuoifWB3VKec7rLvN8Zhoi0lnGPMMWbCZ9yb
	 cvqsz2u3WAGkhvooBb6ITmoPOmkFzvKVjDnOIAI38ujNCrft3umi6BQQw3Te73beXK
	 vvR00UvbY2LMA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0152F4AF05;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:45 +0100
Subject: [PATCH v2 12/12] arm64: dts: qcom: sdm670-google: Enable vbus
 support
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
Message-Id: <20261118-pmi8998-vbus-v2-12-3c77a72b280a@ixit.cz>
References: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
In-Reply-To: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
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
 bh=opQSg7fZ2yNDm8dbUq57ONjOIZ7j+aCXyQPY1Da3ae0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+X8tGUm9NqcawCeiNNQn3yPCHrsJApxfjza
 /qcssjy6P6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cuOpD/9Mlt3mX5CO1pP7WQX65+rTeQsLM5MkbJ7evmfniT6rHsLOhp71uqBd1GUskQtHJKzxUeU
 0xzKXgB6mfU0pZxyX7A3o3ukHz0LGlBvpLJplRTxru7BL/3f5tkcI+81kTmHBABSXlxdU/D0EoK
 xeO+HpfOfSV75ZzWypwhrmK8vVusYRi4OKMj8jP5p1mlJEXchi3OLXgp3YAuOgj+WqDFmRDdr/D
 YhK9pYMeN0pFs4GgSbaG32ytluKhtIH0p+Re5XZjF4NbxGo9A+SsKWcN5FTqyFGeh4LR4FNRRz7
 d+Qr+lU0HGL0fad1FeZ0dSbWEAaSjwcPjIKwpC/5zgWBAAiOW3itJh3aOBI5XSnqf+9YLycrVfk
 xW3p1cT7PB6W7I4hV8Abk+yrRPDAra0ALUVbAnZnV8y3k1jTp8Z7ZTrolTn4ydrcjSqYFgcDAuR
 acZZEw40VqXMeprrOYbCfS9ubj3OGFXzcToVqAOe+414UW1leMeKg1klnXXTt/OG9EDCALu6u2T
 QTGZw9p+3k/g/hMj1K6uzQsIB61PX50Puvaj1qzAU6LfO5e8jo99pY62Ulp1//OmEjtILyn39MN
 EBgix4WWMXgCRfIjX67T5XjXH3UwDvWdvKrcuCMD6I//Bww47MPrmeb38g6XVvmx9QfsnmhOw1h
 KnLowI+KdNeqNyA==
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
index 8f91faf8a9cc5..9c95855b56e7b 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
@@ -604,16 +604,23 @@ cam_vio_pin: cam-vio-state {
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


