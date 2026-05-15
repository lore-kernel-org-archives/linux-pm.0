Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DCF34F24A
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847858; cv=none; b=RzmzwrPoaCgcAiHjeMeapED7GiXtEvUfH1dIuh5hVJIOKkKikUrQMFmZbf865NsQzeTcY5VDM9bKU5Cxbdf9z9jF5wae3gEYHBg1tWJ0XvK1y+1AHdmDBRXy6A5RcOpUK6nhLdjymT4d5ASa24ni0/VpZBFxfSLqYjAgVW/xAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847858; c=relaxed/simple;
	bh=n35Ox9SHDTSmy/Qme4TpxsG0OormwGUSaHF8R+CbmQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgxGYdxpovk5ukcV7p22zjPj50lzAFdzFfrYqzczxRKeL9FMK2bx+7WHXdXn7BmS7l8tbIMszCvLD/KJ75Je+dDW5WVaHLsyM3Y9uhazZWy0iM2szKt0wCMKwvVQ47Dx+WP89ahmMqhhEXNwshAOtMCr7NgqK243RoRjJzBBNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XYnol/DH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jDB+mcbm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XYnol/DH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jDB+mcbm"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FB1xmb654908
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CUZR9ZoYH1LvpuTJKJNYRmklMZDlDcRHYz9joGI0fw8=; b=XYnol/DHY5sH6esq
	Zw4VVSHJyg2jV3Daou7rbJmqct12kMOuELtApyREqo5d2ZKni+Ip489bO3r/zQmi
	XxaJh46WDvmmWyjv4bd0AdI7sfnMwr2CP8SRpU38mAmIlUeO+h4bslg83UK86zPM
	V/W44VwTvnrZL9lVkEjQkN5+IDoLHHg4Xm3q1oF33ouLGZfkHJPhCRrn37DAvAQg
	O8L1z6I3J3WoS6QKPx0toPf7Zjd/KOFb2cFOuRBMB5h4APvXI3HByOXDoh4ExLMm
	01uz/85QcOc1AsyBNBFY6nRMhsE0nGoUJrEBaWg1DMrnJqzk7E470Pp0bJmeUO1h
	MRFPsA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1pu8vr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 12:24:16 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-575dc3e7bb8so303494e0c.3
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778847855; x=1779452655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CUZR9ZoYH1LvpuTJKJNYRmklMZDlDcRHYz9joGI0fw8=;
        b=jDB+mcbm12xajeRLHANxBqbeIXivzUbR0F9n7ffZznXwrkDChe5TuU3TChBsyZzEDU
         IN6RhZlBk9qOkaOS17pVJjKqHyIpJUDvdx5ZQrawyYIxdtiT9xogJtNenFQLC2tb9w/C
         U8pFCu87+Wk3KzRM3a7TvzvtSla+sWcTQBeUW0SkiQHUpG9fEnAD9QNTl885wgrJ9Cfv
         Qn2ignn0/gkwALt32QnJUlkVn+GHfrEkLCMpeaZL+3lQjulSG1G3c8EUbKbBdyl9j/gX
         HdaZASu5E1qPSQm7mbD55HjPrDoJchwKvulI+eU4PRmsoDErZprQwlaUXTZYYUO3H3/X
         UmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778847855; x=1779452655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUZR9ZoYH1LvpuTJKJNYRmklMZDlDcRHYz9joGI0fw8=;
        b=NV7Kh/KDDxV+s92z9T8U0yNW+Oo2fnz5sjYm9KacM/c0vasfC74Hk7l5y0Iy5sgKxU
         55mCoeh9ii0qmIenDB23oa/IK15fmG3+4ob2EFdUE2fJJ5YR6TNTSmobq1jveyotQPAC
         Qg/WkUigtho+OugVLQtf65/b8nNiYVM8h2bwBrUGzDPYtwFwrdngUinsStnrC0i0iqkk
         IfFSwuqZbTYJ87XVeJBowzb1utjnSwdfaG190Pinkpbpto900rO5TzxUDjqRUJYMAOlm
         bcU+2EVHefZ6y8vIu1SsGK8I1gd71UCW5u5fK5G9lbfaP2zR1uZKy47YkVYPKOsb54YR
         TrrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zX38FxzgB8klGpaikmWR+GLHcq4jJnfJ3yDlGIHNj1HNeoKsDihx5VFQX8eZI7306A+6TCzTysg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkqaSLKDzYIUzMWGCORfEGYcCSoylu6NEY9CUMWlRUsFhFN3V
	/8v8IhKtKP+FDCp7cFDLpYxvHznjWQOX8rdsIrCxz8EkIGWhCw83bwCF/WespwDD4vXMaLDIYcm
	uKcD29VVjHC6C3pvkR+lcKHtCFSKZuxjXhr/AiKrrdczzvYyJ3HpIGaCk9te7cQ==
