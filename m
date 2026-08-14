Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A9641A914
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692775; cv=none; b=cMqPUMdpzCUOptfUxi/VyZNrGc0jP1mQg0QDjrRQv2235dX+oDbvL7ct8eBTN3dJEBoJ4iWthf6a3+74QLltmRJIf95DZKGemtoR9m8j9ewLGZOtWXz1Eo3oRcUgXLWVgWp2A5RLMS3Ppkxmj2txgd/apujI5jK4Ad+GwocdxjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692775; c=relaxed/simple;
	bh=8hC59DyE4kj4f5wzO4D/36omhn2O6YGXfOLRxNZloa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F1dSiN3TTtNlbigA4QqmrcyV7QZsr6GLg9HfzHacRxLDebC5iBMb+J/bDy6CO/m4cawhBBXR1k1u25PVFFVO2Lh9b6nWOSGFBu5o113/LasoQWcYBdMFRqpozdhswllxJjIz2n8se0dgppBmoGJRJhBnYlSEEFAB27dxkvLgKho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HGJngbYj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SYux/mul; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HGJngbYj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SYux/mul"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4Qd0g3614495
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zp+kA094X+7twp5uja4H1YDm8f2Rm0D13sUBNmXg8Cw=; b=HGJngbYjRMOrarCE
	KFhpMptW1UjYqafDEYe2rL6wkNAV2KygZXURHGALi/gJZgrCPl8nQDHokEoT72Xo
	z9gRZfqQs5Z2MDrkN/GE6mJM/ABiOirplTtrJIzco3aEKCExCLOiB2Evl5v6/SnJ
	JR6gs2M1Qr1IpRyAyfl6WOczN5M1CnUU+4/waHhzwZwIbA1zkohAaTZlqgZeRwyQ
	YKahf3EMVSV7CcrSojbtdgfzSCI6oGLfTzsWdVW/KPiRLowSmVCPUug2Uk4yeJFV
	1vfkhGVS28IK6p4gzP/ApnuAZET5/qtLEvzZ0+O+NpW/qh0+x5raz3n2aXKjeVeA
	Eo6spA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy32pe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:32:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84eee2147ffso760723b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692764; x=1787297564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zp+kA094X+7twp5uja4H1YDm8f2Rm0D13sUBNmXg8Cw=;
        b=SYux/mul5SFBA5q7OJL/BTAY0Bhxe6k9r6B7QIzj+3H0CUInrDdvqy0PTu8y2mTR0A
         j/bP8YjPm1qp1JgE15KNsQRYQ1NLzvXqU8Y1Q6O2z7OpWEu1Ejo9hPvaygJZqEt9q1MC
         n9OaIyKrdyb8L9wtHc4U5IR7Jzkf8vXJ0qUnD//23g0tlIFtleyoBuCzh58115Nqhieq
         taBjAaN5qGAmDncqrzJFYdZVlu56hYvuGHXqhrQCHAiDM/PEuEeUt3ONaEa/8auaZQQG
         3PMnwwWzyPkuC+6ug86dyB5ltJBRK07CvsrUx7yDAoSCDiaAXV/V/UHbPIxJeIeDHhHy
         +b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692764; x=1787297564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zp+kA094X+7twp5uja4H1YDm8f2Rm0D13sUBNmXg8Cw=;
        b=gKRi5cJfslM5k9wDKh62SjwpPL7fVXfkQUQHRqRqp0Ua8RGEywy4kF79fQYDbo+J7x
         /V/kBfe675G0Yb+YDsaGnDD6k4qaHj5LhsZaeuGaI/WqdDzLvXC8RmeDQsq11B3gq0To
         rDK6ktygAzsbYN4Vip2tOAbievgX/8GwWSb4UeJMSWHf3iCxNwdKv2kiJ6pdmS6UNFE4
         L57ZNLAZZIBICo3woqLMpk0+btSils+aiUaUzjihdQBV0fV7rbrgYbodibY35BnVNjRO
         6wzhautbwx9f9TMQMCLDtOuihv+QH7jypapvihoQKRfJu5z/lIch5no5yE1ivZtEOwCu
         52GA==
X-Forwarded-Encrypted: i=1; AHgh+RrRjdPPyMrXGUahzzp/8L1rQYlcYuanNAFRI8Nkm9zOkp02YQuVCK9zIW9bNO3Q1gCj9tOWJi75kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtf6WEYLiEn8o6d3pQ6B1BFYXq/PKF6ZVp9d8oba83K3TGVFzO
	c/+6GNOzfMqW+kC7R1zLpKG+JLyWWO2y5gocf+DjLnuFPoPvLMJyWHHxKsx/5sw2pD8ofHplxWS
	rOl5JqBBwtrGJj9dEg+JTE6QzkhG5Kc6ejYDr4bu3MeXZJVtEXw7CfEn/rY7V6A==
