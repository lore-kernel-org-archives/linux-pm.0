From: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
Subject: Re: Need help understanding the logic of __cpuidle_set_driver
Date: Sat, 16 Aug 2014 12:13:05 +0600
Message-ID: <CAHu9=sMqLQ0wVtAoj3KFVN+bwBJED1zHR-aaynYxkr7Bj85MMw@mail.gmail.com>
References: <CAHu9=sOwSuw5igPp0UQWJe8fwMb_vt3PPrc1A9nK4pJB5QmXDA@mail.gmail.com>
	<CAGAs2AkFvnegYmqhj7Bue50xAD1Yh3YoTbVGUviQ0jsPncxdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAGAs2AkFvnegYmqhj7Bue50xAD1Yh3YoTbVGUviQ0jsPncxdXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <http://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: AYAN KUMAR HALDER <ayankumarh@gmail.com>
Cc: linux-pm@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-pm@vger.kernel.org

Thanks Ayan.

My answers are inline below -


On Fri, Aug 15, 2014 at 6:41 PM, AYAN KUMAR HALDER <ayankumarh@gmail.com> wrote:
> On Fri, Aug 15, 2014 at 3:50 PM, Mohammad Merajul Islam Molla
> <meraj.enigma@gmail.com> wrote:
>> Hello,
>>
>> I was looking into the code of drivers/cpuidle/driver.c. I have some
>> doubts regarding the implementation of __cpuidle_set_driver function
>> when CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined.
>>
>> If CONFIG_CPU_IDLE_MULTIPLE_DRIVERS is defined, the code for
>> __cpuidle_set_driver/__cpuidle_unset_driver looks as -
>>
>>  39  * __cpuidle_unset_driver - unset per CPU driver variables.
>>  40  * @drv: a valid pointer to a struct cpuidle_driver
>>  41  *
>>  42  * For each CPU in the driver's CPU mask, unset the registered
>> driver per CPU
>>  43  * variable. If @drv is different from the registered driver, the
>> corresponding
>>  44  * variable is not cleared.
>>  45  */
>>  46 static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
>>  47 {
>>  48         int cpu;
>>  49
>>  50         for_each_cpu(cpu, drv->cpumask) {
>>  51
>>  52                 if (drv != __cpuidle_get_cpu_driver(cpu))
>>  53                         continue;
>>  54
>>  55                 per_cpu(cpuidle_drivers, cpu) = NULL;
>>  56         }
>>  57 }
>>  58
>>  59 /**
>>  60  * __cpuidle_set_driver - set per CPU driver variables for the given driver.
>>  61  * @drv: a valid pointer to a struct cpuidle_driver
>>  62  *
>>  63  * For each CPU in the driver's cpumask, unset the registered driver per CPU
>>  64  * to @drv.
>>  65  *
>>  66  * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
>>  67  */
>>  68 static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>>  69 {
>>  70         int cpu;
>>  71
>>  72         for_each_cpu(cpu, drv->cpumask) {
>>  73
>>  74                 if (__cpuidle_get_cpu_driver(cpu)) {
>>  75                         __cpuidle_unset_driver(drv);
>>  76                         return -EBUSY;
>>  77                 }
>>  78
>>  79                 per_cpu(cpuidle_drivers, cpu) = drv;
>>  80         }
>>  81
>>  82         return 0;
>>  83 }
>>
>> Apparently, the comment should be - "set/register the driver per CPU
>> to @drv" instead of "unset the registered driver per CPU to @drv" in
>> case of __cpuidle_set_driver.
>
> I would like to slightly differ here. As per my understanding, the
> comments given
> for the function is correct. The function __cpuidle_set_driver(drv)
> would do the following:-
>
> 1. If the cpu has any registered idle driver which is same as @drv,
> the registered
> driver would be unset. ie "unset the registered driver per CPU to @drv"
> 2. If the cpu has any registered idle driver which is different from
> @drv, do nothing
> 3. If the cpu has no registered idle driver, set the idle driver to @drv
>
>> However, regarding the logic, I have a few doubts -
>>
>> 1. for each cpu in drv->cpumask, if there is already a driver
>> registered, its calling __cpuidle_unset_driver which loops over for
>> each cpu in drv->cpumask again. Isn't it unnecessary to do this nested
>> calls?
>
> __cpuidle_unset_driver :- This function gets called from
> "__cpuidle_unregister_driver()" too.
> So it needs to loop over each cpu to see if its registered driver is
> same as @drv. What

Yes, to unset the driver __cpuidle_unregister_driver calls
__cpuidle_unset_driver(),
which has to loop over the cpus. But __cpuidle_set_driver() can be
implemented itself and therefore,
I don't see any point doing the loop twice.

> you might be trying to convey here is that instead of calling
> __cpuidle_unset_driver, we could
> have done the following:-
> static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
> {
>         int cpu;
>         struct cpuidle_driver *tmp = NULL;
>         for_each_cpu(cpu, drv->cpumask) {
>
>                 tmp = __cpuidle_get_cpu_driver(cpu); /* This would
> prevent nesting of loops */
>                 if ( tmp != NULL ) {
>                         if ( tmp == drv )
>                               per_cpu(cpuidle_drivers, cpu) = NULL;
>                         return -EBUSY;
>                 }
>
>                 per_cpu(cpuidle_drivers, cpu) = drv;
>         }
>
>         return 0;
> }
>
>
>
>> 2. after calling __cpuidle_unset_driver, if drv equals already
>> registered driver, it sets per_cpu driver to null? Isn't it wrong when
>> we are trying to set to a new driver? Why do we need to unset and make
>> the driver null when we are returning EBUSY from __cpuidle_set_driver?
>
> My understanding is that if there is a previously registered cpuidle
> driver, returning
> EBUSY is fine. But I do share the same doubt as you have that if the previous
> registered cpuidle driver is same as the new one, then why should it
> be unset and NULLed.


Right, I don't understand this either.


>
>> Would it be correct and cleaner if the code is written as below -
>>
>>  static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
>>  {
>>          int ret = -EBUSY;
>>          int cpu;
>>
>>         for_each_cpu(cpu, drv->cpumask) {
>>                 if (drv == __cpuidle_get_cpu_driver(cpu))    [if drv
>> is already the registered driver, do nothing]
>>                          continue;
>>
>>                  per_cpu(cpuidle_drivers, cpu) = drv;  [if only drv !=
>> already registered driver, set per_cpu driver to drv and set ret 0]
>>                  ret = 0;
>>          }
>>
>>          return ret;     [only if all cpus already had drv as
>> registered driver, return -EBUSY. Otherwise return 0]
>>  }
>>
> The difference that might cause some trouble is that the timer
> broadcast notification is
> not sent while changing the cpuide drivers.
>
> Regards,
> Ayan Kumar Halder


Anyone else looking at this? Please clarify.



Thanks,
-Meraj
