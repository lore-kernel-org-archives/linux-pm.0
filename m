Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D13E54B
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778994259; cv=none; b=ZmjM78DX/Yab3qGSuzs5hQGrzXRwRY/gK/iNrIp4PQIw/3LhROCFQCiI403wcQ0ssTZY8EAiTzqpejA037+HKZa3ftx4pJ4r9kQ8A4GXvKN8K/gLQ95Bcabmuj7uyE4XeYNCpbXlkFUPhoZ2+S1DudxMw4eZbMST5BUTnC5vy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778994259; c=relaxed/simple;
	bh=9chvZhONWPW0yZQWwIdHzFAtCifRhqpM1JBcB87tDqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h38pXC8yPAxJqwh6xSIgPN9fOCOtG39sUSL30Tvs5fQmHUkPkKvq+oENcYSmoVCexTqBuj7awuqI4ha1gqIsLxU98DA//uSRczgrU2GX41ZkR3USKCp72aCR4vs1/ny7B1oRGkFlU8dYUHsiZIo+j3SltnRLKtpaxCOQjv/CR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JG7hSkx8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UYEf+1AC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JG7hSkx8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UYEf+1AC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H1B2Pm2067447
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 05:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t5aq4c4WhfDevmOHXhOf6BjhCvkdaQq+LYOF9/fXEAg=; b=JG7hSkx85qL5y2ri
	6dSNUeGJgko0nF68HUERZORBpIp8fGM2H8RqFhStrcATUvkB6Ax1AY9nYeZRrP4a
	3JdIurV4ZMHGOw62GoUlGUkDBCuoe6+niSJNiIX5I+1Uae2Ghu3dCXYYR2hkTFC1
	2WBKvI+Ax1wEB86QzyLpqHMPImpK3Gm36uAEt+PMNPqCOjStSYSPC7q/+/oU68L3
	FHdG/467Jp51oO5KyJgePe1UayfVt5O/SdcTci1BIwrmTBAwRZP2QZviUoe2smWp
	iVSqxOFEywSUk5m4elLcd9jqNJMRSV71HyzH3B+3nhqgW02qBP08F0X+JIfnxGsF
	T47e+A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvqt8d4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 05:04:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so1509744b3a.0
        for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 22:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778994256; x=1779599056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5aq4c4WhfDevmOHXhOf6BjhCvkdaQq+LYOF9/fXEAg=;
        b=UYEf+1ACXbMDX86ZbNalg9wssWxCX1Od41GhAbWq9lm56OTH3ixgAb3qHusnlWEpqU
         mj7u7mbi3A0rLOKBXY4ewZsq2Mdoe/GsJpvxUlu5G1coPBuGsikJfLIZ07YsYvHrDA82
         KHtgM0ARZxVCk2QrsmrsBZukk3sSHzLC5CTHFjBBRzU6L7JAP8X3zTDt391ZMqweJZgN
         MtQ988dyPUysJtEXcfxaJxuy7N/XtDELKr+ZWEBNZ5ZXVjXHKh9VqFuQSqIbrseUTU3l
         wa3wyBOdy/ddIo/mYUV8RMOwBoSQJdGzCfwhRvk/Og59DDgIqTlYNE/gzfmVHWcmjFUG
         MOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778994256; x=1779599056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5aq4c4WhfDevmOHXhOf6BjhCvkdaQq+LYOF9/fXEAg=;
        b=Yci96huId8bBLBiYFbfSEzP5TGpFPCfz71yVWEx04Fa/FjvrfZaQdEX0NZg+BeLAbd
         crUwpZyx5CWUI4ijzJGX5l6LVJQzvz6FAG3oxw/c3EygJuDVmQdlLqpwjudOwZ8tf1vS
         dakibHRuNhN0qNyOTr+k8Dmti8K6v7/9Xx+f/TejqPI6niJuhTqBmO/jZTNDlipr4hrR
         phiOhKN/XJO1Z7L0L40nY0vS+gKKGWEyzGC0uK9xcPCbvoVzqJi87W7OwRmbTNDLeRE6
         yhD8g0cdDf399LOw9MgXwhpKeXZ4RWUayUmIRnR48X/v6UIDMDPvB50NLTfqCMv32Xye
         iYyw==
X-Forwarded-Encrypted: i=1; AFNElJ8U/omakVzlDet4kUc/upMHer3v4rhTvXn2Mzdq2o0PztxW6UGKIHMy2YGU+StevBZB5Is5PS64mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxzV0RJtPqiSbR8oWM1OP+o4Gj1xBksRxQPRcbYRrLGzKAfnA
	PTSRyaUekABY6hwlBHn4H5WwFb+UD/gbjLJnlmWnlmL0T1jG3RD5mX5ap+8qAz0YIKau/lRljDa
	RDOpfaQOFc56CaZyIXuf3tPQgWUpMjP5wHh+AnDfEjPYekHnh8S2prb8ytp3zmg==
