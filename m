Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022749;
	b=mDgfD/wD8alezkoepJYRmh4IHaG1yA0yPBq7WxnB3cw2vow8jNs0ywjsYJfKwnD88cWL
	 5X5N0tjyYgRgL8ba9ZtIRR3iNTe0l4i/7yU+/EEmwZoqcWl+oCcC/dQ8zh2UUv1cehzNt
	 qGBFpZJMMFeZSYTTTWLoB6PjGe3QOVUie++JzteFAg5GvDHPsJ3iY8k8sPxPGlKuNKrBU
	 c6SgFudGlYl+ulTqqmmjtbx3CjognXlTpaOJVKPF56etBpq/rA+y0kXIFJrPt2aYMqbMP
	 UC6YLK8PAr12n3eQUWbBdL8pRrDuEH0WLFHMffEMSUfE3kSmVLyqBFssJ0IcXpKUeSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022749;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	b=j4YRk1kRcl98/GmeyGI8Fb9MkdukpSi8AqbQOijIkGxQPceK2qKwaS00SXWRNnOeHRlH
	 yEPm/kRM7zAbGReyoc/MNDEZKJtNG74DlEKAKDxvroCPuIwroSFF5Qd+mSqJw8Zia1flz
	 1C4MVLNq96obqrWsEbIVfpvU0K2teyRbBztvGwrb1CMAMS6YcltBNhbKxL0Qb4O74tLMH
	 +g/nw2/PIzSNHHRedHaKsCgf0Lza3bcuoy5QH4XkqrzRuD29P+J8sGOG89wa1feJ9yMLC
	 cD3OWQlANB2zg4wmjlJjLrRzoMKmlZpR9NUqm71U9scBpEKiChtle86Aqhs0ab4WSOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0RBDYdj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4B660A6F6D;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0RBDYdj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022748;
	b=qKP6GBiqLsn85Oz+8p2+kvdDDHeZupBrf/8lCv56PLtxAGhmGERfeP/4VM9br8nryVUN
	 Lpt3mulsmKv3O6nPJDh2FWiRoFiYmLzgN+dyBKyjaFA8x6TaW9DJSMgdCWVuQ81IYPzKG
	 D0eau4L858DtRLePaeQYH2mbLiJuIYXMBp9EG/4gWRdfKSChB5enhTYoX0jWGRaQt2A6p
	 5SGPg/YJB63I0hKtMM1uZiUYko/xKMZ4mOBVqZgkc8gR5//+5cdf0ZBLSo1BDuuJQJ4Rp
	 LqWzQ3qjaz+QDgLdnpVaTMOdRrI3TE0duMRj/6de/BygALWgQRD3ZWe9mBb8UUaFqPA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022748;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	b=rUmgo2vl/K27HuMTZu75HrXPHHztwqJI5OYk/3gmnE2pbXW3g7iY05PqJ6jjSf3qjKlm
	 A22RNWs45CEYzdO9I9HunU+WM7nZNb4LnFJ6qClqfxqs+Eu5SPX270M93yfYWbRPVZeW9
	 1Zb+oYIdO1U17URiqycqbt58lwyBOoICSwqZBvU5QDmU2NlXbWh/vV5H3QWmeFFzC84I9
	 P3bUMoBxiUoyge4EZVhpsLMeQsHM5Jv3/lbmWApJGAb9OOBfqVfvS4Z15qyNCVAWOjI2Q
	 eNmwHubSHljAzIPt144+7qSAuI0xA+UpdSIDTtp2Q6678trQryW1/jfFBliiCvMJPEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8AE3C1F000C4;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022748;
	bh=l6BGL8rq8PAzR3QRqlSVv7W6mCHD1s7S80zZtUVkUDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=E0RBDYdjktsnIZeYJ5GbhDsP0V3Wns68GyNF4Rgxan1uMd68MprquMqOaY9NRnGOZ
	 ilFw/897VQzClVsYayj8xZsg1LI1gTzEn9lE+iA0qwbDnxJtKhoI+gchaNiemj7yxU
	 qBlZ7oc1emvCee9avAw6qSAjtKgHEui3fk3Y69KUntULLpYJW49now/KadEGmN8aCj
	 s6G6+yHk8oE8nsCli3XEtmGYEpsb4kxdul5icYT+N8FO0z7gGoZbSC/xizlP9bFayC
	 Pr2/zQZULLrsBtIOmucGuvkFQstjsroyQ6zqpoRwBzsinFOcBnKUqrdbsQQzhLuzYM
	 zCOb9xuVmKhbQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4E1824AEEA;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:38 +0100
Subject: [PATCH v2 05/12] arm64: dts: qcom: pmi8998: Add node for PMIC VBUS
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
Message-Id: <20261118-pmi8998-vbus-v2-5-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=Vml5iGmLl1DRnRJN3EG4LOdQ6VYHu9Isno8WfrbJtu0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XemSzEY+u+p5xduVbCY5qO/O3Aygrw5bOq
 QQpsVQYqa6JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 ciI4D/4wKee+VYKUNi3UFoP1r1oc2tDloP/9f0eHvYdr9US6whWYCtZO12lCJZt7H0kjfzTaMAT
 MZ6CImazYP7oAkvqTC7U/mHGQHlbq7BhA4ECOmrGf4O3nrf6d6g1Yb1GTc7JouReujrPDSvbAHW
 JyiVliU4K+kmXCpsNGxd5W22FdKECk0aDtBmQdc2XEdY40WUNLhHVpdzmeANyuKdxJpEZuKaA/9
 sBKsxxs9vX3lIwSvuiLLXkB7mEnx0vGiX+W7GtLKy/3v7U3rHTgRMxT7HoKx5lAcrQVRwJSOje7
 HRX6j4XCw7DJNwmXAElrSEDNToJ+HXnyHSp/yIF6XBKPYXcoCEBTi4w8DNkRWcQI6D6lrYySIrk
 Kaq8+t2in19t/0bkBJBBrOtDb0yvb/ONQxQVE/rnSp20n3WgYaMjDhSuxr4M/4VLPhYMiPn5S3Q
 qQL4SmSsrLTmHV3n00RQ9czrWY0xaHPQ53nEUock6gJ6cd4QCsKzjK8BpymR/WqEDwCbzmFJRCy
 n3EqMcuSB5EqClSb8FZubS/tuXAEdyGuGpB0KDvMPBjypgGhW87k2zqMeGJ4ERR67ffuPh3uSBa
 IMmQQhMIczBkuE7fWvK+O8W3iMKazfyPSFTtsoesA2fsP9Gqb4Pja6OOACqYyb5GJws1v1forux
 XgwC2A8he5BtrCw==
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


