Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61033E5A2C
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701356; cv=none; b=a+/sYnF/D3N7wGLj5YlF6G+PF850PhXuW/If/EusuJLSqL7nUz8u9lWY/DfMwNoedTlNv+IiH6at9AEZrYZcUgYm3TcS4zt5UcyeByKcghPUsa4/pO7V4EEyids4n3aw6fkcriRS6lUCfH/S7KAbeYsDEdYhJeyR96YpCLWCLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701356; c=relaxed/simple;
	bh=bgx0puC9B1x58t89nsIA/Vu0Vaps99oYM2U+hYmCYMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUWhtBZ84RJk/RLE6OVQzh/1cMF4oYDAXc20Ao2JcfoTBVMNq/wTlZHx9oZK56xjnT0vJZMNhIAREfBXvcbgpmBuQ5qmt1lkq9wzd9ZXabhN/giyAWzpsDM8WvM783Vpf5pYntS1iRTIxTzroe80rOiQlkHfWkDSOhXaGLnrsLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R3F+DjvR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KTIeABVk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R3F+DjvR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTIeABVk"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P70pmg609776
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XhFILbTxtLrUyeqKqIsvkPpS
	bVh7DYMyBkYHZMO4Wj8=; b=R3F+DjvRnhsO+sq4eitp+mA6txC1Cxi5Q482SZbH
	5seK16JnJ1HEiDONWx+v2vXBvr912j+xfAsa84iWzzacHcW0IZFIBtoLisa4mqpl
	yoDh4gSwBqFy0+jFZUJxcVpccCyfW2h+wAPE/+1Xmqsk18I+W5+754gFr5y4Fc8p
	lcm3JyEDRaG05Q6wWbFjN9NuIYtJhtrVMr8vlEXy8DFUcrNwl9SuOYIaN0dzYQed
	1YFj0HwxWisZT/mLrg70h2attw9Gk9U5IUsc2n1Z/nmZBEE1kaRHjOCg+848303Y
	GQVEkqEnwa7lhocFPEPZphxctkmeZyQWwuvkRK7cQ2KVsw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb5h9nv1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 09:29:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-515224a8aa0so24779271cf.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779701344; x=1780306144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XhFILbTxtLrUyeqKqIsvkPpSbVh7DYMyBkYHZMO4Wj8=;
        b=KTIeABVkWj8MA37U37nXBBcuMGlhAPptDp9/LNqa+cEsSRjgt1QTEYKXNDk+/7zark
         A4ZvCeOGuqedpjZ5yM3CjJhXJldJMPb11ASWZW5mEXXUNiT8Gu+k1UvcGbhcwOctwah+
         gs591tERPtFEKiQOLnNPm/rQgWjDE9692C7BGL5oLqub4fod+OlYa6wBaUhNizAz5/dk
         8WNu1h2jgUD+N7/6XuY+pWZcmRbfbnTWmvfzXcOQYLDuOrM0xqAaSFZU/PDCn8V7vhsx
         DKJ5jTeu4KdcW1PG5cKFoDSbPNq031dXQp6zXDLTuRZrUPOBVo61ffbTOrk5/SddHevv
         nTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779701344; x=1780306144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhFILbTxtLrUyeqKqIsvkPpSbVh7DYMyBkYHZMO4Wj8=;
        b=WH85pj2b17lIJoNMrPxFHklycQK/VN/F+Tb0m9LugVXwIdzTgadcOv5GYM0xCveTeB
         xRGeLJyUHUvgMxtAwRoZYtO1u/rZoJf/lgVJjkxwEuq1lXDrfIpObK32yrG7avMHPZb8
         1orfWMrvD2HBBk6XRBgn03B5PuwjTVeQAVkKHpnUGc8RikigrrEmuAX8yQIrF19OnwXQ
         9sgsRHww0+0yyDfrEUeNNJJG8nFiQmv/IILWN9ya2prg53eh8mtUcjwN7aWau6e9ehYJ
         ddgv32PJyn2wfkXdtj8odevVdROEdAchtbP75Tg7bW0BmgwB/0XjFmoxvhcK5JSXfav9
         dMbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8RuslfB6x3M48qU+vij4AZgpv1qMKrtsporQmdYbnKgZ04I7H4mhmwUVtL3TL1AODvEOKgZDV+nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNz5qFX2l7XqXmE6osrjgwkmqANKdyPf4vq/YQXBmbdA+SSHZ
	cr9tkjRcdmMjtHDIEj0bhqo0epDzmAvVcOCGEGXIFka9gZNz0go7s2bnyziU+zM+baaSWm2aypH
	pu5dA4OvhohG3sAxPRkOSYi/+00p9GTY2f4dNBzVrm3TqTf0Me8DUeoDuFmiCvg==
