Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A53E8C75
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 14:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776177893; cv=none; b=tB/ovcz9BCvTvk3VO8uzHwvjwW8nWPHNN2JXRVp3TvLNpWIa47DR6HWjfY+b7ALN9tZE4IjiVoGD5x5q16PSxf5bFuKbKN9tC4LMfzfD+upIvRKG84jCfv2kKe9xKbeKz6+ONiR17iNxXu/fy8eA3PXjrvHIX8Hdn30PWZTzYs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776177893; c=relaxed/simple;
	bh=DX1MPo+kqyXJxBsYGxWbZPzutWkdknr6uxWSneDoXxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aX+loQvoY0rXQ7pu1mOl1Axqs6ixe86brsWGz5ZQLKByvRzeONWzZhpDxnmRP0393Y9Q4ty+XLJHymwe1sQYkUhXlxvwTvvsvzF6DkgzWNHh7UaVhB4v1llcH+3TAOC+8yJv0+sZtcG9M5FbriDeYLdDF1gwAk4AtL3s1ZwtWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ig8KDx46; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fV5JVnyC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ig8KDx46";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fV5JVnyC"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EBJ2pu395284
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 14:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lwkZgI/g1jpJ/KRU6AzAiZ0EFxlQQy0hmdMCJlnWlg8=; b=ig8KDx46eP0zpW00
	jSW9QTR6QsWGYdi81My6XqId8iON5g24Tck+m2b69QzPhT94BQVV7kv9fwvBcEW1
	0bATbMguExS4GE0BF/AnTtvv2ymHQLt2HhR4yKGe/XYuylhCYJe34KGaanwuQro4
	30DgUqCcc3OM+xyNQvAHfB+n1T1sK6pl3fgPgN//z5Rp7qa/Zx+//r3AFiWpe4X7
	bjKQkx13Uaz0LS9z2Ok6ixg1O+MuGZXtXDgsDNYczbQJAxPuPzLlPZMDM+gEtISL
	zLelZSEZV+OTIYMdbZqbp/ZbJqb/PMmMG/SNVdoOFrdk5bpQaXzSxZU78eeGEH63
	VtXVOA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870u4nb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 14:44:49 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a6c70f1f8so3818279b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 07:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776177888; x=1776782688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwkZgI/g1jpJ/KRU6AzAiZ0EFxlQQy0hmdMCJlnWlg8=;
        b=fV5JVnyC6ShPRsdRxebdloJigIeyuTZoDmGfI7ANl+NlXb0Rq0W56CoaZQ8FO2nmuH
         AltMKSpBWL9JcVaUqup2CdDSoxB8hNCnV9ANM5ftt7cPnC655caut93ZGjCH+HpzeKsA
         2va4zMdShylbA3PmUfYgkG4W/dw/dlek+tWj4Webz0jGuJA2MLyAwMTrCJGIa1Rzv0DI
         6BRMa/urr90DSfyLds8cfoD6PxehAhYglz+c47Io47RxvxyOxQdC0ruJuYgMI8AkCgiO
         tVaJMwDRHfJIqcLqGjec8/HNmSBQTljnVPXe+eMZ1SfozXtKSVh3HSTO2Pr0PEoM39fU
         vI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776177888; x=1776782688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lwkZgI/g1jpJ/KRU6AzAiZ0EFxlQQy0hmdMCJlnWlg8=;
        b=lBp5mOPq/vKKj/aV4AuJJChEIS2ssj/SrHPUBUinZps824ZsMv/cahs0zb5YSKN+K/
         0vu4y4QqkNYZWfk5GWOuAAuxcM7owatfhkuqShUK+1XyvYg5DgHJ3WyS6/VE8S1+bNIj
         IR81Vk1IQvkNHLOp65cbmbeKWMWOtXTTztYisAWi6w0bmho0GHzKC1I6NFqu+Sxjp+N4
         Cib4WjhK5PSr2rgsD9mXug5ejMjqYONkVVUcBUw1PgsQGdLgS7PMdBI3G9YPlpuNC/7B
         5sUB6eCzoeMMOhHHv/8YgVX5BN7zP2iNex12qN2VUi7/Rm5SHY4Hynn24/dPL4Yo8FMe
         byMg==
X-Forwarded-Encrypted: i=1; AFNElJ82lImYxHiTlyo43mQb40mMx2o1cAh3K0KPhirSU+oeqDwryq+o5/EQ5+I2wK90qx0S7Eyeq5VJ1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6j2UtruOlvhztTW7NGnQ3mXdBoVS6bs8/r6ttlXZBdAiX5jF
	okc7XtHoZBHWzyQKvP/eHmG+Q+tmOCZocxcYzEHqvGTd0a7PWuPQTgdK0naQiSjchvbjFupX548
	vASHQr+gifnhoSVlPgWWsT/l74KwwBCimllkE4vUEdp22JHalyCtMACWQDbXjvg==
X-Gm-Gg: AeBDievIf/oeVKZZ3TwFBdyW5kJpKDdSAqoRBSyFNYBNP6CMNDe00Taji0oCIkh7ApS
	B3+V2/mV6JsEaW41eYh/70xYAI6gkDX6Oz5MFz4+DqGp94NKtpfrJKcDJXitmZhGb8doggs4qKs
	C2tFohFFefhtpN+4Y4KxnSrEEfsgFg+YCEXA37I6SkvV1+61g8CavlFXrwQ5vED7kWp5tP2lQoX
	1IX+qQ+ykz0jvCBzBmDpCax7eygh7VetrFt3WaXoeuoVysycnG8FwxTCK6bzHRLLItjnUTpDp7N
	Rt4cgtaJFNHHxu8Yu6fCQMYN5ZnEXDYhMWWMy80BDE5vRkf+4WsJweHUWV1a9ZMEuWzPviJrmri
	OSlo7PluIBfA5Y9moGkTAqspY7LvWXRemSyGea9DqxuSmA7F5b90GdSKKfvT/nVEuLNvekVrKGH
	vPdHQ+y+reND8WAH+2/P5ft/Fl2y1J
