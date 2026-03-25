Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353230E0ED
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417028; cv=none; b=XqM+d5iZceW2kJbJ/VU2wPvOxjD/ENcK27B5itxay5cwokpj57S4hghB45PbQjgIYWlS46+xerHI5q9y8FNKNyKSEID8Re44eAtGaeWd3CSEfklBJHL+35li4cfVHNof+FnI87Kc7RzKVapNFn7vAtg0nLyM3oUo9i/nwf+lJ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417028; c=relaxed/simple;
	bh=VfbE5p6XxWDtrZKL4z25W3T7EhTAqU1R09iqQNmKxnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvTudmqRJFyZmvINcjPEF5u8u1uW7ejF9VxdFokt833wEavfnKsql+O2FTQvNCn3L+wkgRofJtkMI48MTCw7gi7d/4Pm8hgR3dIE9bossLC40FWTIFFnRWz61Az3x1mfNlKFMsxHQGt6b+0Qi+9V5apnJFXQQ0H3GwNNF8rCDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nv/hLECV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O4mMw/xS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nv/hLECV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O4mMw/xS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P4ExuW989005
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:37:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4OZ7+DhzAq7S4Ng68Au4YsE5QtH605huiFIU9p+rIo=; b=Nv/hLECVJIDE5rWb
	FZ+2J1HimcyyiTy96vTZ5lDjZCOPJrIzcX5BCBtdhvlDzEJSCPwLcEFws9+vFfD3
	EHQKUHzy/zWLe4vcjjPsL3qFXAhzx3DrPG3WXW9jLiJrnbV/ywQyVg0/Sv/bWLO8
	QF/DWtdvZgCD0urnhK8QuUhAHcJF+8RoqOVHgEE0FiiJDJRfHmmMY0Olk9VwOeYJ
	HoBwcwisTT977Bl0TwNg96HZ8VRTHGCx3ULcmIn1grRVZC2Jzyep8q6bSXM2uDZv
	JX4HfKjGcXI8UWO/jNarE8kEyTvHoY9vKUG9bBU7bOxjVr3eYJH4r4qB+Gd45UHc
	ARdINA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m3859-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2026 05:37:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7414516609so1320269a12.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 22:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774417026; x=1775021826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4OZ7+DhzAq7S4Ng68Au4YsE5QtH605huiFIU9p+rIo=;
        b=O4mMw/xSKzBB5fsbdg136ZIbExNbVSio+gfzpW/Gsvnt9KBrW6s5CIPKzbf7TuMaId
         yGnXo0Eq9xPQh7zWrYH6cfV7M/yQLbAAmaNAz733IRYR65gNeu4zUrNT/s6P4LkjGOC2
         OVI9jZ42HoYs/hVR+soLkoyCeK76ryVqZc4FSGlh0aZcBzVM/hTJ9jod2758LAPcQVrT
         WTkmUepKWDmbDi/D5QE0oa6SiLll558G5BN2zINgVTZExbn6fNNJw7xRWpEM6YBEgLtr
         HftO8u4jeQxmrI4g9kgRZOZ5mu7Cr2J0kgUo/MhowV25U3GDzZnf+iY83/pRxY5hnGlg
         Obhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774417026; x=1775021826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4OZ7+DhzAq7S4Ng68Au4YsE5QtH605huiFIU9p+rIo=;
        b=sm8eSQPcgyGd9bLlZ+pIZkjELSmYAdTKAPqQrLOs3V52T3DxkayptPfhOgy+HzMV2I
         MMKHzXFLd/oFDPSrj2AR6P5WhR1YZaurxN2V9jXdxttWMaOerTG+LQqbS4NVD9cYSbN0
         K6sSjyoeTeyznSnOUB6I34ZlZe4IIZ/yZHWconm8e6LDSIJpsaiMsCfpRdIh03G1U+m8
         zGC250AxesL+1GsqJEoCfy40wI3mDC88Jf3DETmO0QFBB3FrRbJp8HfdILKJU3SYFy2/
         os0+YtRwm721UnhBLAupTkEEzMjLEjsMxPCb/w6YoTjvqmCEtSEIIoZdFx6BNdzGboIZ
         BF7w==
X-Forwarded-Encrypted: i=1; AJvYcCWd2rBf3c65MS7jGrsut3sHI9NCUMYwZ2JhfV+Ndf84IW90ayuKDxT4XGP7X28bogl1SESuRprk5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxze+V8Af1FNXHKCmuOojhZZQb5l+jNHdZwjNfgCTfidV+T/C0U
	At5rc8mZV4XjF1ToQ6oEN9793dLracGYfgYo2hExy0gIz9obtzpj1xvhhlmKvTVI4fFRMZ2+lfT
	TENZcC9iU+JGm8ojmqUsW06NXLJLhTIUr/Dy1CmuHffJfa3TrnnHGQDlz+Tg/5VrSYOnZIA==
X-Gm-Gg: ATEYQzz1+c+7qc9PYnUz2kLy/lMXYAIR6D6lmHorfAqnDBtu3JBWy7sPKf7vr3Ib65d
	yLaE5ynel5MDhvIg5Rc+JUVvBmW3Vol/rLb+AvRGa0D0qzfCkQMufWEo6CiPssbs5YDwBisVnEE
	UiL/v5dQKJrd62azImEvuFPc9aTcWnNo+W018yZCdUowslcP0JKZB6PVdoEnqtXS3qNlaD48DJu
	UGdJ7gvlhdx0OetR2v4Z6tOjkzfjx2czGqJzUM1ywimRPOo+neRphbeqijuZKB1lMJvRUuJHe4a
	ZIoDKNC++jD5I70fNZBuK3Py+kQy/y4UfN2g0CQA4MVhaIVQNbVPDYxcyt3HbmEeQLlPhCOies/
	ItM/nNXhkWtgofrCPs13pR7TOxj/kXZkrokijiGcUyNTqwzz3xXU=
X-Received: by 2002:a05:6a00:420b:b0:827:3710:2c3e with SMTP id d2e1a72fcca58-82c6decbba0mr2114527b3a.14.1774417025589;
        Tue, 24 Mar 2026 22:37:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:420b:b0:827:3710:2c3e with SMTP id d2e1a72fcca58-82c6decbba0mr2114506b3a.14.1774417025030;
        Tue, 24 Mar 2026 22:37:05 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03be3396sm15360546b3a.27.2026.03.24.22.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 22:37:04 -0700 (PDT)
Message-ID: <6d1cc767-05b2-428e-9328-599bf7721d72@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 11:07:00 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <CAJZ5v0hv+t8=mT39-xOkGUS5i6vckJxwfQfqGZ4foxK2rFn8gw@mail.gmail.com>
 <fcb05fb8-ed4f-4df1-9aa2-18bc3320cad5@oss.qualcomm.com>
 <CAJZ5v0jL6ms3jaB5Ra9h5FA4WY6J7sGgFLnXTOEC+dvVpW7eaA@mail.gmail.com>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0jL6ms3jaB5Ra9h5FA4WY6J7sGgFLnXTOEC+dvVpW7eaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c37482 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=6lJ8GlR-gWZHLfuqW2AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: fIsu5VoZvuqBpD4DCHKqIhP6vmFQ-3hk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAzNyBTYWx0ZWRfX+nA/iZdyYPox
 17jJuvrbFa2Xq77Z6ZwPMH+6DKLJeJYyZzOaCw7IlsgjjntzAIYPyRqRP9feb5arJa63o1YSZus
 M5O4ePoV6Dqam1Aze86ZMHrr20tN57njimk/z+H+Bkus84fRWOJL/CIyAh//aQn2v715ttlFJMV
 WmOOz8getGYHhG9AM1jqvTJoebg85ariW6G1jF4XopClsi2tnrVin0DLEwizqfeSeKcVUXyqbR/
 WdiFv8flZ7wPtwWNS86+8A//4lWyV9KGUlKuxZ83CLUkf16zX7+Nv701xXD2pW44ayFBSkCnCf9
 odyZCcaoXs89Ght/zxnj5OhoDnE86jLilUuxSMFVTiOSt7fj1wIAOS4oXIsoRnKN1tJJ0e9fShQ
 dZHGgWvwvJILop/xa1eLDiieAzPG6bzU/wW5E1qTJ3ww2ycuO5L+8CQtoWY6ZMqXk0TaKfgtv4N
 AcwsT+9lPVX2JC4gQfg==
