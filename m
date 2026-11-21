Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300705;
	b=RYJtbq/SUlydsePLo8RflwHveU+PgptKZjr1ctiQp/kADbj/KpXZuNX/mrOSuRmBt3Ug
	 Sqkge4GO0MLzo5PrAcPSSc3ghVruM9vKnSLlddgEsH7FdJV99M4QV3CZTFK2P+1hmJbWy
	 qWoN66+KuVDlGwkuFhEJ46RPxNRqkdzN839XvUQvqY9bBp85vyL4gInOneOsGeKbHtC0Q
	 eT1JKKVFYS+qMxlhSepS96h0qy5fV4/RiBUzjGb2f6SM9wIgbAbTuXGCMintdgVko5I1Q
	 aDNQZEftcc5v6i7XHHnzQuwMQxZo5M7a1/WH6z5VSijU2/jNG+inidIYq5RKcyHc/QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Tgh36Sv6gx9QTBxUR4McAI5E37aAs2WThFr3fenzEZQ=;
	b=B0CaHsbGGu0BvSqE+GAQHSG54HtODeZh3+8uQGu7bA9EArf2UMHtXkJLgkJbO5M6Mr7K
	 ORAGEGDtrZ2qcS9XgLJv7yPbs5hM2ceI1RyjB+8tkM7LPXD1wQnOcOSb5cwTxKpA73+Ur
	 Vv8sN8ueA9vguxV0JBALO5rNBmsVk6Yul8ykbutblnJjdtyoYHGz6NFdVEy/X4dCl/0q4
	 /aFXDZE7l+O1hL+sI5C+4cW+XBqooBGC2cYgiqLmfhheI1pz9dIcamF65cNSXOPD2SCu3
	 x9RdxIXEO22K7ORHe9gRagv8b46puUDzwv3uc7gWb4t7wA9F6l1EEgt2aZZM3ZZLREA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPHQHCWi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F1606A6B6;
	Sat, 21 Nov 2026 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPHQHCWi
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300704;
	b=Xg/BjPwXw6XC355C0oryYv7KxTUsUTsTOPW4L2J/Wj4w72nxAkfggMTI/UBpGSCjk2P5
	 9MZJbTWpm9hvAVEqE7FW5yhdNBtHZ/64593gzeavC/xfj7j410C0DdCJhxokBWPIxp/bI
	 wUbRz4DgbdniEmyPXoEl6cFbLxd6YVKljUO5TkTZS5qH/N2kulrKuHrX2L0ZwZJB4tO4U
	 VJ7b3472hHMiR+wq/tCjJr9Ynkn16gTcsiyn/aRrWLL0AsyosJBxSzqFo5kGWls+bl1Ns
	 MiSyipFDqSsrpzqgI8/0FiZRn6W6qYKPyZ/eG9xsh6FstQs81Z/ocaRU8uSNJDNFWIw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300704;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Tgh36Sv6gx9QTBxUR4McAI5E37aAs2WThFr3fenzEZQ=;
	b=1QT1G+k1Ap7SCDRdrWQqi2+wbt4AeCFHdWjV69QtFVSOrF17ImGBJKt8ctUe7Pp8Rt5e
	 00lt+18BHP2NLU4aaaMp7g20HnNkCFrzC4zu8mdoqbsbBdc892iMnaCujAYCqFQtW/+vV
	 1c3SA1bMYYiCy7p+z4UHOWclaE8nAzp9bf4vD3uNf6/dEGZki8c+ytNbqDZFGzlF6JsHi
	 +nEYzRc8fZoRlMvC55A92zoPLQnVKT1GgzHQP2C4s59x0y/KhwSKZHvCDi/vDqcoakeIg
	 useHcLN5VjOSKRgCWL8X6PGmYohZD+klkpAjwB/5SbU6Hz2UF8QQYbltR4cyMPfdyRw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 86D281F000D0;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300704;
	bh=Tgh36Sv6gx9QTBxUR4McAI5E37aAs2WThFr3fenzEZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gPHQHCWiKtpsDb3WnV4bHja5yVVJH0eNp8a77SXtWwDc/jrLDaNmVK4B9RyY/1kLp
	 ipS8g1Ds34enn5TYX/3x50F8KxoIBRWNjoxmGbfEYINER4ZK6p9l+eOp2D4RWthhDH
	 48bIdyY9UZPIlqvMggZe/5JsD9SU/0ETWNFKhv4TbBcGFNaf+go4u0lSBE7KomyzKU
	 EG6SoZyMZAqHDZX28Pp/c8L8tYqYaafsdrjAIyY3fieo2vyi2JS4t7r3Tng5hzt0V5
	 iXELEyYRsET20A3gEuUNC1BMA08zw2huut+Z2HBq5n1Qtzq7Mk6pX8wvojdh+o8EEi
	 KfUuR64DS3EHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7C67B4BE3E;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:01 +0100
Subject: [PATCH v3 07/12] arm64: dts: qcom: sdm845-google: Enable vbus
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
Message-Id: <20261121-pmi8998-vbus-v3-7-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=3zA9zU8QD5bgQ4Qh8shKYoahEuzHYEn4sy0F1hyRj2g=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1bcWmiz6YqSfFByl8hyykX2F8eiNAIW6iuY
 ootX0Ac2uiJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 cr3ED/9AHkfN7jEtdqQaKDKcESMhhZjpTzQrVaklKnov2jBR7j6BfMwBFVCdwuY8v/oplJ3tEs4
 qbZpok4jjpTznl2bCtRGwfIg2wg3hisZmAtmAKhF9Jy03DwQQS1Htgw3ayLieYJBQeRygLLD1/X
 qZTREBQt2MmAjMVU3jeYhzsDfGXKlVfEz+4ihkuYuIvURbHNNsTdV3v+Sg6PqAU0IzwKL7DQDd0
 I9162APcxamdo44V+I1eLiFCa1aeu91loQ9usNeDKzf0DhSzm5lIqmTqTgvJVKYZSAgjq+NG99l
 7tSpWk4uc1WM9icwBnGzhpHEQEl/Y7cYPswcEYeqh1nSXnUWd4Po5XXvAbfi6/s0a2/HLUq/1Wc
 lCqczitgpwywtJmho9barvHvqZTH6uioUmCMifGtTmogtnZ7u2W0rdpy8lBl8hANOtHprzewg8S
 X7p5GlM+RJcxJzxgIkAXdF+ZoEppxsNHDPqzvQJlnTrtXEezaD4Za6CMxGzC6PjvzE2xP+oxgj2
 SFK2T5WVI1GZQrxq7Kr73FK1dEYq7xhplxlpWtjwa/liBeYkQGnaVkZQDLJQ2zUIafb/5FxbLjA
 CrNFjMRl8dTbUDjt6Xl/Q+lJodENR4dnHe0XTVYnzrhewzCSiQdN01D+crixfzUacf4bUWZCDWz
 FImy0UenHBJ47Bg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

Enable the PMI8998 VBUS regulator on Pixel 3 and 3 XL.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index 3c9656b88b696..417c767a1821d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
@@ -451,16 +451,23 @@ &pm8998_resin {
 };
 
 &pmi8998_charger {
 	monitored-battery = <&battery>;
 
 	status = "okay";
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
 
 &qupv3_id_1 {
 	status = "okay";
 };
 

-- 
2.55.0


