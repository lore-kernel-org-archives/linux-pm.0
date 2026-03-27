Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78939903B;
	Fri, 27 Mar 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642325; cv=none; b=c+KiRMA3xV2jL6Vht/o1e4ICJFsEnaOtfYa5/HwFZz4DVie2yuOhINprD5/m6goL4s2yCkcnkby0PuiI6XmKK+B/sEsLgz4wIkP3AnpOte0PB42qQ3+Yuct7WfcSNzfmCrC2f5k2tafvnj6dmQlG48wh1aeFgZXnZqEG8w9ETWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642325; c=relaxed/simple;
	bh=li8k6NvmwOJUKGTCWxc7O1wcEBsi5q99DzwNtsIk9uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBONpmKhnbXJieQaM686cKVxRe9tW+AgzLAnNQea9YQLUJ6OY90+LZvAdJZaogc7+C+Xaj7Vhl5BoAxDy53EAyPsbWYtqsUc0TGBjy75CdSIhG81Zz2iBpC24cDKfdzUicci6sRF3VSzOlYQnxvpTnDC3bERBTE+izMZmcCumhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=eJV42E63; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=1U0eKHRU; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="eJV42E63";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="1U0eKHRU"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642310; bh=oTQb0KiUBDhaRKdojAhDpNp
	tyuBC6zXmXVY4SOhC5r4=; b=eJV42E63m5Y7EQeQJMEPWYSR8CJaSUk1j9SK2D8FJhlT3InaIr
	/kVeGkV5rdPt6yV+gEEl5iAh+tNa8Jti88bldLNrl6VgAKx023RQJXOkY2IQ3vQZ5gEggrk3IHE
	MFibXlLb3kERAKzCEYJSw8ofhP5La3QQ7MrtkiVvbQvaqUJODNAxjlJ3aerpdDqurCVfVEm3cIz
	af9geJHujm2ug0UAiLEChzIDr99dC14rEVYyIAyxvFFYdL3Sv0UDw1IS/BmgdTb495lAoH9gKeV
	HRl8lgqWfAs7+bdtwmM6G43LrjvLh5UvQmdl5vfRdLTIfhnpPoPMA09aTeYjAYLQAsQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642310; bh=oTQb0KiUBDhaRKdojAhDpNp
	tyuBC6zXmXVY4SOhC5r4=; b=1U0eKHRUYbrvTPkZaLxyCKOvQ1/X2da2JNS4/YwMSG9OB4uevv
	g4g7bET9Qqi9IgKIDGOcd3HN2rWZv9dnSaBA==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 27 Mar 2026 21:11:46 +0100
Subject: [PATCH 4/7] arm64: dts: qcom: msm8953: fix modem pm domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-sdm632-rpmpd-v1-4-6098dc997d66@mainlining.org>
References: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
In-Reply-To: <20260327-sdm632-rpmpd-v1-0-6098dc997d66@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774642307; l=852;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=li8k6NvmwOJUKGTCWxc7O1wcEBsi5q99DzwNtsIk9uU=;
 b=t+gFL2tNpr1fIrX/oSxjVRM4UzkxXwGwW+1pPz7bdGJzG3kUSn3YXbK0gJZlOG6anlgXMHS4l
 dxA+xG5FNHdCL7yJZeH9k5bacP3Tnui/eUi6zoHx1odIb53KTmxES0K
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

MSM8953 MSS is using mss-supply as regulator.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 753167c3f861..c7dc08858d54 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -1451,9 +1451,8 @@ mpss: remoteproc@4080000 {
 					  "handover", "stop-ack";
 
 			power-domains = <&rpmpd MSM8953_VDDCX>,
-					<&rpmpd MSM8953_VDDMX>,
-					<&rpmpd MSM8953_VDDMD>;
-			power-domain-names = "cx", "mx","mss";
+					<&rpmpd MSM8953_VDDMX>;
+			power-domain-names = "cx", "mx";
 
 			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
 				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,

-- 
2.53.0