X-Gm-Gg: Acq92OH7Jx815h/iF3G7zozo5oV7WgK4LDm/Bgk0xVsJv2wWxKDTha8zylO/wEcQsg+
	Lhf+IYSqJoaBIvn6G5YmdkpkLSRmMUmG52MH0L7ky9CBn8Fo/e/QlO+dec+K5mP29Fy+4Du0HOS
	hjX/yWy/6KHjR/RwDmsTnWk6OY/oDBgX0wfEYkGTwmzUyYVRGJYVcSWgcDEtEr6H26MzmxDhP9U
	mD1G+sfDq5W+EI9tK1SdE3o/1DgVvsR2pbZ0jj2H+73ZZLPoAgQvV3sM16ltU9DD7lo/esZCxxr
	AaNRcmAEloA2Uwx37pPGDQ1LNDCYQd4VbV2PTIcz7u3iA+qEQODry5uk7tuck+8oApyY974K/uz
	e/aMHkv952OGEp014f2nhFBwhwtdsgT0eww4urRICKzPWgwuQhU1JIFgG0e2JOq+nm63+aDI8bO
	zYEdQ=
X-Received: by 2002:a05:6122:4019:b0:56c:ce6a:90d4 with SMTP id 71dfb90a1353d-5760c08722dmr855409e0c.3.1778847855224;
        Fri, 15 May 2026 05:24:15 -0700 (PDT)
X-Received: by 2002:a05:6122:4019:b0:56c:ce6a:90d4 with SMTP id 71dfb90a1353d-5760c08722dmr855388e0c.3.1778847854572;
        Fri, 15 May 2026 05:24:14 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd110asm221859166b.4.2026.05.15.05.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 05:24:13 -0700 (PDT)
Message-ID: <a3c5432a-3bc5-4db4-a9fd-964363f9a247@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/drivers/qcom/tsens: Add support for ipq5210
 tsens
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260515-tsens-driver-v1-0-015ca76f1418@oss.qualcomm.com>
 <20260515-tsens-driver-v1-1-015ca76f1418@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260515-tsens-driver-v1-1-015ca76f1418@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DRMPD_YKUaMQgLWryCjUE92I15Fz7hmY
X-Proofpoint-ORIG-GUID: DRMPD_YKUaMQgLWryCjUE92I15Fz7hmY
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a071070 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=QEtjM6DR4gV46jJZMCkA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEyNCBTYWx0ZWRfX8N/Uhgn0vkvd
 j0WeFT+4SnU2Qu4vywCDl9jxTlkhlUhaV/mYzALddMaACOwLWINv6yyPJYPt4j1gc+zBgciDun+
 jP+8pqH4PQ4fsGCTg1ggVuUOyY2ZRRU6x8WQxcbsjIN6n/l/+Ff4bQOPM8mOFl+SUxiMJHwnWa8
 6NTKkt6+4yf1G+DdeC9uEr2bHndlSRti/KEQA+f5FfaJWp3COhDS7KytOBgJ7sFHILcA24Pdj4J
 OQUxzJ+OyUwc4z010ZqGmOWtklqjWZl24UGE5LtlD2oW+RHjF7JKidZeZK5nUKVdz272OEI6cUb
 hwx+t7j7loSmjIHFU5o35D0mgkcJQmwZaUu5YmB1EAuv8aa7HYwYBmWFYwyBGzO2uMjzN9mTbjh
 gQDEi4emaQFoABN6U5j21ocAWxaaVRbuJ+uE48dWiN/KigMbMW05YBJiIhn1b99pEyRhHjBfUjt
 1aTQILg9/8D38EOU0UA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150124

On 5/15/26 12:17 PM, Varadarajan Narayanan wrote:
> ipq5210's tsens is similar to ipq5332 tsens. Re-use the ipq5332
> data for ipq5210.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/tsens.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index a2422ebee816..c0c7ecdb9c2b 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1110,6 +1110,9 @@ static const struct of_device_id tsens_table[] = {
>  	{
>  		.compatible = "qcom,ipq5018-tsens",
>  		.data = &data_ipq5018,
> +	}, {
> +		.compatible = "qcom,ipq5210-tsens",
> +		.data = &data_ipq5332,

Fallback compatible, perhaps then?

Konrad
