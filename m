Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8A3C98BE
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780984036; cv=none; b=DkmyZGQ13VbOfJWjvrdr1wBukznllsL2gvL+irxaHuZGQm4KifD+VeFxVra3RdjeXrcy8afPrLwh1eUfhvv1VN3O+z6kgeePH6kMwsChyekv7Wv0RGNeNxkRgDX2usHBXw8tnzECxpSQ1XdnrFv9q1gW+3wYkulRWFRKAtPGSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780984036; c=relaxed/simple;
	bh=so1zBd3nO45nJIzTPGgrERW8Lcd2s/vTZUV+2uG8ilI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T1cA3jA4XAfQO1H6L4JfmL6jw905bKq7Z6nOQ5p0JD0kNzmT30CKWNNLDarEGJxHodHX8ztaN7Da7zzwsPlNLMUnTf56QtBPIdG1nHoU7s00HrvFOOGAk84uofS78C2N5xKVeaud/5OJVBd66jAZ5QdG1bMhSRQBs2evPLfCFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5VhKDm8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B2HolZLq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5VhKDm8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B2HolZLq"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wmZa994662
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 05:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ngbOWDMjIN8EWkgDlORz4DJk7K8eQHzIas+4rhC1DVU=; b=B5VhKDm87MQusmw9
	aryygQpzC5UfGLdTFQP3AXlVg1nPZ70WRUQuR/xLLxw5/XXUVeWyj9YdVVgN2c3S
	hkAhV1TYrYpyqJ94WIr3k+xcOl0Pa56Ta1CYXrQM5477hX25T54VhOyrcMSKs6+p
	IdaJY9wOKB2meZVgwCUFoRuBFDqrpFJzeGll+wA+Lq1vUbFvzHFTeXRj5UEcm45e
	8fIyEUNf/cg2XfOnNUGP5XRBJ6jd+zMlX1/vJsg9nuUHMgzPsdS5VhTLK+OYGrp9
	NlrEZn97usI6cdIctjyAjeS+i+Ki3YgU2imXk1PWbVgOAoDvalbVwma/KpsIOOUp
	JhrBqg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4entrkvvqj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 05:47:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c0c20f7581so55254475ad.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 22:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780984033; x=1781588833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngbOWDMjIN8EWkgDlORz4DJk7K8eQHzIas+4rhC1DVU=;
        b=B2HolZLq66K1a6e5QDZ8HZnhnDnrrt9uNl40ZAjlFxdtOxbBE9IsVu93IGNsRO6cct
         0S2tUuUEEa0dPSMg9oZTo3tEPdVqhPUJ5jZ8DS0oFMRNuowUHFltJE6FnqU5Ud5ebS6o
         3eQSJjHb/xF5WNBTWHFo24kjv6aROga7cpjneRjUzrCNd+BmdY332Goa0d/zK5HJ9Elj
         SfpajvugvvRimo+972NHb1n7yqzpuzuDbchcsou+S8G3q0o+53zniL4vG1RN4Vev/6Lj
         f59Pcoqvk8gh5M5Zahts3d9whWKs8IOC1v4p/i4g/KWisnHBEr5RpStssg0c+vMn8NId
         cXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780984033; x=1781588833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngbOWDMjIN8EWkgDlORz4DJk7K8eQHzIas+4rhC1DVU=;
        b=U5W3UWX1Hoy3QryUtAJRsYXPnEDy3mWaytck6hpcGGZ62A9yDnHE2yMtQMb/v2t4VV
         KpEsoEW1dKFzGfDKab2iHXS2an6lfzjEKDvlqUZqNRy1E6qgoBndIr9w++Am8XLGPYl0
         MzgYOSxFQ8iJAUpdCuWz3hLwXMHR9j82wc/GhNGvlr36uxfZ5waPmsirs6sOU+LxSYEs
         dPi1+MqlDd1OMuMEDakOnf9nZCBBhrv8Md3bvLqgFgH9XQ1wVWhGIG3LBcR1p3JM02Jz
         5mT/s8miOpQKwQcRtO2fC8iXe/r1FI+3jM/XlbU3KIOO4YghTpBpQa+KznXzT6yR5KOG
         VdFw==
X-Forwarded-Encrypted: i=1; AFNElJ/khRmnXsk3u4Du0jlRcEV05SE0BBQno9RImsUWDn8suG3TPdw9v9IimGldjsapHDAkawoMTPHq3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9GWdJW+HdzjLrhJzXs6nA+bj4VbiqrevlWfe2XXqWrLxYh/a
	30SyNDmF2mx1ghU69S6pmMP3PO61zUbsegWd5zxHeSlKoC2HF3CN7FwjFPLDXAQUwFnjaoahB5z
	QDlppMvNjIH5EItk8QDId2vF9Hb6Urnsb9gysUfzq0Ya7m3ViF6/3ITJTsSe2TQ==
