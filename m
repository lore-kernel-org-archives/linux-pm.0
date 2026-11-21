Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300705;
	b=XuRGomEHTqmmWeVFc1kAyaz12KXExgJMUCbmZ/tMSlE6iCH4RgD4fFjl43+vsWJ6ajhw
	 6eujzZHeHD7ZstO6G/hGGnF/D7GMfwCOcW7LqCuT2d7xNHXGnxtEI5VkU8GoQwikheg1v
	 TH1MlPODFMVB+OincSzWydGcEu3Z35P0BAM81VLRb9+nWVZ78KL92RZTiVGPhS2oe+JXA
	 ZygJ3GNL2XY0lj88ucMx++QpcGQfoURIHvvb438oh1R9aJwb+NUM0DCse0IPMdDYEhKXG
	 ezYOiopA08BbJd1c6Q+Siil/HzPs7IMF/gre+GpeCBG5MXP8r/0HR8qOctOdHm3cHsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	b=mDXdr4XYOSMub63ya0UQIZbOOi64BH+mf5m6GP6phH1frr0IBsWyD6+wguBq1FfJ6cW+
	 T4Rjsc+YB7Xs91Kj12k5TRxJzuOaBT/ZDvfe/F5RnNgsVaNXTc39UNnGgPbEW0xsFC878
	 /T8pqYGVNxoZKdAlzl8JgcBERjrmNhLQf9KVxXmtStvRZ4A0mvsMXb/taYXQiHR9osDZz
	 2VDupe42A2RSB66mJsKwT03CACl0xFBgVIe0NwWrbJDl64ZV4+E/vjMhCfdykGGpNXEfr
	 bJMfJrsXlqOgFoBnhuIegu+XBW3RQoXCqWh+jYEYRuRLHd68IZHnwkvvKqe/q4puR7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxFgV7bc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E3B606A68D;
	Sat, 21 Nov 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BxFgV7bc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300705;
	b=tqFpFV0WALk2aZwXLAwOFyVQGwh9WeZBY30rHTJw2vNhBzzZ6rHTUYSLvThcYsvQCFoN
	 aJuJCjqW3OoEPQJVB2RgCgw6ox0n0mFslbxv52bQu7FKiEmdrjO3spP4tlFielvngme0W
	 JpppaNbSzXbmOL3pinmqMKAoihltq5nYXPdoc6cxmUWKNFHOKjcoLyJt1IJfj+lBThll5
	 n55zbn2Kydsj7oL65PGPE2i1G/kJBiyZm0Zax+Fhg0f3Z7O9wa0wnLrFsJocbAUTTJR3B
	 GZLjEwV7umOAe7ui2qD8DxdJLLkF7ih5tbiXIG858eHdlfoeBiOhiSLVk8PtBF026Bw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	b=Pz2awlAE8ChieIzFAPTaRsRDTnrhJQHOzWdRj7w1sIG+so6NR4rFzHdMDEWq5KPTHj2Y
	 1SPO485V6bOF6yW/35YZg5YVLMmBo4zxtc/eXY9TWpX8gmK2FjM3NzuuL+NdsQpn/VeTz
	 UfRsvqBJXwdrC+sz+QEUvhsJ/uE6noAde1pdk8Uweb001IuXilFSvj23xVrZ10GZ84JS+
	 CVsB8bGVnARWRpLBJ7lTMmbuxOZCXUAZxzk/CLsg+7jYcHG5yik466U6smjJHIEyIXCdF
	 dSY6jIinewCkiS+ojX+QRnVG6LK43WwE/578KWDpMDJUukwqzmNbchVdSAJ42wLiPlg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A06B81F000D4;
	Sat, 21 Nov 2026 22:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300705;
	bh=4mkoX+OtXZlUYM2KdWyZuMLbP5nRS3AuI75xvEPjRPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BxFgV7bcpK2dAf7q5MRXYxG46mHWc9rWHr7ice8L2NaFZLwDtmG2fSjVYS77YlHoz
	 hGYS9bL1H5xirS8X/Z5K7A1Z9HyyzzW8ZHa1UvbTH0u3sG3fSJ9eHttchnL81wrtoE
	 tH+QmG6jfeeFWPfJ1JzmylzrsPGPzR5oR8Ds6eiZVelmBBKO1nWNQXUMFzYoHJcC0K
	 IbymRRcZNuqpv4bSQoRmHPLfv7PmyR0s6yehMQHclAd77xrCoarudigMs/xt0HKxkp
	 fwBYsEtilTgKJeiIeY/jAJYn7BxzHQ2FfLEBmQ/58eqJrx3e5ngQWQbLfBp5Fae8OY
	 k3IPzouBN69dQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 61B6C4BE3A;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:38:00 +0100
Subject: [PATCH v3 06/12] arm64: dts: qcom: pm660: Add node for PMIC VBUS
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
Message-Id: <20261121-pmi8998-vbus-v3-6-91ba2e61a877@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=YJAh5JKxsMmwh1tjGfME9pip1rZ2KokfphW0+tMoGZ0=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1buHGuUxmoIIzuGDVDXYwd52yGDl0BlJRVk
 yNslinULPKJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWwAKCRBgAj/E00kg
 cjxaD/950tAIkyPW4qo258AxR9vp7/L7FkyGsj5RyVfHV7xc0yCzkZq3FrR8RoTCTi/xP+S+d84
 Ey4aEJw40nPGL2/1O9AveqW4IftRIq10ppkmziT/UkGtXyyomlrg3kHfdeeCih2SnU977PLvcmc
 SafSfAZkiK4LQrvSnrL435MMHMHd3Ke6j6A3pq+eQciybEjxxg4uVWL1wfWQPzPRGmjEkoWOZCt
 6QjNkYvK+KUMs3M8chU1BkfQRSb5OLfhvq38f5802E4dwnSOMKf004uzsTc/dqwgIPj283LPe2w
 CO98DtuVPxDsV7RBoda6XVqPxhOpxo/lULboNpYcpHusmp80yjaSDSAAXXHVjNASvUX4etDkxXV
 I0wSPgN8vsSd5nQ0V4+aIFMSb7r6JxAVSq7T5j/xTP3lgGawEGWeISs0Ro+xI1jDs6ijkU21sDl
 CVG0cdLITKmOC3EWXxRbuX5DEQlQb/bTTlW61NtXigJ9dEZI+1OHWrzshR45R24lm+gRgaiF+Dk
 jEVD+OMgi5S8bjCbkSLfYqMKBjMJ14SLpAYQT7y74iqj9d9u59c3d/NFo/oodOhYpNdvaVBvxM2
 oDUBInG5bFVoO/NBi+trlA8GgS4+/NUidcGZhOmhmnqfLtecYcfmTL3YpeeC9jUHOppaKxo7WW/
 wtP53V1kEpTZTOw==
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
index 156b2ddff0dcb..fe9ef304d64e7 100644
--- a/arch/arm64/boot/dts/qcom/pm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm660.dtsi
@@ -85,16 +85,23 @@ pm660_charger: charger@1000 {
 
 			io-channels = <&pm660_rradc 3>,
 				      <&pm660_rradc 4>;
 			io-channel-names = "usbin_i", "usbin_v";
 
 			status = "disabled";
 		};
 
+		pm660_vbus: usb-vbus-regulator@1100 {
+			compatible = "qcom,pm660-vbus-reg", "qcom,pmi8998-vbus-reg";
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


