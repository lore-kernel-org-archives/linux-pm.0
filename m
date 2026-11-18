Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022748;
	b=k3sFh6bS85kSCWo1Nc+sxLv7yXkfTuxzdtsFioaDjtnrH7oLlxExrfFoqRJiqxBPtbSJ
	 V2YlJ6yzIU9VQgNL4srZlBFAAknHD8nxDJYq1Utjz/4OAS9FHCuQ4pEORS6HxS49NYQBw
	 bSpOiRnjWIffLSCWSOSmTIvJugByvp8F93EtAOlFLS1vMOfQwC+h5JJZF6RRczreAmrmH
	 2BQUwCzN1caibnPlFP595tBBI//Aqr+WMy3vnQhtrPgsI+ZU1bFDgPTKsAjFnEPdRxK9F
	 Bat/LgpVD9SWAkKAGVNjLe1kSYGQWI8GD01gOdDha2BarUvzkI6elXysqHlZwWv6uzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022748;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HSCUWDSJEqkYX38VOL+ytbHQvfr3sRJ7rJar/F/Nk2I=;
	b=0cj9H34dcjc1A1n0lVd7WTI8qq4M7lTu3r2cjWH5Wqefb+bvMrHME/FYv17GlZsWiMcV
	 tln6h3ZZ0KgREEOlpiAt/Wj898FCGX+M0uovf/LerlAhGrp2bMrb75q4f1jfiLyJtIvZr
	 URlKl0C3ro6hVc2YuN0dpNEa+blDcuwalIJqefBcaNlH+tOTVBrWEC7adWpa2baGrAv/w
	 Zl7nNHeZhiiKERNmITLXpg/V+7aBr7joBRK89avR22xvEPh2QeUhZHBPDTuGqCqqc0+Kh
	 KYhsy6gIB/mJxOiBTBr+4qWiqoqiIDR5p1vNxTOJzqmHrYn6p33ZwdAyewz3KoTW+kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5A2VSXE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92F60A5BD1;
	Wed, 18 Nov 2026 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5A2VSXE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022748;
	b=tXllFHDjEURiGAmWYhPEA4PtK1siTXBTXLOjSirLbZ88xgbG40xmm276A7tMZI9WipaM
	 7sxmLCLgSy0SQy7KwhD1nhc3VU+AfW9sTTSrXGGcWcrpXpjNL3hvvGLTI2/0BPorxLOlC
	 aZpb16tPOrFLT3wlkv0w6nj4JFXcaOTWv558mSxZZXMnFkjpeRjpHFn0+SheFNDa0/dcQ
	 oEPaxV3tL+IXQro6FtW90Ue+nM0ZoTfAl+C9/VN1HXTC6SjrbGqJqmgT97wXQ//LXEBvI
	 RA8mv3CcTChpI9ABC+LaBk6Dw2r0RmqAyvZS8GGAjGWZ4idK2DFF/IhB9uxnuRs501A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022748;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=HSCUWDSJEqkYX38VOL+ytbHQvfr3sRJ7rJar/F/Nk2I=;
	b=1DRqaCgHxjSJG+JJi6VVCqhH+EomtrYgQYzJQKb1Qipebf5JCdxXuVX2XpGIrWKG9X6t
	 7SkU25hafeoQDbBfb+hzTFYqE4h8jG8sWLpAm0gV3C8PcG6oDfaP4B62N3BOsM1p2VCWQ
	 WKQdk4cbTRFTtmbLRLmvZeM5WQU4tl49aq+Zc4LKhK56lWMLaGNeIf4Au8umoUDKz3tzM
	 vg6Nu5mzJN+yH7tZVtOkFCNNZuREybxveFwgFJISYN4nkdRFg9eTmYDGx2xKl3iyl2Ztj
	 btv2J2gUlywFvtfhr4McsxySmcBt1aSpSL49SQdwbvl8Y3hhDnDz11k3BUu5YjW8UKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 435F51F000D0;
	Wed, 18 Nov 2026 17:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022748;
	bh=HSCUWDSJEqkYX38VOL+ytbHQvfr3sRJ7rJar/F/Nk2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=F5A2VSXEP3PcRheDvrXpkB+3IdaPmF1ZdGWN0WK4swC4NMUHurZz/JOlH5Zisx/Gy
	 SHbMsPg27U9s+sK7jfkxv/DuA+U9ogHcmlUBhHvSxtnfkUDlK75LW+oNeTV8E4hE+Q
	 aqgi31sZfCWbzNbaVptE8lAdysKV+Qztkv/jmOPHW8pGxFLv0Bu0vjhunAAe8VawmA
	 VCCSwOhqqs9vudNNYCCnnl7arfjRjdcK0zQP3k817qQ9x1fjmxkBDfyF3me5MZ7ER+
	 LBThu9hvLvt+5XAW+RBhQkpksxLUbcgzIodwnkvb2p3Yxzt5rip3kjxiGNntuG+BV6
	 40Aq0VajaGrSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DD4C44AF01;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:44 +0100
