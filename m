Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022747;
	b=1OanH/1KQ2BQb21dl3JhZc2ao6j2LvUPbhK6v7JY/kr7c12snxY1nKFqi15Ucni7oD8S
	 CZhZDjpMnLYQB4lnWZRxAbDi9djPWWf/yikXJO08EJeGwHvTpiRRJDe5nH6OsR5lpFdSs
	 oKcPpkmLNGMuT/VrJ3tj//UrRfO6Wu7WcF3m9p9t8vMdpSWn8yoTKBwApv1QGlMzLFB88
	 CgqvNr2BjUTJ3bR0QAOGURwQcouq1BEwtDpkJSAGCdkE9V8ThhBBM/8WjFs6pzH/EkkqJ
	 n21QAr5s5o1SVNVfYQxOGefPtwX7O/IlTAgo51sZNqHZaAv1MJQqfxfX47fr3Q9Lfkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022747;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yXluSobaMZMbKLzA61AfBwd0tBsSypE8yf7S782q9wQ=;
	b=nvEDmEeThWGbrUh37Pbfz49JkIu1e2nRpYkV0L1aDcqtLDHVkzQJWxwvlHWQrWlqqhph
	 7DpQA+ErOIH0mqRplcO9X8gfL+Xxvu1lnAIdZ0DIJ7p+g9kM/SQbHsg+O26NBoCgakngw
	 b0vVPxOrqwctz4g+K06CXjvNECf4rIDQMwCetbrQBWTl+Ip07iIW/EydLYZHoKVCRUZMJ
	 gk2fmeM0CF0TncGXBDOarQswmD/EH/QuoGvwKbl4djA/Goqye3MaejUUiBqlcPq1MoIYA
	 VDbbfBmOo23gFj/CskYbZuJU9ZC6g+iUCmYPrUi03+fxeF7OxWi9ykaYPhXCQ3Ddruw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jX/hm0su";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6960A3826;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jX/hm0su
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022747;
	b=NLc9btd+otGo62dd6iK2wgKjcBFLigNIpKLGV529NaaJAaezMrE6B8fwr3YphMDePv9B
	 s7DcRR7XywCMFIrQEoqRgeXzECBkajjYx7zyolz870cYC48VmH75OUz7Bw7ExYDUL2F2+
	 ASWo/X0dkcsYf5KuooNm54vWrhioFZY0t8Jf0kv0AmIJRKaXtwJEDJIzo0zo6yHWRpPIy
	 t7H2dWnuLuDc76IRVvgKpzP+7jwTweSsa+coiucehRLypUH0xpBvz4HE5E/6Aa4jF9PiA
	 A8csh+IsNionmX2xtEtJ78Z/RMBduX6XLYjxIkxxLwlfz6NrFUR8bZQxz6QOwdj6l2w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022747;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=yXluSobaMZMbKLzA61AfBwd0tBsSypE8yf7S782q9wQ=;
	b=0+yugHEI0lgo1g02RNcaZatOZr4G4c/9yvqKp1DvTLsk+VA2FDfB7EeaKmpFoTAliV2f
	 T7C9h/BylRlb8sAvzTyWaiRh6RtmoAxELkRggvv7UyYbdPeiMg8q9UxytIOElWPxVA9C+
	 uy1LVcfjdbdl5jQtmXks3H1LStG2JmuCA5mPfjZz+cGjlV75quBgCcjtKkqU4O4aNXEHA
	 CMWAHXwqs4Km8tUDhjl5Z4SuR6rg5TbuK2U/ZOpQWhYw8gIWSgkQqDsXMqV95Jv3r0XMo
	 7gaVQ8XnDexsCZJ2ItAlOIhBh0bzhV0YqKpX7m5EIjcJJwRPdM0gLwyJNfid3bbc3qQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ADBFB1F000CF;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022747;
	bh=yXluSobaMZMbKLzA61AfBwd0tBsSypE8yf7S782q9wQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jX/hm0suTWOO99AAzN2tzoQk6coTwrei+0QHlofTZwDfNrsVxZuIJS3VLGQO+Bxn1
	 IguaZFwSbhv1Qk3Qg1j2/4e27KtAY7ToJ7r8s4Yeo+wPs8VtsVC5+R6cr0C3Lh5rfI
	 u6MwPdGE2thOotNoeNQq2J4IAY274bfhUXdkwobYNUXbfLn5BBNIITIzMjILV9h+eZ
	 GRpdNxOPkbq/88ktM3mdFOzNGSwEkomAy8rVy+LBG11RUOP4FRl3UtxYrE6GA1jDgB
	 zaTsdThPzdfNkwcLST6WoxdTpGPBygXS7kRqGfsysPhEQOET9Otq4zEWXN9MioHgeY
	 aqS8YJxtNmNnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7E28A4AEF2;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:40 +0100
Subject: [PATCH v2 07/12] arm64: dts: qcom: sdm845-google: Enable vbus
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
Message-Id: <20261118-pmi8998-vbus-v2-7-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=VkOTwwbUirh5SMOgzMhWbBAJrp1wguqG0ymDT4qYW/I=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XZSFQwxLzTmFjB1NHz/hEX3XHI77Ygrdl2
 Prlq7NZiyqJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cjGmD/sEaSEdMyQLmSgXhBuZ12FqpHWGOIFl8ctW1iDbvRKqVBAU7LZfvq9YvbYd5+THnoXnb3s
 JMMUUJEAOSWgjrMR4zz6FAird4bh2JY/h6gqof/G/1eteZcL5cUAcBS4NUHy9hzTocW7n45QrBZ
 nlb95iDdPyqD9NxU2H9fAAdM53V4SsLqxWS4MtnBZCaAutEpo6hOMbBZ6p/DmUq3nufRKnWxspi
 aVX3JmlJ3F8sl59L9CUp0M3ce8fCuP/BExdpEv9xSfcCUSW1uPy6C3AXBFeO4rbF9YmhSiOMz19
 QBYEx/RJ8O4CY3JUeHmVSQTii2Zw0Bz7FdYVBD4ebqfz6TICGevxcDLSowbPsjGg31FX3VgQad6
 NuuTceMoqtQBlmgFB8p9x6/L/1YmBxcwSAzYbn9KgaudEaHLe/WTKYTGRgJ2apy/5lRt0vz8FL3
 JpPwfmBBWMEWfLbII1QemNAPSHAILj0sIQrVaFOD2UhkeHbo7GKZqnk9AbKt2N+o3wfjUAzBgNJ
 yVNQceX5iY936IVsm38JZ4/AT4Ot14Qk29BtFNjo2DmDe3JcNSdWJ87LD6Se1Sydkp7BwypKxj4
 NGF+VIoh1ZMOppI06UguG5Zz94SMWMZ4qm1Z1Lk9IPKjgCxiNgTdNMBv5f6wTz0mOS31TDxwvhK
 Y8vQXaXp6GAVKYg==
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


