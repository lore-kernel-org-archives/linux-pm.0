Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459124;
	b=sVqYsajO/l1H9nKVSPgMuwc8NorcfMBddxyCVm1pDBetNQYJAY1Ad1jpnmFDkOwulyqX
	 UdhsULAe+tBoQTCm6XXIuQMKzUN1VfELIFUBOHCGs13zy2fxCDRc7A0meemP3niu3hrh7
	 W/FpSKXdjLjrh796Y3Yb9U5WL7l/DyiMPIEHKbOCV/6Ct7m/ABLqZ12miSajmg5ZK6n16
	 GL8uUNlbAhN+SQmTIAkNpPBzKzXJAVp9k/Nj3dGw6nfsrjuVqAx3bg1iIUpMIEC72nmH8
	 qyn4EzVlDdvLO4unYcrhhvt+ObiIcT5V2mSQj+Y9bszZYq9b43fBOi8fdyPHc21Lagg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XtMDggZfqhjPnyTNupsCm43yB2IJZ6YG2yl3RHMdJt4=;
	b=4pXztSv3xtOxqigJb0t9Q3v3dHqtVDCDroRdgSb2+Rtt+UrTkYHKCfSnSEFTqeRra9wX
	 u0PvUeA7+KuiMDY1GOh+Sd1IMuKYU3d1PJGEDFfxLDFVIGyHUZFOiA4z6VuaY5YOqc2GX
	 4htPWkdri1KkY0YD5Ev1bBSMaBHWJ+VLUp4Cq5Vd+KfDhTDN9WEqJv2BUt4cMcIoZZHWM
	 R4uF9J4yffhkCrImcsc4Y69PbqYMJZNQt0aNqbzLVWnogpPBwxgY8QGP82VvH39S5mHGZ
	 v68xNnt295W95t9nIU51Rt4laqi1tH6hchHT5z6Z/jvCA4d2nmZGFLdHg9m+wtGNurw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doFRX458;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D2606A32C;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doFRX458
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459123;
	b=cIzym2uLJC9k7ygZgKDZOrcHP0C5ULtrJYt6Rjuf6A1iOw9OFTnbHNi9pjWVQTnKWzwC
	 5ov1IQz83jDB3yddk9koZk6pBOFIsiDYqCQ/f+gGKjQ7G7k7XGxtUsg296OCFuqfTuEyb
	 Fmn9yW6/1w8sdN/aPq1DT69GoIXb6B1q5PNcU5CNFLTv8HSSzLL8EOgLw4NgtNQ31NzpO
	 6ET0Qli9UFEZ1IYlt0Lh5jQpiEi1CAc+vJ80fTM4Hs08s92GWLD6YRWk0wRmpWvXL1BM7
	 42Vh/Rx0A/TCX83KUCuHxhA7iHq1iYQVXtTV0sw9jHuEJrKovNC/kPCcwDaJfxi2YBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459123;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XtMDggZfqhjPnyTNupsCm43yB2IJZ6YG2yl3RHMdJt4=;
	b=EVh0We04lQL3xzU1UbyNrvXmHnhdpo5efMY3nrLLNJN0ngg01Bs2fGbrkQ6kFr1le7oV
	 bpCDcJ0nr4gSQiBtVVXObHQLymqKfv5U8oz+IswoUwNN9Kmjerwmq1x4I0lv8vjYlkpHO
	 /OJSO+86jj9MKbeAylYqO46GCojnYyi8n8Gl/GmKrqLmaXd2Oagn5WbhZjXk29/gzPZgf
	 66YLoRUQbye+2EfMetiaAG+LLsfJdj08DNlwOgNwvNw6SGxOgfcYLyRDSmgCaEZIqMGAZ
	 evAUKmu9DiEMX6Tes2BOhlVs+8pA6mSyUvWPX2EerWnc0M11Ba2oyq9exm3pstttWnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1F9FF1F00A16;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459123;
	bh=XtMDggZfqhjPnyTNupsCm43yB2IJZ6YG2yl3RHMdJt4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=doFRX458gkudCiN+ETuPMtFxFVNQ8rEE18ZqEZIdbTR9ZDYhwZzcF0Cq/u3DdvTBS
	 0Kdw9G2V1Eb9PY+5yd13FBjQAwDnUoVw9lJ55QRv3DAF1cczcdFL3mF7QGlV2jUh2z
	 gaRMNqXcJs8jyWZ0yZCSxGjKdrMLYqKGPXvIBl3XFsxtsJU85ByW2eI+DSSuUUXxhZ
	 3aTXHxzPUIFNYKdy6aZ4z4ym+kGjiKWWr6QrVS9GPgUeP0dbhSCdBiAcbl0bNJo758
	 DlgULccL5ZeakgtJgpA+lqbaPH/fIyP6Dw4jVsNUI3pabTZPjXTI6xM5W8iifkAfje
	 bsdBoBRtDneZA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8569D45F13;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:02 +0100