Subject: [PATCH v2 11/12] arm64: dts: qcom: sdm845-xiaomi-beryllium: Enable
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
Message-Id: <20261118-pmi8998-vbus-v2-11-3c77a72b280a@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=/Lj3TGFexa5AfzuS/I1Uhtld+K5vTju4obeOh3yWZrc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XlZGDgGZoz0iSr3s6ex4mRpEIhqUZGBxp+
 1ZJCxpTckeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 cq+EEADLvJzKhZRpu+5LyYC9tSlFmKR0zlyaDNa2Mj6LtKIDkysLAiI20OPDn3NsKzhV7zLrzpI
 3mHCEwoZi4IhgrpTsdnWZQ85lJr2UydKl8dtn0tV2Fmtlj0udVyEIW89kwxBFuedvluPYVjX4eq
 ynSJmSNPNm3o4Tqj7mCUAZ5KpzZj4pSA6q8+Iv+bZYxW5whj4YYEkbXosEKAmtH2ratIIHQZ+ha
 hGDNxJfefCTEmz0fGctH1h0yhfWzEADXsh1F+B1YDQJE/8opCZVB1vYeEd2TOQj+m8jG0SMhMrP
 9B8USfeseQsjXBfkqQetQZplwto3brFCt4gaMaSiwxzbhhUsZ4gnnFAyKws/LbYzp0sVtyoH5So
 +/ijmXpCTFoC9jNf+cAeuQxSMQdgJBKxDbMl4z/fBRnb/ErMh7b3uGxZgs42g1+7pnGGkA6HKvh
 XYwBLLfyYScLcksaw6dcVVlAW7aJwfHTRkRq1K3EShcZJRlcJpkozrB/jLCA9lSjQiZOXA7YQz2
 FicoGv9jBsgA1MU8lo8UuMql1X9PrRsqoqpSUpRS6E+PLgJjwvdf9xIvLyFPwq8Az4UKWP2VUP7
 kRzElwwHW5Se2Huvqczo39yHcNr1bp4pyzN1GKfDqcKfBXI+4ig+xLxKWQM36MtupP4J9KGjedz
 qD0LjtOki2MBOpA==
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
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index d57851b0b9419..aab5738253914 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -418,16 +418,23 @@ led-1 {
 	};
 };
 
 &pm8998_resin {
 	linux,code = <KEY_VOLUMEDOWN>;
 	status = "okay";
 };
 
+&pmi8998_vbus {
+	regulator-min-microamp = <500000>;
+	regulator-max-microamp = <1500000>;
+
+	status = "okay";
+};
+
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	dai@22 {
 		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
 
@@ -682,9 +689,8 @@ &wifi {
 	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
 	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
 	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
 	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
 
 	qcom,calibration-variant = "xiaomi_beryllium";
 	qcom,snoc-host-cap-skip-quirk;
 };
-

-- 
2.55.0


