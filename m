From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/16] cpuidle: pseries: Convert to hotplug state machine
Date: Tue, 23 Aug 2016 16:16:12 +0200
Message-ID: <57BC5AAC.7070707@linaro.org>
References: <20160818125731.27256-1-bigeasy@linutronix.de>
 <20160818125731.27256-11-bigeasy@linutronix.de> <57BB23CB.2080908@linaro.org>
 <20160822190404.i56qlimrqkhozacn@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160822190404.i56qlimrqkhozacn@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, rt@linutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/22/2016 09:04 PM, Sebastian Andrzej Siewior wrote:
> On 2016-08-22 18:09:47 [+0200], Daniel Lezcano wrote:
>> On 08/18/2016 02:57 PM, Sebastian Andrzej Siewior wrote:
>>> Install the callbacks via the state machine.
>>>
>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>>> index 5811954809af..baecc4faf028 100644
>>> --- a/include/linux/cpuhotplug.h
>>> +++ b/include/linux/cpuhotplug.h
>>> @@ -19,6 +19,7 @@ enum cpuhp_state {
>>>  	CPUHP_MM_WRITEBACK_DEAD,
>>>  	CPUHP_SOFTIRQ_DEAD,
>>>  	CPUHP_NET_MVNETA_DEAD,
>>> +	CPUHP_CPUIDLE_PSERIES_DEAD,
>>
>> Can't we directly merge these into CPUHP_CPUIDLE_DEAD instead ? Or is it
>> planned to be done separately ?
> 
> You mean CPUHP_CPUIDLE_DEAD instead of _PSERIES_DEAD and _POWERNV_DEAD?

Yes. If we can limit the number of duplicating enum for the same purpose
right now, it would be nice.

> We could do that but you would have to ensure that only one CPUIDLE
> driver registers itself at a time and for those powerpc drivers it looks
> like you could have two registered (not sure about ARM's little/big (if
> you could have two of those later at run-time)).

At the first glance, I don't think it is possible to register the cpu
hotplug callback twice because the cpuidle drivers are doing:

...
        retval = cpuidle_register(&pseries_idle_driver, NULL);
        if (retval) {
                printk(KERN_DEBUG "Registration of pseries driver
failed.\n");
                return retval;
        }

        register_cpu_notifier(&setup_hotplug_notifier);

So if a previous driver was already registered, cpuidle_register will
fail and register_cpu_notifier won't be hit.

There is the same scenario for intel_idle and processor_idle (acpi).

> For the ONLINE state we have dynamic allocation of IDs. If it is
> possible to rework the code to use only ONLINE & PRE_DOWN instead of
> DEAD then we wouldn't have this. I can't say at this point if we do
> dynamic allocation of the DEAD IDs.
> 
> Sebastian
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
