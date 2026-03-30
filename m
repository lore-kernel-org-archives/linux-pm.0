Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E90D3B634D
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865106; cv=none; b=MOVnwCERyLIWmOtugn+X0/avjbCXsRO7YrGRBTHONTvOdnqoH26N3WztiliubrZ969XIXML7d+xoxHLmxXYaSOCBfXiYkcOvUp6imTlkxcQImpVOIwoSenLOYixZmnrNI1AXCszQMYuk7TIQVf54V51pkKGe6mM2OxpfTJbW1gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865106; c=relaxed/simple;
	bh=tkSZD2K7DdJY6frknv6PnsaeA19NFEYn+BZRQIyByI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JSSJcHtx4bEZjgr0SO1VyYT1+NfLIcuOnVLe+v2XPZEuwjOOwLwhjsQtEeXYfetm4Uv9g1ZU4r8mS6JytRWLfAr0BG/4QCfoAGBpfmjIl32JgVAnfJ9uQrPSZ7RtlDjiwX0gIrnh0p3J6/0B/uroQ4dGOOEdKCsx/aDeeHVQNTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RNYYmvQu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kEO90koa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RNYYmvQu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kEO90koa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U9tmdJ202653
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eBY3cxS3DbBsaQF3TD14VLqct7YSsXHc278ExE899J8=; b=RNYYmvQu4xspc5K5
	8f13x/xm9eOM4FFsC1zmgZOXckDY3PDNdcIkyNxrFt4zLfRZ10S6BUe/SHZ6Wsyc
	AlkitV+yF/dKYbLVdM9Toh7Xundobxu+kK64zlEoFY/i21cpAxSUDkLUnVx5YL5R
	dBDlFZ6uOf9ZE1kh9i0z2uz4jIS2EVIeHFTVPs3pPBQYSpFqrN2cIoJtG8+13Ws3
	ZzZPdP/E9IbFUWXUIFNKy8Qm8SdXTJwmKUkqqh39QVmoDFSt5K9XHNY6p2JZ4WSi
	x+oWt5QjGd1MQcoZnihc75+jXp2qOcQgjwJu1OsOaK+EnyBXlmF9FEwtcU5lHfaa
	YR+GOA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d66jwnpgr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 10:05:04 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89cd541c0edso19871156d6.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 03:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774865104; x=1775469904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eBY3cxS3DbBsaQF3TD14VLqct7YSsXHc278ExE899J8=;
        b=kEO90koaaAHJNj7j/VRCusPMJWt2WpI803HiBfwZwTAeiSPFBNSK8Ry9AJyfkgEoDh
         A/IZcdKhgCibVgDF1JAdwZfEkbY6CB4Z4VJ68Lll+yNoQHoqTcJZKWjPvyWDvvgmmUm7
         L1HWc+jdk2r2hoa9NPp9oxrnuGqx3c6guJN7At80qHsjpKNQ/klW07WppymQHjQAAa8n
         d4BGPpnmG/6LqQyOM78lUpSCSvvDkxdWO+pXmOJIB1pEDXxHHhCXJ5HOCKzSst1y3hgJ
         ZgEu8susYky3V5BsYV/jq3J7L74Z698tMsY8LqC/5xPZ4OU9REODRQiAK8PgIsIvovuG
         US6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865104; x=1775469904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBY3cxS3DbBsaQF3TD14VLqct7YSsXHc278ExE899J8=;
        b=WmrRVh/pfcppm+JqxzsU2QfKCHnO1X4kxnRx6xQBsEFglNnfJ7BvcOM+2fzLkw0egE
         3ogpCf69V54P4Dq1aj3n56ZSYWmCv8xmA+HxqVzad63twoxMXWqvIB2MtbYGTJ0KOCJM
         vwqBqX7L4e3f3YFGZrXtP6sO1gaFBirQlPWu/b4esldjjRO6E4iRv1NXwgbb8veWKeNU
         5wwABfgbDghUtLz4WqXrDbTNnwEzj7ce6+ePT94MvIla+rwvT0oEyzC3J24bg5a0yOhm
         KtAAYyF5tcmDZneMrQEMUgcdWHWmVLjupwxZfwpg2OkhkYtrV9ZtoxNXqR97E0PoKL0A
         1gWg==
X-Forwarded-Encrypted: i=1; AJvYcCVRYVKExWpeiCoDUU+4PShF6IPQ1pzD7W8cYihCbXj3pIckhzi7GDFjAIdDm57wEFsFfczmiqmhhg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxNEdRbcnDNe+oCcqrHra0gmypQW9iSdwzYAvKs2E8k5th4LgWK
	n5Jh6ZcnoVulSAeJ+KnUsGzsZ8otfkNy7uneBiP2KvyYXUEO/jc78f8dbsMR2h5TO1dcEaJKPf/
	zRRAQzftN8lBORL4McOVJKqY5FKWr+jqXhMsHK9D4RWDIZpQ+CCbVLTaRKrgkPw==
