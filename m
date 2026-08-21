Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE804C77B4
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328582; cv=none; b=dYUfWs9a/nOxAgLq14YEEMpx8oPle2fGqgjg9jjAVJsJet+wD/HjDDtxC51E0CXdVOrS82hpiyR+E7zbrIQKsY7vyGIex5Uyea0iZLqLu5axOtQCxFJ1TjxGWA038uIIV72NWnKGIo97csr7zlI/qXapxcznwTeYU7r37EFCJ5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328582; c=relaxed/simple;
	bh=tzDqNTEhoFVwtAYNfXTfFhwNi1y+wzNPDmbGPl082TY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyXyZjYb8ix4/vCQqZDrn2tPsP4pq9B53WKn4wBUTRRNLg3v2S0QSP3ysVOIOYiyp4IlmKoG0lZj5b2NwfisRd0jvhrGHBHK/LODQnEYbdI+DQmNsFKEDwKDsJqKTyN1boticx6kIk+fLJl2FUCzSzXpEqEZm+c3OyXIUDvVm5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sc6ERies; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aDJqomlL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sc6ERies";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aDJqomlL"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LFmLF83876810
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yksA1f4CIEDmfZUrVzhMhyAFPy3A2If+RJxkkjk66Z0=; b=Sc6ERiescPJxMtCO
	q20LPtHZHJlYliJPC77R2myg7VPX1FBpmh4j2CABvdp866c6hagoFGYJ4agPu2BL
	vhuH2Qt/fQNe0U845R/0llDR9orG8AhBhR2/xqVZhhig74LdNwj93FIduXHCM7HG
	8cEjrAGJZkHTd3e7Zcc+gNk4sBPCJPg1npfC0byjo2aMc2L1NrkeSLrNu5PWXixF
	SxZJjlTbhBaZhUfTYhzlKA5NBbCS7O+AhY/xXHi0M3sKTzo+aZ4noBrb2HaorCbI
	AZbB6X2JYUhK4UaCQ8etsqNRBLvGhvx7YYsOEgZlGIz1JdKD5xsrToEKl6xTObMo
	hiVlSA==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9thsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 16:09:40 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4af9bf0f53bso1904334b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 09:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787328579; x=1787933379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yksA1f4CIEDmfZUrVzhMhyAFPy3A2If+RJxkkjk66Z0=;
        b=aDJqomlLqKvRianifF4ErXJ4addT3KkyNjBeHh2DzIkJmtEIvW/OoA159q6md35MI1
         4EaA1dD9eMATE0IYX2BhxMvrw8eCZpN76c8Zia1rIsp7A1BDqkWFtTn/d5K7XqrYwsov
         3jKUsVvU1wSvWu8KdtHKZLP1s/9dwECNsF1iQuvAVkwbEqRh5lFLlSAquzoUtN+5WGTM
         zMVt6hq2MSUcvkvFIV7nvHaQWooCt6ewYQFBzxNlfJcM1VASAlVPV47uRUZOp3/PnExI
         73kySQMXxuIfYIDObCZ64Iy38O8kQ1jhU7p9zX4DzvbS84WPEytVYqgu2thlBdEm1Xqh
         I9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328579; x=1787933379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yksA1f4CIEDmfZUrVzhMhyAFPy3A2If+RJxkkjk66Z0=;
        b=s2ANm+/7AoTzZOn8pt5yTZigWiKWSbtpysnjseH7jWE8ejqtoEReckXXx5wiHisOcM
         e7CuKupcqD37wrBu3RkuXpL7FvLo3SSO9mVdJGivkvekKupfMs+UO2ZsaH9Bg/hEqdeQ
         V27LlLaITfgxl2ofraou/FJdB36MRwpQGjE4Xm6xprBMoAYAEaaRCJ9b8J9ggVcIMASO
         teTA+wVFdmKcDvry9Ifj2yLC3ocKyfkjka9i5B4b4s9Hsk87UhAekOB2osDiKZsFxp4h
         HezR6dVvHlGK9Taa2gViVwOQrLidm0XiA87eNqvIRuYEwyO3hvtLgGjqWL59h27p+fnU
         H2qA==
X-Forwarded-Encrypted: i=1; AHgh+Rrqw7tGMPEL2ir01V8lZzJaDJmWwDHZIRW3iQDaXbBa7hePNmx+a337iTg4uh6ZA8tT6lkIlYGoQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YztlV0PMWvgb92EjVls++cqgHRc7bJd7bh6hjQcElCDoHpzw1BP
	vDZg4YOWDkytjOqz9ZbcESr6CpD1g3fOIiTe9ZqF4gcloi+U91eCcR0V89/Ve3/LJLpXgV4QhdA
	niN0IitNPmYqTlQASGETXlc9juY4tC4Qy8pFfVg8/x/Im0PhGeL2vYboSW7zlcA==
X-Gm-Gg: AR+sD12BtjSUJ2Bzv76F0aOejziU12xyaYP6kvasbkWdMscQQvDKCOiZFWGtgmCuwfm
	HB4BgvvREdKNGcNnGA/XQLDxzSbip4JvHsQskzYUnY33Qf7IucLDu5WX/iC3OJCsNdQ+4H9dkrV
	tID8kZFkycqDU+dRFHe3z/3FUBY967P72RGb2xG5pi0WhG4T7BKPfQZkcQcwncrNxAOpFCRs11Z
	+Xg0AX/FUfbxkiU31r3gbd7w1bP2iesGPo7jVWa72c6Tf6voDE/wpPnb2N1kKLcWZRPFvnAHMYE
	deBttFgDAT3kGbL8nr32GOuLftvYJ24yur1CyY5YQ78XkKTjU/itUXtF34Lbv6d3jgNHpWpJhHq
	YsaEQ9/QBCAEf3pixiqyzpL0/whyeIDWBxhvUKhWfav+LuoNRp9SqURqNpx6O84HYZ1eShjCxI4
	6N7Ers3d7uzIzdjg3pw7xf9P4=
