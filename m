Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624758599E;
	Wed,  9 Sep 2026 16:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972129; cv=none; b=Q9kHB+bOt2+XIS0o8YYfeg0qr1KxNhJwIhoaXPLJ7YkfsbrAdHomSTNtdNfI7P/t82g15HU1Eh7vZlcLLf7wBU5lcyctC4N3QTEwNON1T++8Hzbwrcx7v8NK4Mrd2c6wG2WEn/NJGguHxfQ1OebJSHQTxQ4DbKtxTpX46A9iqH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972129; c=relaxed/simple;
	bh=Saw9oQjpmCOPBdHQ24rWkzLed+yX8U8tzZwDqBe85/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bu786EEiYGXyjttPb96SoxPfzzAkwUB6ZKwmV5BfOjQpuDHYWhMO8+Xb+qb8nH84KU94IZV9TP2IaVcOS12diTpZG3/QZxpoz1WZkFd+QDcHCkN0IOlCKNKmPkpIhkUw4TO9WJLSNpS8hcZca+kIDDfjpvpk0aw6RV9eWFuBhMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvIcVr0T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvIcVr0T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CED21F000FF;
	Wed,  9 Sep 2026 16:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972127;
	bh=zMBvILJQ3rVZJDsl6gHMlJGk+imyYQUzgOFzEqMBpR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fvIcVr0TGDx9TGuQlhENHAl+KExVig5fIpBzR5lLDvT5G21ByOmwy4GhZY2UB0KXi
	 YfWsZ/VgoVMsFx5SA1IrVzHG5tELNtEDFyY2GwKI0GQfA6o5AI8Up1aju7/3Rzgrca
	 P4nwcUVkKd1q26Pz+2r/QOrgi+FO+3/Q33OlxCIEn1o37CUlIT29Yd9T7Yjp3g+Hv5
	 VT/V7trcMAqFHkzhWuXbMDB90kdHbzrqsK0tPDJYa6PmwtSNPlDyVUdxfQ/sB14pX8
	 Ji7HvvdccwAuvpolRMmaK/IDs3OoY2+9lnTTSbDJRg7fw52iNbxGF2SlfXACY3qBs5
	 u+VVNt//2u82A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Wed, 09 Sep 2026 18:41:55 +0200
Subject: [PATCH 2/6] interconnect: qcom: icc-rpm: Don't skip small votes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-icc_rpm_smd_qol-v1-2-6dc5b5e97626@oss.qualcomm.com>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>, 
 Yassine Oudjana <y.oudjana@protonmail.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Adam Skladowski <a39.skl@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788972117; l=1589;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=+u2BZarVZ/NIuhBagHU5zciFixnbmdImgYtKugL0Uwg=;
 b=L3xRCMSYg/Z5tqs88ZtXF+Uf5b09FH6481QkQ8SUPpBK8qiYHytZ6xWl8WQIOb5hr+hl6ABT9
 HjbfV8v0ZHRAC3CRmxzd+Qr1qMoNirtp1TYATLwhT5IA61zKrAdM/gP
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Small votes (such as 1 or 100) can end up being rounded down to 0
midway through the calculations. Use qcom_bw_div() when dividing to
prevent that.

Assisted-by: LLM
Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ca4c8a944755..f571f002ccbd 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -298,25 +298,25 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
 	u64 agg_avg_rate, agg_peak_rate, agg_rate;
 
 	if (qn->channels)
-		agg_avg_rate = div_u64(qn->sum_avg[ctx], qn->channels);
+		agg_avg_rate = qcom_bw_div(qn->sum_avg[ctx], qn->channels);
 	else
 		agg_avg_rate = qn->sum_avg[ctx];
 
 	if (qn->ab_coeff) {
 		agg_avg_rate = agg_avg_rate * qn->ab_coeff;
-		agg_avg_rate = div_u64(agg_avg_rate, 100);
+		agg_avg_rate = qcom_bw_div(agg_avg_rate, 100);
 	}
 
 	if (qn->ib_coeff) {
 		agg_peak_rate = qn->max_peak[ctx] * 100;
-		agg_peak_rate = div_u64(agg_peak_rate, qn->ib_coeff);
+		agg_peak_rate = qcom_bw_div(agg_peak_rate, qn->ib_coeff);
 	} else {
 		agg_peak_rate = qn->max_peak[ctx];
 	}
 
 	agg_rate = max_t(u64, agg_avg_rate, agg_peak_rate);
 
-	return div_u64(agg_rate, qn->buswidth);
+	return qcom_bw_div(agg_rate, qn->buswidth);
 }
 
 /**

-- 
2.55.0

