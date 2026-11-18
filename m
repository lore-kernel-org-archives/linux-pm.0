Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022748;
	b=cnZ/4veUFqj/+grnZ/PTphSQC1ji64FSgFojMHU9tcVq2H4FceCsvFG+EruC/G0+BJK7
	 g/Hnkbrlqc8WNdx7u1VNEog+4pjVtCAiSTTjncb0quwYcsqEhnSIeGm199lAPjJ9O6fsH
	 o+EWrXpuDIuWTPrM6/BVcUu+0X1LPxAWKqDQHvoCM64687vWk2Ng8Z1Q5UAyUPuBXK1Ic
	 zszh5f7PtGUciqguZAL9W7FjfMT+T9USgY3Id0IuRLrWG9tCQwLayHzvIh8GU0MvSM1uw
	 1dYVNR78a7MfIFG5mTCQHBgWVDKghpIao8qrVoYgfrIdfjx3HvHXO2HvQzmnhz9FglQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022748;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	b=KAEoaO5nGjbx+wOZwhRyyrTyOU8OueQaFvhnG2LsOUAXKaGlJnXmIChTmAnlvrxV6Yr+
	 LupeoAAD9OmeZACHHTdwbsIpkov5WPVFlCPaZgmbnzT0nDD7Ng35LlztmvOI3RDQntw2a
	 iyr4ifOBq+9sypzmx24wuX6jfeefypwIDgdIUUo6pvuMSIfFEVVSJb08BXNRODRajR/GG
	 uXxnCoZFY3nxod8t8wyYAqlhSO6rlGEihFJvVUtX59RSSoQ4pRPqM5BChVDEq2kU1qfdr
	 7fAi8fdeO2yziqeMGpXnH1rODJodara1+xHkxSKg2Rs83G01BJDdyVUlbhw4ZBRNQ1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwYfQ6cR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A360A3832;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FwYfQ6cR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022747;
	b=Ww/+dxbJ99RaVDIUegQUmMOQdF1LKJO2mtSof08TaX8hfp27jC/tE4SPwIAsenb5KBGC
	 2UfaDPzfG5zl0l3yNARy0sSy5zeyKhJ9TXWLS/YjpVCyOJazLhC1lvI7gGjERuGnQXZNd
	 HNHvLD5zRFbYyT9/wYEwfo2IPV4RqhbJ6iP8hZukouZ4xM6EMBI8X7OqInxG2bBfSIkd7
	 0OPecGkQh8DXOrWHzfUP+sNwGuxhsCsOg9rI3RemQjZXaqjW88uzwdCFxYrJB+fSCyo15
	 ZgayBoKv1C6BxHswHGWlt2zzGBK1y1Ut3QCqMt+44Ma39R/ree5UbhXtnNPdbewiJmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	b=MPySBWdH3Hys6umJ/FjY3jb+sogf/YxO9NY3fCMAiSGh8mIxf/VNLpfOtymD6rTsSWTx
	 kX5CBhiVSpyFWNzMYZMLdNbM5TGHGukTbdxo6P7CVBxtT7QVZxczHyo5KCQu65y8vgRWz
	 JIKlUEOMZW4SBaiaJRThdTwpFTpflgN6KybWvnKbhtwNHeYKKVm3CuBJxMSJOiqzDX/Yc
	 CUls+9ajGnRAYXAFnCnHOsVJFfJsZM82yJ1X5IQc1Kz7IUe8ca21JIBlGmJdh2LI1V0UH
	 dosVzQFnYuuCWxFoCmBKXWNqU7WR7v1XlVq9TDLSx3GO83axWUK3ICGJ6TJFZJIQFKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 34AA91F000C6;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022747;
	bh=k+6zsmvtRENf7Mri4E14HPcjVt27QJWZ3dorS/q0bNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FwYfQ6cR5fpOEwjTYzu/jj/Z43MvnFiIz+8EZ9V0gspCKJa0A4z9YqN5AMOlcdWA3
	 hFhkEjnwxqWvDtj+I44T9NF6d+ld0peQ6J8lqHRTB1EgxM0fuZovFHWliR221ujnvb
	 +tdPVCzeO6dd+RuaqQeWVySSUSXSJwznWSWWXtyxG7TvedcGBzGf/ghMsXKO52XkuY
	 gvBRm7Pik9TZE8m8FvWmPHLrTQ7/E+zzqotXW20XH18WQqKFEDfPAJyOaZ6BoWaRcI
	 mG5Fiwjdk1JKIMFGi7XTF604AuGD/IgFelVDDt8hZPquyWEy6gPac58vjmbDpDrnI6
	 92LXW0vrkAFug==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AD3EC4AEF9;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:42 +0100
Subject: [PATCH v2 09/12] arm64: dts: qcom: sdm845-shift-axolotl: Enable
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
Message-Id: <20261118-pmi8998-vbus-v2-9-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VGlvhzohfkCXo1xrxHnzPQfZCT11uvlRraEHS3HXGX8=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XwLxl+WCziFjoZ0PJmkLg9vtrKNVnyVPw0
 64Tmv/q94+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cqLhD/95gZDo8ePIqSIOKZqyj3JHXXnZP/N7/30MxPUqZL8ewdmdsIwQp361cKZl66xHSVr0ORr
 8zAFkEllhvZiWCOL23y0CSiX92gDE8bXajZHqDWr3scdSgikSUrRfIOWM6jwkE/3Nh0RwvRRBs5
 OQUqxyz6F7ChzpNX8QlWuOTYyeKJ/jYGAcdt5RWj+Qgvq/Dh09wTNJyvjtk+8qUS7UltzD8yVKk
 2bLqCPWh97niYRZimUJcthalKOFhLInbJwJPZKHPTwIJyBJ8tdXocZSe3jpW+IP4Fk00ZJMIgWB
 XPc1MKDY9CrYlzxQFjSJP1H54GarCclyW9qWwFDcnfg9PNDawrCmv9/CpoxHPyFJIRhOQijqiqD
 DAGPQE+ozTBCIvbNot/7xY33peECkoXl//BTg9snmTSBoNiiUcg+ckpTqFn/ntw3c2t7ybyAauE
 WkhcWCCaRCB4QZ/Alh/WUAbYwiyGmMsZd9PSI4fHGCNLtK0WcftPQJIf6+uh7BtBEtTfSvBBZz0
 c894fYF4Q2lAw6uE8jDuUhgnPsGICmj3UkqYAUYoFs/NVw/SbWIhznI4CRKX4vAl3jX73A21tOd
 xZpBNu3vBMQEOM+uMSOvkgNCS3Y7upmy49u727Mykg4aut07zO2mCP+xBSAgsP0CWjsdHCjZGKt
 Os3JvI2DkfaTQqg==
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