X-Received: by 2002:a05:6a00:b908:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82f0c250a31mr18715999b3a.11.1776177888149;
        Tue, 14 Apr 2026 07:44:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:b908:b0:82c:6da7:2d3d with SMTP id d2e1a72fcca58-82f0c250a31mr18715680b3a.11.1776177883213;
        Tue, 14 Apr 2026 07:44:43 -0700 (PDT)
Received: from [10.133.33.119] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b5a79sm15506391b3a.30.2026.04.14.07.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 07:44:42 -0700 (PDT)
Message-ID: <b3cabf3d-7672-4816-91f0-e6fafd9db4d0@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 22:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpufreq: Fix hotplug-suspend race during reboot
To: Tianxiang Chen <nanmu@xiaomi.com>, rafael@kernel.org
Cc: viresh.kumar@linaro.org, lingyue@xiaomi.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAJZ5v0ie54h2aK05qNZTWNw5bu7GZDgsxM55KSsuF=ReLMkm-w@mail.gmail.com>
 <20260408141914.35281-1-nanmu@xiaomi.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260408141914.35281-1-nanmu@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gc9SuVRFDWJLSyFaFbHy7CLIr-KFGfS_
X-Proofpoint-GUID: gc9SuVRFDWJLSyFaFbHy7CLIr-KFGfS_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDEzOCBTYWx0ZWRfXzcv6x/P7qizj
 DSnyhi9jbfpMJuqqU1GW/qezWyFehmPzKi39NdXaXuNlCFRmXTM/RSVAUrDnj1LYrt3BZw2nTcU
 oQn1kSf2IPK0qeP9TAuC0BBLoyzop9VqHbv/W/WmN15cj43z7daq6aPz2e16UtF0rGHcWrRc/GT
 Azbk5RBK3tBP9oCVrGcqW3y8dhTjwRvbUsHRAKU6EgZZEHZwt80WBhde8SjnB5IPgZyHdaNlXrX
 CGwalXjb3VEC2Izz0jPDE2NSv3vSn6/xbnUJxI6Cf+2+mMaaMznrTR9M8F11vylwkr+Og0WXetI
 X6KJIwdUwPD35/ijtn0YfTm3IasSgz/WFAvyXCighw8LUC3O/OOS507WQOheVRd6yZLrNUe/HU0
 sV1gGsPo3QEbMqQzw5ue/q/koR9pFkPooHzC94XPudU23ixXhhDxjH8rMREuN+JUuDjpFmkQda6
 YuPIGYcYloyKEJoYOqA==
X-Authority-Analysis: v=2.4 cv=MK9QXsZl c=1 sm=1 tr=0 ts=69de52e1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=IeNN-m2dAAAA:8 a=gX2q-BxIxH3dfueY6j8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140138

On 4/8/2026 10:19 PM, Tianxiang Chen wrote:
> During system reboot, cpufreq_suspend() is called via the
> kernel_restart() -> device_shutdown() -> pm_notifier_call_chain()
> path. Unlike the normal system suspend path, the reboot path does not
> call freeze_processes(), so userspace processes and kernel threads
> remain active.
> 
> This allows CPU hotplug operations to run concurrently with
> cpufreq_suspend(). The original code has no synchronization with CPU
> hotplug, leading to a race condition where governor_data can be freed
> by the hotplug path while cpufreq_suspend() is still accessing it,
> resulting in a null pointer dereference:
> 
>    Unable to handle kernel NULL pointer dereference
>    Call Trace:
>     do_kernel_fault+0x28/0x3c
>     cpufreq_suspend+0xdc/0x160
>     device_shutdown+0x18/0x200
>     kernel_restart+0x40/0x80
>     arm64_sys_reboot+0x1b0/0x200
> 
> Fix this by adding cpus_read_lock()/cpus_read_unlock() to
> cpufreq_suspend() to block CPU hotplug operations while suspend is in
> progress.
> 
> Signed-off-by: Tianxiang Chen <nanmu@xiaomi.com>
> ---
> v2:
> - Update changelog to explicitly mention reboot scenario
> - Add observed crash trace
> ---
>   drivers/cpufreq/cpufreq.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1f794524a1d9..6f1d264c378b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1979,6 +1979,7 @@ void cpufreq_suspend(void)
>   	if (!cpufreq_driver)
>   		return;
>   
> +	cpus_read_lock();
>   	if (!has_target() && !cpufreq_driver->suspend)
>   		goto suspend;
>   
> @@ -1998,6 +1999,7 @@ void cpufreq_suspend(void)
>   
>   suspend:
>   	cpufreq_suspended = true;
> +	cpus_read_unlock();
>   }
>   
>   /**

Hi Tianxiang,

May I know did you test this with lockdep enabled? Specifically, does
the new cpus_read_lock() → policy->rwsem ordering in cpufreq_suspend()
trigger any lockdep warnings? Thanks



-- 
Thx and BRs,
Zhongqiu Han