X-Gm-Gg: Acq92OH+lQTf8nXw3cI72wBz4QfXw3aA7wLMszcpq1FFuoxf2Q62zAs++Wms3BFz1Hw
	i6On+1krm6FDB1YJO1g+9TelwZuI1877u8XeBDAlxLMxj44KQnXs/c55VZRk9sPOHejnoTduFxh
	bzcAwNfzfyQf4jBRR4cPQrjHEdFvMR2Tsg57u8GTWqV1DIuAqfUuGpafk3YMmf75LgYoG3+707N
	nkk9tr1T0AFTPm0SGVq3CDxfmqRE0TFeEMFfV45SWoSVQc3AMJk+MXARC3FsuAn5i8UaZZZcSAx
	0yDIJyK+hn7ViYpUU6JvtLLQgAxjae2BjkfuVKSOFdfiV7qRKlwvaR+zNXtIoVdKNIUwVp9OJoE
	oFukTP7oy1MTecIjhgkVQtyvLSxSD3PhS5EFybxALzpRfyJZuBo53zPZRz0U3i6wBX7HgtfjmiC
	sn5j7cpJO7Fqxa1E1tLKa6p05oVNdNl3QHyz0=
X-Received: by 2002:ac8:5912:0:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-516d4376f00mr168713761cf.37.1779701344172;
        Mon, 25 May 2026 02:29:04 -0700 (PDT)
X-Received: by 2002:ac8:5912:0:b0:50d:3e1e:7998 with SMTP id d75a77b69052e-516d4376f00mr168713451cf.37.1779701343752;
        Mon, 25 May 2026 02:29:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dca7853esm22438921fa.14.2026.05.25.02.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 02:29:02 -0700 (PDT)
Date: Mon, 25 May 2026 12:29:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH 10/16] arm64: dts: qcom: shikra-cqm: Enable CDSP, LPAICP
 and MPSS
Message-ID: <xq6vkeer7c32fmmofhu3yxnwxns4mn7umzwjf6k575m55s5mek@zrjiuo3eiq37>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-10-f51a9838dbaa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525-shikra-dt-m1-v1-10-f51a9838dbaa@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 3WizAs-3djkvHYdCtE-EpgzBNbQJYrsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA5NiBTYWx0ZWRfX4BmgOCcX4GO6
 iNHypIRmnZgELPric81LIWpDSL6woeZjkh5ko18QvhTAtPNpm4PCuWGrjTRZQ76p26v/SJMt6xH
 qBrnuKkJyb1WHZKVcP/9arHG8kvYiCjqi96VpPgQq97Kl25n1vxH70HG4IMTVfCuyi/6/kgK7aP
 6DW70yE7u+5RaTNcsF3R+dXHa0f0XI8/TZSk7ZQ9k+XGdrLn4CS9GT92lDvkxvKgAGMKt74rW46
 ySr8JeJUYnNybb2lfYS4HY17kK2EnCmNwxWiaefnpGQ1VP14X6mpkuJRYzbw6IwBG7ukmu4stZj
 GWTlTamC/aMNTdy7l4fvGRMAA1IjmqPUCpep4RduWksFjGIpGupHkGDuSdL7W4JSS1Rc0zpKx0f
 nTC1Fs9EqIyD5h6HhahSG13swf6oxGr354LEFGM036aebu0zHVCh/KLkYKaZLdAW03Sfi7gkYK3
 bBJaEpQLPcDuJsT29ZQ==
X-Authority-Analysis: v=2.4 cv=H7jrBeYi c=1 sm=1 tr=0 ts=6a141661 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=sdsj3k5SV4FyJC0wfRUA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 3WizAs-3djkvHYdCtE-EpgzBNbQJYrsk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250096

On Mon, May 25, 2026 at 01:19:14AM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM EVK board.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> index 0a52ab9b7a4c..b112b21b1d79 100644
> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> @@ -23,6 +23,25 @@ chosen {
>  	};
>  };
>  
> +&remoteproc_cdsp {
> +	firmware-name = "qcom/shikra/cdsp.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_lpaicp {
> +	firmware-name = "qcom/shikra/lpaicp.mbn",
> +			"qcom/shikra/lpaicp_dtb.mbn";

When can we expect modem and LPAICP firmware in linux-firmware?

> +
> +	status = "okay";
> +};
> +
> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
> +
> +	status = "okay";
> +};
> +
>  &sdhc_1 {
>  	vmmc-supply = <&pm4125_l20>;
>  	vqmmc-supply = <&pm4125_l14>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
