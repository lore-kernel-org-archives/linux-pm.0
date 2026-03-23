Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D8399003
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774268005; cv=none; b=akyJSuSjk/wCoqiaRdasXvq4hOm4Eb7m78UpexZxu0CQ2e4AOOp/gJcG+e2vH1ccJ/zol/TjnM3XzIlUc7SPMQbkfT7ueDlkptf/g73ePBSROxVtIPh02d0Ed1xlAEck2BAox3hNDMroJlDY4fDbmiwyUX9+78BYtGTYGUuB/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774268005; c=relaxed/simple;
	bh=o+JFJtu6y7N5kdyo3DdaubQZRMksn2QckUlkaFBAxlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikUVKyBd3UpV2F0THRcGa7dgHZwZuMl/8kF8eD/ifazyoDAOudKI6uNhf6ETNOO4rwzAPAw/u3fbkaLDrgm8n69V6qysPGT6M929pAiLHxdwfSdNnEIeEwONF/BFrSXTEy5bbCOlNFrYpIJcEUZGn1RG4Neymn7G2dLzxBfcYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bmb7UHgU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qh3kq8EH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bmb7UHgU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qh3kq8EH"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N7tdui1627218
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9kZ8mRHoal7TjebVoiJ3QW1/Vt28tdmOa/xyLh0UN7o=; b=bmb7UHgUYndyvqdS
	38xJGwuRiN4KyoMiZDow2PhbsOtlhFY7sCSntZgoPsWuiOxbZv6NRZvdBVc2OXfO
	RAw7fk4CE7BGiBOu82MYlYrCkO/3BVsJhNoSR6Ewob8jYYdoziZKQO94cvh10oaX
	/LU/jZksG6VhREqdsHgnOEJSK+JLc/xQqpHG09wVjDO4KmW6ZPmVLnMe7nrJ8qYY
	DqydSs/j+nr1+DLSpd20p6u74aYHiJo7QGnS+alQwbh4MluoVz4e5vN4kHjzlHVE
	cS5KKMy8dibv1oBy9mxtxO2Sy+DCeiDsNJ5aMHHk/9gsCzz1pBztpvK7gOeIvVJ1
	oDzX+A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc0vwc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 12:13:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35b96fbfc64so15030291a91.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 05:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774268002; x=1774872802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kZ8mRHoal7TjebVoiJ3QW1/Vt28tdmOa/xyLh0UN7o=;
        b=Qh3kq8EHXj3F4QjbCb89HPd7KRRjyXeSpj7tRZ0h3QojPSsX5WN2tsBkFJB3zaQfXo
         QaYZuYQa8UNULgbBnsR6sr2b7kITqTnJa1NW00me0GXds1DDwy0zZIkNgkVon2Lf6J3t
         7N71soSeOgPsdrNHnh2iy9WXoeiQmUQZe8w9Kr5n1SAILHHqrsO5w9LjwVAF3x1WtsDo
         j9L1xnbe9I81IAOHyNm1HOuPbOXZaNJIlsEPAV+rFjXgMieZvQ1Mf3yDMFrw6BKZ883d
         ZoBtpukm6iP+OrsogkaRJJb+563cYWECbzCe9VWzy2KvAMW1XjdJzQxPlV2k5qIn8jf9
         Bwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774268002; x=1774872802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kZ8mRHoal7TjebVoiJ3QW1/Vt28tdmOa/xyLh0UN7o=;
        b=Rd+jOIjSj56OZkBINETwkCnlqEQ3hDW0/FVLeyK5vJxKoonYyy4v4WEZYEQmNFTSiQ
         kePYt8JfXsyOtwLTESpPnbpCZbuoUXkb8yEb9nV3o5XAqYTh/Ux8o+C1HGQwBd6tZv+l
         xvTdzLaS/VvJSTUvJAA681MEOYh6/qzRgvTg8Hi+NOz+3GzosQTOAW8gUWUgv9o1RZho
         CEDCxzn1dK4oOg453+aNVxZZjqmtI/Ai73mNizfXFqa89qmSZ5Sh3HqKflTrNy/i0ayE
         iLlxD5iseQH2GRz+uIK8j0saYSgZms3YvlxapWhdU95hFkoZ+i14VegPoM0xJjHF7Mla
         YjEg==
X-Forwarded-Encrypted: i=1; AJvYcCWDrOQTC29KOtqk+VXkEvkGB5/QTHCfxj6guWwNUaT65ISS5j8D4a883HnnqqP8nYhVIf7c3kJLfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Nxs9Hpko4PjxmHOa2IABmIF7nLpj0lsEGczQOUWFfwRMwFee
	Q9J2gGBHFnXVpEhsft2oGQ4ACfG9hMKuomi8oCmcVyUoQuXQHrr94QAIHBKlcRg816ov8Q7ga0k
	8RTfD2BoVOi4BS8ZkwCa744mrbIflAnxGxa/wQ3MMcLUVDUbm9HhgXt7em0LfFg==
