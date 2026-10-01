Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA72F535FAC;
	Thu,  1 Oct 2026 22:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894363; cv=none; b=XOcVDtJTdwOq3EYuM/HHq9kEVlvdEmoqDbmDP680xAKGEwxobmO9GTcWOVop2dyEs2bUkVD4IGkUDgyevONj7phPySmrOLo0iVAIQtxQimNAlh2spMexEkGgL5zb3aucweX5Im5JKI4N0GWGqWFHfkADGmpmAK7rYh1+ZENj9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894363; c=relaxed/simple;
	bh=LdeD07OUbuHlKI7WbVebNu2JluffV7vDAsjraaCmJEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=arXAf67kXg1khzTXgBkcukMoOezP3yYJFHVTRC99m1vwhHXJhVVjgVdOEJL6UWbr50MfobA3iFs9cUlX6/heFTGZFGH9Bx/Dn3QwNQ9jMrMALWH70RlCnXQO8ZQedaRi4ww1UoHX5f/Ylm0+SDIUzbZ+Mro+iXlXnuEB+vOyydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=PWvTUtqu; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BGtK29HQ; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="PWvTUtqu";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BGtK29HQ"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894354; bh=ThwJajHEHOqiKBTA5Vzxpn4
	nGowEBIDInxsN8sG66co=; b=PWvTUtqu6fct/DlATHKBcFKwJT7P2eLYmkW+Px/SYw0ik7nzWN
	8XX1nPP7d3PZBkAfRMvGp6yPMkLzogNBduZhdR1pRhkY5As8CYaiMS3V/ECCFYAvJiuwf+7V81u
	zVDjQIQ11M0201cEhWeBLTVaahHQqWDu+jsJAJwt4bwz3+O5WC1WwbAkWcXQBjcZkppWAigIjpl
	jHP49EnuyHV7+Sb+expCcDKd0oGY1xIfEI2krxvvVndZ1Bub00z4GCx9BeSQUacOvGLbzb4QsrM
	OS4kpf9btVQzfbFHYHVt20F4ATH5CITydtL8nyMp2UZbVjSRIA5pnlCXxTF5o3YtBNw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894354; bh=ThwJajHEHOqiKBTA5Vzxpn4
	nGowEBIDInxsN8sG66co=; b=BGtK29HQYxFUCaL862n+l5ZEpIMm8GpfR+jm5FxFgk1AeuHl+v
	DUyDW/bPNIc2o24YmiX3zCCFRX2iwJX/ySCw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:35 +0200
Subject: [PATCH v3 7/7] arm64: dts: qcom: sdm632: Correct power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-7-95c47d0f26cf@mainlining.org>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
In-Reply-To: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=1214;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=LdeD07OUbuHlKI7WbVebNu2JluffV7vDAsjraaCmJEk=;
 b=YEty+mvgDUJdjSu2O9QjSGSJv+DJGdA4Wdk4p5yWpjR9VwIABz7hwJDDCkm33u1LiVkTY88Kc
 hj/cSz5LappCrYpZu4B26j64oUVst0fq/GWR8rNt0aP5I/l7hkKamXU
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
2.56.0

