Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170133;
	b=idJBCxKzXaZ9aKENxHhk37ZvMfWqCnqhpDkyNZzljQPU7BtF8Mlus2vjrbVBSUTKUfSG
	 IShjkLUi6Fal/Btwl3/aACkYIfjULtvD94f5kfdVmhfm1Ybisxw2ragTwY2agsiB4pJFB
	 lyoh3kWZRNC39zi82KUBe8TmJdOZ1GedAxAXRu8XHDnaXvazNfytGwhe0ZttXuoGTCteh
	 Mrh5SaNAW+flDbBEs2BrB4WdkPGmFaJPCD+B/lhSsKAGuF0JVZFBXzJ8MUAMV4dUdZ4So
	 mqLseL3qe9ElO5yXrdoVrmRfbpKdF3eny5Qpfg+gCcVrbQ7DAsWFBbeWfZp4QnyGcbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=z1MGMcXxwJZ7aC9YYQ26OH+G9qkkBjw1QsP0VNbDjno=;
	b=Yq37tPy5+/0veYJJVfTLsJCM/igNpXQfg97pkcv9isNYpmuTJTWG3nUOK0KSZ1DwNPVF
	 B6hyk9T01yjnM5RIaPMF/xe8TEBj7HeZLXKm3hnYDUTY0+OoylCdmXeoq5w2DDzmMltKp
	 B9MEOkEGDFA6dMdbAL7AJOOmdNqrmGLwuM/opoBTbgQWsCsjx4Rba7VkyZXTd1ksT+0SX
	 SJ/UoYqHUY3VfoDFCafc2YXkMN8ydOQIRRgxid2jDeo7HuTqUygliG/IU862qK3q3SkrH
	 TXSHQzIuUGRCBI5H708re+dCBiMq+7JcN1ntHuT4i3/9yszUNoO8Op9R944bKBSpBQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEJ2Qkek;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eWOo9ers;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEA606A335
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDEA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YEJ2Qkek;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eWOo9ers
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7frYH2695575
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=z1MGMcXxwJZ7aC9YYQ26OH+G
	9qkkBjw1QsP0VNbDjno=; b=YEJ2QkekzsvzilqybtrIOF17/qu5tiMJz5gYXq2i
	HFShxDd8O8TMOBOkrs7njtl6bDfpWdwuKea9Q24JMTx9P8lJdjWKehmYDU+PNtik
	ztS4KTSOzgkKO5nylH2EMOUPcfTU8fyWF67Bk2oHWAss21DgNZ/1kF4AC7AwIUmD
	05HxTLs/r4sTBFOOgNwI8Nj8TDohDLI/1aA3EoAfdvWx0ODmOeLTH7m31aSEuRBf
	ihQal+uRFTomuyo+Tas9ZZ8zKZFG86yL3lk5tjOoglZkI8UFmG0BiTrIWRRX/4cg
	mqTjVlIDiyWg4hjDu/Vw4MluqBu3qEvAufJyjIZHNmDz1Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j27au36qe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 10:22:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-55c16eb248eso13812041cf.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 02:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795170131; x=1795774931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z1MGMcXxwJZ7aC9YYQ26OH+G9qkkBjw1QsP0VNbDjno=;
        b=eWOo9ers7osRg2E87cOLSOUzN9Mr7Qy4uMu5swGFJzBnqLl4QHUR2FGhMYNEDfRnAS
         VCCvW2Lhb7VD+bo9VxG84uoGq0Dp3SCQ1zI6dfxLshkb+n726dnJM4DqjkRv2hoDeO3A
         rozocKOY1Lwn16dyFg5l3obFE83VeTD1gN7+9Qq0ydqbeorBPO8BtT7xcwqPxcPbBGdI
         bOfEk8DspeUd9fyQB7UyHM2gAZjdHCNZtAp8ln83ustNec6D+h+EPly3c3BaCKEXeLM1
         3PmRPpAVxsDmQx2vQjIgXGBdH3ZE2THQD4ZUyVHKTJZ6gRCUchj9OIpBscglP12kZD5+
         KoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170131; x=1795774931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z1MGMcXxwJZ7aC9YYQ26OH+G9qkkBjw1QsP0VNbDjno=;
        b=PY2sF7C/Uwg3K15ifnj1loFCWjyI6ckRyxpK68GdBU2cfKtCW29AYrvMahZPlfP/rw
         Ro4xzlqGLlbFsHs71G8X5Pk3VHM8rASFzk4qFLDKW28qEu3B0cbr4llRXwJJPGU7YZjV
         FC0sOMQK5Hg+z9pD3WwIyaUV1SCu2lERNt9QJoirhcfu/JYpJLE08QzVofW9W2A30xOP
         NfRfBDOuZhdh5GdZSUBbElx+7AdhJCvPv5AVuOmXNPeAK0ysR7njyd1q5p3YaexjXK91
         c5xf5/rsfidP2gCxTTI7K+vu1/vN97bBGiGESanOkLqaWeh2EdDhMDl6z00qFtbqtZA7
         Z7yw==
