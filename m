From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle: Handle tick_broadcast_enter() failure gracefully
Date: Thu, 07 May 2015 23:19:28 +0530
Message-ID: <554BA5A8.3040009@linux.vnet.ibm.com>
References: <20150507052600.20882.39542.stgit@preeti.in.ibm.com> <554B36DD.5080807@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <554B36DD.5080807@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "rlippert@google.com" <rlippert@google.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On 05/07/2015 03:26 PM, Sudeep Holla wrote:
> Hi Preeti,
> 
> On 07/05/15 06:26, Preeti U Murthy wrote:
>> When a CPU has to enter an idle state where tick stops, it makes a call
>> to tick_broadcast_enter(). The call will fail if this CPU is the
>> broadcast CPU. Today, under such a circumstance, the arch cpuidle code
>> handles this CPU.  This is not convincing because not only are we not
>> aware what the arch cpuidle code does, but we also do not account for
>> the idle state residency time and usage of such a CPU.
>>
>> This scenario can be handled better by simply asking the cpuidle
>> governor to choose an idle state where in ticks do not stop. To
>> accommodate this change move the setting of runqueue idle state from the
>> core to the cpuidle driver, else the rq->idle_state will be set wrong.
>>
>> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> ---
>> Based on linux-pm/bleeding-edge
> 
> I am unable to apply this patch cleanly on linux-pm/bleeding-edge
> I think it conflicts with few patches that Rafael posted recently
> which are in the branch now.

Thanks so much for pointing out this! I have resent the patch as V2
after the rebase on the updated linux-pm/bleeding-edge branch

Regards
Preeti U Murthy
> 
> Regards,
> Sudeep
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
