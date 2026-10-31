Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459124;
	b=k27hN6TrbJjpmO7Gg3wWUUQeVu2kiwo3ZgxCioEqKG+IpKtTmPYP7PZtP+XGkE42VCSu
	 bludLJL6xWdYUzLO7OzjvpPhHK312c6WBLqMDXeR1J0qa6zs7KrYxUPq5pEnLgjAtOGYB
	 hQ02Tfn9bfip04yvXO8p/3mXutJ6MSyW2l2h1g11Cf9fXeBgi1IPfVHbJWJhA3QSZeB+V
	 JAS4QKoJB2axJk3ImfrK6Dyp4FV0fJxBmReCBBEaBTjCOKmjumamkAoYvIE6JK0ZiMjnn
	 NCErhE6hjzQ9hMuYHFal09ACRH/BSHNHdH94CKRy0EUkkSIH8g8HIGdp5GRAH2vm+ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459124;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SQqLEFbgZFouwcF6/RQEgTplyebDM/+Zzfi67y+ba60=;
	b=bqepSpIFqTiu+NvOkX4h3rbqFz6prE7WNORrDvVhSRcmZPFMGyDe0uFQFi7xOJ1LWOdH
	 BD3fPZqaZ1gQLXMo1mZARzWr/xgNUzR5Y+1mgA+82idx/lYCBffxDvDz7wYHj5jYVIkUR
	 9pSysVF4TeCeB7a7Lk2yHCqLnn4qW9veRmFdImK2+iXagLweJkm/lumiTUues0ReUlV3s
	 hUfL8WYttpgdzi6xdS6CuUXKsS7Q4WI4gHXXBI5fwpg5j8vbRivFw1OTeZXcpNUBpNTUh
	 Kpy7F5kBcbaXwfZObXv6fcHrT++eDzeko79ME2PkxfNpQpNArXKfrxwbF1kh7sIcBmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I9/g11TC";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA4606A33E;
	Sat, 31 Oct 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9/g11TC
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459124;
	b=Gv4JX9jIyXZddcA4dEV8nmsPi0gBfTLau0auSYicvPcPjJHG+awGcl2XtapUlkdBvqpE
	 pk0VRaqHFW8TqsGi51Vcdx+5wu2lXREZxgoKgg8y03zxZYGfkvjzk5vdrK2NZDIu5tRla
	 MwKEWzqT0JyEyBujBRWwIymSP2isz34j8ZZQl9BGvXoW3rAuZmH5aE/hJ+GmuNOopYbid
	 wOkvfZNeZV+4pmg3baB6aEe2kUrKSrIrEb0Oc93XcUK/h0QdKG1TlXWKc29MNizxYg9Kq
	 OBfhLPvHtd6+9wOxURABbCzoLpLdv30HJVS6Jc2czyPkdGdI91uHBKpiDpTgTcoHahA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=SQqLEFbgZFouwcF6/RQEgTplyebDM/+Zzfi67y+ba60=;
	b=LRO/srd6UTQe8ZNaf+EHwxK/oT87g/dn7poyeBeYHGCxuOfUedLq6M04qg8SAXPLpH3o
	 Q5oU1DY43XOFh3szJ98uXqtGcVNiFspv6RWubO8oRER+InhuhpRv+BeTufkNcW9n2Br7G
	 UVpeHQCxXmhHS94xpIpr99jDI1JYVSgXDP5WQXSmGxCOLTsRQZgA58MbeU5ivRFuB3uZk
	 BPSWhuVLUQ6kJzc0B8DaxS8fF80YUHuQSbOdMHDaTqh2lv/tsq32YVU/B8F+aUlfI8UAy
	 tuUzbWbsuQiFfJiiQgEM0arHmTjmZxRy0ONOn3Gl1Pd7xjs9hm1HCmDGCvIMREapBJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 27DD11F0093A;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459124;
	bh=SQqLEFbgZFouwcF6/RQEgTplyebDM/+Zzfi67y+ba60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=I9/g11TC2DTE76Co2puP9pIhfItvQm+c4YG4R114IO++V6s5b2TyDOLYZHwqIaCFR
	 u/0BK3TBDRHuKE8vrRDKjC7MmEnCnmYWENPf28a5HPVREEumxurmPg0VifH9gPG+7S
	 wiXwdjjWNpOl0/zimi1aKFMKMlgPVBnDyjrZkZkyAroCPc2Agp7Jsht88e1Emui+wA
	 Q+R22ntqrgfDQZH5S4x89b3yGLVucFftS8xsY2rAjvHzJAvQj0/RpMqe7IaQ9y1JiD
	 jop4iwukoaav8JDbAcpsxR7gqIiZLdxSUb+Rx/Q07kJPTPmyYJ7iIk/NmxvzuciIjB
	 qya4ExXrB/UnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9255C45F17;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:03 +0100
Subject: [PATCH 06/11] arm64: dts: qcom: sdm845-google: Enable vbus support
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
Message-Id: <20261031-pmi8998-vbus-v1-6-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=7CBgv18ArIrBQNH4lCvE3E/2X60T84ZTgUfqUmKu+ko=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvv5xQ1k7s4cFeL5ZqPIxziSgGitRTmeU24
 5sg/WzYggKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 chb0EACUTL7lE5X5Q7FTtXZFrl+epB3s3olPUiP/HWtks0Vblmg6JoQFCCtnneEeqBLOf52z/TR
 aC+em7aBcpWRM0Np4h2HPJiqdG8NiLibkGhJ6ldEFRSFJcit/eCi66iguTn1pUgU/itbEKpv7em
 LKSXLktslC23r6txip2w6WgIVxqyeirFnt2I0iTQ5myuRZmI8RgK3c+d6jW9Clfuti9KLlhQyRs
 zS8WRKqfXoL3cFfUfK9lXFlDX/Sy/m2VtypSr4ug8vpgS0LdeXBUhyfqyPIFeMpj0AoImUAMZSj
 dHn3+SuU4wZ83kBacXf5a0sQftZdfD83LtyNDQfAxRWsra4C0UuIz+NTnRR0D/OKdY2dBMSsiFQ
 cc3Pi3Mm7RoUnkqZy8GXNyF8L37WrhznOf24q28IrVcsyFujJufmFF7+nEuCp7DxcW2tHK/YkZu
 SZ5s9NvKidYhE0gZZlKoaRrOs+vdnQNgXblXFsFQjU/07FciKH04D63QF1ORVSUWXGAklFmlVcd
 NvVj19MYaidU3J64Jl9m2EvpQJAsasPrqNOweGxp0x1NMLjeuVFCqBEnCnDsO4RJ7MLUsZX0mhu
 AR9ChUa9lSM1IOBNShuZHij4+dh+cq9wMaUARcPrw6CeK8370KwAovHggTLRqSF7o5Y7L35fKw4
 2o6eVEFG83vQnnQ==
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
 arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi
index f1379857e2742..1cffe3c7cf76a 100644
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


