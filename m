Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ACB47CC71;
	Tue, 18 Aug 2026 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069443; cv=none; b=qOpuviOKrzchNR57fyTIcKcZo0NmXz+KaWr+J7LOmwGL9+cjWodT50Zp0sDTOkO+aAtL6fBCSR8k5B8FrAwqc+zrB3bNR85dQfz94/I8D95YpnBOZBspk3PJNKDxGjzR/UXRzWl8RX5Y1YwFMLaPDMa4ZiVVa2oEWIcPJ4fT/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069443; c=relaxed/simple;
	bh=1yXR7c6RYA/4K5q55flP0Y5hn0BebEcUl3UTHOa2tNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k27JKCS2iOv81tNpVi0DHQEJtXWYunl0ByPCIyEkmPC88TBEK+C1jUrdjW+rHFu0ZUOnldrrpw1SFdiNDA09EVs6jORVQT16Ex9WjMcpG5zH/HZNlw8uMA7wAuI1IEeInL7HCcGEDb9VZ86FRqtvSZI0aj3GXY/yIH888WI5A/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r01YAmRY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r01YAmRY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC471A00;
	Tue, 18 Aug 2026 09:10:32 -0700 (PDT)
Received: from [10.1.39.91] (unknown [10.1.39.91])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0E13F85F;
	Tue, 18 Aug 2026 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787069436; bh=1yXR7c6RYA/4K5q55flP0Y5hn0BebEcUl3UTHOa2tNs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r01YAmRY0CFAfOkL1NYcGpNT9K4IMObLLcDxfbA6Vp8LSIS7esA3c8rwzv8OsD2vS
	 H8q53ceXGBDILnVDjxRSOngso8ifEZNnqrMd6FLp0FGT4NAEfRJKl5GpDt+eWu5Xj4
	 VGO1l/YWQHjDGiWcFpjgF7kO+bDKOK8OVvVD9UfM=
Message-ID: <bc9c2236-6411-4ff1-a03c-d97997b5f780@arm.com>
Date: Tue, 18 Aug 2026 17:10:32 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20260403-cpuidle_ipi-v2-1-b3e44b032e2c@oss.qualcomm.com>
 <CAJZ5v0jXwtBz3z4h3ehJTuaqYN4z7=wOv_LGnjQ4LQMP0TBKmA@mail.gmail.com>
 <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <5cfd774e-8797-4765-a36a-c3dc2d6ac004@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/13/26 06:03, Maulik Shah (mkshah) wrote:
> 
> 
> On 4/6/2026 8:37 PM, Rafael J. Wysocki wrote:
>> On Fri, Apr 3, 2026 at 6:08 AM Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>>>
>>> CPU can get IPI interrupt from another CPU while it is executing
>>> cpuidle_select() or about to execute same. The selection do not account
>>> for pending interrupts and may continue to enter selected idle state only
>>> to exit immediately.
>>>
>>> Example trace collected when there is cross CPU IPI.
>>>
>>>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>>>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>>>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>>>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>>>  [007] 154.892211: ipi_entry: (Function call interrupts)
>>>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>>>  [007] 154.892214: ipi_exit: (Function call interrupts)
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
>>> Changes in v2:
>>> - Fix cpumask argument of cpus_peek_for_pending_ipi() to take single cpu
>>> - Link to v1: https://lore.kernel.org/r/20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com
>>> ---
>>>  drivers/cpuidle/cpuidle.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c01e57df64ca5af8c28da3d971500b3f38306cdf 100644
>>> --- a/drivers/cpuidle/cpuidle.c
>>> +++ b/drivers/cpuidle/cpuidle.c
>>> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>>>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>>>         ktime_t time_start, time_end;
>>>
>>> +       if (cpus_peek_for_pending_ipi(cpumask_of(dev->cpu)))
>>> +               return -EBUSY;
>>> +
>>
>> Why do you want to check it here and not in cpuidle_idle_call(), for example?
> 
> It can be moved in cpuidle_idle_call(), just before call_cpuidle() too.
> The intention is to check after cpuidle_select() is done.
> 
What do we do about the cpuidle stats in that case?
I'm thinking primiarly about last_residency_ns and rejected here.