X-Gm-Gg: ATEYQzwlxLndcVPROp3QyAbbsLzytw3XXIDhnzG07GlUhrHBkbmfEcleK6nHPIxUVAj
	VYtiKJsbBuzv5aeGLuO98cG2/Ju38JRGbr9FmctTiedhoxWnlvGCqq/iNEz2V5NDJX3lZ9OmI+X
	vw4rJXaPD4RDkuzEoz7KQQHVvqWjeexVrjb3y+Ya3n6DQXbZYy43LA+A9iaiHvKtPMc6ku8YdJr
	/dHWqvKiG9yZG/wdMM9vLtGv3UHF/OkSIRffKRgkapGD1Z+qcraMKdb9L/GAJ4RID5lXtzuPd2P
	/dcwyHYkDbJUd7gPJbdlFnFFYxipmo+oNEFOn418I2KKxPEUs1YChGPDRYn8sF/Xih/AHXxKTUl
	8tD0MGPU2nBuAJcUmu9i34Jxg0WknabLkAdh9yHC+QjAxrGBWUg3kMwjgk2yEaYpahTBnXdQRJg
	Q+mtw=
X-Received: by 2002:a05:6214:2e88:b0:89c:ec59:87d1 with SMTP id 6a1803df08f44-89cec598947mr95913836d6.1.1774865103614;
        Mon, 30 Mar 2026 03:05:03 -0700 (PDT)
X-Received: by 2002:a05:6214:2e88:b0:89c:ec59:87d1 with SMTP id 6a1803df08f44-89cec598947mr95913516d6.1.1774865103127;
        Mon, 30 Mar 2026 03:05:03 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7b1e4395sm261709466b.44.2026.03.30.03.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 03:05:02 -0700 (PDT)
Message-ID: <30aac663-2483-4cf6-9376-ed9508d62997@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 12:04:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] thermal/qcom/lmh: support SDM670 and its CPU
 clusters
To: Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20260328014041.83777-1-mailingradian@gmail.com>
 <20260328014041.83777-4-mailingradian@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260328014041.83777-4-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=I8dohdgg c=1 sm=1 tr=0 ts=69ca4ad0 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=lVURl5kSPPj-3T30F2AA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: EoTblZl9smVwTTb_R_flD8CEAhVs0rIG
X-Proofpoint-ORIG-GUID: EoTblZl9smVwTTb_R_flD8CEAhVs0rIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA3OCBTYWx0ZWRfX4m+OpvbgVcsT
 +Z/4v41GlbsPa+UyyrxZHhDStbGbVBHGVWP6EFRldJN1KCishXt8DeyQVKTQC0bvod+wFWA6C7x
 XjjTZNsAh5QFlAT/Vbif/NCKyGCHGXzv1ZdMR/cUsjlQz3ZeYUz08L1iYbo/MoH3bR1+6M0sfwP
 Il6Y7jds9XonuT0csEfyBgZf/a1s2I8tzseWpcKGzZAEqJlGTXWSQKg7JObAgYUCMhIQ4ddvV4E
 euo2O6rRQF2xPvDcgvBqibUb3n4xklSZl+auEr6kojtzLoGaUMci29KqqR+9Rh9O1wG0/OV/2Sp
 iZkEZioWeDZAeVsusFBmfsAvnuJTU1mN7IAqQkDpIt3bd9w17XzRCQADihQ+VMeFFWQgttPX7Vo
 kBG3imhZhI8dFkII/93uMJoJlucUpGF+kf/ecizDNoc/EUJeYl9XAsLwUd0Qr/izbLGoYNlzfNd
 4A0tFs4HS75Rr382R1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300078

On 3/28/26 2:40 AM, Richard Acayan wrote:
> The LMh driver was made for Qualcomm SoCs with clusters of 4 CPUs, but
> some SoCs divide the CPUs into different sizes of clusters. In SDM670,
> the first 6 CPUs are in the little cluster and the next 2 are in the big
> cluster. Define the clusters in the match data and define the different
> cluster configuration for SDM670.
> 
> Currently, this only supports 8 CPUs and tolerates linking to any CPU in
> the cluster.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/thermal/qcom/lmh.c | 69 +++++++++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index 3d072b7a4a6d..46c1e301f6c8 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -30,14 +30,17 @@
>  
>  #define LMH_REG_DCVS_INTR_CLR		0x8
>  
> -#define LMH_ENABLE_ALGOS		1
> -
>  struct lmh_hw_data {
>  	void __iomem *base;
>  	struct irq_domain *domain;
>  	int irq;
>  };
>  
> +struct lmh_soc_data {
> +	bool enable_algos;
> +	u32 node_ids[8];

u32 clus1_start_idx or something similar denoting the first CPU index
in the second cluster?

Konrad
