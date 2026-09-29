Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67B954B1AA;
	Tue, 29 Sep 2026 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706550; cv=none; b=WATDlUV2UN4+QwlqnQlvwhVjAvASMr7/Wa25xlxnRxJAwmhvSHNRxzOJd48JtRTU/CVALYw3m8vIVctKfOT9Vc0JtDkj8jqyE3f8EcXg0cAWBeDHVKtZlwQfY14KcEH+mVzY2cTSoJF4UfEwumd2am2h+dWHEkkb/wwXLf337VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706550; c=relaxed/simple;
	bh=/UCJqM69l+mBK5cLc+/7jQiceKRDGABHpNzvTW4cZhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOqwsPW/HfZJfNPNiDKA4KjdQU8RncJjDoOTQHgOwpp6YqRPo/IFXbLAyvQ8GTDhLISj4y94tElXboUOHy/wTACTaYYCcHMHyG2A3ux40tJOt9BPCkcr+RSi6mRhxmHbw9JHuU9D9o/l7nI6MTpHsqUauxbKU2fBBYjkKwi0+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hdopW09U; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=6RL4wPNL; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hdopW09U";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="6RL4wPNL"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706532; bh=E+5m8U+2CcrFfH/M9yZSCND
	lrlyXFG0z3T47OWBnwUQ=; b=hdopW09U53jH6WYe/yzSZUf07AmCJfA7ThkZosqdMc5R2qnRDQ
	KyMHGEesG4UO7xbl1yK77W8a+ZpjaSKMLC67g+myFQ7W8HHzgSxHn9IIYwWZYMpZHYxv3r6YbIg
	CAs6DwLa8FZ/S9pCyemmJbuuUNem2BwdEn7EG2Ni2vwBRKETRcytgkSoMxH6kAQvYGGs/WGoyNo
	bZG/J5WXAn4I7hcofjSoed4LzDQi7n3sUW+e6ESFofB8ZT8JCQglxF/r6XWj27fWgkXSSuehegI
	DgMu4Bkll4vqK7WMecx0VNNSgG1kOfMv2recZ8mTYc6YKuFsATUsMcfNT7EevhMC7DA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1790706532; bh=E+5m8U+2CcrFfH/M9yZSCND
	lrlyXFG0z3T47OWBnwUQ=; b=6RL4wPNLpbkCMNYXcRlxKQFSDilINqMaFWmTCQRiVCl75ngPSB
	LvgHfCjHPEJvsq+4tDJhy3AAfziyDLHKgLCg==;
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Date: Tue, 29 Sep 2026 20:28:32 +0200
Subject: [PATCH v2 3/6] remoteproc: qcom_q6v5_mss: Use mss as regulator for
 MSM8953
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-sdm632-rpmpd-v2-3-97ef8858161b@mainlining.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790706517; l=1724;
 i=barnabas.czeman@mainlining.org; s=20240730; h=from:subject:message-id;
 bh=/UCJqM69l+mBK5cLc+/7jQiceKRDGABHpNzvTW4cZhI=;
 b=cQq0A2TPf1f4eG0Wr2qVg6HEwjuy2/c+CxaRtt5qJ+W6j8BImAyGG9VHzKk+DOqlXAnS9Nnha
 QBzqYU9lL2bC/iNOw73IzjePACrGGto8sS43rbc24DzOJWqeeFoKqc7
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
2.55.0

