From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: stable 3-10-3: strange output of  "lsmod | grep ^acpi_cpufreq"
Date: Mon, 29 Jul 2013 15:11:45 +0530
Message-ID: <51F638D9.7050904@linux.vnet.ibm.com>
References: <51F40612.2050403@gmx.de> <2111514.pxW5saG1J3@vostro.rjw.lan> <18359786.D7glpto546@vostro.rjw.lan> <2368277.VjYrsHUseA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <2368277.VjYrsHUseA@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/29/2013 04:50 AM, Rafael J. Wysocki wrote:
> On Monday, July 29, 2013 12:43:59 AM Rafael J. Wysocki wrote:
>> On Monday, July 29, 2013 12:11:18 AM Rafael J. Wysocki wrote:
>>> On Sunday, July 28, 2013 12:21:22 PM Toralf F=C3=B6rster wrote:
>>>> On 07/28/2013 01:39 AM, Rafael J. Wysocki wrote:
>>>>> On Saturday, July 27, 2013 07:40:34 PM Toralf F=C3=B6rster wrote:
>>>>>> it gives at a ThinkPad T420:
>>>>>>
>>>>>> tfoerste@n22 ~/tmp $ lsmod | grep ^acpi_cpufreq
>>>>>> acpi_cpufreq           12902  2147483647
>>>>>
>>>>> That is -1, which indicates some module refcount woes.
>>>>
>>>> yes, ofc.
>>>>
>>>> The issue apears after 1 s2ram/resume cycle, before s2ram the refc=
ount is 1.
>>>>
>>>>> I definitely can't see that with the mainline on my machines.
>>>>
>>>> It is in mainline too.
>>>
>>> Does the appended patch help?
>>
>> Actually, something as simple as this also should help:
>>
>> ---
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Subject: cpufreq: Fix cpufreq driver module refcount balance after s=
uspend/resume
>>
>> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
>> driver module refcount, __cpufreq_remove_dev() causes that refcount
>> to become negative after a suspend/resume cycle, for example.
>>
>> To prevent this from happening make __cpufreq_remove_dev() put
>> the policy kobject only instead of calling cpufreq_cpu_put().
>=20
> Having a deeper look at it, though, I see that in fact the whole
> cpufreq_cpu_put() is needed if the CPU is not the last one for the gi=
ven
> policy and is not needed at all otherwise (as described in the change=
log
> of the patch below).
>=20
> Srivatsa, does this make sense to you?
>

Code-wise, your patch looks good to me. But one thing in the existing c=
ode
struck me as a little strange.

I'm assuming that the module_get() is used in the cpufreq core to ensur=
e that
until the cpufreq core is managing (atleast one) CPU(s), the cpufreq ba=
ckend
driver module (eg: acpi-cpufreq) can't be removed.

But the cpufreq_add_dev() function does a module *put* at the end of
initializing a fresh CPU.

1057         kobject_uevent(&policy->kobj, KOBJ_ADD);
1058         module_put(cpufreq_driver->owner);
1059         pr_debug("initialization complete\n");
1060=20
1061         return 0;

So at that point, the module refcount of the cpufreq backend driver wil=
l become
zero, since we dropped it. Perhaps that was not the original intention.

Looking further (with respect to the problem we are discussing), the ro=
ot-cause
is that a fresh CPU never does a cpufreq_cpu_get() for itself, but does=
 it only
for the other CPUs in its policy->cpus mask.

=46rom cpufreq_add_dev_symlink():

 814         for_each_cpu(j, policy->cpus) {
 815                 struct cpufreq_policy *managed_policy;
 816                 struct device *cpu_dev;
 817=20
 818                 if (j =3D=3D cpu)
 819                         continue;
 820=20
 821                 pr_debug("CPU %u already managed, adding link\n", =
j);
 822                 managed_policy =3D cpufreq_cpu_get(cpu);
 823                 cpu_dev =3D get_cpu_device(j);

So, that 'continue' statement skips bumping the refcount on behalf of t=
he master
CPU.

So, I wonder if it would be a good idea to instead allow that CPU to ta=
ke a
module refcount as well. That way, the problem that Toralf reported wou=
ld go
away, and at the same time, we can ensure that as long as the cpufreq c=
ore is
managing CPUs, the cpufreq-backend-driver module refcount never drops t=
o zero.

Something like this:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a4ad733..ecfbc52 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -878,9 +878,14 @@ static int cpufreq_add_dev_interface(unsigned int =
cpu,
 	}
 	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
=20
+	/* Bump up the refcount for this CPU */
+	policy =3D cpufreq_cpu_get(cpu);
+
 	ret =3D cpufreq_add_dev_symlink(cpu, policy);
-	if (ret)
+	if (ret) {
+		cpufreq_cpu_put(policy);
 		goto err_out_kobj_put;
+	}
=20
 	memcpy(&new_policy, policy, sizeof(struct cpufreq_policy));
 	/* assure that the starting sequence is run in __cpufreq_set_policy *=
/

Thoughts?

Regards,
Srivatsa S. Bhat
=20
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: cpufreq: Fix cpufreq driver module refcount balance after su=
spend/resume
>=20
> Since cpufreq_cpu_put() called by __cpufreq_remove_dev() drops the
> driver module refcount, __cpufreq_remove_dev() causes that refcount
> to become negative for the acpi-cpufreq driver after a suspend/resume
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
> call pufreq_cpu_put() in that case.
>=20
> Thus, to fix the described problem and keep the reference
> counters balanced in both cases, move the cpufreq_cpu_get() call
> in __cpufreq_remove_dev() to the code path executed only for
> CPUs that share the policy with other CPUs.
>=20
> Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -1181,7 +1181,6 @@ static int __cpufreq_remove_dev(struct d
>  		__cpufreq_governor(data, CPUFREQ_GOV_POLICY_EXIT);
> =20
>  	pr_debug("%s: removing link, cpu: %d\n", __func__, cpu);
> -	cpufreq_cpu_put(data);
> =20
>  	/* If cpu is last user of policy, free policy */
>  	if (cpus =3D=3D 1) {
> @@ -1205,9 +1204,12 @@ static int __cpufreq_remove_dev(struct d
>  		free_cpumask_var(data->related_cpus);
>  		free_cpumask_var(data->cpus);
>  		kfree(data);
> -	} else if (cpufreq_driver->target) {
> -		__cpufreq_governor(data, CPUFREQ_GOV_START);
> -		__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> +	} else {
> +		cpufreq_cpu_put(data);
> +		if (cpufreq_driver->target) {
> +			__cpufreq_governor(data, CPUFREQ_GOV_START);
> +			__cpufreq_governor(data, CPUFREQ_GOV_LIMITS);
> +		}
>  	}
> =20
>  	per_cpu(cpufreq_policy_cpu, cpu) =3D -1;
>=20

