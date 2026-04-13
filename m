Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F98386566
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 05:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776056605; cv=none; b=Fawx2Mh9dK9by5Z4nY8dQcVNLST04E8EkEfc5xVU3GFv4gLV3NnCc+dxb4+lMcPsUAUC9e7GqIyJQT8veWkVNPCKvjgZo150z0hP75R+c+svVl24OOo7XhjKJoFMBS4V6x0uyraQ7s0aMQvJHBCHz7QK8siqp/bTxZ808/8GAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776056605; c=relaxed/simple;
	bh=2L7O0U0ExmYqZ1og3MD3W3RnaeewohUnJ9nb1qeHewM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HhDt2+nCLMXEfqHL+QBh5cxu8sGwlfwIZS/Y5zVe5jJS64MUUQQJzyM65EzYOgkD9HvelFeak9UarQ7qirb6HsZAHTHWDr/JdMyO1eJ2Ii+20kTiISStI+LEb9aFjEXtpUiJdM8/CvRTi5b2flC0RE6NDskucC4c9tqo4ry2E8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6OiJLeK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UaigkrmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6OiJLeK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UaigkrmO"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CNJ4Kj2745122
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 05:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X1meCnpTLq4hEXz2VH+vYcBDlyL0wD7MXjHoWxKiirs=; b=K6OiJLeKKJMkU3Lz
	EQp1yrm2WA9rbMJ1OS/JgWfwB3ItqZrDwsitd5m8a0uEqHvsuoG8Hdh29qAiNPEE
	R0l7O0JpZIR2WNaD1wlfJ9gX050hHnUQqsK7XSqpEajxb/o22Adn465HoSpbNnfL
	WIlw8asA/4RuqzwJFkDSwe7Q2BrcXPLpE5LHSAdjElvdMCTHeMJh9eJmom4JjOuE
	NNHfwyctJJy1oVncB3lbMFdoZj7dv1lHe606MPoOQ0i4Z0cv3ex/O0DWZdTIZCEd
	taAqq6bXpb8ZNcbUrqw9hAr2nSCyGmxwhg6ulx2u4Je/M2nyGWJ8Ji7pP6HvrBHc
	C0eUeQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dffk6kt6w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 05:03:18 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f07078eaaso1970495b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776056598; x=1776661398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X1meCnpTLq4hEXz2VH+vYcBDlyL0wD7MXjHoWxKiirs=;
        b=UaigkrmOj7vv4z6N0inHjrRPoqs8WVikYslpIxUflxvlYVpSZe8ma0mAWhS4h/TOjy
         Gw8BAwuK+hif/tyWM2T1qr/3MrCDXdVx7zRFxlOxDnmxpejod7luvr/rZKruD5XR9IuE
         FL0MbPdzXL3NTl05+/R6b3MR4KlAs8qrEsry+KJOeJWkR9CVE8BF2KhNKvAiGMmI1mes
         Qm+0qtrzAPJabboo6Jd0yxZrwmQ4B5E17HAOee93qr9dx8UnAYx/qxMdH1RXQ4w+WnIH
         B5IJFGv7fMuO4dT845ujWRI+fUidnU4iVDqX4/9KvgTN+BWaxsKsplQg70u6+6k7yoOF
         IPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776056598; x=1776661398;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1meCnpTLq4hEXz2VH+vYcBDlyL0wD7MXjHoWxKiirs=;
        b=LhJneYzM/dVTSSjNs8UYw59TPGZymNHjcDHra8bht0U2jm8BfX9L0uYZpXJU5h/oSb
         TM8b9vktGjninGM/Lf2G9ZupyGKXr/GUKNqLTT0pOMmerX4eoXu7qvEUtSku6TVELgwI
         GBgQM+98Knec1gOw3T8HWKVgI5ceD7sjp3o7MvpPBSc5nDdO1Y7wrRgP86VfBbg5ZMyY
         Qh46GcIKe31MEkb3Jt7W+7ga2wkuUP9vnDG6phynFjxEpYMK/GtSR0GmCJiuOZNFKFN6
         hfa82Snz/I845z3VO0obfCKbiXkjPVSOrkS2RguFKxVDJUTZRpqQq+ppiVCbnOuPYolD
         1hvA==
X-Forwarded-Encrypted: i=1; AFNElJ8w6NplTOpHmM8mfJI5wCsLf9MsPApK8YJn0VXhthHgTbcDjgf09DLv8tB2tVShL66WQDi316CGww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBvEbytFOzW5WUTy/mwNlRwAKu5J2pBwxnh8GxQzZG93cH9uB
	jTvRrHFfswKiyxCFoxQvX9rN5EUZfAPt4MrhcLgqsDFaTex0cmgz9EQKWvt/EL/yHpFY6al1BHo
	wUrVZnIKy5PKvA7JmDlRM3CYk1voEFDf6SRKlWXQ3qtSGSXylfjQX+dvtCJ75PnpApY9sOw==
