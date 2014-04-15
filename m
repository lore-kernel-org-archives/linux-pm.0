From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCHC 2/3] idle: store the idle state the cpu is
Date: Tue, 15 Apr 2014 16:39:06 +0200
Message-ID: <534D448A.8040002@linaro.org>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-3-git-send-email-daniel.lezcano@linaro.org> <20140415124330.GK11182@twins.programming.kicks-ass.net> <20140415124437.GO13658@twins.programming.kicks-ass.net> <534D3F80.9010902@linaro.org> <20140415143343.GX11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:60051 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaDOOip (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Apr 2014 10:38:45 -0400
Received: by mail-wi0-f179.google.com with SMTP id z2so5794105wiv.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2014 07:38:43 -0700 (PDT)
In-Reply-To: <20140415143343.GX11096@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, nicolas.pitre@linaro.org, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On 04/15/2014 04:33 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2014 at 04:17:36PM +0200, Daniel Lezcano wrote:
>> On 04/15/2014 02:44 PM, Peter Zijlstra wrote:
>>> On Tue, Apr 15, 2014 at 02:43:30PM +0200, Peter Zijlstra wrote:
>>>> On Fri, Mar 28, 2014 at 01:29:55PM +0100, Daniel Lezcano wrote:
>>>>> @@ -143,6 +145,10 @@ static int cpuidle_idle_call(void)
>>>>>   			if (!ret) {
>>>>>   				trace_cpu_idle_rcuidle(next_state, dev->cpu);
>>>>>
>>>>> +				*power =3D &drv->states[next_state].power;
>>>>> +
>>>>> +				wmb();
>>>>> +
>>>>
>>>> I very much suspect you meant: smp_wmb(), as I don't see the hardw=
are
>>>> reading that pointer, therefore UP wouldn't care. Also, any and al=
l
>>>> barriers should come with a comment that describes the data orderi=
ng and
>>>> points to the matchin barriers.
>>>
>>> Furthermore, this patch fails to describe the life-time rules of th=
e
>>> object placed there. Can the objected pointed to ever disappear?
>>
>> Hi Peter,
>>
>> thanks for reviewing the patches.
>>
>> There are a couple of situations where a cpuidle state can disappear=
:
>>
>> 1. For x86/acpi with dynamic c-states, when a laptop switches from b=
attery
>> to AC that could result on removing the deeper idle state. The acpi =
driver
>> triggers:
>>
>> 'acpi_processor_cst_has_changed' which will call 'cpuidle_pause_and_=
lock'.
>> This one will call 'cpuidle_uninstall_idle_handler' which in turn ca=
lls
>> 'kick_all_cpus_sync'.
>>
>> All cpus will exit their idle state and the pointed object will be s=
et to
>> NULL again.
>>
>> 2. The cpuidle driver is unloaded. Logically that could happen but n=
ot in
>> practice because the drivers are always compiled in and 95% of the d=
rivers
>> are not coded to unregister the driver. Anyway ...
>>
>> The unloading code must call 'cpuidle_unregister_device', that calls
>> 'cpuidle_pause_and_lock' leading to 'kick_all_cpus_sync'.
>>
>> IIUC, the race can happen if we take the pointer and then one of the=
se two
>> situation occurs at the same moment.
>>
>> As the function 'find_idlest_cpu' is inside a rcu_read_lock may be a
>> rcu_barrier in 'cpuidle_pause_and_lock' or 'cpuidle_uninstall_idle_h=
andler'
>> should suffice, no ?
>
> Indeed. But be sure to document this.

Yes, sure. Thanks for pointing this.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