X-Gm-Gg: AR+sD13nBpQp/WgHGtqzRmWQDvkOxR77W9YS5r2V57I1l//aij/o/Uo0Ify1C/rCAn5
	P8OC0J3EHWZ3/Q2T2P1/SVZNPa4KtfdKeD4K9aQnYY4SRsrF0u2g0n358ceMa65k4x1PWwXfcWo
	FsGuRsy6xwGcx5l9vKTgycmPpQ/wnlq33A39SXAg7NqImrZE7dyMcFEVrc+CUTTnLh2l0kkWaDL
	UTof9vmGpr/ALBmUWGVv5uF3MMXqJZJTPeDmbIhR42/7+jJxiNeU4rgbSsXA0OteGUfdQf5eZ5f
	w7vpsDTquLJAvczKti4YngkIX9pZ/DpRXxbyeRLEva5r9n+ImpSecI6TOt3DLwStWqhdv15gObS
	2awbk6yz74rWapNZiA+uS6Y9VPKamYvvo78lse6i8l3uH11W6jVoyzt71tIRwNXe5noNgUnOIWe
	msdC7UebOevSdDxdNIBCipvqk=
X-Received: by 2002:a05:6a21:3398:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3cc71d53eacmr4045608637.21.1786692764425;
        Fri, 14 Aug 2026 00:32:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:3398:b0:3bc:5284:5445 with SMTP id adf61e73a8af0-3cc71d53eacmr4045548637.21.1786692764036;
        Fri, 14 Aug 2026 00:32:44 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:32:43 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:36 +0530
Subject: [PATCH v2 05/15] clk: qcom: clk-rpmh: Add support for Kuno RPMh
 clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-5-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692713; l=2020;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=8hC59DyE4kj4f5wzO4D/36omhn2O6YGXfOLRxNZloa4=;
 b=Bp3nz6QUprcZk2VGvZmq2p8bTdzjWGyyjR/4qIxFefb+IZyXceD21k0toykb2OeXrboXpRTIL
 rAH62D/G2N5DfIQtvymarQsd9LnsiUadpWv7+b/csPnmAztLysObdNR
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX2Y9e/zWi+cH8
 9cGDnHVqi6qGfIaMkgXrSQFcjQpbsCuP3ytBchl+i/lR4xvI8aHc/ItO/dcrz3C5iUFeAsCDtBD
 NTDJ4EdhVlmWbyH0BXlHVSatkMHiQJtAZ0iuZZOTuKSW9G6jN9EaMLXWad8KHKplfJOwTNlVkIv
 1EBtDhCJsqVPrDxkunNbvkoQOQPO+brP4rm9TVHmbdwFOm0NiDpbc3sJUJkCyoRDXZA3sEKhGoZ
 z7F5G9cjI6qJYlomO6MjlXr2rOMnFtd+RxMjVrXXIRN9ZO9qm2oZK+OvjlFCacpYLBs8YtfpOvW
 iCseLkc4ebQkztZuLixrjvDSbbO0JbxOKayB/Oya1Ct4kAA/ell4mMUCDRejmZAyKzMnCssSLh9
 C5siobnFnR44uoUXc9oZGwvgdbR7RaeBJq6aAQesP0sHkct573NsRlHI7tKj35mOQO3g2UFI3s/
 idR8bRiyAFHxF/gKzww==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7ec49d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=81ep5gnlwPa1PUBqnVYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: OAq_SRpc2IGUp6fSthUJMeqNS5F4u4M1
X-Proofpoint-GUID: OAq_SRpc2IGUp6fSthUJMeqNS5F4u4M1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfXy3VTqW9slgW0
 454RfNfvDD+Zf0CMf4+jujGNj+TjxKj00dkF1E72fJVgpnrTCYn+pe0+daCDFf3rwuyWjXRTcSI
 hI+dmZBicfa2hwmXsi/iJt87qhn6Xec=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Add the RPMh clock description for the Qualcomm Kuno SoC so the
qcom,kuno-rpmh-clk compatible can provide the RPMh-managed clocks to
consumers: the CXO div-2 (and always-on variant), RF clock 1 (and
always-on variant), the QPIC BCM clock and the IPA clock.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-rpmh.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 6367b2a5a4e0..d8c3a6b12d4a 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -943,6 +943,20 @@ static const struct clk_rpmh_desc clk_rpmh_kaanapali = {
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
@@ -1103,6 +1117,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmh-clk", .data = &clk_rpmh_glymur},
 	{ .compatible = "qcom,hawi-rpmh-clk", .data = &clk_rpmh_hawi},
 	{ .compatible = "qcom,kaanapali-rpmh-clk", .data = &clk_rpmh_kaanapali},
+	{ .compatible = "qcom,kuno-rpmh-clk", .data = &clk_rpmh_kuno},
 	{ .compatible = "qcom,milos-rpmh-clk", .data = &clk_rpmh_milos},
 	{ .compatible = "qcom,nord-rpmh-clk", .data = &clk_rpmh_nord},
 	{ .compatible = "qcom,qcs615-rpmh-clk", .data = &clk_rpmh_qcs615},

-- 
2.43.0