X-Gm-Gg: AeBDietrD9OnEyxZn47KNkPtJNHciirUSahyT3CYK2DaSNWDrt8OnLLlJs1jHPpRe+P
	C1/b2aVYBHYdhyIoOM8/OJlOX1TDi7pCgW7goLrhnKlUhv8avlAxbCvvx3UNJfpG5v9R0D/HLsA
	xOsTchOBFaXhU7jW2POsOx0aKWprDLCu8mqY6sfwvXi3KDmSDu8jVmk3mLXxlbqEvcqn3z8Amsq
	FfHrPX7i5CJPOFnoC2U5JXv5qwF+rpQZdqXLhjbsANAJU8sIdI2WrLbP1OGlntAodSpEvPmW4l0
	dKxq+AxF2v2rWZcuyiEM0jDi3TRZK1KtBCdoiY3g2rsgEO5b7NqQecfGPmfv/ELmPJc6mc5Hqp/
	NK4TFUid0XCSCpoRBwrvepeTi8Kf4YlzqBK9+RmTi8LtrTvfxTAc=
X-Received: by 2002:a05:6a00:6c8b:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-82f0c1ce9d0mr11933298b3a.3.1776056597526;
        Sun, 12 Apr 2026 22:03:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c8b:b0:82c:6b23:6d10 with SMTP id d2e1a72fcca58-82f0c1ce9d0mr11933258b3a.3.1776056596865;
        Sun, 12 Apr 2026 22:03:16 -0700 (PDT)
Received: from [10.217.198.242] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e3d41sm12205132b3a.48.2026.04.12.22.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2026 22:03:16 -0700 (PDT)
Message-ID: <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 10:33:10 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
 <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA0NSBTYWx0ZWRfX8GKfloIqOg7G
 3DBfylC8eq4tqaVPegvnUVa0Ovf/3PPQNOCoTOcJC53OqgVfxnXaK6LFvzg5Hv143GynNpwSR+y
 D+qxcDo9aQdZXFbqkfPRliju92drECk3kMErUEYss9UgMPji6g5ts6JRtF+5gTeb01u/gq1uMoI
 xvCk4tclE3GtsGzS0elNyzDoeu1PF/9cIJsogZ4bQS+l+pnldkhYOc1I2mLTBNJt6WE5ELsgs2v
 qOzkpBCmb/rmubt7DAbKs4TWP2IQYx9aGTRb8Wu03r0vGsHFVb08xHhU286II2QmrSvpDW+IAT5
 92uQlAQWYlqeoRpBZrCqnyiJzIz+NJ7+rwWCJdNnEF+NDTinNEAqhVAlvAynL3sVM5iQy5lfnC5
 yqrbckhkq6UJkN9BSLd6tJBLZvgTXY8jntayFrUZ+qlqKtRaGQiSKhMofSLKimLPZmi7ZzeVUEx
 xZFL/0a1aGRZMmrV2sQ==
X-Authority-Analysis: v=2.4 cv=YM2vDxGx c=1 sm=1 tr=0 ts=69dc7916 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lggpn7pwzXPsZ0vCzx8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: zoanPhFXIAzYh2lO-sN5sqwa76POQkjm
X-Proofpoint-ORIG-GUID: zoanPhFXIAzYh2lO-sN5sqwa76POQkjm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_01,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130045



On 4/6/2026 8:37 PM, Rafael J. Wysocki wrote:
> On Fri, Apr 3, 2026 at 6:08 AM Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
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
>> Changes in v2:
>> - Fix cpumask argument of cpus_peek_for_pending_ipi() to take single cpu
>> - Link to v1: https://lore.kernel.org/r/20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com
>> ---
>>  drivers/cpuidle/cpuidle.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c01e57df64ca5af8c28da3d971500b3f38306cdf 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>         ktime_t time_start, time_end;
>>
>> +       if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))
>> +               return -EBUSY;
>> +
> 
> Why do you want to check it here and not in cpuidle_idle_call(), for example?

It can be moved in cpuidle_idle_call(), just before call_cpuidle() too.
The intention is to check after cpuidle_select() is done.

> 
> In principle, this check may be useful in the default idle path too.

Yes, this check may be useful in default_idle_call() too.

Thanks,
Maulik

> 
>>         instrumentation_begin();
>>
>>         /*
>>
>> ---

