Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480585;
	b=WR9yNZWr0TsRf5HFMBri3Dq4iFciu7s3HJH43uRrMpJ8evCpc/JM3gF0ZU2MA0iW/HE+
	 yjDfaylRZbSwgy5crf67yS9ZqopavGTB3fGf4pwxEJL9NZDoFczJvbj1idZnQ5nn35qx8
	 b7Uep8VQY6lbaJC/wIPa7/pp9IpreyZ4j0+PvrIKji15rsiHFNTDHi+0fqGASWruLXUar
	 hMzZO54yxFNa6FU5QOq9PyTwH8/t7If1GL48WSAPn+v6OMKneFux4r+dInLM5yf+jifMA
	 QhISCiYfKkEEuueGmvrT04M5fUUIQlfqZodoFwUjaCL0n+sw7lhs2z/MAcpAavBhg0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480585;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=TS9vB8FLk0MX03vHuui6sa0P8Af+Zt25Qlv0IPb3C6Y=;
	b=y+TJUbjLPF8vkj7NGHaW32vj2uE1sX9kZ2aDg8jO14+++aJ1dbqGOMkhOmaAr3Rq1qe4
	 eYQ0NRIXOGF5J/f4oMTDXrcg+dINWtRhNrruaZlVHxrpQ7Sc0J82NRye4B/SCSrwFJUHQ
	 hcU4KkSDkAfxQ0FDXCK6/vg9Zn5IoItOl8zT37HLnE4bvVZrC0VnSR5EciLTwogvq5rhL
	 zqJm51/BVCE9LZK4m2vvX3GzLOTzQgaK5xmwVA9g2gkEciY9OkkzZHCcN+UO9IkJIGzoo
	 eDLbxUIOYYML2inhGGmTkz4kjYaSULK+nPJ+39F1RKYato5U3oFQxw+GXNggtbp/yCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0AtttzR;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V18Eh7K8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CACE606A31F
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CACE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M0AtttzR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V18Eh7K8
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0t6Ub185928
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TS9vB8FLk0MX03vHuui6sa0P8Af+Zt25Qlv0IPb3C6Y=; b=M0AtttzRXOO1ivfx
	P54emTh0eMhl4KmvPdkYFzNqyXijoRTDcUeSu+ngkx8qXmnJ8lct3xywB2NAkQN0
	oBu+obGrXburVFGq6psNnsw5orgmtMMMRkZlU2vCL12somGkZtjr52kLvB0W2kha
	a/WGPetwm/kk4EfpfnRdL0747MqveEigzgFvLp02ZTKdvCOmDVWphrAUSIUTbCD5
	cMN9fPtrmmsDodnrXJlXP+CEAEgxOfVtf+BVRJkUliHevJCpVGxjxUGPD7/GzbY7
	mwy1yNt5pGzpecmUG3w6vFHSACYpdwEYwsglREW3LyGE3y+DkOFZrWxhXUnI93iA
	lBdXAA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5nsbcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:16:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-915e9e1a5f1so6366616d6.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 00:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792480583; x=1793085383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TS9vB8FLk0MX03vHuui6sa0P8Af+Zt25Qlv0IPb3C6Y=;
        b=V18Eh7K8grEUDdrJuAn6M3ttf/DhP8tYryXo1HKMPi5pnB0NGy7YlOAHvZZHdAm6qD
         E4RZpnL4V4hmRS1xkXGj2ooRiMqD8auO+luEOVGa96OUqUP0EE5NXv6LrI/VFK8kUVRN
         Os9w5RzcWBvanmvw27FVaf/ZpbiSmyBUwJHTPoS1Cp/91Yx9ETBIPVMovfWa2MSHbwZ0
         VwBEdoKpULz8qiC+7RhrxkPIyRvE7WKJWfBDZ93KZvrR//l04sf6RRLMQlypL4y93xSp
         HTJSn44BuREsSdxRcXKjExK11nEuaRPWRqRdsWn6hRkYDqks/XUHo3GlWHfmw/6RQIAc
         cOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480583; x=1793085383;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TS9vB8FLk0MX03vHuui6sa0P8Af+Zt25Qlv0IPb3C6Y=;
        b=PMTkKcn+tBBxIpRxhWRCS4VVBKYtpOj/0AWhBhCZpT2iCnfFQ9hMF5q3S5C2SAyh9T
         TDAHX4P0m5MX6zA5cUq42Uv3bPebV5kmpIVNDkV8AT8AqVpZrz9+14X2McT9/EGU9oJ9
         eeHULr1SQIGlpzBKBL5K0oHwP8KMImp7uiuJENgU4V7t93TGmIYgpP09+wOngwQ61gpe
         Os4QYG9RpnW1mB6JQ/9uhCWi7UUnEO3hekW/NkZ3ySaXsYRKAjgKYW4TNXP7iPaIis3z
         7l/vpTzUoehEyeVg/LZFYHTr9vhp/eK1xG+GWG8ZfsMXv9iQ0cd9h45rqhq6ataplaYi
         8qRA==
X-Forwarded-Encrypted: i=1; AKwUvBznKKE0EFnj0+NBHpCtYGy6hVevR8sH+ijU39brQ/7GBTcY7nDZm+GZWJIu8hpYW2vUBjDwa4dOYw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLxqXvojb8vcHzFvfjOk3QP3hmJS9Mrjpi2QVPthwcLOcol/lVg
	iDAVl+7uzSDuIrJEXGWXcRBx6/ZOsSD3vt5Llhz2y9U8HZpqiUoUkcp4UsHfLn84FyHfBbwtyfO
	pXC2pNm/5RJ/iYq7leJNqu87UuE8JVehWxOAajn8z90DEooHPIh70FHJ3ulQtsw==
