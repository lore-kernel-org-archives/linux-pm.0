Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459125;
	b=PrJ7yn7uaSVzexvMS7psYLXYfjRhPU1RqzCLc/k6p8sqrwJKLcfWvAnO7JmXyk5LdgNL
	 hBhm20ACHUeOz9O7lmVgXi0Dgc4lxoTue6RGnVf1+HJZHfTwJAgrqYIqf2zdpBrV+9k2P
	 7BIj3TWf22O02Jqi0WRZwbO1jxaD/XNWTX3h70q1X3h/1H0NDdyelWMk0lwD8ecZBvGiU
	 goDICXYzB4dEnJcfrKvI8CVSYe9FavH57e/YKu8/Nzg+fTTPHi7S/+L++pje3zt1yR92J
	 SfrpONly3wB/bkj+iZmJUi5TvitDhdEOEeMqFlxCgPNDjlIDOG2dRBn/mP6pME359ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459125;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	b=wqc6sN5zJOuhB5TyVXaZpc8ERpv184E+DwHHNwHnkxM9YG4jnbhStpeuohxHxQm7lZfB
	 ZZ/huPKiVlhgGWalAD/NR2LRxriY/gnZuYknyl4D10l1+YYrAVIadFXShPgiRMh3KSmim
	 GIHjFKO8wJewzjQrN1F3F2DYXCblOtxY4APyBU/xAw+h0PXe2n8IMCJQbKQ1QOdnPpkBX
	 H9kAb/Ut3C/TYHIzQKUz+YBByYZ2ku3hqxtOHibvDaisRBUNX1d+B0UxdJqUIhizpHPw7
	 DMBez9i6kMPiD4+P12y4hPrHQi5r8KIMCgRMl7qnhytqldLVsX9wWWO3aVIibNaBYNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PuF/mwd0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC360A2609;
	Sat, 31 Oct 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PuF/mwd0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459124;
	b=biXMQJNcEhWkdYXXx+RXrE+9i40STobhPcui6xIzUAz5A75Rs6EmR9PfKXwZclkh9VD3
	 a+REpb3SqUPFAKWS1wqOHUNMfgFrj8OCgBmRLC8koTrCxcGN0AkdmsiKSFl1H/X29MXl+
	 D8DUCk8Vz0GtU0r6wLnAjzUo+sxvDvSCkVzD4dSowXd79hWcau+Krf3mwgkAaUb7aQLK6
	 m9sy/i3jgcpexajX2lEm78U11u8vkiLZ86h/98ADzmE0LdINyQI+8E4OP1bzQYjy/+Kyh
	 9xfRLZdLvqccxb7U5/S6mDeSBt5M8RV/HtehpwAwWasULdU8RIz5XKyebsJK3zHYnWg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459124;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	b=eW2EiaeIC+jTJ+0dmowRPSV+JxDKnWfmwov5bEyd2K1H3jdRVa7Dvv/lsesLlL6+pK7k
	 f8mYZHMrZ/o/dn630TIZGZigiuwfckLt/9x+0FiqcoUiVoLNt778ERp/3w49D36rEIMKj
	 ux8BpBVr1u+QoGZsvteIkeTxCNKwUhElB2MXjl5wze73P/6wZXSfTlve6vh8LawzNSZdF
	 mM/OmlEMTGZ3zx3XPZaP9G8LPnPRftwJ0oeioYQN3fHC4eZQiEM1lNtbZxT4PCAWjLhhZ
	 JMxpdOEFKYyAJ8FasmX4zf/leyWbaTm896IznwtMIotq1Y0lhwZxsU7YxhpV0xU0lWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C07D11F00A1C;
	Sat, 31 Oct 2026 15:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459124;
	bh=GOtB/aqTsvf6bQGU9dL2JqihPsMclbo/24c9lDiPZws=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PuF/mwd0m6dyAWE2TF2top72KrLwayM7agGbm9d/YLovOcMsxDaw4riGlMoHB9Zzq
	 9CRlTrUjgPrb1ZE33TGdinukWXaGw3x/s8S2d1xRh224KQrSjOJugGyVgLz3/BVKf7
	 DAi62+XHibwe/fnsHOofV15VFQY9YBizbdCD5LdC9eskfJVL0RtafNG8mkIi6s+Icr
	 +lvtmO8S/hvDqaIOP1SD6DgMlQpKbuXuqqxvq4x1R7f9mru5EFLAh0CcgCY5BkIy/b
	 eITbyxdA7m1mfd28r05B57BmrePQ2X56mVlZotuGfZmEUe4x+n1zaujzW26nNdnbS+
	 Iw4Esh0alw7WQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E9A345F1B;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:04 +0100
Subject: [PATCH 07/11] arm64: dts: qcom: sdm845-oneplus: Enable vbus
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
Message-Id: <20261031-pmi8998-vbus-v1-7-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=qtK8U0DG1cRkdsACHAr+c1jMalJb+5fDCyLN85kWDvA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvumnNkjX9xEkWmSZ03N2FQLW1h7MKYlPAb
 XF0klZkU26JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 crq+EACg6Q0/DvGX7+HThl0wRuAbMDl1EQfhjxmcDDlxUq/vORmUwxVfpyUFldpcSFZlBTYlzzW
 GM8+XbKePDKCY5XXcUZ0JEmUB9b0o6UnnAkvlEzXveYSwwWo2y8FWRDC+GJXBVOVgKTfDNFD4Q1
 T6ovUgq9h97lesdOLVaQYjHVawqI17yPArry2BNA/nvrlwzTgD+YjnMwFnNQ5draqjOMvwRDvpm
 jwgD1vFDYv+yvn+4jcQVDR1XdBsNjfvDv5vfyaE55nuXbLiHJZLKNIThMg77B0+WANso1U12UEV
 54nTjMg2+m54LvdkDPQ5rWrZ5GG2qo/3K/B+hfGzTza5gL15kDBG3bzm6CJgsdCVcnjA2+clIZf
 9XC0mFbJgcUsEFCrWmZyVsqq6NmfB8d+gs7VNY20UmPbg33M0QiVre86+6deTp2K9UjjXFHXNr9
 e7FzDtNolJ9mhRnrEpJsHb7LYjXKkH6OUKdhguH8FyFaSJNnNx7FJtjFc1p2Lguh38mKpy69U6R
 mzLn7z0VcR0znXZF+fvx5Yxt7Lt1zGTOOvBNYukCPZKpJ2YLgQzZO43cxadT1NMBHNarRtKxS81
 DdTWKqYTmB7/MQ1j9E1MnDZm2Qj0Brl5Em0pHY04D8vKyUcWOmklsyVgoerkPntQ+iVdIcnJh3j
 Vo0GQGrfLh3Kjxw==
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


