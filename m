From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle : use percpu cpuidle in the core code
Date: Sat, 31 Mar 2012 13:15:30 +0530
Message-ID: <4F76B61A.5020201@linux.vnet.ibm.com>
References: <1333104499-8627-1-git-send-email-daniel.lezcano@linaro.org>
	<4F759838.4060007@linux.vnet.ibm.com> <4F759CDE.9060108@linaro.org>
	<4F75A015.2010609@linux.vnet.ibm.com> <4F75DCBE.8000309@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F75DCBE.8000309@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org, patches@linaro.org
List-Id: linux-pm@vger.kernel.org

On 03/30/2012 09:48 PM, Daniel Lezcano wrote:

> On 03/30/2012 01:59 PM, Srivatsa S. Bhat wrote:
>> On 03/30/2012 05:15 PM, Daniel Lezcano wrote:
>>
>>> On 03/30/2012 01:25 PM, Srivatsa S. Bhat wrote:
>>>> On 03/30/2012 04:18 PM, Daniel Lezcano wrote:
>>>>
>>>>> The usual cpuidle initialization routines are to register the
>>>>> driver, then register a cpuidle device per cpu.
>>>>>
>>>>> With the device's state count default initialization with the
>>>>> driver's state count, the code initialization remains mostly the
>>>>> same in the different drivers.
>>>>>
>>>>> We can then add a new function 'cpuidle_register' where we register
>>>>> the driver and the devices. These devices can be defined in a global
>>>>> static variable in cpuidle.c. We will be able to factor out and
>>>>> remove a lot of duplicate lines of code.
>>>>>
>>>>> As we still have some drivers, with different initialization routines,
>>>>> we keep 'cpuidle_register_driver' and 'cpuidle_register_device' as low
>>>>> level initialization routines to do some specific operations on the
>>>>> cpuidle devices.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>>>> ---
>>>>>    drivers/cpuidle/cpuidle.c |   34 ++++++++++++++++++++++++++++++++++
>>>>>    include/linux/cpuidle.h   |    3 +++
>>>>>    2 files changed, 37 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>>>>> index b8a1faf..2a174e8 100644
>>>>> --- a/drivers/cpuidle/cpuidle.c
>>>>> +++ b/drivers/cpuidle/cpuidle.c
>>>>> @@ -23,6 +23,7 @@
>>>>>    #include "cpuidle.h"
>>>>>
>>>>>    DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>>>>> +DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
>>>>>
>>>>>    DEFINE_MUTEX(cpuidle_lock);
>>>>>    LIST_HEAD(cpuidle_detected_devices);
>>>>> @@ -391,6 +392,39 @@ int cpuidle_register_device(struct
>>>>> cpuidle_device *dev)
>>>>>
>>>>>    EXPORT_SYMBOL_GPL(cpuidle_register_device);
>>>>>
>>>>> +int cpuidle_register(struct cpuidle_driver *drv)
>>>>> +{
>>>>> +    int ret, cpu;
>>>>> +    struct cpuidle_device *dev;
>>>>> +
>>>>> +    ret = cpuidle_register_driver(drv);
>>>>> +    if (ret)
>>>>> +        return ret;
>>>>> +
>>>>> +    for_each_online_cpu(cpu) {
>>>>> +        dev =&per_cpu(cpuidle_device, cpu);
>>>>> +        dev->cpu = cpu;
>>>>> +
>>>>> +        ret = cpuidle_register_device(dev);
>>>>> +        if (ret)
>>>>> +            goto out_unregister;
>>>>> +    }
>>>>> +
>>>>
>>>>
>>>> Isn't this racy with respect to CPU hotplug?
>>>
>>> No, I don't think so. Do you see a race ?
>>
>>
>> Well, that depends on when/where this function gets called.
>> This patch introduces the function. Where is the caller?
> 
> There is no caller for the moment because they are in the different arch
> specific code in the different trees.
> 
> But the callers will be in the init calls at boot up.
> 
>> As of now, if you are calling this in boot-up code, its not racy.
> 
> Most of the caller are in the boot-up code, in device_init or
> module_init. The other ones are doing some specific initialization on
> the cpuidle_device (cpuinit, like acpi) and can't use the
> cpuidle_register function.
> 
>> However, there have been attempts to speed up boot times by trying
>> to online cpus in parallel with the rest of the kernel initialization[1].
>> In that case, unless your call is an early init call, it can race
>> with CPU hotplug.
>>
>> [1]. https://lkml.org/lkml/2012/1/30/647
> 
> Aha ! Now I understand the race you were talking about. Thanks for the
> pointer. It is very interesting.
> 
> I realize if the cpus boot up in parallel, that will break a lot of
> things and, for my concern, that will break most of the cpuidle drivers.
> 


Exactly!

> So far the cpu bootup parallelization is not there, so from my POV, my
> patch is correct as we will factor out in a single place some code which
> will be potentially broken by this parallelization in the future. It
> will be easier to fix that in a single place rather in multiple drivers.
> 
> Thanks for spotting this potential problem. This is something I will
> keep in mind for the future.
>


Sure, that would be great! 

>>>>> +out:
>>>>> +    return ret;
>>>>> +
>>>>> +out_unregister:
>>>>> +    for_each_online_cpu(cpu) {
>>>>> +        dev =&per_cpu(cpuidle_device, cpu);
>>>>> +        cpuidle_unregister_device(dev);
>>>>> +    }
>>>>> +
>>>>
>>>>
>>>> This could be improved I guess.. What if the registration fails
>>>> for the first cpu itself? Then looping over entire online cpumask
>>>> would be a waste of time..
>>>
>>> Certainly in a critical section that would make sense, but for 4,8 or 16
>>> cpus in an initialization path at boot time... Anyway, I can add what is
>>> proposed in https://lkml.org/lkml/2012/3/22/143.
>>>
>>
>>
>> What about servers with a lot more CPUs, like say 128 or even more? :-)
>>
>> Moreover I don't see any downsides to the optimization. So should be good
>> to add it in any case...
> 
> Yes, no problem. I will add it.
> 


Thanks!

Regards,
Srivatsa S. Bhat
IBM Linux Technology Center