X-Gm-Gg: AYBFou28b7qPoXTagSc+qra02r1aGQ8BUrTFPoBejewwo7gpFmDzjLT1xFWzKck5Rkv
	QCKZRMfYS/FrkbPxY/xLNHI4h2iyzadfaPVJ256tdbarA5HzpoVJXaIFM12gF/IZcuvqtnmUo+T
	cBaoBLWuLQd3LzgbfRXNuRygxjsa2tlpc9VBsBhh6BzqLXQH7NzsIbXKAsMRkVmXRCyTlXMq2mU
	m4K+OX43ulbku4DP3Ru/OndbQkatavsyAr9wU/exEAPKMwbOyuLkbkpcx3c9OndjecaWw+VT4Xz
	55O5NNniJUBwn6WF20eKZ9ypJ7yK07BIA4e3theiRSYGZg7FcxasHXEQ+TZUkVGCY1naCRxWz4B
	XWh7NrRBYCLFpGOlw5z23/Q==
X-Received: by 2002:a05:622a:134f:b0:536:91cc:465b with SMTP id d75a77b69052e-53691cc4bb3mr1516061cf.3.1792480578317;
        Tue, 20 Oct 2026 00:16:18 -0700 (PDT)
X-Received: by 2002:a05:622a:134f:b0:536:91cc:465b with SMTP id d75a77b69052e-53691cc4bb3mr1515851cf.3.1792480577861;
        Tue, 20 Oct 2026 00:16:17 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb164fsm447640066b.70.2026.10.20.00.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:16:17 -0700 (PDT)
Message-ID: <aee928e2-909a-456a-8ab4-66d8b5aaeaf5@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 09:16:15 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] arm64: dts: qcom: msm8998: wire up interconnect paths
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261019-msm8998-icc-v1-0-c2da3934b6c8@oss.qualcomm.com>
 <20261019-msm8998-icc-v1-8-c2da3934b6c8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-msm8998-icc-v1-8-c2da3934b6c8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3rk1lzgRiXZ-JBy9wdeTw6R7Qs3QAqj_
X-Authority-Analysis: v=2.4 cv=DZOCOftW c=1 sm=1 tr=0 ts=6ad71548 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=JzhSTXaIO3PCq1I_VtQA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: 3rk1lzgRiXZ-JBy9wdeTw6R7Qs3QAqj_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyOCBTYWx0ZWRfX0sF1/QQEiT/a
 BBk1P76hBPlSsM8Sci9iry+TxQMOx7v4VELyyPTxHlKpG941WWzRF4PDNr48JPTQzDwadVgqvvb
 IhH2giI1iDszx4tQSo2FoLxkkwYVYl5JAXdzW2nvtzEqWu56hUjQ8e1d/O0JH5sjCjC4v333XOE
 I51kgil/nZmZxtN96Utovid6Grg8OcamSydTdhO/Q0KCbI0lpMMV/QYDZGlLBjMYsyofWCE1pvZ
 4zgoSWd18UDyiGNVABRAD7CALq9RWVcLLBpxqhEVriOluBNMtX6nq/Kyfo7F97uVwd76w0vzo4x
 0f+odM4bO3dvBa0ZPEkPSB9blkdgFfoNGdyY4Szv731b5757dflk97SwyZcGEDxYxFFguLSXLdE
 G0vY5FRD8xyjPqf0HrPcoRMtG9OoTVAnsbUsF/5Slpff5gvT+pTH3WVtW0KBM9h8SiTJAIOlA2H
 dAPwdHX83wvktOjc89A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyOCBTYWx0ZWRfX7qQM/Dum8gmn
 jfZbei04G8vVlTEdh1VSE9ItN/ynnQ/kNDf8fuGhMJ3jRshCPlhxUsxM9ZH5b72MtedQibBu1wM
 6jKptpCAwJ/4DNUTdb5fAsIvoZLzMjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200028

On 10/19/26 4:12 PM, Dmitry Baryshkov wrote:
> With the NoC providers described but no consumer referencing them, the
> NoC bus clocks stay at their boot rates: nothing votes for DDR or
> config bandwidth, so masters such as MDSS or UFS run on whatever the
> bootloader left behind.
> 
> Add the interconnect paths for the GPU, MDSS, Venus, UFS, USB and SDHC2.
> PCIe is deliberately left out: MSM8998 has no route from the CPU to the
> PCIe config slave, and requesting one only makes the PCIe driver fail
> to probe.

On upstream, sm8450 is the first one to have one wired up in DT
(intriguing), sdm845 is the first one to have one in the icc driver

Downstream, 8450 and earlier do not have a path defined on the PCIe
node but clearly that relies on lucky ordering

I threw the LLM at msm8998-bus.dtsi and it said:

The only edges into slv_pcie_0 come from three masters:
- mas_bimc_snoc_1 (line 669), reachable only from slv_bimc_snoc_1,
  which is fed by mas_oxili and mas_mnoc_bimc. Neither is reachable from
  the apps master.
- mas_a1noc_snoc (line 679), reachable only from slv_a1noc_snoc, which
  is fed by PCIe, USB3, UFS, and BLSP2 masters.
- mas_a2noc_snoc (line 692), reachable only from slv_a2noc_snoc, which
  is fed by mas_cnoc_a2noc, IPA, SDCC2/4, TSIF, BLSP1, and
  mas_cr_virt_a2noc. The last two come from slv_cnoc_a2noc (fed only by
  mas_qdss_dap) and slv_cr_virt_a2noc (fed only by mas_crypto_c0). Neither
  of those is reachable from the apps master.

But I wonder if it's some sort of an oversight. Can we try to
regenerate the paths internally?

Konrad
