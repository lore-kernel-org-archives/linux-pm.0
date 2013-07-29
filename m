From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: stable 3-10-3: strange output of "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 19:23:35 +0200
Message-ID: <51F6A517.8060502@gmx.de>
References: <51F40612.2050403@gmx.de> <51F638D9.7050904@linux.vnet.ibm.com> <CAOh2x=nQL+8DNaSFOnvq9eVMse8-gDvW1gPqFtu+CT52JsG15A@mail.gmail.com> <1462209.u176D8q1Fr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1462209.u176D8q1Fr@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/29/2013 01:54 PM, Rafael J. Wysocki wrote:
> On Monday, July 29, 2013 04:52:39 PM Viresh Kumar wrote:
>> On Mon, Jul 29, 2013 at 3:11 PM, Srivatsa S. Bhat
>> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
>>> I'm assuming that the module_get() is used in the cpufreq core to e=
nsure that
>>> until the cpufreq core is managing (atleast one) CPU(s), the cpufre=
q backend
>>> driver module (eg: acpi-cpufreq) can't be removed.
>>
>> I missed this simple stuff in my email.. :(
>>
>>> But the cpufreq_add_dev() function does a module *put* at the end o=
f
>>> initializing a fresh CPU.
>>>
>>> 1057         kobject_uevent(&policy->kobj, KOBJ_ADD);
>>> 1058         module_put(cpufreq_driver->owner);
>>> 1059         pr_debug("initialization complete\n");
>>> 1060
>>> 1061         return 0;
>>
>> That actually looks wrong. And shoud be fixed.
>=20
> OK
>=20
>>> So, I wonder if it would be a good idea to instead allow that CPU t=
o take a
>>> module refcount as well. That way, the problem that Toralf reported=
 would go
>>> away, and at the same time, we can ensure that as long as the cpufr=
eq core is
>>> managing CPUs, the cpufreq-backend-driver module refcount never dro=
ps to zero.
>>>
>>> Something like this:
>>>
>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>>> index a4ad733..ecfbc52 100644
>>> --- a/drivers/cpufreq/cpufreq.c
>>> +++ b/drivers/cpufreq/cpufreq.c
>>> @@ -878,9 +878,14 @@ static int cpufreq_add_dev_interface(unsigned =
int cpu,
>>>         }
>>>         write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>>>
>>> +       /* Bump up the refcount for this CPU */
>>> +       policy =3D cpufreq_cpu_get(cpu);
>>> +
>>>         ret =3D cpufreq_add_dev_symlink(cpu, policy);
>>> -       if (ret)
>>> +       if (ret) {
>>> +               cpufreq_cpu_put(policy);
>>>                 goto err_out_kobj_put;
>>> +       }
>>
>> That will do an extra kobject_get() which we don't require.. Only re=
moving what
>> I mentioned earlier should be good enough, I believe.
>>
>> Over that, I think below code in __cpufreq_governor() is also wrong.
>>
>> 	/* we keep one module reference alive for
>> 			each CPU governed by this CPU */
>> 	if ((event !=3D CPUFREQ_GOV_START) || ret)
>> 		module_put(policy->governor->owner);
>> 	if ((event =3D=3D CPUFREQ_GOV_STOP) && !ret)
>> 		module_put(policy->governor->owner);
>>
>> The second if is sensible as it puts count when governor is stopped.
>> But the first one decrements the count when we failed for anything
>> other than START..
>>
>> But this routine is called for other stuff too:
>> - INIT/Exit
>> - LIMITS,
>>
>> And so, count must be incremented for a passed INIT call and
>> decremented for a passed EXIT call, otherwise shouldn't be
>> touched.
>=20
> That sounds good, but I don't want to make those changes for 3.11 and=
 at the
> same time I *do* want the reference count issue to go away.
>=20
> So the patch below is the one I'd like to apply for the time being an=
d
> we can work on more improvements on top of that.
>=20
> Any objections?
>=20
> Toralf, please test this patch in the meantime.

works - tested on top of 3.10.4

> Rafael
>=20
>=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Fix cpufreq driver module refcount balance after su=
spend/resume
>=20
> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
> driver module refcount, __cpufreq_remove_dev() causes that refcount
> to become negative for the cpufreq driver after a suspend/resume
> cycle.
>=20
> This is not the only bad thing that happens there, however, because
> kobject_put() should only be called for the policy kobject at this
> point if the CPU is not the last one for that policy.
>=20
> Namely, if the given CPU is the last one for that policy, the
> policy kobject's refcount should be 1 at this point, as set by
> cpufreq_add_dev_interface(), and only needs to be dropped once for
> the kobject to go away.  This actually happens under the cpu =3D=3D 1
> check, so it need not be done before by cpufreq_cpu_put().
>=20
> On the other hand, if the given CPU is not the last one for that
> policy, this means that cpufreq_add_policy_cpu() has been called
> at least once for that policy and cpufreq_cpu_get() has been
> called for it too.  To balance that cpufreq_cpu_get(), we need to
> call cpufreq_cpu_put() in that case.
>=20
> Thus, to fix the described problem and keep the reference
> counters balanced in both cases, move the cpufreq_cpu_get() call
> in __cpufreq_remove_dev() to the code path executed only for
> CPUs that share the policy with other CPUs.
>=20
> Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1177,14 +1177,11 @@ static int __cpufreq_remove_dev(struct d
>  				__func__, cpu_dev->id, cpu);
>  	}
> =20
> -	if ((cpus =3D=3D 1) && (cpufreq_driver->target))
> -		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> -
> -	pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> -	cpufreq_cpu_put(data);
> -
>  	/* If cpu is last user of policy, free policy */
>  	if (cpus =3D=3D 1) {
> +		if (cpufreq_driver->target)
> +			__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> +
>  		lock_policy_rwsem_read(cpu);
>  		kobj =3D &data->kobj;
>  		cmp =3D &data->kobj_unregister;
> @@ -1205,9 +1202,13 @@ static int __cpufreq_remove_dev(struct d
>  		free_cpumask_var(data->related_cpus);
>  		free_cpumask_var(data->cpus);
>  		kfree(data);
> -	} else if (cpufreq_driver->target) {
> -		__cpufreq_governor(data, CPUFREQ_GOV_START);
> -		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> +	} else {
> +		pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> +		cpufreq_cpu_put(data);
> +		if (cpufreq_driver->target) {
> +			__cpufreq_governor(data, CPUFREQ_GOV_START);
> +			__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> +		}
>  	}
> =20
>  	per_cpu(cpufreq_policy_cpu, cpu) =3D -1;
>=20
>=20


--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
