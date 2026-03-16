Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D7251795
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653528; cv=none; b=ozXrE+zuz6vuWhsFMyvq5cKq6Jb79qglcjXexENwU26MzLQnip4DpKM48EKgWmlHAIAQ+dcmbnQGHU2w/Aka702J0sc6v53odMHOpb2ZSEYEomyd59aAuVplwdm6f5eJq4m8sJ3Y/HVzjq6gfufOYHpHK2+dFCV02pFC3UN/g3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653528; c=relaxed/simple;
	bh=XJqokLOZsKTYJReR4cyIg3v1eo4NKzO7ugmYAgK7NWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsjVtim86xbLkfOq4PDmrzVWYLzemnwFpwOsL6gFM2XD3sTbTWRgeViwegucCuhfJziuIQL/Pb1NZsX+GGXInUBXbzTzNa0cbSgEMod2GFpjpnMqqXZH66XeBFQ5qTdP4XuvDH4kJms2s7ncxZgCJJq6Jt2mvkH8SYWUX7JfZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JePlYEyh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fA9sBT96; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JePlYEyh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fA9sBT96"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G65BwU1068188
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f8X5kFWCBMHnHAO6UFq3igterPL5sWg/kPVCVlpvea4=; b=JePlYEyhlCzzXls6
	LZ2P+MaAKZ5JahO6nscuCySZNkWfk30ZcQ4xJ3/Y2uRH9nqnblZTMAF8OWFrSEPI
	rVZKqXQ+5kVKsIkUHmWONICVePSvzDKAwyafuhyFOkm9QJbxjEOhbRJwqKT9MBze
	GWTklqboGjbvlxhDPB2bOvjrT0jo1vYaQpXiKUE4tUYgTuyJLDnEeon8wnzskyYw
	EnUl0cPicCScLFq60prGJNts9wbABE1N1USnzRoqdhOyw5HOaq4QPGBUPvQTwV2+
	wYxhW4jj/rtyx8j2LDo8YI6hpOf2osdafuLhe8NAS8B3OSZ11RtLATUPNkIWSraR
	s2yThA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw027d2x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:32:06 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd84943c76so3967689785a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773653526; x=1774258326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f8X5kFWCBMHnHAO6UFq3igterPL5sWg/kPVCVlpvea4=;
        b=fA9sBT965t7Dd9ov+TbJ2AHU/+GUF71qsf52yQV649o2SUau0ZAhVlXJqlr7iZugDM
         Zi8n7v9OBKZqw1CD/quikp9lfAhsjao/um5XDPZAZ1FQOEppNZb039X0uv9z76t0NGa8
         HLGCgRkLY9jyPGRau1mQ+44S+5S4YJyPFrwciX53uVqUBGOHT1m6RFFgRdWcj5w2QZez
         PE7gIfVhlrUgjgaVSkaRha3YIIVdZIdBSn08fkrKDphOfxl1/5sMaA6YdYrhCml37fJQ
         3ZlcO/ONtqR66U4NXtnijHmf266Wc1pNDyMsCWenYQQYtBf8KERpJJSKZWLvFVVEup9C
         BHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653526; x=1774258326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8X5kFWCBMHnHAO6UFq3igterPL5sWg/kPVCVlpvea4=;
        b=PjaVGwWFtDtJH8EeoW3J7rb4GYbCCNA1i0ZnA5Hq+2czoOh62f2D1WEa4d2r8gDQzD
         8qeZiYVFcEkfd4yFkbWqDufdHckNFhPkwcIDYqZI8omfkgw/O898AqiehKyKLpNnRIdx
         1WRD1kxOPeKHILXiqvIWFBDrcQTLxpRGuCPfJDaZs55dkNBATj47etkW8POJ0B1uMPme
         H3z8z/+NAul/S+Qm15cVetck1b1pWJoRLeRfowR9bp+nJKbScwXIG07G4wsjMspI2C8z
         qqf06tkgjud/AONu3c0Hdf11dlI99eL4au4LkaxHtO7586gL2eCcstp9DEOnE3d2DFot
         BkMg==
X-Gm-Message-State: AOJu0YxfODrwfuuqOgS8QabQLBXCN/A2YQWcCuZIZYNMYMviBgDb/A3n
	vpxswhZvEQ++U5Ip9u2vPHzAJDT4yW/xEsIND/+9Bia7jfSlDmH95/BU3A60KINQZebh37YAw5h
	n8l7H0nGGTvx0eTqAKO4ZMzKP/CjtmlPY8/xPJKrL34W6kN3rs524FSYEw73j2EkDc6XokQ==
X-Gm-Gg: ATEYQzwkB8d7wcNKWJ3X0bfK0X4uWgYCIyLrQW8U1zcDHualhuCi1ISr0pFqZHrpH/X
	QYjSKX3vFHRi7VB+9f6A+1eczh+KBqFXdL7Jwi6bG4KKKvAlR35y/KhlqX1DdtS6XqTdyenMFRB
	yOlmwlZX+g45k2bibn3A6QXHhYwXMOB0Zh6Lk9nIeqY4TMrW23Ju9pZYgEsU7Hh+abfA7CLxPPS
	NzboAosbEqiCaVG8xj9vCb2AStsJgbEalHSXJMuWmAUqv3jlsEPdAWMb0QPehJv5FEKOHYJRF+Q
	1BvTIKv8rNCjnAchQ0dVd1029mh5VEiZdlyKcG9DNFIdyYG12GI5FbwOHgPswgayWYPyzXHtR7y
	G/Rt8JRhOEXgEfwhXILsOlXNaoOvwDOSUZtRO5gXl+AppUebCx5UFPnAeSUp7zdL8ygrKbkJaNZ
	2NNka1S5s7