X-Gm-Gg: Acq92OG5Cek9MDo27YnifGEosswXef9Dmh7/8PXRdIoC9ytatX2XHmRTLYOe0DRy+oS
	ewn0E7IyLe6tlaeZmRyLeFyAPJCqjVKwFNLA17QD7FPCz5/e4f8EjR3+3yVQQOgZDz0wdimAXi+
	46GL04hIACxxdUUOvKh9rusnK20ij7SnToWihJWLw4ERrhCoC13SSF67V2Jo0iUpJ/U5aAOMEvp
	PLFnfnAZlXFNoqUB4HlFD0j/1P5jlFbfWBd3tBnjqE9mOUy0r1cLxZwJj1PmEymAhP4EGnRv7lC
	EibMHZMPYC5OobhVkOr/S/s1U6JjzjXXryIyjqTCAWsnPtXNGjPstLhj7XVUqFvfHtwizzEbN4b
	FdomrTJpLsvAf+7awoAcoPbmC4OC7ghjGQam6aUqnqWkfFinKS7cumwmDN9/9Dqcc
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c1e79e29ebmr222076495ad.3.1780984033343;
        Mon, 08 Jun 2026 22:47:13 -0700 (PDT)
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c1e79e29ebmr222076015ad.3.1780984032810;
        Mon, 08 Jun 2026 22:47:12 -0700 (PDT)
Received: from [10.206.105.200] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664950aesm192056405ad.69.2026.06.08.22.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 22:47:12 -0700 (PDT)
Message-ID: <44671f38-88d0-55f1-0a54-3997f37c5a60@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:17:01 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>, Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
 <20260604-iris-venus-fix-sm8250-v7-2-7bd2f0e5bae8@oss.qualcomm.com>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260604-iris-venus-fix-sm8250-v7-2-7bd2f0e5bae8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: p8D4M2WVTjel-XAtlkCTDbTTPI7aju7p
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a27a8e2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=2OYgVc-5B2WHko4x-TYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: p8D4M2WVTjel-XAtlkCTDbTTPI7aju7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA1MSBTYWx0ZWRfX+r0gfst8rmEI
 GowpMrKpqKlIJvf0RBGeVl3c9yotieeTxiWaCFtVG1HLAL98V36bseBu5Hoduc1AYkotbPgPS8A
 EKk6TAMBObvxiibQI+r47+t8d26rY/1u2JK/Q6Fj/g7by8aWJ58G4KrF4lm9/75X2kaZ71rx+aj
 umS2p9KhIFFjMzeZkAIfYoRU4wOH2qkrCZb1JYEbilRylhf1nKu0KL388FNynOAiA8CH8DP6baG
 NTxU8PzoKoVCNl1mepLeZJS9fffbphkdMjFCqSWh2I0imgb7l21mfwpdifxq2YnQCKHjm50mVR8
 biEniXVtvCo9ak3s+L7u3/P7xgb+gizi7cCYcUDHylbn6IlxZ7Cbo9MD4EnJDchqvPQK/gU4r+y
 fsz5YS96/00Q47EZ3bMowTCcYwkF5YzMfmVZOgHr8dzQDqtEuk87zA8bTGJkFd0iJgAQeNB9qOo
 l79Y+GUjJVKP0bXkHVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090051


On 6/4/2026 9:52 PM, Dmitry Baryshkov wrote:
> The OPP table for the Iris core is wrong, it copies the VDD table from
> the downstream kernel, but that table is written for the
> video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
> rate setting (which is clk_src divided by 3). Specify correct
> frequencies in the OPP table.
>
> Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 6150380795b8..f6044bfaef87 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -4355,26 +4355,26 @@ venus: video-codec@aa00000 {
>  			venus_opp_table: opp-table {
>  				compatible = "operating-points-v2";
>  
> -				opp-720000000 {
> -					opp-hz = /bits/ 64 <720000000>;
> +				opp-240000000 {
> +					opp-hz = /bits/ 64 <240000000>;
>  					required-opps = <&rpmhpd_opp_svs>,
>  							<&rpmhpd_opp_low_svs>;
>  				};
>  
> -				opp-1014000000 {
> -					opp-hz = /bits/ 64 <1014000000>;
> +				opp-338000000 {
> +					opp-hz = /bits/ 64 <338000000>;
>  					required-opps = <&rpmhpd_opp_svs>,
>  							<&rpmhpd_opp_svs>;
>  				};
>  
> -				opp-1098000000 {
> -					opp-hz = /bits/ 64 <1098000000>;
> +				opp-366000000 {
> +					opp-hz = /bits/ 64 <366000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>,
>  							<&rpmhpd_opp_svs_l1>;
>  				};
>  
> -				opp-1332000000 {
> -					opp-hz = /bits/ 64 <1332000000>;
> +				opp-444000000 {
> +					opp-hz = /bits/ 64 <444000000>;
>  					required-opps = <&rpmhpd_opp_svs_l1>,
>  							<&rpmhpd_opp_nom>;
>  				};

Reviewed-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>

