Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300706;
	b=Q4c8ZfaqEhuu1g0uKwy8VVt466aa/4cn9e/68bPIG0/YQ1ytuOCE/zFUAID9VyyYfovC
	 YiYLsdCoQLP0X29OVe0NMZKvTDq45c27wUqLBvZv+/FxvyDql/0Se2Nq1qPLiOIubrNJp
	 hYfIXacCQsLqCwJN6G6NC/psTMN3S3sVCM1H/xGtyz/NGQDu/wLlOzkNEThsT5nFUQrye
	 7RKa+v8uJXpqTEVw5uH29GYF8TC88Q2RErKGHO2M94M8nFFAKDhqTjDd2baQ8Z3+lU7gj
	 a9z0u3fNxTMDccWvQdcsNg9LW/SwBH1w3t93yypIkHao1+haOIO1DQRlRXDL+nvYltg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=34xwTelqWGJQv4LwWYCv/J2DGeoXjpIQopPxW13aH34=;
	b=OKwhoryaHx0ANDgbsLAmCoXnY0vx3x13UrRWXhmFXPegbtf5w7lXBbiT1jTtDYHDgQiw
	 Lnv5BKoLRmw4Tbo0AsG3VJrUdRNgwp5qKIGLi4byXsODZZRlJ9lrHP1tuRrkgD7Af0iEK
	 hFFIE5YZyHqqCIpyFFbozOIlPxHljdO/jFcKzHWiKQjY6dHLkpaHlEDA/Mo1dQEm6A4ch
	 0DbZBGFB5/Zo9Rsrh6q4y9RPOgbmBIT6lkBuMmkEQDq1WHQooUqmfeVYXIqzt7uJOFZGP
	 WuyfmbQOHNSc39UOc6SzpQfP5Xi+X3Q/qZAlxk5jVYpIIpPEv0bbh8zSFDR3GMrIU5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJtSyREL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E01606A695;
	Sat, 21 Nov 2026 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJtSyREL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300705;
	b=EzJAxszxoruh57ONDfo+JpejeyK/7/vX8cteyWn2mK48jXwX/Ptkj68ZCW9nnWXnTe9o
	 ncnHoL5QSewQ1QjANIN6lUw5mLw/Gk6bWHGvjvqLSpiFOfiVo+khwmltqn0qQK2KumCnF
	 +pdfcSe8k2Kb9BJIM24h2Y7H2YWhTqcmCpI+7S/BhX68Z5oriMzuzHjF/X5ljDKAIHUQI
	 4LqRnO4A2SesW/rgnmZimrEqt0SjSyvQBjH9sxvHX9sCOBxWo/Y4cu4WX6WEie06VWzIL
	 DWCWeW60TJQLYOhO3+fkweaWgES42JnGZqvCqHr4+wXOMoWHh/z2aMp/k66sD8ZxHKw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=34xwTelqWGJQv4LwWYCv/J2DGeoXjpIQopPxW13aH34=;
	b=LvBh27GTPSCo4XPuSU2iz29q8xuYgXcLiebCOxY6k/wWovVHpvNdLDNOoFmIxQcO53N8
	 VKZh5QSD3MV7ug8SZZPuBMRp+uL8u/Lo3gWqvfH3AtuxaVDqvCNjezHq7kDbJn/0OC1DK
	 7mv4Ywh6gHUOIo0/xI9TXi+24sSgFkmzoUkdEFQVLUkjgFIs5PsSOd+hRPZB7WUyxs8dJ
	 Vt6J8/qKTwY2LXXdQ7YXwhnLI0CFRNPLbIfiS5wYLe0BdhAUW6aYAov2hTECxKre7eKak
	 EwwZU7gQhm0+pj4uYXClyh4ZJIV3PXliYRx8i/2fLb/oKyGTlutp/7/uNv7ZgJIio6A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DBFCB1F000EE;
	Sat, 21 Nov 2026 22:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300705;
	bh=34xwTelqWGJQv4LwWYCv/J2DGeoXjpIQopPxW13aH34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=mJtSyRELEckVggmqLtJTTeeN8wTopNumv4C2480v/szS3/zBNanOSmt40R24zWQj5
	 xAIbniKs+GEZFW+PisFamSGkIm2cJSJgNmEQ2/17972j56ZKHuNMSud8jBSjtkHnPQ
	 AG968Ygx85u2ZkbU+c3c7bGXDLa7SPKW9suyqhOLXRnj4lcviPxZuAJt776GuSt8xp
	 ivlWthbIGbg1HDcKd/OpYdOlv/pmZaZHEKaNH96xGZnz7EhHlF91CymPtMrCRcMzLD
	 myDtrAJKqtZAnHRY0BY80yqL0C8HQQg6bhIMd3Vsm12V4Aoe7q8bK8bahD5Asrznyi
	 DyKZn3kjGlQ6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CE9B14BE4A;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:04 +0100
Subject: [PATCH v3 10/12] arm64: dts: qcom: sdm845-lg: Enable vbus support
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
Message-Id: <20261121-pmi8998-vbus-v3-10-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=PavlMPZO7QvSw1lRn1wTc2SGr5e1GuOSIzQ2zRWRWLw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1bExgVMsWQiDaUrbVQemaVjcDi6CY13LLQN
 iDwaTVRlQqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 chjqD/4ho11s8jHXBdU2Z9GBgWmUwQNoVS22goJDvSYQlRU9bO4lPjFg8HPd4Di4xloifGKE0Ct
 SNWadEHktihYPuJgvmmkdWrHeEYuAmPSxXY21xgA4taOkNgDp4P2sGKgUOyC+f8mPmLVg2oTEeI
 +Tl1ICXhJ76wGYCmST9eknEETn67xvMgTHW9NWpOXquk/OGdw7XK0zZdmD9L++WLgB1zaFSshf9
 luFNFTZXw123GU1Vj6EOrvfOtyCPCZRnWg1F9f1ivloXmXN7FHieC2Zt8mb2lsZHXMsmZvyNTLF
 Ibm18u7YuNifEku5hsSNrfepK8WDxup+mihW72/3jme/d8G/z9gQJwnXIL21NEeZO5deshdVhYu
 pVu/13W8FsZSzZwm9LGw/xc3pZxpk+uo7Kt9IkfNdTQkUQqBQTe6gFwYJW1UB4KZ26BhKhh1zbU
 dJwCknWWlsvtUsm6UgVA/3ll3VJX3sOILSg+AahSOgNWe6QGSgjbjnt9KzC2rReNUmINLL1XBPZ
 tLmBcz/+rxK8+2DBKZGMAY/L0+WVm/STf/tmsce4KPqyjmuTaGQjBVfzg/3H6/kET+BB/32O5GJ
 3LECbvsfKz/bCETBYIowWO9Z0NSk/xw5ofBYrZ2EWmQrCxZqeylYmiD92+uRm27oSplEcDkT+Rj
 ybCM7bs1QBAknKg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

On LG G7 (judyln), vbus block was kept uncontrolled.
LG V35 (judyp) doesn't have charger block wired yet in upstream, thus
nothing was done, but we know from downstream this configuration is
valid, thus enable vbus block too.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
index 6989532584251..e868cf44956b5 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-lg-common.dtsi
@@ -548,16 +548,23 @@ led@4 {
 
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
 	qcom,cabc;
 	status = "okay";
 };
 

-- 
2.55.0