Subject: [PATCH 05/11] arm64: dts: qcom: pm660: Add node for PMIC VBUS
 booster
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
Message-Id: <20261031-pmi8998-vbus-v1-5-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=p63Dg9i1oE6P2ODBJ4VzZiAmk+f8FnNEbY1449D7Tf4=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOveGztyizkzMKlhhMHa6tPLFDLf6x7vnkdn
 IKLLQdF3R2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 ck2pEACiYMmrBoBCQJrpMIg53wd8Q3hcKdPXITGKL9loBR8pjG79vwHd2ofjQCiCMi188so6Uhz
 YLe9KjgC0NOipwW0ip1eR1J4okOE7lo4QQh5wkk6Rv5MYp0vDnaqcSlxWQkhSaiB0xxOcLqRx/S
 TLiofbrNuaInNv6r6uKg05U9moaSi23jrkjFZ0EJru15WMNp+JsuyM5y5Lo0QDn5jNnm7TbqI2H
 olwLupTVZXqwmfOKGSoy2xEt8ecZAH5RsUAdacLm41fYpGWuh5MZKxj8QCfXzS9juM+m6hYFrN9
 BDfCasROXhdMOpcq1W+LwZEb+QGX0mYLGaelr5VWaBPkBTBX8Z/7QoEBXN4eK8NEMDfCde8Dx/i
 IRzVK7gV5RoV8fCdz/S/OwHVE+nzHDtLsIUNEr0FCOv98htYCW63y2uFfBLCmNrxR/xet22rZHw
 BxEsluh1hjm70wDdxbYiodbMje+oBCJXXLMAzK8fdnYPRdOBeHha9R6QtIy/5bak4FlHiN9TLNw
 1UTVQSHpNWQehjTjC0s77C7AWn7jH0PUmguHnEE+gcZtWg+O2V5HB83kJ20vMzpLqZ3xCMo6DsJ
 jYgkX0G+bxP5efObUzBsoWVpupJWJbKN8iuJ8ihSzEbxvN6fTWteKc0w4EDtu99svhTEPq6eyMj
 Pdjz4JoMgmDhRfA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Add the required DTS node for the USB VBUS output regulator, which is
available on PM660. This will provide the VBUS source to connected
peripherals.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pm660.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm660.dtsi b/arch/arm64/boot/dts/qcom/pm660.dtsi
index 156b2ddff0dcb..86e9223ed88f4 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -85,16 +85,23 @@ pm660_charger: charger@1000 {
 
 			io-channels = <&pm660_rradc 3>,
 				      <&pm660_rradc 4>;
 			io-channel-names = "usbin_i", "usbin_v";
 
 			status = "disabled";
 		};
 
+		pm660_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm660-vbus-reg", "qcom,pm8150b-vbus-reg";
+			reg = <0x1100>;
+
+			status = "disabled";
+		};
+
 		pm660_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
 			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
 			io-channels = <&pm660_adc ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
 		};

-- 
2.55.0


