Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0A4A3D4F;
	Thu,  1 Oct 2026 22:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790894361; cv=none; b=mDASC2FrUHvvNi1Yc8sVzGZAG/lQqhxtOA40kSx4jbJQsBBQB5seySLvBdLbH/ZWlmPpBRVeSGurSFMJmW/3HpqCfaUBev6OrH3zMWSVXMY6vy2wdySI/0SfMoTBpBD2yJ8o1z8dL828O1CBoFy4BaCRIha2HQ4ehRri5TbrMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790894361; c=relaxed/simple;
	bh=z53TG5dWIYk6Poh8uNHpxUnVrej1mKY3F0B1iRNYNFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfaPBZWSdk5DrBdsz83QhjpA68CJq+UdqRC3PEmlx0yhjUBvienu045V9alaROUwxMIrEr46TJw6yCwnZZu6qhotSHAU3GXk4Y7lhSVjfmjR2fb/YyGXC/8mL7fWUndd2I2WORPwK8hzwJRdashVV9hgw6fSn+V3meQCE39haiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=i/+aqttq; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=gsE7qwMj; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="i/+aqttq";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="gsE7qwMj"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894351; bh=9ruTVAlBuE/iEueBCEjag5x
	effPrZfC7p8jqytCBQ+c=; b=i/+aqttqgfW5yTERUVo1iDuURz5cPoQ49VyeRTHIGiwKGThgMt
	s6VSu5Xf08LWEOgindmW7Wy3Ei1plTrgT2jX42D+9/z8849CU6Kp2gNoCLqmqlHgIwC4YStgzsw
	8W2DaDyWdUHidYGl5u2G19FpRd9e9jUVEACfvfpwXmS7e6swdCueHkSSQ6y0FvzEtwV2H75bg1X
	5vFudnbGWxOZJp5untUwsCP51O7fObS9A0gxUwxpPcRhFEwsJcbvimZiUeacvPMJopU+iWRRwa1
	n3Krxa1KjKFKhB6r8vX8VlK++XK68Y4nDNN6du62gAwywXyrzrvZPMmENcUuWseqwug==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790894351; bh=9ruTVAlBuE/iEueBCEjag5x
	effPrZfC7p8jqytCBQ+c=; b=gsE7qwMjMr9tg4xR3wrEuZBpp/KrkG0RvTjAesQVuwGyOArSZ5
	LRzgcdGWgnMdbBXMr5X3sVjvDajUCYbJmXAw==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Fri, 02 Oct 2026 00:38:32 +0200
Subject: [PATCH v3 4/7] remoteproc: qcom_q6v5_mss: Use mss as regulator for
 MSM8953
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-sdm632-rpmpd-v3-4-95c47d0f26cf@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790894346; l=1724;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=z53TG5dWIYk6Poh8uNHpxUnVrej1mKY3F0B1iRNYNFM=;
 b=mmBG6zaADGK3d/Thkb7mb6hkLT8HYnK7Sy1n0c8tzXhhO6/UNK2uV8m4LS183e4WxotW7rn8y
 turJueUt7d0Djqpm+GxgmIYGLrGHXUg84QA4/2+mCWip2X/bfPACSAT
X-Developer-Key: i=barnabas.czeman@mainlining.org; a=ed25519;
 pk=TWUSIGgwW/Sn4xnX25nw+lszj1AT/A3bzkahn7EhOFc=

On MSM8953 MSS regulators is controlled using the voltages rather than
performance levels. Correct DT definition and model the MSS as a
regulator rather than a power domain

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 5 ++---
 drivers/remoteproc/qcom_q6v5_mss.c    | 9 ++++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

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
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2f71ed2feff6..8f6312213e1a 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -2728,6 +2728,14 @@ static const struct rproc_hexagon_res msm8953_mss = {
 		},
 		{}
 	},
+	.active_supply = (struct qcom_mss_reg_res[]) {
+		{
+			.supply = "mss",
+			.uV = 1050000,
+			.uA = 100000,
+		},
+		{}
+	},
 	.proxy_clk_names = (char*[]){
 		"xo",
 		NULL
@@ -2741,7 +2749,6 @@ static const struct rproc_hexagon_res msm8953_mss = {
 	.proxy_pd_names = (char*[]) {
 		"cx",
 		"mx",
-		"mss",
 		NULL
 	},
 	.need_mem_protection = false,

-- 
2.56.0

