From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH V2] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 10 Jul 2014 12:26:16 -0700
Message-ID: <53BEE8D8.6080103@codeaurora.org>
References: <1eff59d9b51f8ade67bc1cf9f10683f9463ec9f6.1404996041.git.viresh.kumar@linaro.org> <D51F586F-EA6C-4BAF-8CFC-8E7BB5719423@qti.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <D51F586F-EA6C-4BAF-8CFC-8E7BB5719423@qti.qualcomm.com>
Sender: stable-owner@vger.kernel.org
To: "Bu, Yitian" <ybu@qti.qualcomm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "arvind.chauhan@arm.com" <arvind.chauhan@arm.com>, "srivatsa@mit.edu" <srivatsa@mit.edu>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/10/2014 08:12 AM, Bu, Yitian wrote:
>=20
>=20
>> =D4=DA 2014=C4=EA7=D4=C210=C8=D5=A3=AC20:41=A3=AC"Viresh Kumar" <vir=
esh.kumar@linaro.org> =D0=B4=B5=C0=A3=BA
>>
>> This is only relevant to implementations with multiple clusters, whe=
re clusters
>> have separate clock lines but all CPUs within a cluster share it.
>>
>> Consider a dual cluster platform with 2 cores per cluster. During su=
spend we
>> start offlining CPUs from 1 to 3. When CPU2 is remove, policy->kobj =
would be
>> moved to CPU3 and when CPU3 goes down we wouldn't free policy or its=
 kobj.
