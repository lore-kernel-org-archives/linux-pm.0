Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E541D202
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853124; cv=none; b=TZ3hYhFfR4zX1x3q1JFjlvjWXsggvZR51I+LBK99wbxCVuyDcs/OwaKfHFzr4Htg9uSalfPGl14KJ9PrJSTXEiIVNlIc1iJbMmZvmpMtvsUs3VtBc6+CChU2ZTdc31SOFLRsgf+gixgnhYQeuAnsh1B4GExLnGPd4SBQHu85zN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853124; c=relaxed/simple;
	bh=HmmI194gyOrC38jn1kOmQP92tC7eCM4pFbLwZh2jkps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ebpz1h9HZlWzqIIHUexy1rxmRUkoETacuMyc+tCHwfcYRzCiJ4UMnoxiQbMqa6bpKpCy9awCjcVyA5RlkE5qRUgr9px5Zd/2EWXMX/Ki7vp5BGUbQcAxQLb7Oj4aUjTjYAfczWxRK0JemGkdcMHOiGz7f5+YNrZbmiZf6uXJAKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFjphGD1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OGKkloIQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFjphGD1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OGKkloIQ"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHYCfl1122342
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hXdk8G4pm4CrNjX95hM/lx/4VQ+3Uhckavbrp7NZTHs=; b=dFjphGD1N1rclYjX
	8PSV+w6jwQkIr9YsWFTgstUfoQy0sQTtmwYkZwWGWf9WrrKhCCKDRV9Sy44n8wgX
	9/R6ju+uTmnYRNLj+F+bFhRAFosKeaoHAEdxTGctP4oFWJxbfstvSEJUzPcSqTvQ
	PNhSNznNXpI7RwaYqH/7/klKwEofU5m8o56E4GcbHF2B02b5CeFb4h1MbghFoCUj
	5CVoYfBPrK+W2mzMsTawrpG/17oOGRoBu2cW0Rr+OReb1yrcvZn3KQF8wr4wmVr6
	0MwOr0Bz145oMEBJLNBBgoFa5ucHyykmQjLc6lZbG9nt5zqEaGykFAl2Pl/yEXZh
	n+8o3w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gapgv98vg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:52:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfe48ca1efso1741635ad.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853121; x=1788457921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXdk8G4pm4CrNjX95hM/lx/4VQ+3Uhckavbrp7NZTHs=;
        b=OGKkloIQZCYNqRsq4nlpVvITEsr7LRElGFP7JZnhPYItECyap+1/eK33XW54trtgh+
         yVG1I/6qoP8QNUhmYp1iuQc+1fjYAkpjV6A0fDSL2uIpIG4MH3i3UqNzVZAl57iHS51V
         r0O4btIzSIuoZ5bVWoXESoGRlbUwaN+kyhmIiZYoW607zoGX8wxaI3ieMkIJRf/AbWSC
         dRNW6VJN9f2XCy32mGNqd+d2M3KXYdrBXmb3VhQEMhGnL/fzrkYfV8BtdK9AM6FSO8m7
         5Yy7ckN03M0RhN2LZ7HK3c7dp70sTrEYll8QJz2RuFrTb2l5RCnnjRqOzBg01UrcBsXs
         ky8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853121; x=1788457921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXdk8G4pm4CrNjX95hM/lx/4VQ+3Uhckavbrp7NZTHs=;
        b=ASk7QqfYm6rwWIYxcpyU9LZDwXRtxjX8FhbFIfQIQCrsg9G5UJ6J85zNS55e5XbMLq
         4LOPjVAwrczb28h7reYW8HDh7VyIQBTI4z4oQ20RJmF+1M8fJ7A28UaJj8B/03pHJSp6
         uXcob1Vvip9bQ6nrLql486hZyZF0DKpJMGPC5lAc62bVKH++uNJSuuVebvmFTuZGUFD7
         AdXbuXX8RylrYjnKtRBnHOTWxChd5xN5xHDolgZ7HQ54G9CvMiVdxZtIm+ohEXKWwe8D
         TrkioPEiIbGjO6cbV9FoHPyEj3m49//1JcpbWj48R9ooeMz5SC9ixB67v3fZlFVmKDke
         1D8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrh7dfE7/bZD3jsbIICUXA0h2GATgmiOogWdLyQxGipa5DYFqWBGXghGvWfFUeSj0SJCqEgbD2H/g==@vger.kernel.org
X-Gm-Message-State: AFuF++kDI2U6hWMxC0I/VHLsGmgQnyAanSQpc4W7iYcNCOZIDZan3sk4
	FspUTtMQjLkPL24TaRtMVpxliWgBXKkiMlelJnFiaBpUlIODGIGwhyoxPob8xux7k+NPGGaEJ0f
	66jtBPbsw2wlPGB9Bm7eRiq7y8nIFGJKfgJwqAy81sZAVW1GD4OA2G2/G1sD56g==