X-Received: by 2002:a05:620a:4441:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cdaa8c59c8mr2259642685a.45.1773653525767;
        Mon, 16 Mar 2026 02:32:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:8c7:110e:9cd5 with SMTP id af79cd13be357-8cdaa8c59c8mr2259638385a.45.1773653525298;
        Mon, 16 Mar 2026 02:32:05 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:5dfc:3995:22ce:d286? ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm871921055e9.10.2026.03.16.02.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 02:32:04 -0700 (PDT)
Message-ID: <ba23f8c8-a842-4498-b52f-528baed62325@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:32:04 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WaX865TV6RsjhN4D_8QqLagNjoQhakDd
X-Proofpoint-ORIG-GUID: WaX865TV6RsjhN4D_8QqLagNjoQhakDd
X-Authority-Analysis: v=2.4 cv=AqXjHe9P c=1 sm=1 tr=0 ts=69b7ce16 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lggpn7pwzXPsZ0vCzx8A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3MyBTYWx0ZWRfX/gZUSuWqqSao
 Z/t4IPO8EiGjJTWjZ/jk58IrlqvoB98GokLfMCsNRfVIaPoRSIL55aQAh04bkiqlgLqueyMAiLH
 a4dfD7oRT8Jfrj1ufDewtcJ85mmn1XNo3NP4+IMAfFcYEqY3aCbLgnWZO6c5f/Omjjkjx6Plz1d
 Xal8jXlYaOyFn8fdf11D9T5P3zrGNIEqppn0/vadCxJWb6Nja33NHQaKRqbsNodpl8MSkuFaLGY
 tY6DJpbkmOuZBshpaEubwUdprzyFaCsNClER3bnbkVXRJCOLicO3HNBE3WD4vBpmT7Q9ijbSFzA
 VxfpWc/8XUvTAQBVfR3iZUQApGc1NS3uWnC/GS3a87aiFtFdu52zUiIeUsmczZ7EJUo1iELutdn
 MyIoFvy4vZEWyNdglPAV3CXAL2NrQ/aO6eDyCmWVmyOX8ZZqWZT+R7mZDnNFnjE4JFvto/ihrQh
 7re87TX/nxMSXfeT5CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160073

On 3/16/26 09:55, Christian Loehle wrote:
> On 3/16/26 07:37, Maulik Shah wrote:
>> CPU can get IPI interrupt from another CPU while it is executing
>> cpuidle_select() or about to execute same. The selection do not account
>> for pending interrupts and may continue to enter selected idle state only
>> to exit immediately.
>>
>> Example trace collected when there is cross CPU IPI.
>>
>>   [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>   [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>   [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>   [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>   [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>   [007] 154.892211: ipi_entry: (Function call interrupts)
>>   [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>   [007] 154.892214: ipi_exit: (Function call interrupts)
>>
>> This impacts performance and the above count increments.
>>
>> commit ccde6525183c ("smp: Introduce a helper function to check for pending
>> IPIs") already introduced a helper function to check the pending IPIs and
>> it is used in pmdomain governor to deny the cluster level idle state when
>> there is a pending IPI on any of cluster CPUs.
>>
>> This however does not stop CPU to enter CPU level idle state. Make use of
>> same at CPUidle to deny the idle entry when there is already IPI pending.
>>
>> With change observing glmark2 [1] off screen scores improving in the range
>> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
>> clusters each with 4 CPUs.
>>
>> [1] https://github.com/glmark2/glmark2
>>
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> ---
>>   drivers/cpuidle/cpuidle.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>   	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>   	ktime_t time_start, time_end;
>>   
>> +	if (cpus_peek_for_pending_ipi(drv->cpumask))
>> +		return -EBUSY;
>> +
>>   	instrumentation_begin();
>>   
>>   	/*
>>
>> ---
>> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
>> change-id: 20260316-cpuidle_ipi-4c64036f9a48
>>
>> Best regards,
> 
> So we already do a per-CPU IPI need_resched() check in the idle path.

The need_resched() is not the same check. Here the interrupts are off, 
the test check if there is a pending IPI before entering the sleep 
routine which will in any case abort because of it. This check saves the 
costs related to preparing entering the idle state, the call to the 
firmware and the rollback. Those add an overhead in terms of latency and 
energy for nothing. As stated in the description, this ultimate check 
before going idle was introduced also for the cluster idle state and 
showed a significant improvement [1].

[1] 
https://lore.kernel.org/all/20251105095415.17269-1-ulf.hansson@linaro.org/

> Your patch uses drv->cpumask, which will contain all CPUs, preventing idle entry if
> any CPU has an IPI pending?