X-Gm-Gg: ATEYQzy2bUG8GpchXTvggrllRidsWP+7bI6G5ooIk0Qj112LdtdO1cFLKIcElpk94li
	5ustRnRMtSB5NUb7WEthsgCJxXDnSXxByHUIqOoo1Geeo6v8Xb2EOy9IOTKjnE37IP7P7ggAnPd
	FFF4eL0C5lo2qoGQA6QdrXP0F+9T+9hcsZQn00vDC4c8aD67JnS0ViYeGx6MgNP9RTtR7WwbA30
	nwgNFpHXuQtYsQRATRhjhPO/p4iM6clsvOgwAODS2NRKmL4hC5rSmiO4gMmF5kdeauiwO18uAEr
	ZRHg45kOqclMbR6UMBOHIuDO7JDUbj3/s/e8HsNz+Rs/8wSh2kPrbmUjDT62WClnxmAeh8lUgrD
	sHeVKOPeJYeM0JFxd+0eNC0iO7BWH+3Kl/ySoz0HBaggKsOHjjZQ=
X-Received: by 2002:a17:90b:5203:b0:359:8e1c:542 with SMTP id 98e67ed59e1d1-35bd2d217b9mr9330694a91.18.1774268002455;
        Mon, 23 Mar 2026 05:13:22 -0700 (PDT)
X-Received: by 2002:a17:90b:5203:b0:359:8e1c:542 with SMTP id 98e67ed59e1d1-35bd2d217b9mr9330655a91.18.1774268001912;
        Mon, 23 Mar 2026 05:13:21 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm12976530a91.5.2026.03.23.05.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2026 05:13:21 -0700 (PDT)
Message-ID: <fcb05fb8-ed4f-4df1-9aa2-18bc3320cad5@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 17:43:18 +0530
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
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0hv+t8=mT39-xOkGUS5i6vckJxwfQfqGZ4foxK2rFn8gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c12e63 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=lggpn7pwzXPsZ0vCzx8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: fLM8aJR24jMJZiUGM8p8SOon8rqs7WkZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA5NSBTYWx0ZWRfX0zDmGfqE+Wjt
 7DNuogHJGwqGDxXWIamUfrd32xT6k2g+SHcMYL3ar/2oG9bKTguPUeo/MX/LGeffKfLz/F9ZrBz
 h95PuyCslPG53FSqqA5BhQVr1mJOTRPmbVwEWEyxq+OyMFuIVplC24g4ObhON+8x5m7VfFbme8k
 9OoPKamtcPjKFmwqflAQNL6LJUMoE/zyFpVK9qEiQ+yrqrtVDcYvUb8zQNWH6/oBGS8nGt24i8b
 QYjJqlIF6FGJ/beerp8ghHy2jIyLU2c3rqVxOGexDuG8H1gPqkTucRQXgzVpQjW831zbm8uNp4N
 4MnCtvY3nZ1JjFzdQIU/xgGxYr6bDK37H1i9PX3dxx8iYrHqG5dOglTxTGICiouzoYFDtQuo4Nm
 dIiQAL6YBfLM2caVNs7ld/NBVOTHCtqF59IlIWP0boKNOD8U2M8PvKXVPSgWzOE6hF7lsTpO/VP
 r6RzReiBwf5xY8qPtsw==
X-Proofpoint-ORIG-GUID: fLM8aJR24jMJZiUGM8p8SOon8rqs7WkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230095



On 3/20/2026 11:59 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 16, 2026 at 8:38 AM Maulik Shah
> <maulik.shah@oss.qualcomm.com> wrote:
>>
>> CPU can get IPI interrupt from another CPU while it is executing
>> cpuidle_select() or about to execute same. The selection do not account
>> for pending interrupts and may continue to enter selected idle state only
>> to exit immediately.
>>
>> Example trace collected when there is cross CPU IPI.
>>
>>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>  [007] 154.892211: ipi_entry: (Function call interrupts)
>>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>  [007] 154.892214: ipi_exit: (Function call interrupts)
>>
>> This impacts performance and the above count increments.
>>
>> commit ccde6525183c ("smp: Introduce a helper function to check for pending
>> IPIs") already introduced a helper function to check the pending IPIs and
>> it is used in pmdomain governor to deny the cluster level idle state when
>> there is a pending IPI on any of cluster CPUs.
> 
> You seem to be overlooking the fact that resched wakeups need not be
> signaled via IPIs, but they may be updates of a monitored cache line.
> 
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
>>  drivers/cpuidle/cpuidle.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>         ktime_t time_start, time_end;
>>
>> +       if (cpus_peek_for_pending_ipi(drv->cpumask))
>> +               return -EBUSY;
>> +
> 
> So what if the driver handles all CPUs in the system and there are
> many of them (say ~500) and if IPIs occur rarely (because resched
> events are not IPIs)?

Missed the case of driver handling multiple CPUs,
In v2 would fix this as below, which checks pending IPI on single
CPU trying to enter idle.

     if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))

I see IPIs do occur often, in the glmark2 offscreen case
mentioned in commit text, out of total ~12.2k IPIs across all 8 CPUs,
~9.6k are function call IPIs, ~2k are IRQ work IPIs, ~560 Timer broadcast
IPIs while rescheduling IPIs are only 82.

Thanks,
Maulik

> 
>>         instrumentation_begin();
>>
>>         /*
>>
>> ---

