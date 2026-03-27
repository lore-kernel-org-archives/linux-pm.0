Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1D39B48A;
	Fri, 27 Mar 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642326; cv=none; b=VRaDdtWTQxqdcV5mx7jTqGvi7pG/rb6SxWk3QVJZdRWqvMkh5GpHoATXYEWAErMm0ulkV8EYRqrt5bU2mZy9uh/Oi0ojU2Nx7yKoQZY28ph4a+si62Nh3nFal1KjWbiFp58ppWZU0hl10Kay4gYe5XDESnpJ7pOnPTFlF/7g50w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642326; c=relaxed/simple;
	bh=6e/5jXtu13VBk8LRM5jtWAa5J2pNT8LIvUUdasNSbps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AkHUHG3PJPOa0h2ygrVQk5fBFcweXOksNhHrlJOObSOPUxO5nwaqnBvQLaTSUPk6U2Aa8/lf8cf4zq+GUQnWCHx5ZbtseNHmBrNnnQUBxsy+79q39YJ3cM/uwof5Cf5MjPTKS9DJ3DSvAHAaZ4634Xa9bTjhOa2bKGetocFPHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Vz6x78ds; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qFtB1qJT; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Vz6x78ds";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qFtB1qJT"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642312; bh=BOmVS2GEca7l5PvScE7treU
	x+K7c2RG61soZHTUZLAc=; b=Vz6x78dsmyKJ1GKva8iOEtt/qGe4mUxG3aj9lpj3hqSYl+7duE
	UsHWFZDlN3VOcqSLvrQs6A3W4gfa2ukIGa3WYR/Llb28+1fH0Zy0ECRRV3xbYLHoET9zfhsfRTw
	iBZ4xDXy1+wJ+3dbWtkUw7r7alkrRCGJX9LPlzvsQeH+qyutIyFlWUzUj+3sWeRaQPFsmjcwWe3
	f5MZkv2wSoyuCP9XTi2WKkAAEYi2apGkLmAAk8B68ActNmQfS7kZp7vFjfK9mbR4YsCNIytwY9J
	wOqrAjCZ4JvH4f9e97raYVMz+j7aogMAOJ8Dszk+QyvlWC9XRp7XbbFD0q6jfQ47Xkg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1774642312; bh=BOmVS2GEca7l5PvScE7treU
	x+K7c2RG61soZHTUZLAc=; b=qFtB1qJTpKOWd72c5/jT3BIXSr9e7amu5x2jCEqfwqOQQUcYT5
	btzOz4cx7ik1z/awVwd1LaHpvrvCTjWxMSDA==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 27 Mar 2026 21:11:49 +0100
Subject: [PATCH 7/7] arm64: dts: qcom: sdm632: Correct power domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260327-sdm632-rpmpd-v1-7-6098dc997d66@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774642307; l=1189;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=6e/5jXtu13VBk8LRM5jtWAa5J2pNT8LIvUUdasNSbps=;
 b=8vjZbP8Ml3qZnFSjkIOEr94sryghlHYwagSVw4/kAoEFOf0OKtEiXd7VrjrAZKu26GIvt7zX0
 emsZbFc61KTB2ei+XVtDDOIDXGStilQL+Ihl/cbjbf/Dl7O9kMbpvvZ
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

SDM632 is using different pm domains from MSM8953 override them
where it is needed.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/sdm632.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
index 40d86d91b67f..b1dbcffd51b6 100644
--- a/arch/arm64/boot/dts/qcom/sdm632.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -87,3 +87,34 @@ opp-725000000 {
 		required-opps = <&rpmpd_opp_turbo>;
 	};
 };
+
+&lpass {
+	power-domains = <&rpmpd SDM632_VDDCX>;
+	power-domain-names = "cx";
+};
+
+&mpss {
+	compatible = "qcom,sdm632-mss-pil";
+	power-domains = <&rpmpd SDM632_VDDCX>,
+			<&rpmpd SDM632_VDDMX>,
+			<&rpmpd SDM632_VDDMD>;
+	power-domain-names = "cx", "mx", "mss";
+};
+
+&rpmpd {
+	compatible = "qcom,sdm632-rpmpd";
+};
+
+&sdhc_1 {
+	power-domains = <&rpmpd SDM632_VDDCX>;
+};
+
+&sdhc_2 {
+	power-domains = <&rpmpd SDM632_VDDCX>;
+};
+
+&wcnss {
+	power-domains = <&rpmpd SDM632_VDDCX>,
+			<&rpmpd SDM632_VDDMX>;
+	power-domain-names = "cx", "mx";
+};

-- 
2.53.0

