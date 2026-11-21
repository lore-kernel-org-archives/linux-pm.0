Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300704;
	b=yiPlG0N1Xk2JP+GwsnU/6ccHwQr0tmlp+Y3LTrOiqUS7uZ53xQNt58NvGFuX0SYbGchZ
	 Cesn1dW3luUnxr3LCLNvZxEqZNgxgBmUjYynn19Os3xcWZznU5R1gGZ9h1lDZDUV3OSt7
	 0b1KqHWYysQdenRZ1eK1RseAdf5QfMcqHoQqhfRV0tkq7ybnT1rH7yQFCncWc2baU4QZn
	 J4e7OWStPYjZgybyegU6wAIIlyoMfdaM1+rvEDWfc2NILccYm8rVQI2d+8vSFZlv8G+oJ
	 v+/gRHok8xaLBwr0NkynSoWW/cpQYkaCPT9wPJp/wtn8JjFyDkh2gr0fMwG+eyZ4ZWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300704;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	b=rQ5YxOej6ohjVpfP+t1JgXro4n0UXDZo7X4G61f2np0tKHYDvodkKWXjUwsgto1m8loB
	 KS6JwQtNkfyoNLUqyzypx0EdQYeeQMPb9EGnBfoz6iYGJVl7rxuaFdBzfBdvAPv2z3ZME
	 WD7aKM6T4VPNmHHUClVlyWCkb5qHE6mNp0kd1FD/EKaz88XmtACnL3XsxErD++nHtiRTD
	 QeiS8VsuBsS8RVReoMlllYffSHc8csgfiWYwJsGQ5cN9SdyN66hCrE4Vlq6EZhDezK6jl
	 g9VhSyrxFbLeRZnsak9uBNIMLoyXHxVugkoVxurPRaV20FFDm8AhzXU+LScIXmhdgwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFbA0vYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEA606A333;
	Sat, 21 Nov 2026 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFbA0vYY
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300704;
	b=JL3/g3bzZDBlOQth/7WlpPiPSGev0rsa9sKEL1TUPnRzeApIvYGzghv13BfUSeS0AhyN
	 E+0UyPnqQnsGBrsYDNklcgyyeqH8S9+fNA/aqJS5liAjkl9UnpcW9FRpdU/LUPkFc4Udo
	 fMgAZvz8ydNZ7GP0s0SphHNwwIgZxIf4IFKCcAZUTxN0PgnQiyt1m01FQ6RdH9rszcqxj
	 aAjkkGvZ2yg5KsQc7DBO1IiNsGHiiK06VOfB059U6rjP6Jx9wCcsxaNjH1bCwnw4WWloK
	 ks0KCXhVXHiLwhAh5jrFM9bJVcOUzlzAkH54ZCM7vr1Oqr4cKQki8e6XKlr7psPXSyQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300704;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	b=PM4j8f6WhZhMtzotVv+Y5IWAi8mNj/rhTZgFumj0NHq42GnFSMSc8fXdK7pHndoq37PW
	 c0UJcpA4uFUmCnwIlV68x1I5BVcoESltsosjzezpL8QdtVmHFB1Ir5twJYhE8fveW3gvM
	 d0qNkG8FJYxTg/bTvElJVFaUh7jB2mRyEuBDxd1iBSzxc18U5laDazTu6kBh3Qijrgord
	 pVMCIOKOYTO1tgpX3t+OjskDE+0DYPquuQr8RoAQKUwzhQDngSLf3xZ9nq8yrVYl7fs+1
	 S6SD/IZzCYhZUlVyJ9SJO9kEwwhmd8W43fqAyAh7+UAoNNpt56rnJJqeBEPnVHwKTjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9BE241F000C6;
	Sat, 21 Nov 2026 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300704;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FFbA0vYYoMa40IYKfgvCyFo+rZg/59nzWXa65EA1woZ4nDOazGt5WUyaVV6WftSb6
	 +62dMH7JqO8xvMe+KecEYfTNpfBIl+tRC8xl2jpgJPGCuDYDeRP+OLSXiqCg9sPYgI
	 xpifbV3pSDVxh3S9mF7F6NeE5HI8+dvhSTJ4x6G5yDOxeLRqJHSAngdkF46iEM51yf
	 imIDcywsrvL1z8RsvLN9dj3B6gbvy/+TLDNY9HhVHXs8Y3egXRg3hefTH+aLK7aQVg
	 rDkdUKbQus03G4tJ/G80MXANzcBj1qB9CQWyo1riRbBAfi+MU8x1QirJyiw/Qrn6+1
	 sKUqigHC9viqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 46EFC4BE36;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:37:59 +0100
Subject: [PATCH v3 05/12] arm64: dts: qcom: pmi8998: Add node for PMIC VBUS
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
Message-Id: <20261121-pmi8998-vbus-v3-5-91ba2e61a877@ixit.cz>
References: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
In-Reply-To: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Vml5iGmLl1DRnRJN3EG4LOdQ6VYHu9Isno8WfrbJtu0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1aKQWMjhZcoN9y6hROnpzIFiqFXlRsbz9e2
 1MpJAixkXyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 chskD/94I/rdP84yvgfbaab9bWAmakCcY8OYFSbMDRGom0caO91AVEAs3JSNQ1+PTfcDbFbIi9K
 /ACpKXVq7zSIbRE4Ybr+4NkrMShnKgt2KrbGN0m4xsz9fo1OdDEzDmEBXJH1LzG6dySkD4wS6oF
 DFVhjNsF3qcPiSUKRSeejICpsIiRLLpK+Uyu2LYY8f459PWaQklilhfvGUuNcw/nyE7Z0ldXGpJ
 mgTpFgJ/Y3SHb67B3lH3tMvOxFsiKCPdEdw0Vygra40qUULPSoP/wR5em+jkAsKj35DGcdj5n31
 ya/+7rzuFqdt8eOir5fw9Y4ow7Z4GGwVNERPxs21Ra+JvblYzp3bFOT4PUPE81ZFXXZfRdAkBw2
 QpqPjAN/SpeVLW38qPmddUJe6d2MeQoz+czQ5nXWpmwbP7VUlL/1at0UAkq4/Bwyf04tZGvzIW3
 /g1vSeQwdvo/JdkJmEbSeqaxrP0kikKWQTocxDQ9lMWPzM9EBFf3t1xGttBXpLRXr5E7Hf10GQ1
 TaWipOdoO11wbMBkFvn3JS4QB6I9MX0tnLEjWvOGVzzpbLMBXTxV6jWJHMIN2bD5teQLVaR0U8Q
 saRmOR4LalqH0Ux67UgzPMVmQBFQmExfU7mpvdWwdX58Qa11NvuPc8ENzbdfDdBTGWPYcAQn6VX
 szNOXLmmN4orZ9A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Add the required DTS node for the USB VBUS output regulator, which is
available on PMI8998. This will provide the VBUS source to connected
peripherals.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index cd3f0790fd420..9d65dd4abcdbb 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -24,16 +24,23 @@ pmi8998_charger: charger@1000 {
 
 			io-channels = <&pmi8998_rradc 3>,
 				      <&pmi8998_rradc 4>;
 			io-channel-names = "usbin_i", "usbin_v";
 
 			status = "disabled";
 		};
 
+		pmi8998_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pmi8998-vbus-reg";
+			reg = <0x1100>;
+
+			status = "disabled";
+		};
+
 		pmi8998_gpios: gpio@c000 {
 			compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
 			reg = <0xc000>;
 			gpio-controller;
 			gpio-ranges = <&pmi8998_gpios 0 0 14>;
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;

-- 
2.55.0


