Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC0640DB37
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842251; cv=none; b=bx/maJ48KMXSGnFdVGCAOMlen58M+Iu2uS2ABhvi5lWejUphZO/vt55BcJ2Ti6E2OrClxyAzCKZufX0vIVSNGaJ6E8gAqWbOP5vLSYaZol/7Thn364k3t/cXwVsBHBJJIp8mnxzJWPqLaed7YLw4To/IHU2owtsiwP4KUf1Gt8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842251; c=relaxed/simple;
	bh=P6jfC0A0EmG/xyfQcbws1efUz2wOkhVgwoKrGtJHlrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieY6X/5U7ZTFynlqBnpddATip5oJc5+fkdxoE/5PFdiUdfyAPJmKB98+nFn9rHgqWBKay4yU+uar6yEwq/lWICwyFoft/eVdO214rGAiE+84oLr4/P/lLmN/XLQSwMpGv0abcL6ZuSJrD/43Nub8O+coWjU+sx0zzNwVriDto5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=obR9ibNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JWUYo6XT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="obR9ibNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JWUYo6XT"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CJMoSL144145
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 21:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=; b=obR9ibNyB7rgLaoF
	z62XLJbC4hYkUvwqdYBGhigKWvYaC3RH7SfggKa/mhO1WR8ruWHX9p/UrdNE6gmb
	k+xC6Yf8Lx2KCMQAZQFggHsx7fE+0SWtZLGg3MBO0K6g5Yt5PBdoh8u4Mb6RzMxX
	jxggXFZkmdpcJZ37AEIFhOJwPR0hW1xQE3X7ovKkfnp7jIaRO7VlPpYLx0pCwaXe
	c9Wr3R3S1Vrgup8sUxj2irHlKBxUXAnb8lZLnInekWjn6H9DcFLmJWKNiStb+MIN
	b1DPzWFBLtYMpwyRZP83VD7U+TP5lyqcfMc+k/e24JDQIhm2xrpBn1y6d68EIu7i
	K8lulA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wdrayjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 21:57:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb71b1443so504254285a.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 14:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791842247; x=1792447047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=;
        b=JWUYo6XTP5qUSpsPyZ33sBkeH7ETgktuCJ5RdqHkvgG/siqD9Xe5et28drIOuKcMtB
         cIFBwbSPkOlgGmFI4nR03WLFTr9sEk9qDjAXGvtCHnRnVpF2qyNhWdqR3n1xg0I/WXmO
         pyCRZqK6Wtoz/3ibiO22NdNDipH5+jghncooUotwKjta5v/f5xcMGG8Re0LuzOqHAcWp
         Ra1ZrzzjNen5nkL8fcCMcLyXVaXvvbfouq6yUJw6tBo7C4ey8upFUSee0Ap/zYQh/87z
         DthBzF+wjsfVCfevUynl2hHqrfOmz3e4bEQt/I2q2vyz143vtJsnCLiWpf7FLqDLSKs/
         nT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842247; x=1792447047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6GrCqiMFgsWuCjxp/MP+SWZYLaDIyfVl/iFjpkLpo+U=;
        b=wlD9cCNa6XcxHX1Q4ex0csvwysjHm8EuNaG507uspuRY/XzBaufMADOTf8ojqPWnHt
         fVfqclEZalCOikLA0drZhyKN7a2ZtEeFYNMOG2vmSWwdjmfOhY3gjSbwboU3rHv8SPJm
         21fk4THCzTMkQHU2hH8pPF1UWW998Ci4Sk8S7CsON5fcvT3U2yt++J6y+PIB3lKNx/10
         4HP/J4TLaLWrlP/SGapo24xA6joTIZRfzVbezmWkvPutAzN0DQnw7Apnk4PmLO73a3l7
         a7IqmYq5WJvUCzIzvh5z4p8dAFpc3UvzyynyWybwaaKl9lC2e+mQVU4yhjsaX5rhPO+F
         MgDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxD9QDKVP+FuIhrN45eAeXgJGBQsgjKE3016JpCsw12i4H7yIJAa8C0N7rEyObd8UoGKQUmYfcXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIp123c2eR9SLxc7+FA7iu2IFF74/P9w6+9vF+quRLlzzXxQx40
	4i+6ImQJU32GzVXVoMVMhseE3fgzbheQ8HcG69BQ+QhYUEr4UbL26HscmQ3gh7itvVXMug6lmHl
	T8Nx0WzUDbXJTQaFsfaC7+g4HtY2dpyeao3XKBHTID47jGTYRXziQVxitTlNv+Q==
