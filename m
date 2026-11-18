Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022748;
	b=k9FyG3LZGYVj++Y5ywcCE30U6DDiizGqyvPyKGJdDKdqU1ETS4e6iF9SXb47YXA94iaR
	 45UxeRbmrWmo5pvUaFq/jKcZ7mPC+TYm/lOPu7NoziL/79+b5qx5ONJLOswEKf6D3JmVG
	 5h+W5BWzci7X5PnlLa56dZxL29yVk0Tk5agGUjXdrbXWXRT4PtvOhoxmKmbM8uV+uy9CZ
	 A/ZBicBDwW8Lrl8N80j8KtRCcFvkAh1qBk15huzrfh0bKK6qR9zI3EhT/x1Hg2Y1/tAC+
	 nvhq3xRSpsZJ6Osmd2oxCYEltR/2BSk2GzSGkZywVjpePrbYa1rgfsLULwICmDb3C6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022748;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	b=awVcTvqe0IJnwmQyAapNzhgjC2Xnwg5gaJ8RaSSqjx/5SpWRz34XjkT4OTSmjXY5hhMo
	 r0CIYHeRoIPhE47xWqNG2iNvZYizxyZiv4kYcatgXTBMyzg5+7rHeQMuE5N9qT10SB6xd
	 KQj0SjEmsWZyERn5VR9rb5g2vm+32/r+dz9uYit9IR1E9SMCPK2ahp3Nuluca7jdxU4KW
	 BCXT8Z1rt2Xo4ztugGsNR6IOSos6YygKEtseEeti7S9TfIYftobzg2pBFpQSZFMMxCxbQ
	 Hm7GWIq8qTGGd44Hw8CFKjvcEO19vTvhFkJ0APFJ66npb+y4Rp3Osn/SUpqqOtfy0GA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K09DotHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276360A6F46;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K09DotHH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022748;
	b=p1op4C3mO0bNJ0m8l7yeG+uF5QolcKzAtuBnmNuvARI2SoHMAdkhqyr7jey8natoqrWT
	 8htr8ceKPanRUM9wXvAwPah4piOpH04cdi6J+dTpUOZl9YFlcOyOMIO3r0FaynrGo0vQG
	 CkmrelIC/hu5oeODmW+yvx8Tbw35KPBCzg0K6Ke5oLc4ji8IY+gtrcEIQ7Ga8ftrujre0
	 TovohsmTM066C05cH49zLcwizxnKn1oVJIiTSk4pS4cGp6h4yCKwcdgAX18lCEfAQWgPT
	 hWUBKnZEfY7lk2e5E0aMJNmdlgNUtyc6TBgklzpR0QyH+tn9oTFemO18MpkiZF/oJOA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022748;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	b=ngxPQPYs8ShxoFnVZjyBhMvhh2XhK8XQlgPROwDhTOeDJAmzwBTxEfkK77/wHl/hSsRs
	 DZsD4c6+BqlSc6S8uDYMxEfpdXko/mBJXdcPGiCQ+9pqCNu9NmOp6Fm3siPE8rt56EWKH
	 zMHhVs7zhcp0xlcIfXIF17GDtnJNNLlnQLjXSurtHei3t8kFBHWCNJf7BvaptSx+UVkFQ
	 xjTmnxVWi/aoSFEDpymf0I3gjUawS/ilinL9pS+4PgcR3ktzo9OnA7Ipj1ZRlWvIQq5Ya
	 DLks8w8BYrQPZJOh2KJpG/6Nvs3hKmxGg5cj/DW4sYQsDQtnP9R+W6c/+4E7npQJ6ZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B45111F00926;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022748;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K09DotHH4eiT/ORBa9XOKMiZTdrYLNKbMv/xVmxR3V0WZopJy9Y/pCd/iCI4TZFmH
	 QQzSXoeL23R7YY3v0KvqY9g6BfMRp8JqyY5ltFcxU2nvkiUG9wzNaGiJRjo1zOiP04
	 eNus3yRlT5F/DyuCBONx0fHVNEx0s+V0WWEd8oOcAFEzZrOTwT+rvHf0/lQs+f1Qg6
	 tu76IJCNoIepTzX6qZMjlRuw8fXNiSzY6nHbc24nTTrMwb5YBoWEYx0IfrzxW7Umyv
	 tIDyfnZiJfDaoRRiFHlaOpnyD9bkYcpyQ3ERjStb8iPryNm64xwV2CrBakjdzqVU98
	 ZQ4mSkE2n513g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 959A24AEF5;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:41 +0100
Subject: [PATCH v2 08/12] arm64: dts: qcom: sdm845-oneplus: Enable vbus
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
Message-Id: <20261118-pmi8998-vbus-v2-8-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=qtK8U0DG1cRkdsACHAr+c1jMalJb+5fDCyLN85kWDvA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+Xux/XV/RcXxApBTxcJ2ZIuM8XgqAeK/KNK
 oiW3dqxLhCJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cpXqD/0cPSi/Spa6ztty2BllXCoc8Y4UUnWTZswjzAhVje+ckv0MNJKQB50DIqRZpPJ9aawHKbk
 N6E9/IapIM+brBH6XCLadnKgIZ5tayWX2BeOeEToCibAAMoNKA1mUXBCUz4yOyMx26pwb5ykTEj
 /6ltPIUNvlJYTBSY0Ag4TVOBxSDyVvfAuX1SeXzg0UIHFBTG1W81m+YOTVr6MhzEfnJv8pGGzsz
 aTQzhXh9KZse1YZGPXsRMYVi3Pk1sOIHdEg7DGvwNwcCvqYnyuWknh+KWy0/izApn8MI6fLjiPo
 WgBkQbmwzdU1uvyxc8kuNLo1DZmpuqckgOpEZZZjyg0ykcwxzv4K1piUpVaTyELUNE1V3aZDLUd
 VNam24iFesz58IY6sUhhOwSFtE5AwyzPHVJMi35vFa3GiqxFCl5kD01j2dl98Rk6xOfaacPUhX2
 tpDa5oTzEb4133IVX+0sQvRLQOyw/vtAKhAV8ATH/z3zttbk6BURLC3dKjwiJnFn1TkarlhrW7Q
 B/tAJNBAQVmKvm3bb6b6wRooFUj1lLeZfBPbpbyro2nsIL7ltEDdHOT6ODLJ8Us8Obk7pSPs3NQ
 WXMhi4likHlzUE1SmyNkIUNSGkw/GnoSNJ8JHiuF/fg+qAv/YWFYokgdrVLIOb5xPvKANWr3wob
 MG4Yrdla/Na43Cw==
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
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 1df09da3c4d71..4996ce24fee36 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -660,16 +660,23 @@ led-1 {
 		color = <LED_COLOR_ID_YELLOW>;
 		led-sources = <2>;
 		led-max-microamp = <500000>;
 		flash-max-microamp = <1500000>;
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
 &q6afedai {
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <1>;
 	};
 
 	dai@23 {
 		reg = <QUATERNARY_MI2S_TX>;

-- 
2.55.0


