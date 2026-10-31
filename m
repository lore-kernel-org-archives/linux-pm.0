Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459126;
	b=TKYalsKCb0+IhJmEMInyKwiip8Sl57J4sH8FYhlCOAO8hT9kYTMK+KyzbBRAdlTDdraD
	 US8LVZljRZtcEYT4GDPejqGav9pjsIVWvL/pbln9PE77Du714BPEdAi8CR/Y1VmrlHVCM
	 2R9ogvsRL/G/OvpoApJPFK6peeqNLea07oA73XElWkK5t0N0EAJVK75dfgDqGPMqptTeD
	 KnNFviADD1KzsmpdOZoNbx1+EegaxRmG1E+BVzMi9I+ekY+GtIGjbrjJZ6Go+iXONDHWa
	 QL67PV8uDicsAJoBYD3zJMkXtVnAVTSdw6OmeXssprBoaVN0PSF/VwFZ+Xp055eSaTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459126;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sI06bW74G9Z7ZLkDfxO0vwt+rVibvEuX0DC37ZaDPXQ=;
	b=eJ5xEnoDppOli21tqUB398QDWaNNUeqqy56afgUZWkLlJK5h9ec0M8gbrWM2mYuDrcYZ
	 rtkix4DCk/RCLLqH+m5DNtgQ2iPuM0ct3el4SFCXGGImFG0jXSD2w/ZodgcqCrHacdp0m
	 KW+uYbwR7QbYG4dBlUZMmvpnXLxOFy1MeoPk9qCmiSG2DrsysGa/Ry+fJeyszvlO9Zt0L
	 51vSmrjWePByG4JtL/ZpqJwWU5I+Gt0SLHfwvZz1PX0tnYLzorbKJ7whaoR/bPYJLb6aF
	 JeBO53yvKHxt2UnXqLIFMVH3z6HYsauqGKezeieJfNv635cpWOb54i9BY8Qa1FIH8XA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4rPuSWQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C202C606A33C;
	Sat, 31 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4rPuSWQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459125;
	b=lBR03D+KP/DQEiC5OI6ApLsMof/LoblAemj6Dc6+Gzbq7qh1sOyYwE6Gr1DZ+JMGBn7S
	 H2Y3FUkP13pdSBuREDk+x0hI5zaH6gi720d+w1ddnDY1JDHO/ehatIHdgH6d02dvjaCTG
	 eDYTG72XKXfcg7yzP6aGPKtcMTILdp7J0fa/dwuDlpeU3zeUSREj323xFE5Tbc85T77hY
	 vrMtTHDarP+Z0ZOy44ef64L+D2zU0aJAywBa8vbY68hZqZdcrebnbhsxRbQ9VfVBrczZX
	 9NK3poz6gk9ui2wK95QJB8xYT26/Z9659Pop3UYszH+5tmkeFfVhfQIDRzAC1LxRsrA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459125;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sI06bW74G9Z7ZLkDfxO0vwt+rVibvEuX0DC37ZaDPXQ=;
	b=wuEsi9x0jtaWMKXomc7R9M/o6lDOZN/KADJf5kjwpVisKlFzjlrYL6kducUbnPq1kETh
	 GFfbQRMtxDnyqI0yJeXetyaCIcw1Nd8lVVzUZwZdVHPkHVGbuJiAC+vqfHYBSxPqSlnOQ
	 jvDPCOcs/UFgdqfaI3UuMrNGU9Izt9AWIANBgKwKtMCOteeHAc1Wbc/ylC0emTvDiC6oC
	 UioiAiGC9cQiVCvq9mRukY9EsbEbZazaXbX4zIC/4OsHvviDVarFF8OyuGN2/GjznA1Fk
	 fhbMhIV62MlP4KFFfyA0W4Q99+cLjrIwBenPVXhsY43KYwWG0QkJrc+gIuaAsvtECBQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E8E5A1F00A1B;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459125;
	bh=sI06bW74G9Z7ZLkDfxO0vwt+rVibvEuX0DC37ZaDPXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O4rPuSWQ21Lim6HG0aDpC6AAd2btzqOGuk4R3/e1kbLIsrel8TNYNVAwStHdDxn55
	 e5bHd7ySAc6l2iPzyOpccIMNVXkEoVwJl+n/GnIZELYIhQi39m6GpkUq/fnMk8vwGG
	 mqv8zV13jg9COhT9MuGCU9fzwEFdKmjHohYKzEAB4ljb3b+cvhPt8OKxE4v/0bgbRX
	 Je+Pok5lv9CdNsmEZt9/1BKhWkD0dMz9eP+veEZz+MCT/+38C87+qWjs1XGXpexjRQ
	 8MEnMaLLz9UOVGjBJWfLtaAeNLibjYMfScJxHAFHWIFQ3xGDEbCgvntX1Zrnlt9RvJ
	 ZGGJcynG6kZBw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C622545F27;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:07 +0100
Subject: [PATCH 10/11] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
 vbus support
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
Message-Id: <20261031-pmi8998-vbus-v1-10-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=pWeViIMDuSNHB82CtRWxu+MFw3oz1VMoW84oZxyP/2s=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOwDXKqQ8GqeE33K9jzyYozL4KpVaQSmgjMC
 SlPBy2X4XCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDsAAKCRBgAj/E00kg
 cnIoEADOXThUpx81FmPowhpVnT4AmAQV5ohbU/UVRbX8F7H5x3qDJ6YMCR63duwlG4I/k7NT+ry
 pfkUruPpDT4LNFSRr8Wnft3cV6PoVFyBTssAXZGlCU3UtCgCRCN0KMh2GeX3hkKHTcDfDDi+a/Y
 H2Xta4xlfbvBbZGx1C0GKrhw99Zq4jFft1xwZxxn1KB/IE+QRA8Bd6ab1ALJcOMfWoRAQ54Gxwh
 U3ic8rqPYj0lngXuDQYNq7QAlJ3YamomPZAR0aDwAjqSNEkxOdDFjtJ76QZHqiHBhnWbl8a6Ej6
 kTGJJ1vP3eZsabwmRur07ASeAcZObvZLjZuw+tR3zEjAILz4Muu3aPB0a5DFTsP1C616XbHYNkv
 YAAbvso/vLyFh5Y1VcAc5kPNnEeFW/LptOoXnHK4EJ4ZMZlmnv1v3TWHkyEcBq5FGUGajEWRL0l
 KAEqiA5qZpIRMdFKHSJ6a9k8DgDyZ9K/BybROw5hiPEW/Wdml7yvKbq1KJZOC6UBOwkOEVfzrCG
 kUhtillWgy2uHIF3VStA3+daTD5ebNWwAHFHS9rz9Zp8P9TyOWuGjDzALCj4SF0CpKbmwUIkdpG
 52ucWu0qWw7b4GdM9P+sD1AXqXnCHW77CqhwncwPnNjNGlDuLKtrs2hPiTO7W8VKT//uSYnHcYB
 TzBBENIy+iGKCoA==
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
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 35babe8c5f757..2986693b3ed71 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -414,16 +414,23 @@ led-1 {
 	};
 };
 
 &pm8998_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
 
@@ -678,9 +685,8 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,calibration-variant = "xiaomi_beryllium";
 	qcom,snoc-host-cap-skip-quirk;
 };
-

-- 
2.55.0


