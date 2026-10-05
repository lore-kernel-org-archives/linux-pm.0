Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6C365A19
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 07:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791183978; cv=none; b=qfHuW5nMuB7VZGZOpDLrqQnnTKigZt98m0NaA3SX6D0xeY8Y79alpBVRH9ozPeJzr8HKQ+3zPZQHjdUmE+YLY5h5H1kl4+LRulWepQm2zSpHRhCQLe90uTUlLwA5ulJyhOE5H0kB6TZR7SCD89Sab86PqjBh1PpxRIpFKJcOSME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791183978; c=relaxed/simple;
	bh=atrjdIQ97trzdZpGjI+qemq9aj6Nd3thS1TUv+eArUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oposE9u1S7xEiHASIQ0FVH0fgIlypJfhZMwC3jS7dmESj+A5tLYE7hWKd3LWPy7yjHJGfqtz9qtCwEOitydYCYt2KtIxWG3l/6ZvAoo02ATg5YeKD0AKIWKVQg2QOInv3RRbsD2FE8xLjCfQd/2Pdsxul8DT5gd0qe0yLlfQopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsvePr11; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HCUMw7YI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lsvePr11";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HCUMw7YI"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695107kp497212
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 07:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yiEyYAeWYq28BCDpwkf47FyVsnh8JwoWDWQ3CJx+bfk=; b=lsvePr11+Lrh4Tng
	9YmBWlhU9+uaw1LjvwVApNPtLRgYBRWIij9FUVeZnjG/CSwBqIJFJXCZ3iyDetxl
	9lWeNni4xvKjX56JE8nY2udW4OsQBZjMjN5fVP3ldZEPFtYF/sN4ZuzcK/AeVqML
	cxs3Bd/C99H9d+lHX7/Zh14ATL0lULWNioSh66xKcfddtMAS13LRPikZZVTAV4hR
	cObDUUZviSTRVkmS2ldUsPaXBOqLIAkMaK+mn7isqZQwULFofmEosE+DdWrggbmr
	SOUGz4GxmsB4kzZDcwWGs3zOppw0BkNZ8jm+ATE2Dk11O0mzFYXrfnjk/vQOH6Zt
	+YeulA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgys30c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 07:06:15 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917b7dd3f1dso26980876d6.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791183975; x=1791788775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yiEyYAeWYq28BCDpwkf47FyVsnh8JwoWDWQ3CJx+bfk=;
        b=HCUMw7YIsIPGkLeQXAu1fxl4wBg8IkK/cIZyILedmDARsGyHuP9L8z7MLTJr/0ch65
         +gsW6V7M5oQsOgXTUsYsHdjD0ypqmilA5P8mQ+9qdNbJzvwe9y2Wr/0mfq6a8DQF2ftn
         bb4d0zetAsEwqbHu0WONlM0gQ10jXjzFHfkStbzZV/8Vdgm297GlZ9D8/QLjx5CfvhWu
         oo8qjXaAj2dA2U1FMBlICP1QZJmt+GtVBUDxD+hBCqvAFQg7S31OLyayyeTIvT98zqM1
         ki5Ek7qWO40otNV2zoSyQfPLX49scOcROqVunjSDAa5AqydXHfIqli6rlQMWwwb7hPVl
         g+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791183975; x=1791788775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yiEyYAeWYq28BCDpwkf47FyVsnh8JwoWDWQ3CJx+bfk=;
        b=gqTKBTftYqg2keTIMnaK10jF+f4NQUv8hjy539B/xx5pMxNenQlsX4yBiWhnRXnuRg
         VE6l0a/ra/+qv+tXVpRF/AFK2Gh06blc+IGthuMAd2FckZsHVVMBgmu6IfoF1NjiEXqL
         yk/hOuXPj4/ParhOY0KGFX4FgT1wdhogIHG9YQsKzejt3n2MJHKaItjH6Ny7hZQTJRZ3
         Ld143mm6JRUcvF7fcrjZGKPgG24KXi5CTBX8+Y9oKLhdQer9KnJHLXQqKPnhEPgWpbiJ
         CMX8XDQIJLN+mKQGC02Eu/c7qR4/LHmUdZgL1tJWt+lh2drBos+0/fiKEZUQ2BW7qRz9
         jhfA==
X-Forwarded-Encrypted: i=1; AKwUvBzyXZ5EF8BiYYMOAu8VCfQtuPtlcwMrJP7CLVkkdx1aCZHDTPcEEN6Jo1hF3t0s5cAYbQKSwQp3RA==@vger.kernel.org
X-Gm-Message-State: AFuF++nAplWDZaaKwQmfoO6zQGewzxUqS2mC6aF2jFQwrwfIzt9AZ2f4
	28H7SJxmMn9EP1f66MWMSifZtFNhmHF9meC0zxVIN6zenZMB0jZmoMIb6DnE72jM0QAI5+Hm0De
	jQijy7DoJsEhwbyWQ9UKfphpaaIMOYgZ5+MBS+pjgSBGfu6EZ1MpkXy+uOEMqzw==
X-Gm-Gg: AYBFou3G5DSOaMdwc6x0OnlXBvEJY/3F8M8VW9wdDJRGCTwPEphhO5715an0H8Cci0V
	qktishR6eP/8O3cX5e7w91vNWjrlPaSHjI3ScXb/x8KVlm7oEJmxPXER60X4HMEdYUDtBd8mkTp
	zp4FiitoPAeGt4ljGOB2vqLL10cmQaUG4b/yRKdMYBogWTi9PZre274tX23fFoUH6LN+ShTFM3l
	aLRyosrbAx4e2S3IX0gSeV4Vj1oA+K/xhZkWPMZbJBQEQuIEtrAIHcPqooj2AbYxKir0OzdMvjK
	YW7CV4uVroKPqTXFXJIld7KGrctqmk41ryEnAZyLHrNqos5an/t4IKolaO7j+1Xuq83IUbEVdXW
	EqEUEQ5azYJyMMTJJOW8jYzKKchxydA+RtnfrAAWDip9Q0lhMQmvJ9Gn7dNk4Lap/Lk57d7Ls3a
	OeA+B1vqL9fV+a