X-Proofpoint-GUID: fIsu5VoZvuqBpD4DCHKqIhP6vmFQ-3hk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250037



On 3/24/2026 9:37 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 23, 2026 at 1:13 PM Maulik Shah (mkshah)
> <maulik.shah@oss.qualcomm.com> wrote:
>>
>>
>>
>> On 3/20/2026 11:59 PM, Rafael J. Wysocki wrote:
>>> On Mon, Mar 16, 2026 at 8:38 AM Maulik Shah
>>> <maulik.shah@oss.qualcomm.com> wrote:
>>>>
>>>> CPU can get IPI interrupt from another CPU while it is executing
>>>> cpuidle_select() or about to execute same. The selection do not account
>>>> for pending interrupts and may continue to enter selected idle state only
>>>> to exit immediately.
>>>>
>>>> Example trace collected when there is cross CPU IPI.
>>>>
>>>>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>>>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>>>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>>>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>>>  [007] 154.892211: ipi_entry: (Function call interrupts)
>>>>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>>  [007] 154.892214: ipi_exit: (Function call interrupts)
>>>>
>>>> This impacts performance and the above count increments.
>>>>
>>>> commit ccde6525183c ("smp: Introduce a helper function to check for pending
>>>> IPIs") already introduced a helper function to check the pending IPIs and
>>>> it is used in pmdomain governor to deny the cluster level idle state when
>>>> there is a pending IPI on any of cluster CPUs.
>>>
>>> You seem to be overlooking the fact that resched wakeups need not be
>>> signaled via IPIs, but they may be updates of a monitored cache line.
>>>
>>>> This however does not stop CPU to enter CPU level idle state. Make use of
>>>> same at CPUidle to deny the idle entry when there is already IPI pending.
>>>>
>>>> With change observing glmark2 [1] off screen scores improving in the range
>>>> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
>>>> clusters each with 4 CPUs.
>>>>
>>>> [1] https://github.com/glmark2/glmark2
>>>>
>>>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>> ---
>>>>  drivers/cpuidle/cpuidle.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>>>> --- a/drivers/cpuidle/cpuidle.c
>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>>>         ktime_t time_start, time_end;
>>>>
>>>> +       if (cpus_peek_for_pending_ipi(drv->cpumask))
>>>> +               return -EBUSY;
>>>> +
>>>
>>> So what if the driver handles all CPUs in the system and there are
>>> many of them (say ~500) and if IPIs occur rarely (because resched
>>> events are not IPIs)?
>>
>> Missed the case of driver handling multiple CPUs,
>> In v2 would fix this as below, which checks pending IPI on single
>> CPU trying to enter idle.
>>
>>      if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))
> 
> And the for_each_cpu() loop in cpus_peek_for_pending_ipi() would then
> become useless overhead, wouldn't ir?

Given that mask in loop for_each_cpu(cpu, mask) will have a single cpu, overhead should be minor.
or May be we can have new API for a single CPU case.

> 
>> I see IPIs do occur often, in the glmark2 offscreen case
>> mentioned in commit text, out of total ~12.2k IPIs across all 8 CPUs,
>> ~9.6k are function call IPIs, ~2k are IRQ work IPIs, ~560 Timer broadcast
>> IPIs while rescheduling IPIs are only 82.
> 
> So how many of those IPIs actually wake up CPUs from idle prematurely?

282 times out of total 12.2k IPIs (~2.3%) hitting the newly added condition.

Thanks,
Maulik
