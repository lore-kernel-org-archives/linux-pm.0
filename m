Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300706;
	b=Ch3YCKTsQ4KpiWjn01ZWhv82i6PSq52oprQxZMqV5YUNNogxxf+Fn7ckNxUPh1krumKP
	 EO+SbX7VoUDM5+LnE6KecPBwesbqspZQsvnHrCOO1r3D1clL4tnhcXE+IUzH6k0KW2zvX
	 fgJsWN6EsRs42JS2UKfhLjteABuwVbVxGY0zpMX35bQg4l6PuZUqUoRKd+r7aEAc8U8Nj
	 IYr1FrHMmbx9TTVYvyzM832h8HAs/Q5CiOBT6ppTH7vS1ffXcGKFzSJoMZK75EwhGftN+
	 2ixbK+lNSPTo6OuDU2jiwyS1QmF4dPLjNoyKECHwVOdu8licNThDX/Xwawpq9OV8G1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gAbAToIsQ+0j9VXiUtufOIftnbiABwtrIObzAajN3G4=;
	b=gQCtwzvnDmz10Js8AFnIm6UpheAVxi/zUVeic6p4u2/Zd+XLpGTN9ut/6grZj1QMPzqn
	 jixY/qqb8wx9O+HxK06w+I2YlX/gWkEh0uG4OVzoCAGnzNPjzR4MhifZ0vXBOs4zp5UDO
	 w42yRqnD1oZcrUrOqPoE51yw4cIl1SNXvIr3TTzHxaD+o698P3sZVtkEGLqFQnLVV2M72
	 2BDQ1h9LMe7QMnH0ekRX9jg27RuhFF/fzbRAwQxq0sdZbmoMjS59+TbTy2cqeHd0d9IST
	 W0DJXKUc3ba3LI3GKCXRwlFkgyfl7BtTNLh9yp/8rfr0c0m8vJj6VcG07W1DYo6kLAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogQHu2bS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36CD60A260D;
	Sat, 21 Nov 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ogQHu2bS
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300705;
	b=J31GST2lGbfYkj1UhLNe+AncTCjJVMuLJucRcYLmrS6pNjAccw0aISy+9iE1uWRNE3lg
	 UU/vXcX1WEqfTLZPjUmVKSnd/iuUTqCkInODCr7JcmhGZPfW6V2vuVvb2d3/MTq3R9+zU
	 GL4bZ9fvPpWP9hSjn/cfcmMByOCCm0QWDFhRJBd2qCK85xSZtx3fvh7AY5zZXFk+b11wC
	 l8IXHj41zIPH+Kf7vJOVBnJBMMLx3lRCDjQgfbqHm1KpWABF3OXZPpCgd3XDul1uGVecR
	 n2/xKGroiJSQluXsOjit0eEzLgr/ZY/couKLVd0fAijQSJb/HYE82nso2QmVXX8ShAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gAbAToIsQ+0j9VXiUtufOIftnbiABwtrIObzAajN3G4=;
	b=2V5MsdRskhJs93lDD0KmB1xTI3Dmct79SBc5c9/NtPhkTmmr/MVz2FKkl3hzDoY5bTXa
	 hFxMCs9wKuK7CX/lMxxLnI/gSr2feWqgjTvifVaUgg4yjcjgL1/y2AqUaA4jQMveafJT/
	 DR0t1T3k24v8sbWYV1fhmYYm/ofWljgyOMghCmANUJ+/BG3SjsLau16EjyT822kQjv+VZ
	 WXcwsYAdDppbTgBA5nQvUT/B9eW8QXqbQCBZSgOjwPLHrEga01MLVtkNlwHPze56+KadZ
	 5HcS89YzBHGbd7ydnjpBIj0lH+a5gysTOFjpaweG2BVy/m6kXbW84YFNhQ+k8c0hWRg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4609F1F000D2;
	Sat, 21 Nov 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300705;
	bh=gAbAToIsQ+0j9VXiUtufOIftnbiABwtrIObzAajN3G4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ogQHu2bSAY/3ORL4lrjvMsrDq0vCmHNPNIbZ10KVnFn7X/O2Megx7SFyRgCSszxsS
	 WDjDdL+h/e52VCs/hUYaKmtNYJO1+m07KT7fto92Jg6ywuHki5frSRCHz8YOcbxK/H
	 F+oP7oCM3A8l4CHnYGiyBXdLZPk2KBwRzEQnNuhFJ+wWAD7Pjglgf54jWd2xHZYYPI
	 PO11NVJhc5chFfk7SEcgfHAXnbLJ0CJLFclKqKBkv393bwwfCp812vOA1AxnzGbuqM
	 56nNc2lWiDqP0iq5jP8+KnFjP3mZJ3N9DdRCIBW93umH89Lbp70plAHl4FjjnW2eMO
	 0Tzxr5gUND2HA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 10F464BE52;
	Sat, 21 Nov 2026 22:38:22 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:06 +0100
Subject: [PATCH v3 12/12] arm64: dts: qcom: sdm670-google: Enable vbus
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
Message-Id: <20261121-pmi8998-vbus-v3-12-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=0IbEStSfLNSM1QUREHqUTMJimPJpvyfXyF3g24sL/vk=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1bwPzO73tYJW9ij8DdCUY7TsPYtcbxhIJ/S
 urrl9Jcit2JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 chO9D/95HNsmg7vFye2zP53Jaq+wUUNLeTZQV6SxXZNuNWTJS+f4ztho4b46eDk0EUxVdppNjQt
 8OQcpFIdo6eu9K2htn1LeQYKZVGnIEcuXPYxkQo1EB1W1a0c+TcEcgEilBjbGj+rk6JneyXxdE9
 JGmQJHUVQG/KQPEeMp0QoITvRkLoUtunmO1Kr8nE3atAvrmYajCbx1WSQK0OIj2RaNZe/DMdl+1
 qBznvzWl1SHySvfbxCDM6Jv94r5fCEL/E4OBttX4Cv/H7hknrAisdx6KZMPn1fpgjwrCbHhsrns
 iGGwAF84ASiVKN7Y0jWe7xZGjtOVisgl8NlsqlBRkmcsA3oKVIlHeAHWvQ9px76u9I9ymV70Xw2
 aT0z7HssjONp/uEcmAe8TFZo8W2/RFqkpQTUnLIZyE4fLdWeiVL7vt6x9cTkzuKhKuqu3xVYLMr
 Y+hP+UWH4Ij1gwv52dyzuR95kX43HVk91k38sMMWXq+0Kn5k+TCNJlIBRRWjW9VOJGpvbUjeLPs
 RwPOwme0n5fTfq8vIjF3N0gPy+SpycDkf8Bj4kvFprYbU753fJ8wpvhk0JfH1FNHpLfoIe3W6jt
 Vqx9jEtJAZ/qQwnFyZ4EFQVV+XiYRkV+69OxtkVLrl8NW5K0qBkZidPtIls/VtUmrXu1NtO8kgl
 8Fra5C6wkjF0qqA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Enable the PM660 VBUS regulator on Pixel 3a and 3a XL.

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


