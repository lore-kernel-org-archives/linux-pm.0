Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9013F331EB9
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787749483; cv=none; b=G8V5qcGb5wH2nUzpu/o/avWDgmnzCQBBzTJotzW5NS2xZctKz8dFiQXsHOPmX+ktrIej61f3LYUFtAbZyt7FFC9i87Ri2D1P/HIY97/WHK23urWdILGIq6my+CQ5obg3W0jMMcsYaf22Xc9MfzTAtbNSBfdnFggpUnpIkHnpYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787749483; c=relaxed/simple;
	bh=B/QVNW8c9Yt+HEi6DqXYIndWDMwJZmax5BegMSf9VVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHxuJYInnTwHiyjWEyLaNXy8isvp+FJsh1FSMX/XMg4dbiAJ/XgauQe8n/4sZrBHOfS3HW13500MsBb2Q9hJBJKCiV7OY1UtfGBzP1bI4R5Tmge3T+yTJaCx/Keez3v4v3LGUYfX3LT3lYg+/p7OZShNfDsOdhG7CSRApY+ExfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F5+EhYIC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PRjuWaCw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F5+EhYIC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PRjuWaCw"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCBnph1461607
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0C0iLaZ2vQND+BywaHWsCvdfSggpZz0Wz6j9aE4SHDE=; b=F5+EhYICABiU+9Ff
	NQX58fKSxGoQO+rAIB0Mjg/415Dqh4JVJ1XzCvYQ8HFCQNngp0vjZr0vkFmaE1bg
	HAq5yB4EbLfpI/8mXzPzvnTrSsFlrKXqs2kLqg5bSCvfjSJqcqerltVEVT3J/8l9
	M108TQ4JLyIQLG6h8Jj0nMhQUYZEEmE3SqIu8i7YSFynnqryuil5mn7f6xOniS/r
	X3fcRpCM15tVMbKhz+xJIemEuARlP1qvGIFg2Roam2VPX75ImfB7wc3Xk/3jRnOe
	MM2cx+52Z0uBR1hH3g6iRMWg3YYeTr3r5+vSw/TKk3afLe6P+80HQbXkR/5mkNEf
	0+n6Vg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgxm1ev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:04:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97c957141f3so10811241.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787749479; x=1788354279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0C0iLaZ2vQND+BywaHWsCvdfSggpZz0Wz6j9aE4SHDE=;
        b=PRjuWaCw699Z+MT5Q1C2FgYghUl4tVdkBkpGwyR78A58SEy3ObwY6GXThjZc4u5/jS
         yLMXCRGekex7eSOl530G49+uNeH0jWp6OxSSV57WOAmXlb42aVaYgsy0A4PjFLrlFv/1
         pufPhsGj04rC9ZYqQwQKfHbkCZLSg7QhQ9lEYvD/Fn8UUhGlVxemKDPtEQanuImnTu8/
         1GzKH18k3F5IieE1Mr2QfIfquiV7REz28z6i6nJQdAiRQUU3A4irg0g2+t3clvoEZrNy
         xfMaKPb1vgIBnaTqwdhpO9fnDDQrWWVovEyThLmrohfeRyRIsSXtBH4UWH45LH0L5phG
         uGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787749479; x=1788354279;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0C0iLaZ2vQND+BywaHWsCvdfSggpZz0Wz6j9aE4SHDE=;
        b=oabzv3SdqUiIlTazmvZkjANnOYYjNFEB+Pm5U04TlXOwH3oglSqSCAtYm1+jU4djxK
         imXpq6YwmmkrDLbvwR+WV8XlM7k2lAsBNsh3eKzOPZTROP8iys7wFtMfSpc4snnuQcYJ
         upGepglsiHSHbSA6ioPPVds0xCehrW3D+giuX4W6/dnaNelhB+mL5uxt4HtvM4BP2ZB2
         VWJDRo4j5HheFmyQrTScWdemBGs8ZztrBZ0WuFKErLvO+ff0djtshNV+b4KxlOupXELu
         Jxl2E6oUEB+GRGLIEjtIa1IbbnCz0mB2VYfbNHyh6uX87RL8tvqM3soEiJXf7st4K7PI
         9smw==
X-Forwarded-Encrypted: i=1; AHgh+RqzD/ExRrl4YgnxBVIONdYymb5mI/Lxa65iDb7S9E74UqX62Pl4RYnov9noCyDzLinox9bERqtaSQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mjlPlOcxmQHLLIZcCb+8a40eMeo/WlhD4FR6wrrQ7f5zN1f9gD
	/Z+tthzUaTA55PefVKlDUYaDHATvPEySr3PdkA6zE+LtIoNPIYi0RmpxIJpzSxvyDzkFw4TT62V
	mjah08EXqimdixNW5okcc1h1uAx0JkHJAdYXwiEa/yRaTGbou2ZSVs3Vnm0Fz4A==