>>
>> Now on resume, we will get CPU2 before CPU3 and will call __cpufreq_=
add_dev().
>> We will recover the old policy and update policy->cpu from 3 to 2 fr=
om
>> update_policy_cpu().
>>
>> But the kobj is still tied to CPU3 and wasn't moved to CPU2. We woul=
dn't create
>> a link for CPU2, but would try that while bringing CPU3 online. Whic=
h will
>> report errors as CPU3 already has kobj assigned to it.
>>
>> This bug got introduced with commit 42f921a, which overlooked this s=
cenario.
>>
>> To fix this, lets move kobj to the new policy->cpu while bringing fi=
rst CPU of a
>> cluster back. We already have update_policy_cpu() routine which can =
be updated
>> with this change. That would get rid of the cpufreq_nominate_new_pol=
icy_cpu() as
>> update_policy_cpu() is also called on CPU removal.
>>
>> To achieve that we add another parameter to update_policy_cpu() as c=
pu_dev is
>> present with both the callers.
>>
>> Fixes: ("42f921a cpufreq: remove sysfs files for CPUs which failed t=
o come back after resume")
>> Cc: Stable <stable@vger.kernel.org> # 3.13+
>> Reported-by: Bu Yitian <ybu@qti.qualcomm.com>
>> Reported-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> V1->V2: Move kobject_move() call to update_policy_cpu(), which makes
>> cpufreq_nominate_new_policy_cpu() almost empty. So we remove it comp=
letely.
>>
>> @Yitian: Sorry, but you need to test this again as there were enough
>> modifications in V2.
>>
>=20
> Sorry, I don't have latest kernel to test this patch...
> What I am using is 3.10, this patch seems too big to manually apply t=
o 3.10.

Even though our kernel is 3.10, I believe we have pulled in all cpufreq
up to 3.14. So, if you have time, you could pull in rest of the cpufreq
changes and test it out. For our tree, maybe the v1 patch would be
sufficient?

-Saravana
>=20
>=20
>> drivers/cpufreq/cpufreq.c | 73 +++++++++++++++++++++++--------------=
----------
>> 1 file changed, 36 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 62259d2..c81d9ec6 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1076,10 +1076,20 @@ static void cpufreq_policy_free(struct cpufr=
eq_policy *policy)
>>     kfree(policy);
>> }
>>
>> -static void update_policy_cpu(struct cpufreq_policy *policy, unsign=
ed int cpu)
>> +static int update_policy_cpu(struct cpufreq_policy *policy, unsigne=
d int cpu,
>> +                 struct device *cpu_dev)
>> {
>> +    int ret;
>> +
>>     if (WARN_ON(cpu =3D=3D policy->cpu))
>> -        return;
>> +        return 0;
>> +
>> +    /* Move kobject to the new policy->cpu */
>> +    ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>> +    if (ret) {
>> +        pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
>> +        return ret;
>> +    }
>>
>>     down_write(&policy->rwsem);
>>
>> @@ -1090,6 +1100,8 @@ static void update_policy_cpu(struct cpufreq_p=
olicy *policy, unsigned int cpu)
>>
>>     blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
>>             CPUFREQ_UPDATE_POLICY_CPU, policy);
>> +
>> +    return 0;
>> }
>>
>> static int __cpufreq_add_dev(struct device *dev, struct subsys_inter=
face *sif)
>> @@ -1154,7 +1166,7 @@ static int __cpufreq_add_dev(struct device *de=
v, struct subsys_interface *sif)
>>      * by invoking update_policy_cpu().
>>      */
>>     if (recover_policy && cpu !=3D policy->cpu)
>> -        update_policy_cpu(policy, cpu);
>> +        WARN_ON(update_policy_cpu(policy, cpu, dev));
>>     else
>>         policy->cpu =3D cpu;
>>
>> @@ -1307,38 +1319,11 @@ static int cpufreq_add_dev(struct device *de=
v, struct subsys_interface *sif)
>>     return __cpufreq_add_dev(dev, sif);
>> }
>>
>> -static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *p=
olicy,
>> -                       unsigned int old_cpu)
>> -{
>> -    struct device *cpu_dev;
>> -    int ret;
>> -
>> -    /* first sibling now owns the new sysfs dir */
>> -    cpu_dev =3D get_cpu_device(cpumask_any_but(policy->cpus, old_cp=
u));
>> -
>> -    sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>> -    ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>> -    if (ret) {
>> -        pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
>> -
>> -        down_write(&policy->rwsem);
>> -        cpumask_set_cpu(old_cpu, policy->cpus);
>> -        up_write(&policy->rwsem);
>> -
>> -        ret =3D sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
>> -                    "cpufreq");
>> -
>> -        return -EINVAL;
>> -    }
>> -
>> -    return cpu_dev->id;
>> -}
>> -
>> static int __cpufreq_remove_dev_prepare(struct device *dev,
>>                     struct subsys_interface *sif)
>> {
>>     unsigned int cpu =3D dev->id, cpus;
>> -    int new_cpu, ret;
>> +    int ret;
>>     unsigned long flags;
>>     struct cpufreq_policy *policy;
>>
>> @@ -1378,14 +1363,28 @@ static int __cpufreq_remove_dev_prepare(stru=
ct device *dev,
>>     if (cpu !=3D policy->cpu) {
>>         sysfs_remove_link(&dev->kobj, "cpufreq");
>>     } else if (cpus > 1) {
>> -        new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
>> -        if (new_cpu >=3D 0) {
>> -            update_policy_cpu(policy, new_cpu);
>> +        /* Nominate new CPU */
>> +        int new_cpu =3D cpumask_any_but(policy->cpus, cpu);
>> +        struct device *cpu_dev =3D get_cpu_device(new_cpu);
>>
>> -            if (!cpufreq_suspended)
>> -                pr_debug("%s: policy Kobject moved to cpu: %d from:=
 %d\n",
>> -                     __func__, new_cpu, cpu);
>> +        sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>> +        ret =3D update_policy_cpu(policy, new_cpu, cpu_dev);
>> +        if (ret) {
>> +            /*
>> +             * To supress compilation warning about return value of
>> +             * sysfs_create_link().
>> +             */
>> +            int temp;
>> +
>> +            /* Create link again if we failed. */
>> +            temp =3D sysfs_create_link(&cpu_dev->kobj, &policy->kob=
j,
>> +                         "cpufreq");
>> +            return ret;
>>         }
>> +
>> +        if (!cpufreq_suspended)
>> +            pr_debug("%s: policy Kobject moved to cpu: %d from: %d\=
n",
>> +                 __func__, new_cpu, cpu);
>>     } else if (cpufreq_driver->stop_cpu && cpufreq_driver->setpolicy=
) {
>>         cpufreq_driver->stop_cpu(policy);
>>     }
>> --=20
>> 2.0.0.rc2
>>


--=20
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
hosted by The Linux Foundation