X-Gm-Gg: AYBFou1Ih20IkaIIf7bfwM6B4sFSKkHzlP/S6OmizAakoBzROkvVqyMG5cIuI7v/NXb
	ljn+r/h9YevpGcd6+JwgBtMKnjJ4n4VcUJoQXa5c16xmIKu+zWvVO8gSLYhiYVDA4P+RsEXXMEO
	IsljQsYP4VYZeYr7ri6uyTdzd7T4skfoyyeofAknEG1etNpm2jYbCyTg3OphE886sCw3eCl7BJW
	agWoj1o8XLUHIOsjIZ/U0D5XKq58ERqStHuY1D/eOcW1QDrkQvuXa0rdzHHlDfD4TUSZ7uTcpb9
	6gyofYtB6l9+A3BHYZKHfd+2FYYJFxpdOrddplxQYBrjBI1RoN/kI6cyeG432mImlAXfvV/vizd
	RXCv8Gv6eywz10lWPr6YdmBGDFlXnm9RkQFcz2q9Z6ytgn9ufoyeENzOVnEuVaw==
X-Received: by 2002:a05:620a:4149:b0:93e:d051:8f19 with SMTP id af79cd13be357-93ed051b7e3mr1187563485a.40.1791842246788;
        Mon, 12 Oct 2026 14:57:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4149:b0:93e:d051:8f19 with SMTP id af79cd13be357-93ed051b7e3mr1187559685a.40.1791842246244;
        Mon, 12 Oct 2026 14:57:26 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7? ([2a05:6e02:1041:c10:7d20:e20f:a77f:4ef7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf21276sm490389045e9.8.2026.10.12.14.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 14:57:25 -0700 (PDT)
Message-ID: <66a8df16-01c5-4653-9fb5-7d746f03f782@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/8] thermal/drivers/loongson2: Fix negative
 temperature conversion in set_trips
To: Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou
 <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
 <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <38f8e7cde8e454e7c6b72cb1b9a1c54e67c8a7fa.1791512067.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfX4yQ3F8yPbUFJ
 FlhYf64kVg96r3quSqwZBrMZxBL++C1VPf1jdJwdpqNlS44MWRoEXhIN5qP+0UonVa4tOZfwxqc
 +DeRAt36T3rkHccjbdEbk/faDMmMhZp3pe5FU/NnqfgNv2IrNw3trL1r3N7iAQN0mhEcRtrjjvq
 psQ2AAqZfBcF61UJpEZDiCkyOU13I2pc3qaMFsLKthlgiMRJRB3Kxq1vr4P2GqdZ+Ttfoimcv1Q
 j0G/O/V9mNw7GJ/kSVnwT2Du8EEUpN9EUJ+D9NDRpSHJceASWHJG7GOQeO5+r+PdwiEzStHfKgE
 EerYVxLiWtcGfzzQ4MkAPV/krF8yHFhSR75z+rZsp+5ZVZzQvJsc12Qm4dTXmSdQ+0FyDSFxXnA
 mUKvGAyTKX/hOdZBUzNpLDjsm7J5HkYbkJcxgZCTsg5hlFKDdhWndDHNXXbkMHrjR11zrhdW1iI
 FbYmauRknW3boqoXQ3Q==
X-Authority-Analysis: v=2.4 cv=SvAFe/O0 c=1 sm=1 tr=0 ts=6acd57c7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=i-ReG1_fGx0deHkufOwA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfXxOFsUDOAJiW0
 ZP8DQ3C5MqAKMoCnWdHWmOBJIUNmVaMTbblhFZa/7/i18oABcnV63Xvlcq51+QkPjT2k1bNYhZl
 HKNj+RAMBIDT6WeTSjrZhB3aMMdWSNQ=
X-Proofpoint-ORIG-GUID: jP-n8UKx7mc0ogA99fmt0ayhkpnIaStf
X-Proofpoint-GUID: jP-n8UKx7mc0ogA99fmt0ayhkpnIaStf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120087

On 10/9/26 04:57, Binbin Zhou wrote:
> The `MILLI` is defined as an unsigned long constant. When the
> temperatures passed to loongson2_thermal_set_trips() are negative, the
> expression `low / MILLI` triggers implicit conversion of the signed
> operand to unsigned long, and the division is then carried out in
> unsigned arithmetic.
> 
> For example, with a low trip of -40000 (milli-degree Celsius):
> 
>      -40000 / 1000UL = 18446744073709511   /* unsigned long */
> 
> After truncation to the 32-bit register field this becomes
> 1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
> bogus value into the trip register leaves most of the upper bits set,
> which may hit status/trigger bits and cause spurious thermal interrupts.
> 
> Fix this by explicitly casting MILLI to int so that the division is
> performed in signed arithmetic.
> 
> Cc: stable@vger.kernel.org
> Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>   drivers/thermal/loongson2_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
> index 4d40fc706a53..f5ff0cac1442 100644
> --- a/drivers/thermal/loongson2_thermal.c
> +++ b/drivers/thermal/loongson2_thermal.c
> @@ -108,7 +108,7 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
>   {
>   	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
>   
> -	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
> +	return loongson2_thermal_set(data, low / (int)MILLI, high / (int)MILLI, true);

What about using MILLIDEGREE_PER_DEGREE ?

>   }
>   
>   static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {

