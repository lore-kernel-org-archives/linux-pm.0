Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A4D38E11F;
	Mon, 16 Mar 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654651; cv=none; b=dM1Fcq7OUWE+ADhVQWpfyNmoZTBGXUG2Z/yGwMD6p3rjPzF6Plipr0SdWumjnrMHxP1M3Uv92g+dfyKZdgz0uNiqJaEqwi5nIRwVKvmewfUF2bS5m4m5OLPWhhfQ89HD6DnBaDfKnVxhs2z2d8Cy/dqATug1ppGcnAOl1K7r9pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654651; c=relaxed/simple;
	bh=PqA5IV4bBfivPPpAKgL2UMU1yNVHj70TuOWi6O1SY1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjJ1mt9H6dt4mLvDesJBbmh8f6cti+i8gA3QDWLwlRfFaOaeSU1nzo4gMRbUFyM3+RVmwmGR5oexz5OztG09FfLfW1aMMWVm7KhQmu3evXSLmDBAWL0/lHaUUuMj9AVv55khpeDpccX//GnN8Cw6Ma8oaGbAeSveMPzTNXBBn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 866331477;
	Mon, 16 Mar 2026 02:50:42 -0700 (PDT)
Received: from [10.1.28.15] (e127648.arm.com [10.1.28.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56AE3F778;
	Mon, 16 Mar 2026 02:50:46 -0700 (PDT)
Message-ID: <3d56b0db-7ece-48f7-ba59-fb1679aee804@arm.com>
Date: Mon, 16 Mar 2026 09:50:44 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Maulik Shah <maulik.shah@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
 <39ffe4f6-5716-400d-963b-06675a727225@arm.com>
 <ba23f8c8-a842-4498-b52f-528baed62325@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <ba23f8c8-a842-4498-b52f-528baed62325@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/16/26 09:32, Daniel Lezcano wrote:
> On 3/16/26 09:55, Christian Loehle wrote:
>> On 3/16/26 07:37, Maulik Shah wrote:
>>> CPU can get IPI interrupt from another CPU while it is executing
>>> cpuidle_select() or about to execute same. The selection do not account
>>> for pending interrupts and may continue to enter selected idle state only
>>> to exit immediately.
>>>
>>> Example trace collected when there is cross CPU IPI.
>>>
>>>   [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>   [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>>   [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>>   [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>>   [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>>   [007] 154.892211: ipi_entry: (Function call interrupts)
>>>   [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>   [007] 154.892214: ipi_exit: (Function call interrupts)
>>>
>>> This impacts performance and the above count increments.
>>>
>>> commit ccde6525183c ("smp: Introduce a helper function to check for pending
>>> IPIs") already introduced a helper function to check the pending IPIs and
>>> it is used in pmdomain governor to deny the cluster level idle state when
>>> there is a pending IPI on any of cluster CPUs.
>>>
>>> This however does not stop CPU to enter CPU level idle state. Make use of
>>> same at CPUidle to deny the idle entry when there is already IPI pending.
>>>
>>> With change observing glmark2 [1] off screen scores improving in the range
>>> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
>>> clusters each with 4 CPUs.
>>>
>>> [1] https://github.com/glmark2/glmark2
>>>
>>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>> ---
>>>   drivers/cpuidle/cpuidle.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>>       bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>>       ktime_t time_start, time_end;
>>>   +    if (cpus_peek_for_pending_ipi(drv->cpumask))
>>> +        return -EBUSY;
>>> +
>>>       instrumentation_begin();
>>>         /*
>>>
>>> ---
>>> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
>>> change-id: 20260316-cpuidle_ipi-4c64036f9a48
>>>
>>> Best regards,
>>
>> So we already do a per-CPU IPI need_resched() check in the idle path.
> 
> The need_resched() is not the same check. Here the interrupts are off, the test check if there is a pending IPI before entering the sleep routine which will in any case abort because of it. This check saves the costs related to preparing entering the idle state, the call to the firmware and the rollback. Those add an overhead in terms of latency and energy for nothing. As stated in the description, this ultimate check before going idle was introduced also for the cluster idle state and showed a significant improvement [1].
> 
> [1] https://lore.kernel.org/all/20251105095415.17269-1-ulf.hansson@linaro.org/
So I didn't mean this as "it's unnecessary", but it did make me question how big
the "performance" impact of this really is, in particular for per-CPU idle states (i.e.
at most sleep / powerdown for you?)
But if this is only about cluster states (The original patch wasn't really clear on that?)
then one issue is that the non-pmdomain case (e.g. psci PC-mode) we don't actually know
what a cluster is and therefore which CPUs to check for pending IPIs, right?