X-Received: by 2002:a05:620a:404c:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93e51081bbcmr1036871885a.45.1791183974423;
        Mon, 05 Oct 2026 00:06:14 -0700 (PDT)
X-Received: by 2002:a05:620a:404c:b0:93c:b7f3:9f5b with SMTP id af79cd13be357-93e51081bbcmr1036867185a.45.1791183973821;
        Mon, 05 Oct 2026 00:06:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c79d725sm2957189e87.46.2026.10.05.00.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 00:06:12 -0700 (PDT)
Date: Mon, 5 Oct 2026 10:06:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>, Ulf Hansson <ulfh@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v3 4/7] remoteproc: qcom_q6v5_mss: Use mss as regulator
 for MSM8953
Message-ID: <7smt722arn43gwpfhbgagevi3ut6gdxalgfre3mzm4rb25fkkq@ftsucipakelm>
References: <20261002-sdm632-rpmpd-v3-0-95c47d0f26cf@mainlining.org>
 <20261002-sdm632-rpmpd-v3-4-95c47d0f26cf@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261002-sdm632-rpmpd-v3-4-95c47d0f26cf@mainlining.org>
X-Proofpoint-GUID: 5tsmBbHvbevX6ABiR3byyY297qbkldsN
X-Proofpoint-ORIG-GUID: 5tsmBbHvbevX6ABiR3byyY297qbkldsN
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac34c67 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=OuZLqq7tAAAA:8
 a=BJAjVMLeuKdTMRx92iYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX9fy8j3hLB4y/
 gEr/cUWKSQX7mcMg6ptu+dRbIuxbs7Sjb1xuSor6o5mdFKxaLQnrAMPSQRWMZyOP2ht68QLRGVB
 NVNZ491CjbcM77eXMX5q6bfLYIWDyLaxTjpkY030mVHlxc0g/2GDV55BKADtzJ2linqoITjhG1e
 1p4ALrnQ1An0nQFH5xroMVQ+Ls536IOJIViCJpjVtxfD4v9QYqIArOYDg+W3uESNOkDfY1CBqzb
 zAOOjVy91Z4INS1rNrvlfwMrEdJcWaZ4CMK9qaX15jYkiO6YVpXabMF4G9vOtqNlnW5AB0ppoqw
 /vJVQNgmuwkq5dUPovDQ3oUsnJB1j4rM/wAa9RyUlX84jeqQisD8FmWQacdmmBKuvAKgpYMsQfw
 OBLMFocebu/2sUN59XVuIcjx+kDGL7Vw3QAWGzEF36cJRhKn0NQnelnfzAzZ/pWTSNYu76q5C+L
 U+2H6jGyb5TF/sDxxyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX7ljbV4Y4UfF9
 N/+RPQdBjAAAMSaQOLujfvrTDuf6bXvZhdf2/e/Ib/8nQxthCsxHmp4c2EeNz5jO+6vhxq8UxUg
 Bn85SCVkgGoBio/O93b21ic3AhuBGQs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028

On Fri, Oct 02, 2026 at 12:38:32AM +0200, Barnabás Czémán wrote:
> On MSM8953 MSS regulators is controlled using the voltages rather than
> performance levels. Correct DT definition and model the MSS as a
> regulator rather than a power domain
> 
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 5 ++---
>  drivers/remoteproc/qcom_q6v5_mss.c    | 9 ++++++++-

Two separate patches. Yes, one will be broken without another. Write
this in the commit message and explain why you can't provide backwards
compatibility. Don't forget Fixes tags (or explain the lack of them).
But I think it applies to the rest of the series too.

>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 753167c3f861..c7dc08858d54 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -1451,9 +1451,8 @@ mpss: remoteproc@4080000 {
>  					  "handover", "stop-ack";
>  
>  			power-domains = <&rpmpd MSM8953_VDDCX>,
> -					<&rpmpd MSM8953_VDDMX>,
> -					<&rpmpd MSM8953_VDDMD>;
> -			power-domain-names = "cx", "mx","mss";
> +					<&rpmpd MSM8953_VDDMX>;
> +			power-domain-names = "cx", "mx";
>  
>  			clocks = <&gcc GCC_MSS_CFG_AHB_CLK>,
>  				 <&gcc GCC_MSS_Q6_BIMC_AXI_CLK>,
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index 2f71ed2feff6..8f6312213e1a 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -2728,6 +2728,14 @@ static const struct rproc_hexagon_res msm8953_mss = {
>  		},
>  		{}
>  	},
> +	.active_supply = (struct qcom_mss_reg_res[]) {
> +		{
> +			.supply = "mss",
> +			.uV = 1050000,
> +			.uA = 100000,
> +		},
> +		{}
> +	},
>  	.proxy_clk_names = (char*[]){
>  		"xo",
>  		NULL
> @@ -2741,7 +2749,6 @@ static const struct rproc_hexagon_res msm8953_mss = {
>  	.proxy_pd_names = (char*[]) {
>  		"cx",
>  		"mx",
> -		"mss",
>  		NULL
>  	},
>  	.need_mem_protection = false,
> 
> -- 
> 2.56.0
> 

-- 
With best wishes
Dmitry
