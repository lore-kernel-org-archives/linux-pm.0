From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] cpuidle: updates related to tick_broadcast_enter()
 failures
Date: Mon, 11 May 2015 16:13:37 +0100
Message-ID: <5550C721.2050906@arm.com>
References: <20150508073418.28491.4150.stgit@preeti.in.ibm.com> <10239011.l6QLHlKIVm@vostro.rjw.lan> <3161640.llJtBoKCBr@vostro.rjw.lan> <8965830.CMQzZzsqm0@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:58484 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbbEKPNm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 11 May 2015 11:13:42 -0400
In-Reply-To: <8965830.CMQzZzsqm0@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, "peterz@infradead.org" <peterz@infradead.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "rlippert@google.com" <rlippert@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>



On 10/05/15 00:15, Rafael J. Wysocki wrote:
> On Saturday, May 09, 2015 10:33:05 PM Rafael J. Wysocki wrote:
>> On Saturday, May 09, 2015 10:11:41 PM Rafael J. Wysocki wrote:
>>> On Saturday, May 09, 2015 11:19:16 AM Preeti U Murthy wrote:
>>>> Hi Rafael,
>>>>
>>>> On 05/08/2015 07:48 PM, Rafael J. Wysocki wrote:
>>>
>>> [cut]
>>>
>>>>>>
>>>>>> +	/* Take note of the planned idle state. */
>>>>>> +	idle_set_state(smp_processor_id(), target_state);
>>>>>
>>>>> And I wouldn't do this either.
>>>>>
>>>>> The behavior here is pretty much as though the driver demoted the state chosen
>>>>> by the governor and we don't call idle_set_state() again in those cases.
>>>>
>>>> Why is this wrong?
>>>
>>> It is not "wrong", but incomplete, because demotions done by the cpuidle driver
>>> should also be taken into account in the same way.
>>>
>>> But I'm seeing that the recent patch of mine that made cpuidle_enter_state()
>>> call default_idle_call() was a mistake, because it might confuse find_idlest_cpu()
>>> significantly as to what state the CPU is in.  I'll drop that one for now.
>>
>> OK, done.
>>
>> So after I've dropped it I think we need to do three things:
>> (1) Move the idle_set_state() calls to cpuidle_enter_state().
>> (2) Make cpuidle_enter_state() call default_idle_call() again, but this time
>>      do that *before* it has called idle_set_state() for target_state.
>> (3) Introduce demotion as per my last patch.
>>
>> Let me cut patches for that.
>
> Done as per the above and the patches follow in replies to this messge.
>
> All on top of the current linux-next branch of the linux-pm.git tree.
>

Tested on ARM Vexpress platforms with one of the CPU in broadcast mode
and also with broadcast timer. So, you can add:

Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
