Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793459126;
	b=XSZ4vyePQG5dY7CeEf37TeERXKTz1QkhKyOW1OjYniB99ZpAT6oA8a5NWmMW9LNNg8qw
	 ZGTUjYZ2Vwn2vHOqEH/VmwB7eF9+EbSFtiy6w4J4TNBTQfcPfZLzp1Np7SA7uHt5d0ien
	 HS0OIDNOyC4BkZQ6W096RFnoiFSUkjY4m9PhFIoY6TNsRRsUJQONhB4wcFDk16pApbDrc
	 T6FSnuIw9nOqhM6n0WeT6aoU1TLKuI4KWWVboSh3qcroWlHUGJs9+RzXBc2J5HUw3svv1
	 7ZVsxrNmugCaUnaU3aBRdeScWekm8cGkr9JwHoWQ5wWySl50BDB8rElB+eWAqFBU3IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459126;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bl/rYyXttvjHdb4Ohr1xdECvjLaL/p3syYDbGC3Fn7s=;
	b=NUJeLIgO+kE6z/Eo/US7jlyDsrfl29Bpz06Dx7hZnpmWP+zuhbYuSjy5Ld2K49p8Ef/u
	 2dDpUlNrPrMARb5QGs3xCpENmfo5V9TS5jTSLkpaaPfm/54L/IwFbeOygRQ4HuA9lRQ3Y
	 K/VJyxi4BpzEpdzvcJdEojnyrdDm2NQTW86KbwCzuMceYL1d1cz9YI85/ggRxC8mGRHWK
	 qVcBQZhZg7+hTgXdKwzRc2VGxlxvaOD/ZDjc8YQgViqMO8ZhoVzzXXAqsncEDAuwr8Fcu
	 OliM3Ygow9xuvk4tnSdOUDQ61oSnUo6r+zlcBQfpznA/QkVCaXkwBac57l8Oafx44uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHD8hnL4;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A970D606A33A;
	Sat, 31 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZHD8hnL4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459125;
	b=gu2BsLR1Q0pVHyrNVh8sK5gDeEC45nKQeAqdI+Ew1tkRZwq1XOtqsvTQQcCYdC1sHpKg
	 GNHaN45rS9Z7Qqz9ZJLL93oQPM93HEvgC5pBtNje3ExtM1YVPy/vnkM2U713qC9NUieMs
	 TONfuIGXctb6GBsKtbIU+/EnmOGwv8HdzDjC5YcD3bHbwYp9kgvhlGySZ55gD5vAyHyEr
	 qcBC239PPvR+EvRml9nxObM8O0gdUZLU4kQVlFih45wL/dmBGDKOw7MlTXdvMahvM0Dbr
	 R0yFMs/zAE5ZA1lcvvCuU/yIlXTSq+V1IMxLif6Dg2FPwgYRUMINhRlut71HNCZrPTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459125;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bl/rYyXttvjHdb4Ohr1xdECvjLaL/p3syYDbGC3Fn7s=;
	b=ttTFOtlIYT0UwwVZyjfymE9b/+BLc8DD6e+Mq4C4Ubgb/dMXrvHqIT8BSrIUB/Dq1zxW
	 k9QcSg36qC9SBIDM0lJCaf2LbWVho5djSg8+fvH4x4kWfGkykUDdx74y3z+jT9YuXVx8e
	 ZuL2jif/N2oOF4g4wwXtFSlQvbNkh7RcvyDuaRSWvA2x3rh19NltmGwZ0lRiuI4eb3yVY
	 +wp+RSMlnxeJrwpwH62JtPsWP70yKAIyYJgplzVT8PB3axzBRdHac45qBVtwRaquwknyB
	 vc3LF7WcTDb6hL7z5RiROsCK5557Htz4svvE1uBBtVB9dReCVHxgUGE7q0o38AtcTeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E87211F00A1A;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459125;
	bh=bl/rYyXttvjHdb4Ohr1xdECvjLaL/p3syYDbGC3Fn7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZHD8hnL4DH8AZGMWe05Vh/Cn0GhLsxiaYLWXix77U6/XfLcNAgcvoffGhjbCBVCsz
	 /wd5EnHXPyYn3Yc0w9LgFG62D15niqHoqKrhOf4CBied6DBYKiXvQ2tvS/fxR0OGzv
	 asN88QAMNHDsx81AxbJ6lcw6X37kFiby90+3NSXg1FoDGGSoA4OTXNLSXHzHcIL20B
	 wp1IlO+n6FdesoZ0H1fiPME3ECjPyii/4i/hRi/8cgRdg/Q5gQHKXQ5xDMJzuLSnkv
	 tXgEvTHGSQUPNu00jHyg/61SBfIIv3lYFPDysFdlesYKdxyFBEsbSQR8UFSuahK7ms
	 T+5Mm0fjSyVbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B80C445F23;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:06 +0100
Subject: [PATCH 09/11] arm64: dts: qcom: sdm845-lg: Enable vbus support
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
Message-Id: <20261031-pmi8998-vbus-v1-9-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Rihonp/y8+HoX4rhsOxsAwY056X8OB2FPhm/6tjGeo8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOwu6Es3lE0a5vv22oieDwXQsTItibWBcimX
 aV8eNKGZQKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDsAAKCRBgAj/E00kg
 cvLOEADO8ds7RwJwPjQL7KH0HSxa4vjtSilyl4fuCEN7Wwisumhe/Nl146RpydO6rngFMkfxVA8
 w5YwVGKgR3mOsiZss3vL1K+YY1lKM3RJvxfMg68yIAAHLzsFCIzHP5OvR4RdoiWN4CHbLu/W7B/
 VfUtT7Kf8/qBBHSmKj3VgnFuLbt8W5381TSp3nKv8LNVHxLu+o04JsEEktGzNx4ObVvWrkjccg7
 CLHLjmRV70hGx4mxwG1XPtQfIi8FQiCSKGh/3hfe5QIvl0kwu0FY7FuonlQ6T/cW+dJDppbz6T+
 o2ksaePVYa56WRJa45luonj20NhGOl45aIjPvd5x62hNGmVHten7uXZfMrtGBwSaXGxiITDDpks
 RmGNkObqUYSvw8GxoCfrHkdOJKfHJdC8DCyPAv0iA2PXh2HGPnU8SAMK3tsirLamVh3vjUdar2d
 voaSCSGahx7ppMENu7muwJKy0Z8a+na1iCPJoMLL+hgVMBdUEoN0KQiY8Gk2MRv15gnoEM0Jl/2
 SRf/v80St3Cp7T3UJz/NKw4fvg5sD3D8vNx93E3NiAsodZVVok9AnI7tq84ykpvhQkUre+nt/Yt
 MxLTTAN5/qWMji6xeELP/JYe1YTxmeDQZzTlybZHDn6+rQIV0bZhDcSdybkTAErHJ5kSfVI4RIK
 kMvLjRzNWS9zNIA==
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
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 84f0e1f0bcd32..d88bad1d07959 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -529,16 +529,23 @@ led@4 {
 
 		led@5 {
 			reg = <5>;
 			color = <LED_COLOR_ID_RED>;
 		};
 	};
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &pmi8998_wled {
 	qcom,current-limit-microamp = <20000>;
 	qcom,ovp-millivolt = <29600>;
 	qcom,switching-freq = <800>;
 	qcom,num-strings = <3>;
 	qcom,cabc;
 	status = "okay";
 };

-- 
2.55.0