X-Gm-Gg: AR+sD12oCJGFkCB4htstNgF2BaE52SsLbTryfNXo+wX64Ye6GaMQxBikkW2ngH2J2F+
	Z7n57p9JtfTJNMmzgem+TPn3tKIRr5u7IrVAUm3qznS8M+ytNQdZ0FRMYwY+gMVFgRGnstxB9xx
	hSD7YUdWKM1QEoOHv1JS95cMJpSicgNC5VoP789UrNN6yp6jG5MU785UZ3NmYo8sIZToryIyRTy
	jisM5lJetC9aErIEhQhrkGDtCs1LRho8wdM06V/Zgw22UI3yLjIkJBadsEC2UnOaAazkCWBMSpr
	3uZEZH1vFH6S6PdmzfQDPNBcc9wyvI0CRBGMyJeUjfpXHeTKMdQIuIIrB4bS5XMmudPIlM9bkkg
	Eafk8ekWwcYWnlZosBal6dxtZs0mlnlsPXbPBYHOazdHvX6tJLbwJ6Eit3NpzBtEejLej/CNQ8a
	Ww7UGvtboMdD26Xq668FASyXI=
X-Received: by 2002:a17:903:144b:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d74dc2fe73mr15356085ad.4.1787853121209;
        Thu, 27 Aug 2026 10:52:01 -0700 (PDT)
X-Received: by 2002:a17:903:144b:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d74dc2fe73mr15355045ad.4.1787853120764;
        Thu, 27 Aug 2026 10:52:00 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:52:00 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:08 +0530
Subject: [PATCH v5 05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh
 clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-5-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=2134;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=HmmI194gyOrC38jn1kOmQP92tC7eCM4pFbLwZh2jkps=;
 b=DJ/9X+zyxNdrjvjVzxUgzWUEDwu9bnEmv+BH8gG9CMZaVCq54yxqRXbSgGYGyRBaV5davTHKd
 C5aYGAAFLH0AN+pHU9UyxhEQe4FgERHHN0OYSx4KeaK5c2jJs9Qpcx0
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: 3iHfXFbvHfMRBtKmmJWRE0i1M2A1HX2W
X-Proofpoint-GUID: 3iHfXFbvHfMRBtKmmJWRE0i1M2A1HX2W
X-Authority-Analysis: v=2.4 cv=FpU1OWrq c=1 sm=1 tr=0 ts=6a907941 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=cbMe9IPPLhjBV4UIYdkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXyDgJ1yTrVdng
 C93J/qtKXTYKYSf/UxO16b1lkDpAoiXoj5E7AB9p6168c6b/0QlrCdaAb0Gr0kFrmxLxO2ZHvRf
 8tHZmBTRyJB2yD9dMY3Jnb4DcX6AQqAmo+gaqWwx0GVtp5iZI0aJuhshNAvPnlI9sP7Q2DmO1FU
 Wp7wXrMNDUnV0/Hd9PYRZXixNQaCpBE7FOl8exIA8j1Epx+rWdDICkCeTCtAwmEBbLWUJgczBP0
 cbPnJpw+pO8VSnHYRq/1gO1JA+hDBK+NI2/xWkBQy9zv0WOY2wgmFV95r+xbhq+UXsEakODj6b5
 sdOGPtyOjpCxUSqUvJEsDAbTTWTOIwmMw23mbnQ2BikOQtHmnhqYpT182tSQCC1YT3WqXyuHrQI
 F4hzzIq+81IcODfxIaSK/oIjKCA3DqXCimPjLDeKBKMWwZ/mPIdhlF8GSn/56a4VTbwzynBYAGI
 n+ISf+B+6ws4UqYYEVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX9r7HcUBKyKCh
 64MHFW9dnx8FDunFS+kId+w8Au7hv3U8o/kMHDU1EG1K/1fV/Do/ViphT4rLWvBKZqDTVtetNtP
 kHx3ob5zAe6B5BX/5E2NdrkPCEX5Gr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Add the RPMh clock description for the Qualcomm Kuno SoC so the
qcom,kuno-rpmh-clk compatible can provide the RPMh-managed clocks to
consumers: the CXO div-2 (and always-on variant), RF clock 1 (and
always-on variant), the QPIC BCM clock and the IPA clock.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index a224a94ae273..ec8700b6186d 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -937,6 +937,20 @@ static const struct clk_rpmh_desc clk_rpmh_kaanapali = {
 	.num_clks = ARRAY_SIZE(kaanapali_rpmh_clocks),
 };
 
+static struct clk_hw *kuno_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &clk_rpmh_bi_tcxo_div2.hw,
+	[RPMH_CXO_CLK_A]	= &clk_rpmh_bi_tcxo_div2_ao.hw,
+	[RPMH_RF_CLK1]		= &clk_rpmh_rf_clk1_a.hw,
+	[RPMH_RF_CLK1_A]	= &clk_rpmh_rf_clk1_a_ao.hw,
+	[RPMH_QPIC_CLK]		= &clk_rpmh_qpic_clk.hw,
+	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_kuno = {
+	.clks = kuno_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(kuno_rpmh_clocks),
+};
+
 static struct clk_hw *eliza_rpmh_clocks[] = {
 	[RPMH_CXO_CLK]          = &clk_rpmh_bi_tcxo_div2.hw,
 	[RPMH_CXO_CLK_A]        = &clk_rpmh_bi_tcxo_div2_ao.hw,
@@ -1097,6 +1111,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
 	{ .compatible = "qcom,hawi-rpmh-clk", .data = &clk_rpmh_hawi},
 	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
+	{ .compatible = "qcom,kuno-rpmh-clk", .data = &clk_rpmh_kuno},
 	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
 	{ .compatible = "qcom,nord-rpmh-clk", .data = &clk_rpmh_nord},
 	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},

-- 
2.43.0