X-Gm-Gg: AR+sD127adNln/mpsEonzydQEeleR7GqvIukCoikIqdPOVtMtXom40ZWON2Qnm80fCu
	/YTuMoYQ6+zhVnH4cP9i39M0rJXVTBeUPvD3N58R1dCwhWu2c7GnOAvpJRne4CwcTEcDuOLocJI
	82FINhTIsu1nAvx6PPO88ApF1JbcsVSVJTD+OGP4mXjCfFtnYcMaUAVfnWILHJdiW8nU2Hh4qQh
	gHoE40XY7pFU4ymPXpLzVNA+fvLndBn6bDXxrxaok2FwHHrM6lbnAxFzZctT4ltuR3YzscOoyDb
	kkYTjhDYyBP5FPque+AvC5plHyTDm3oIE69WoJKt2NqYfrfoNaMalW1486NVyK9jex44GNgKNSp
	wOnIB0V8h8SIVeojL85pn+cQd
X-Received: by 2002:a05:6122:2c2e:b0:5c1:24b6:a1e0 with SMTP id 71dfb90a1353d-5c66c6e06b4mr47951e0c.3.1787749478883;
        Wed, 26 Aug 2026 06:04:38 -0700 (PDT)
X-Received: by 2002:a05:6122:2c2e:b0:5c1:24b6:a1e0 with SMTP id 71dfb90a1353d-5c66c6e06b4mr47844e0c.3.1787749477474;
        Wed, 26 Aug 2026 06:04:37 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d671csm450856166b.3.2026.08.26.06.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 06:04:36 -0700 (PDT)
Message-ID: <6b2f4411-9c38-4b82-b605-6b9a047ab973@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 15:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] pmdomain: qcom: rpmhpd: Add NMXC power domain for
 Nord
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Ulf Hansson
 <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MqZiLWae c=1 sm=1 tr=0 ts=6a8ee467 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=oFIQYVkMYUJ5M4t5nqgA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: OGoMMkUDACaN99GZorN28WNKfuVM44EF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfXx9u8/z9M9KY6
 qAf8/+hfgr+5NwRRl4CrPhMzhhBI/Xz7+8PB7qFkjHAYRfRf804Be130Ehn1XhUbj4lnfETyLbk
 3DRtFMjerJV6bIC/Z9fck1yTt9VGnO9C78UfXjJR+Sike4vSxMY14DCcJ8W+E/AGHUkOOtl0C/W
 B//P7rC3fT6y3PrB+o1+FdiBhsJ0vWkY/IzU/JozHdGC6SEP4a1JUbezpW6733WvU9zkjqqAHs4
 SMJ5QgFoyZZlxmNNJlmAlIJZ9j8Pr5oLFQMiUS2e6sjewBLQCpen7rYrkVjsCsP4ybl7AF/9O9z
 nWPWuMyGfXv6qTHgH2y2lrqsgozXgYlTa6BDIscXWwckQxBegDSWmADXjUdWqBMMcJIhbYtAd60
 MAnZlPGCcgex8dA4r7+V7Gbmkc+mW6w5Cj2skPfUEuweVm3CsOC65Td5+GsAkTMj7aWTvW6z0+D
 D8Oz1c8KnHLyLhF3olg==
X-Proofpoint-GUID: OGoMMkUDACaN99GZorN28WNKfuVM44EF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX7LzkieD6WCEh
 2KoqWTm7u6BPLF41QM5dJR/KI5RfJH23cD8ssCJYr79X5AB0poDmMrto0Wf3Lq3Y97myzNLAdOB
 ufxn7t9Id1OS8hx1unPLM5zO+V8d0Qc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108

On 8/26/26 12:27 PM, Shawn Guo wrote:
> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> 
> Add the nmxc.lvl RPMh resource and register it in the Nord power domain
> table. Nord supplies the NSP memory rail from this dedicated resource
> rather than from the shared MX rail, so consumers need it exposed as its
> own power domain.
> 
> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> index 96e4bd2f5a14..717c44d1c39a 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -198,6 +198,11 @@ static struct rpmhpd mxc_ao = {
>  	.res_name = "mxc.lvl",
>  };
>  
> +static struct rpmhpd nmxc = {
> +	.pd = { .name = "nmxc", },
> +	.res_name = "nmxc.lvl",

The commandDB sources suggest this shouls be nspmxc.lvl instead..

Can you dump /sys/kernel/debug/cmd-db?

Konrad