X-Received: by 2002:a05:6808:f94:b0:4b1:ba28:5df5 with SMTP id 5614622812f47-4b2ef327908mr7079748b6e.18.1787328579335;
        Fri, 21 Aug 2026 09:09:39 -0700 (PDT)
X-Received: by 2002:a05:6808:f94:b0:4b1:ba28:5df5 with SMTP id 5614622812f47-4b2ef327908mr7079658b6e.18.1787328578881;
        Fri, 21 Aug 2026 09:09:38 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm4804321b6e.13.2026.08.21.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:09:38 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 21:38:56 +0530
Subject: [PATCH v3 03/15] pmdomain: qcom: rpmhpd: Add power domains for
 Kuno
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-kuno-soc-support-v3-3-196e2b306368@oss.qualcomm.com>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
In-Reply-To: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
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
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787328540; l=1748;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=tzDqNTEhoFVwtAYNfXTfFhwNi1y+wzNPDmbGPl082TY=;
 b=CxsWXOKtJP6Cvh3tIteifLhUXNDAbb56aoAXVsLa6v3Cfb3Hb+XK4dUrRN7H+p4kVAxUL64uA
 XGzbF+q4je/BNf+gDCsy3Rm4JwOd+U8TlxfPvt0d5PYj3u/qV6owX4L
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXzLxpjuNRQKrA
 VDWDNOk91ZSAO7Q1iHs9wdiQ6AWnikaFgqIke9oo3W+ZDXyQyhTaK9F4ruLbQiD2RB1LYM1PMZi
 inDijgIRnrBbP1jBNKwG5JxVK+js9kDENV1+/gi6HwU5DcCZjOnniLSypuhzcIe8mQsWpymmnUn
 s+SGEJJnvgV7XvYXYs9tyC3oPmi5OInE3VkPOxN+/N4kYtNmPWHczpbVlLNFbtoJw6V/V0jG6pw
 eTvlQtYbMaalHgXoelT1cP2ONHil1i/j2VoDQrer++eOY4l9qDCdIJ4E7i5lKqx2InxOW878uIZ
 zeoCXe5LziCDTILg9yp86YLLoypEKor3w1a6hkLZIyzC1X0Mo4MaEeKnYUiCdTYF7kGldscY0EZ
 4okrK+tC+Ks9NhsMLlUjRvNG2HRuC/cJ92fJg6Sn80TkWMgHoWYJC2u6GS0/EzV3pUv3L8o52dx
 3xu+i/kmhEwZawUccWQ==
X-Proofpoint-ORIG-GUID: _82O5XnfEEVM_zP4brLECeNUbl10t6xo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyNiBTYWx0ZWRfXxQ2sFNbXrXc3
 24+EVmbv5zXb0IS7A6exoQGx0HtLc4kfymo0j8s2At3f3ZQQ6n8CyumrTcRXf+EaQim9Fsn5j54
 pmHTLGxdlSf0N8fEJyi6LbljUn44XHc=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a887844 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1FmER_HI0FvT1hCPThAA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-GUID: _82O5XnfEEVM_zP4brLECeNUbl10t6xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210126

Add the RPMh power-domain data for the Qualcomm Kuno SoC to enable the
new qcom,kuno-rpmhpd compatible to expose RPMh power domains. Kuno
exposes CX, MX and MXC domains (including always-on variants).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index 96e4bd2f5a14..3c7755735dc9 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -685,6 +685,21 @@ static const struct rpmhpd_desc kaanapali_desc = {
 	.num_pds = ARRAY_SIZE(kaanapali_rpmhpds),
 };
 
+/* Kuno RPMH power domains */
+static struct rpmhpd *kuno_rpmhpds[] = {
+	[RPMHPD_CX] = &cx,
+	[RPMHPD_CX_AO] = &cx_ao,
+	[RPMHPD_MX] = &mx,
+	[RPMHPD_MX_AO] = &mx_ao,
+	[RPMHPD_MXC] = &mxc,
+	[RPMHPD_MXC_AO] = &mxc_ao,
+};
+
+static const struct rpmhpd_desc kuno_desc = {
+	.rpmhpds = kuno_rpmhpds,
+	.num_pds = ARRAY_SIZE(kuno_rpmhpds),
+};
+
 /* Hawi RPMH powerdomains */
 static struct rpmhpd *hawi_rpmhpds[] = {
 	[RPMHPD_CX] = &cx,
@@ -889,6 +904,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,glymur-rpmhpd", .data = &glymur_desc },
 	{ .compatible = "qcom,hawi-rpmhpd", .data = &hawi_desc },
 	{ .compatible = "qcom,kaanapali-rpmhpd", .data = &kaanapali_desc },
+	{ .compatible = "qcom,kuno-rpmhpd", .data = &kuno_desc },
 	{ .compatible = "qcom,milos-rpmhpd", .data = &milos_desc },
 	{ .compatible = "qcom,nord-rpmhpd", .data = &nord_desc },
 	{ .compatible = "qcom,qcs615-rpmhpd", .data = &qcs615_desc },

-- 
2.43.0