X-Forwarded-Encrypted: i=1; AL+hErHRj82fUP3l7C9fUEZOP3uLlwg9NQingbiP/Rz9cGQfWbyNZBSnDMTn0Fy1J5GAxPrV56vZMSM+MQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+fOYm2P3HCmjphc/sXnWWl0byIox8baI09dSwoe5NE0g0/Ibh1
	dtsCPjmHBCZXnsYjsig5KnHg6jH7/vT+LpuI9uOX54UmcS6jlfdgLBIRoQJbfKxgNd5G9YW51GI
	3GeF7Vjyx6td35zQ+F8YJIgP6JD85vDDDPdbG3ZQjyEjFxoMTq/pD+NxvgpWo8g==
X-Gm-Gg: AZFdTZdAV1uHf1XJCQ6mKYiYAuZ1Q1fW/iN7UkxIUCpUZn5F6NSXiqIPFFGe/zz8JcN
	/3Nt2lfHJJ6oRdvMNSDgEEy8RBlVVhFku6NFPAlKT+mtiFa6axk3BfVxJKsYC+K4s1JMToX8Vyn
	/ABuiL3hf+l0CZG7VoX4HbQMkXWsuOxWfzSWGgTnlsZtoV4KPrjuGuneM8iPgHLSOJC9g46ULt1
	FY8/L3g3gxMH8d/uogCiCsoU9zn3ipl9xlz/efhj4HUhUmQc270SVgaiNEq3KurUs1M/16MT4WT
	SFYKWI+xFr0/e7+UtBQAM3hWTybDXRIBqkISH7x9aZ3lrOg6tiHaEoephdBVgXeBETjPJNmpI64
	+eDLUtOZrB9cOLJwvwt7jw4PL7j3HPjd9IXecXIp+tXijqfCfLZH4mrmsKjMH8paQ
X-Received: by 2002:ac8:5ac8:0:b0:532:c057:9564 with SMTP id d75a77b69052e-55d76a2782emr47563581cf.23.1795170130542;
        Fri, 20 Nov 2026 02:22:10 -0800 (PST)
X-Received: by 2002:ac8:5ac8:0:b0:532:c057:9564 with SMTP id d75a77b69052e-55d76a2782emr47563001cf.23.1795170129811;
        Fri, 20 Nov 2026 02:22:09 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm3906179f8f.46.2026.11.20.02.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:22:09 -0800 (PST)
Date: Fri, 20 Nov 2026 12:22:07 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: ipq5210: Fix xo_board parent
 clock
Message-ID: <gejgvl5guwsdfexjqnq7aafesxjn5tjo5xc6ireh6xxi3mkt4y@si3fqc4hj4cd>
References: <20261116-qcom_ipq5210_nsscc-v3-0-1eaf92698379@oss.qualcomm.com>
 <20261116-qcom_ipq5210_nsscc-v3-1-1eaf92698379@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-qcom_ipq5210_nsscc-v3-1-1eaf92698379@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfX2X+r29OFKhc1
 ZP6bNdhvx36Hj/AJvp2hTBXBZ2e931bLwUR+Zj2hhlgy9fh+Cd0rmuSr1UII1vdv45iXKBzCaBd
 D196FzHK4VjRiN2WPVvdkdywpeXgz5g8ewrWYJR8DLBujNQX0RxemZuBA4wxLDQ/1g1q6akxus6
 NvBIxnXz8+Uqz3/WI6y4fottNV/XMFPC1n9ETJrfem/rpf0wLxIvx9LdPSFeUan0u0MYnhX+0gA
 R2+evvp5uyJnICSP47KmG0c6HzI6PgIk0lEbFUYP6/vQ9I1Zrt450Oj0nMChC43sRXfFxu/BREt
 7edLsQDINCIJcQIST/947kMWipEEDIPvFHl2E+HnqBXpdr6FkPbO8VK9XQBo+nM0q1lvecUTLIm
 bvl8vWHkP5LZWQ58l/BKsWc9EpE2HXz/LUH3URe47W4T/u9LC4KH+QKnxo5boiBMxDRaPcG0g4w
 x6EYPLA+nF8/J/BswhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MSBTYWx0ZWRfXyNFDrTZRwh0M
 yiguF/FMi2g+t803fFw6P7cfbwWq1Fw+YDZ4rsGGwpfUsIfxLC2kHmqwpBwsfRkSOOXwj70Tnx2
 54iQjvDs+ev197V5gWrXnMXNMVWJNak=
X-Proofpoint-ORIG-GUID: 9knJOvCcJCKOvBpzwn5lN7zyIkI44Nmv
X-Proofpoint-GUID: 9knJOvCcJCKOvBpzwn5lN7zyIkI44Nmv
X-Authority-Analysis: v=2.4 cv=KuHYSmWN c=1 sm=1 tr=0 ts=6b001f53 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=M5Hs6WqG2zr0kzIIc3sA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200041

On 26-11-16 02:19:48, Luo Jie wrote:
> xo_board is fixed to 24 MHz, which is routed from the 48 MHz WiFi output
> clock (also the reference clock of CMN PLL, ref_48mhz_clk) divided by 2.
> However, xo_board is parented to xo_clk directly, bypassing ref_48mhz_clk.
> 
> Parent xo_board to ref_48mhz_clk to match the hardware clock routing,
> There is no rate change, where xo_clk is 48 MHz and ref_48mhz_clk is 1:1.
> 
> Fixes: 1d6abd242b45 ("arm64: dts: qcom: ipq5210: Update xo_board to use fixed factor clock")
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
