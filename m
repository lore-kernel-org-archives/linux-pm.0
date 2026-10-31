Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459125;
	b=mMHoKQLV8SqFP4q8YGIGFIM7QgzQGt0SOvlufB+0YvBLRjuVh8EKi8NQnASMTlY11Pcq
	 lLMXs7xvUacrz72Ey4/Lt/UueiimTGnlivAKXI3i1bDqKy72t22r2MiPZJxDzwf9DZRxG
	 uFsJuBKsljnt/H0k+c8C1e6iVNNGaZ2kbIzSmsjLkk/CqZipO9M9kxu/SN1MLEWIqkWGQ
	 22IXdjERg0reIjoLgZbcuhfu9azq1tvth9+OalyqN1RM0Mg571KTpPBCCkEQ+J0OQet05
	 +9F//gJVaqh6gtgKGjPjCifhKgSZ5iWwMXOR4Qsho1QiJ7QXpgOMfWPZNaJLu7QMjYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459125;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	b=r7ArHwENT5C43kATs2mXDMds4yWOJwwh75Zgnu0kKsKK0jQtpHJhEC7PH8cYG0bvUpvO
	 eBZ0j4B0U5+U+mJgRYlYw4fbyvGrLJ8qk/4THiIUd9NXqoyn0hqs15j0KZXF8BOFHdl3U
	 XFBkmaUi1lzR7cUUPQV09AhaelVleewRgg6bN/EeTfvc1q+meGjhcGpHI+LEtP1J5VCHu
	 FhmCueGM5m6O9ksRC08IvaHhARP3LUiJMhDLG6bJei/ia89pinhd1qIjd3jf/K5/4EFw6
	 wXIMxEtEPp7iwpl6Nm3rYgUOZesU16xLJ5ab13vbrlh1jK/N07hsIe/ozt0YQ5ITPFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWNr2tTn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2E60A2610;
	Sat, 31 Oct 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fWNr2tTn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459124;
	b=mAj51xzXFga6PaYVJt/0aWeB+t/jQnmm7hWz3I/BUJ7EkO7rnWqqQ1FTwj6GvMuBJIfV
	 b/t7gdlvWmM5uagyOIBb8n15Ppb3lgANY0H9lMs/pGkPTbgv3yHzsXI0ZX18opiDaRKdu
	 H4MA7B9rQDHfJG/L0oP5AyoPoKrF1q2fr46Uwc2e5V+FC5P6bp85wz+a64pWUxpBLTucC
	 mVd8toCW3lyQy2jzYEGvHm9bHxcfDzneOD5LdqA2IIKQ0t0rCe4w30tKVpyS/R3G2eBKv
	 70vvP7MgQWq42uBdWo/cCiyOMX/1mWRUZPtLJdnRd+NA2bbOGrIJ+ay4yGh57/YIVTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	b=mMlaBj/RoJSmL/VTtxzRlFbABXkCRK2cjdoBRNbOtEuCbh5HkPpnjfPOY24nnQ4uigAk
	 xTfKb3vj1OH8+guw6kH82E0futo6d5+sljHqCo0hBCj+0HjBwNBYBuT4t7MXvAIrO9aIR
	 iA5qXjQChkngRphCukqDuAeBMvq+vHPtUzXBy8etP+FwTzRKxWYzPTT+F1nn8MfbBJHG8
	 57OPL8PNoHVNnnn4vwbxNYQTBPgM/olG6Jxi1AOxtP4DKS66MDTLwV+JAyrZoawZjFBtW
	 hVlgAnHgvYIcGpIS46nH+0nPTPJoFbywGhxHhX2DgrGCQt48tV3zY3cOXyGP9Mrj1Qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CB86F1F00A21;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459124;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fWNr2tTntygH7YJVmmnF2RaMVThfsEC/vl9BGAEA5Byuv+SHNXd78RET2mWdWIs0X
	 wANupC4n2mJpVdukaPCpVEqDYt9lJkHoUlBGmVYwg3YmcgxWZjJvqTCcydD/AFFJHV
	 aLEGI5c9e8X9j7eIEvWRmgxeCqFma/S6pyb867RspuUYs5AL9m5P8kRIWvasN5y5Aj
	 hUAAZn8kkJdOxpc8OAtv0G329Fj1JZ2/YxuO3hLwZ1JIUG+5VaWi1cy3qGK7albr55
	 6MP6OJ0g5Do4XKvj7NQbDhUCgA+yn666clFo+QoJ1uW/VOvz5yotS0o8tpGVpOG76m
	 i0cddprCZNtrA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB4A945F1F;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:05 +0100
Subject: [PATCH 08/11] arm64: dts: qcom: sdm845-shift-axolotl: Enable vbus
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
Message-Id: <20261031-pmi8998-vbus-v1-8-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VGlvhzohfkCXo1xrxHnzPQfZCT11uvlRraEHS3HXGX8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOw+Qmkgmz0PHHPS9JPGISet/lf4b1azhgkm
 QrX0PCfidqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDsAAKCRBgAj/E00kg
 cpwED/9nRiTgNmILcJASqhq+aaUj6Vfii4ZSQ0MJlW1/fTweMIee6vNAV51NrpYcrfHRkmpK46B
 smg0rtNPpOb86pkthZ+A3MPCXQAdlr6j3HhhKtQe7BxMzInp53qDpWBhwHPqpaZMo0jQM1zUtuI
 PYWjfU8KOI+/UKTef+Yq7A8cmNqBdWEDWfqoTxHDYu594rt69n6XRF+Ls+qVCW8GNvHOIDE19eI
 0dQRDsM5eUbs+F2UbKOLpPUi1dLb/h46fip7SID/2JmurfbO9woKrT8LMyour+W8k1/neup6qDm
 HmiNa+pKnM9dw3N+OrZekID7WjCW7Yi/kQyEXwywccCwx9Ow1m0FtXKrwrUIZjA6X8Aiw4z6/f+
 KxqM6s06RtAu9WgxV59C/mcFloiKJJYz/DwsGRm8Fj9naGA4ndazsM0dT9mEBEaW2u9+6lrxDIU
 k1agmTFJMhftbj1JCTvKSRrTvBFtdOcgXrt0rdt+ypDWhJ+9XdSpjuY34G437M/Q2DChp1PGx64
 gmdlPslCtA13tgmK/Os5l7on2MWt6bos61p7OiT1YwFomsdZL6aWTZfse2LGaVi7icoutK8vhQB
 J+CuvJ/QiKkPu6IR/kCOqcdWHtaMLgeSazaRXyl0x6OspQ9uKBNj4zNoYeqeQLoqfhCs+xyVHAY
 EdQuJxWBBabhKxg==
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
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 1b0eaeafbd517..124717214edd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -654,16 +654,23 @@ led-1 {
 		color = <LED_COLOR_ID_YELLOW>;
 		led-sources = <2>;
 		led-max-microamp = <100000>;
 		flash-max-microamp = <1100000>;
 		flash-max-timeout-us = <1280000>;
 	};
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &qup_uart9_rx {
 	drive-strength = <2>;
 	bias-pull-up;
 };
 
 &qup_uart9_tx {
 	drive-strength = <2>;
 	bias-disable;

-- 
2.55.0