X-Gm-Gg: Acq92OEASYO60veHpZU0s5aOy9v228BJLnAe7+dLjprx9ckiPX6LtvyhyLgiFJ6KQeZ
	y6KOLf1swKTGxk0tAXSOcOCl+ALjF2emSK4M2EQtHJSr6ExDf8oii+GUicutAd7o0kb8AIvtxwo
	GO0TaQUhGRzKUJ+zDAyFj+cUPBaVDG6eIjK4rVTDe5Kqv/t4VxgXBDF3iVbMY7ghzaCO4Hci/wD
	wfbOeW/thChCD0MYghGH4kJy9DmdQhfVkENFaZ9TnDYSyv6/fqwGb3LXEzFHuXD29ZDqGzitwqs
	foRMpvpBZpuIeITSSY8xh85bB/Ty+COvWNXU6rgaux1QmdKL2UvmgD8ORTX5RiF2jzuIbfGD5AP
	7XwFmSpLQv3LmdV+Mi5iPxns08lmi25t2nRANADjE3xmX7w3V5QTYmuA0S2Ys/bEJpncJffqS1+
	MJxXv/0NJod6zHuOtM
X-Received: by 2002:a05:6a00:3922:b0:83d:d2dc:6b7d with SMTP id d2e1a72fcca58-83f33aee78emr10692515b3a.5.1778994256162;
        Sat, 16 May 2026 22:04:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:3922:b0:83d:d2dc:6b7d with SMTP id d2e1a72fcca58-83f33aee78emr10692474b3a.5.1778994255700;
        Sat, 16 May 2026 22:04:15 -0700 (PDT)
Received: from [10.133.33.58] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c77162sm11517986b3a.40.2026.05.16.22.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 22:04:15 -0700 (PDT)
Message-ID: <05980ed2-e591-468c-a528-5b2b74c192d8@oss.qualcomm.com>
Date: Sun, 17 May 2026 13:04:09 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Documentation: fix sampling_down_factor
 documentation range
To: Pengjie Zhang <zhangpengjie2@huawei.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, zhanjie9@hisilicon.com,
        zhenglifeng1@huawei.com, lihuisong@huawei.com, yubowen8@huawei.com,
        linhongye@h-partners.com, linuxarm@huawei.com, wangzhi12@huawei.com,
        zhongqiu.han@oss.qualcomm.com
References: <20260515094930.273599-1-zhangpengjie2@huawei.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260515094930.273599-1-zhangpengjie2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yDzIzgmqLjuHeozXoQu0CInhORVsYHOC
X-Proofpoint-ORIG-GUID: yDzIzgmqLjuHeozXoQu0CInhORVsYHOC
X-Authority-Analysis: v=2.4 cv=LKJWhpW9 c=1 sm=1 tr=0 ts=6a094c51 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=i0EeH86SAAAA:8 a=S1q_wTaEoxLjIr2KwyUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDA1MSBTYWx0ZWRfX8UIwKrONy+6f
 Bj+vjs0UJEOqgZYqn44ljf+XhlKf2bIqKLSeS+gavNax1ywiD670vi8uBpUyE42kL9Fph9iyYIY
 4tUoyOOdgqxD1HKtE7rd4ufg59sH3YVHx+i/BKuXZshmgBQ7lGTnL01XYWD7ghLkGNxJLlPwZ4r
 Df0EX8b9szZX2y6n6uXwGmAGXtjZNJF8chApFuFaasrPVu8VPMNg65TNQoeGfPwra16FVDAQHA8
 KAG41nZCSSRCXeL16EpeQpRyhtWdgRvlhDy2Mtynv4bIY6rvLPtzVXOH1tlw1zFzZWADezEjIpb
 iLE90HZBSHS0KZmYpfJvYzFoXQu8rSGzY+ohOLIkV2711FzKOqtnKMI2p3HtWSbe0KtB5AJLYS/
 /WvktiiHwvr3XfZJ+G48c5iOhi+drPRClZGP9+POfjfvwfZ/Z45AJ4TWQePEXSBogiMOz3eaTOt
 SbuNEeqBTLDmi+FtM4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170051

On 5/15/2026 5:49 PM, Pengjie Zhang wrote:
> The ondemand governor implementation accepts sampling_down_factor values
> from 1 to 100000 via MAX_SAMPLING_DOWN_FACTOR, but the documentation in
> admin-guide/pm/cpufreq.rst still says the valid range is 1 to 100.
> 
> Update the documentation to match the actual code.
> 
> Fixes: 2a0e49279850 ("cpufreq: User/admin documentation update and consolidation")


Thanks Pengjie,

Yes, commit 3f78a9f7fcee introduced MAX_SAMPLING_DOWN_FACTOR (100000),
and commit 2a0e49279850 updated the documentation later, so the Fixes
tag is correct.

Small nit: "documentation range" feels a bit redundant; just "range"
might be enough.

Looks good to me.

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> Signed-off-by: Pengjie Zhang <zhangpengjie2@huawei.com>
> ---
>   Documentation/admin-guide/pm/cpufreq.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
> index dbe6d23a5d67..fdca59c955dc 100644
> --- a/Documentation/admin-guide/pm/cpufreq.rst
> +++ b/Documentation/admin-guide/pm/cpufreq.rst
> @@ -516,7 +516,7 @@ This governor exposes the following tunables:
>   	of those tasks above 0 and set this attribute to 1.
>   
>   ``sampling_down_factor``
> -	Temporary multiplier, between 1 (default) and 100 inclusive, to apply to
> +	Temporary multiplier, between 1 (default) and 100000 inclusive, to apply to
>   	the ``sampling_rate`` value if the CPU load goes above ``up_threshold``.
>   
>   	This causes the next execution of the governor's worker routine (after


-- 
Thx and BRs,
Zhongqiu Han
