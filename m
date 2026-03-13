Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559603BD620;
	Fri, 13 Mar 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416744; cv=none; b=IfbLQOwzfEOimEve0IvCCGPidJRzIajlD+EpttgW7sOLJqbp9YLsxxW9PwJygyH9468Xc+2gFYIzZt4aVhQAoHVYfrGTepVzXZch115v38aAxkuN9Ten2k0gGGXJu2iuUEWmXVmRMmvO8MwR+qtudWsfefRUTOo/atMpCT1bFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416744; c=relaxed/simple;
	bh=YYhgaGQGgj6pk0KU3WwMbVlwjJ4TINR3W342W46Ppmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krt/hqu4/hH8tAYORaXU2m8j4jOddiCtbk5Wvan+j7ozYEZDEUrwO1MoAdQTJZ7cL40BNV9cEBkDSTIS1dLeiW+/Am7rG8SQDvpgBAgARnaW331zQ4ohfyUcwl/1gc2bObH22Ae45kikWr1OKynOWZY6BjZ98SLdUf5EXYGbdxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635041477;
	Fri, 13 Mar 2026 08:45:35 -0700 (PDT)
Received: from [10.1.37.41] (e127648.arm.com [10.1.37.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8DC573F73B;
	Fri, 13 Mar 2026 08:45:40 -0700 (PDT)
Message-ID: <a102eb05-9051-43bb-9f25-accf71498f6a@arm.com>
Date: Fri, 13 Mar 2026 15:45:38 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] sched: idle: Consolidate the handling of two special
 cases
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Qais Yousef <qyousef@layalina.io>, Frederic Weisbecker
 <frederic@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
References: <4741364.LvFx2qVVIh@rafael.j.wysocki>
 <c1f6d920-6bd9-4131-af08-da1be1206812@arm.com>
 <CAJZ5v0hnamFh6YUriWLgdWip6mRer69pNcL3ueBt5Aux6fzsgg@mail.gmail.com>
 <ae9d5cba-f525-48bb-bac4-cbd50db1dbac@arm.com>
 <CAJZ5v0grtJVtj7oGDRJ=gyWVs6VnGcydOURJ5aDfE6qVn8nkXg@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0grtJVtj7oGDRJ=gyWVs6VnGcydOURJ5aDfE6qVn8nkXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/13/26 15:28, Rafael J. Wysocki wrote:
> On Fri, Mar 13, 2026 at 3:04 PM Christian Loehle
> <christian.loehle@arm.com> wrote:
>>
>> On 3/13/26 13:07, Rafael J. Wysocki wrote:
>>> On Fri, Mar 13, 2026 at 1:53 PM Christian Loehle
>>> <christian.loehle@arm.com> wrote:
>>>>
>>>> On 3/13/26 12:25, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> There are two special cases in the idle loop that are handled
>>>>> inconsistently even though they are analogous.
>>>>>
>>>>> The first one is when a cpuidle driver is absent and the default CPU
>>>>> idle time power management implemented by the architecture code is used.
>>>>> In that case, the scheduler tick is stopped every time before invoking
>>>>> default_idle_call().
>>>>>
>>>>> The second one is when a cpuidle driver is present, but there is only
>>>>> one idle state in its table.  In that case, the scheduler tick is never
>>>>> stopped.
>>>>>
>>>>> Since each of these approaches leads to suboptimal choices in some
>>>>> cases, reconcile them with the help of one simple heuristic.  Namely,
>>>>> stop the tick if the CPU has been woken up by it in the previous
>>>>> iteration of the idle loop, or let it tick otherwise.>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> ---
>>>>>
>>>>> Based on today's mainline.
>>>>>
>>>>> ---
>>>>>  kernel/sched/idle.c |   30 +++++++++++++++++++++---------
>>>>>  1 file changed, 21 insertions(+), 9 deletions(-)
>>>>>
>>>>> --- a/kernel/sched/idle.c
>>>>> +++ b/kernel/sched/idle.c
>>>>> @@ -161,6 +161,14 @@ static int call_cpuidle(struct cpuidle_d
>>>>>       return cpuidle_enter(drv, dev, next_state);
>>>>>  }
>>>>>
>>>>> +static void idle_call_stop_or_retain_tick(bool stop_tick)
>>>>> +{
>>>>> +     if (stop_tick || tick_nohz_tick_stopped())
>>>>> +             tick_nohz_idle_stop_tick();
>>>>> +     else
>>>>> +             tick_nohz_idle_retain_tick();
>>>>> +}
>>>>> +
>>>>>  /**
>>>>>   * cpuidle_idle_call - the main idle function
>>>>>   *
>>>>> @@ -170,7 +178,7 @@ static int call_cpuidle(struct cpuidle_d
>>>>>   * set, and it returns with polling set.  If it ever stops polling, it
>>>>>   * must clear the polling bit.
>>>>>   */
>>>>> -static void cpuidle_idle_call(void)
>>>>> +static void cpuidle_idle_call(bool stop_tick)
>>>>>  {
>>>>>       struct cpuidle_device *dev = cpuidle_get_device();
>>>>>       struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
>>>>> @@ -186,7 +194,7 @@ static void cpuidle_idle_call(void)
>>>>>       }
>>>>>
>>>>>       if (cpuidle_not_available(drv, dev)) {
>>>>> -             tick_nohz_idle_stop_tick();
>>>>> +             idle_call_stop_or_retain_tick(stop_tick);
>>>>>
>>>>>               default_idle_call();
>>>>>               goto exit_idle;
>>>>> @@ -222,17 +230,19 @@ static void cpuidle_idle_call(void)
>>>>>               next_state = cpuidle_find_deepest_state(drv, dev, max_latency_ns);
>>>>>               call_cpuidle(drv, dev, next_state);
>>>>>       } else if (drv->state_count > 1) {
>>>>> -             bool stop_tick = true;
>>>>> +             /*
>>>>> +              * stop_tick is expected to be true by default by cpuidle
>>>>> +              * governors, which allows them to select idle states with
>>>>> +              * target residency above the tick period length.
>>>>> +              */
>>>>> +             stop_tick = true;
>>>>>
>>>>>               /*
>>>>>                * Ask the cpuidle framework to choose a convenient idle state.
>>>>>                */
>>>>>               next_state = cpuidle_select(drv, dev, &stop_tick);
>>>>>
>>>>> -             if (stop_tick || tick_nohz_tick_stopped())
>>>>> -                     tick_nohz_idle_stop_tick();
>>>>> -             else
>>>>> -                     tick_nohz_idle_retain_tick();
>>>>> +             idle_call_stop_or_retain_tick(stop_tick);
>>>>>
>>>>>               entered_state = call_cpuidle(drv, dev, next_state);
>>>>>               /*
>>>>> @@ -240,7 +250,7 @@ static void cpuidle_idle_call(void)
>>>>>                */
>>>>>               cpuidle_reflect(dev, entered_state);
>>>>>       } else {
>>>>> -             tick_nohz_idle_retain_tick();
>>>>> +             idle_call_stop_or_retain_tick(stop_tick);
>>>>
>>>> This would supersede e5c9ffc6ae1b ("cpuidle: Skip governor when only one idle state is available")
>>>> so we should remove that code too.
>>>
>>> Which code?  Do you mean the one that has been removed by
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d557640e4ce589a24dca5ca7ce3b9680f471325f
>>>
>> Ah of course, sorry!
> 
> No worries.
> 
>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> 
> So should I regard this as a fix for 7.0?
> 
> I guess so because I don't think it would be useful to ship 7.0
> without it only to change the behavior immediately in 7.1.  And I
> think that it can be treated as a fix for e5c9ffc6ae1b (above).

Yes I think it being a fix for e5c9ffc6ae1b should be fine (fingers crossed).
