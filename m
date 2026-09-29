Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E975519BF;
	Tue, 29 Sep 2026 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706558; cv=none; b=cq+/Z+7LRBxh1oGaN1S4AcCxPzeWlADmA7qlb/kzc9Fv/mlsx4mhifxzYAo9GzaIzmG0qfRP35O5a/58OSJuuejLVR8aNGyICfTA9r/ds3BDKXCHr8fAl+fu26eCAklSkmT83cTh4S6sQvjKJQsmYCZSpvW9ZX04sug2ZOUm8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706558; c=relaxed/simple;
	bh=oeS73cz1WttKdvCwJuPNtf0awdQaIChwa2ENdCxPEGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otQTwF6TlF4ZGFiIc6uzyHlTzedp2LEd2chT6pOXBsMHP2gD38S2a0AJHYx2/xQQ9PZ2U9oVQ6bevJhxTn2qBAgFWwvRScnyvPosfEC/rKYh2CpZBNBMrWYpYEAwQwq4WkdxImGpccHGw4i/7cjSv0bZSDfFc7n78AmxVkFOHh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=KYQK7e9u; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Tnhl+Vqh; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="KYQK7e9u";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Tnhl+Vqh"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706543; bh=vOUd3B5n0AgEyb894A4eeQu
	NKvHdtrj3e0iX8tFzPD0=; b=KYQK7e9uN1vhzpUhCPXstYq58Vmt0hfjYzPolX8Bqk63VL7Npl
	hHveFmrKUblD4HnL4+xcfQp0M6zQf0PD+ljehB3g5HwQ1vsLczFsfAFWzGOX9bpKYTSkNl8JXpl
	Y/3CYZ4IHppAesrlz6iehB8n7PqfdWpV3MM1/tMj+JLNM3pr5AaKGnPrQ6AWShN68Q34Xg94gyn
	wujowGKrawMLWiJra8qccMcu7e5kb8/ULNP860RtOy36M+2ANiqJuL30xzO/84RqR9vesNyXR52
	1RPiKpW031RovTrKW4pUq3UnYhuYhrLbwz1q710fItNZBeX4wUH4pNzWZqIrgaQB8CQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706543; bh=vOUd3B5n0AgEyb894A4eeQu
	NKvHdtrj3e0iX8tFzPD0=; b=Tnhl+VqheZjVCzB4LRcUsuIXsAD5g8NBlARjztPhIZmenIcxO+
	GRcRj7GBBUa0Q0qD5HBbMM8GxJw+J0caQ3Aw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 29 Sep 2026 20:28:35 +0200
Subject: [PATCH v2 6/6] arm64: dts: qcom: sdm632: Correct power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-sdm632-rpmpd-v2-6-97ef8858161b@mainlining.org>
References: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
In-Reply-To: <20260929-sdm632-rpmpd-v2-0-97ef8858161b@mainlining.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=1214;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=oeS73cz1WttKdvCwJuPNtf0awdQaIChwa2ENdCxPEGs=;
 b=uLYHPLQUKxLOhODqWsx15Tr+3U53JPCRDMvMxbFXhWdIkueqdU5WQ24wOIFrkSpQKLfFzIvAG
 ivqdPqBPRfoCGGWDHR9c4ApZ98iyc8GdZ5p3BPwPpAzCIO5YTPhQc/c
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

SDM632 is using different pm domains from MSM8953 override them
where it is needed.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/sdm632.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
index 40d86d91b67f..5a677da5afb0 100644
--- a/arch/arm64/boot/dts/qcom/sdm632.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -87,3 +87,37 @@ opp-725000000 {
 		required-opps = <&rpmpd_opp_turbo>;
 	};
 };
+
+&lpass {
+	power-domains = <&rpmpd RPMPD_VDDCX>;
+	power-domain-names = "cx";
+};
+
+&mpss {
+	compatible = "qcom,sdm632-mss-pil";
+	power-domains = <&rpmpd RPMPD_VDDCX>,
+			<&rpmpd RPMPD_VDDMX>,
+			<&rpmpd RPMPD_VDDMD>;
+	power-domain-names = "cx",
+			     "mx",
+			     "mss";
+};
+
+&rpmpd {
+	compatible = "qcom,sdm632-rpmpd";
+};
+
+&sdhc_1 {
+	power-domains = <&rpmpd RPMPD_VDDCX>;
+};
+
+&sdhc_2 {
+	power-domains = <&rpmpd RPMPD_VDDCX>;
+};
+
+&wcnss {
+	power-domains = <&rpmpd RPMPD_VDDCX>,
+			<&rpmpd RPMPD_VDDMX>;
+	power-domain-names = "cx",
+			     "mx";
+};

-- 
2.55.0

