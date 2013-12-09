From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Mon, 9 Dec 2013 10:59:50 +0800
Message-ID: <CAOLK0pxW_AjtGNwW2G8-1SpJbYs_GWQDLV=7XzPfDHRj6tCxQQ@mail.gmail.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org>
	<2628468.jr1aJZyvPu@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41184 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760477Ab3LIDFe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 8 Dec 2013 22:05:34 -0500
In-Reply-To: <2628468.jr1aJZyvPu@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ziegler@uni-freiburg.de
Cc: viresh kumar <viresh.kumar@linaro.org>, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

2013/12/5 Rafael J. Wysocki <rjw@rjwysocki.net>:
> On Wednesday, December 04, 2013 04:02:18 PM viresh kumar wrote:
>> On Tuesday 03 December 2013 04:44 PM, Bj=F8rn Mork wrote:
>> > This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Per=
form
>> > light-weight init/teardown during suspend/resume"), which enabled
>> > suspend/resume optimizations leaving the sysfs files in place.
>> >
>> > Errors during suspend/resume are not handled properly, leaving
>> > dead sysfs attributes in case of failures.  There are are number o=
f
>> > functions with special code for the "frozen" case, and all these
>> > need to also have special error handling.
>>
>> Can you try this please if it fixes things for you (with your patch =
reverted):
>>
>> From: Viresh Kumar <viresh.kumar@linaro.org>
>> Date: Wed, 4 Dec 2013 15:20:12 +0530
>> Subject: [PATCH] cpufreq: remove sysfs files for CPU which failed to=
 come
>>  back after resume
>>
>> There are cases where cpufreq_add_dev() may fail for some CPUs durin=
g resume.
>> With the current code we will still have sysfs cpufreq files for suc=
h CPUs, and
>> struct cpufreq_policy would be already freed for them. Hence any ope=
ration on
>> those sysfs files would result in kernel warnings.
>>
>> To fix this, lets remove those sysfs files or put the associated kob=
ject in case
>> of such errors. Also, to make it simple lets remove the sysfs links =
from all the
>> CPUs (except policy->cpu) during suspend as that operation wouldn't =
result with a
>> loss of sysfs file permissions. And so we will create those links du=
ring resume
>> as well.
>>
>> Reported-by: Bj=F8rn Mork <bjorn@mork.no>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> There's no way this can go into 3.13, even though it fixes the proble=
m for
> Bjorn.
>
> I took the Bjorn's patch for 3.13 and this one I can queued up for 3.=
14,
> but for that I guess it should contain a revert of the change made by=
 the
> Bjorn's patch.

This patch causes a s3 regression. Cc:Martin Ziegler
https://bugzilla.kernel.org/show_bug.cgi?id=3D66751

>
> Thanks!
>
>> ---
>>  drivers/cpufreq/cpufreq.c | 61 ++++++++++++++++++++++++------------=
-----------
>>  1 file changed, 31 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 606224a..57c80a7 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -849,8 +849,7 @@ static void cpufreq_init_policy(struct cpufreq_p=
olicy *policy)
>>
>>  #ifdef CONFIG_HOTPLUG_CPU
>>  static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy,
>> -                               unsigned int cpu, struct device *dev=
,
>> -                               bool frozen)
>> +                               unsigned int cpu, struct device *dev=
)
>>  {
>>       int ret =3D 0;
>>       unsigned long flags;
>> @@ -881,9 +880,7 @@ static int cpufreq_add_policy_cpu(struct cpufreq=
_policy *policy,
>>               }
>>       }
>>
>> -     /* Don't touch sysfs links during light-weight init */
>> -     if (!frozen)
>> -             ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "=
cpufreq");
>> +     ret =3D sysfs_create_link(&dev->kobj, &policy->kobj, "cpufreq"=
);
>>
>>       return ret;
>>  }
>> @@ -930,6 +927,27 @@ err_free_policy:
>>       return NULL;
>>  }
>>
>> +static void cpufreq_policy_put_kobj(struct cpufreq_policy *policy)
>> +{
>> +     struct kobject *kobj;
>> +     struct completion *cmp;
>> +
>> +     down_read(&policy->rwsem);
>> +     kobj =3D &policy->kobj;
>> +     cmp =3D &policy->kobj_unregister;
>> +     up_read(&policy->rwsem);
>> +     kobject_put(kobj);
>> +
>> +     /*
>> +      * We need to make sure that the underlying kobj is
>> +      * actually not referenced anymore by anybody before we
>> +      * proceed with unloading.
>> +      */
>> +     pr_debug("waiting for dropping of refcount\n");
>> +     wait_for_completion(cmp);
>> +     pr_debug("wait complete\n");
>> +}
>> +
>>  static void cpufreq_policy_free(struct cpufreq_policy *policy)
>>  {
>>       free_cpumask_var(policy->related_cpus);
>> @@ -990,7 +1008,7 @@ static int __cpufreq_add_dev(struct device *dev=
, struct subsys_interface *sif,
>>       list_for_each_entry(tpolicy, &cpufreq_policy_list, policy_list=
) {
>>               if (cpumask_test_cpu(cpu, tpolicy->related_cpus)) {
>>                       read_unlock_irqrestore(&cpufreq_driver_lock, f=
lags);
>> -                     ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, d=
ev, frozen);
>> +                     ret =3D cpufreq_add_policy_cpu(tpolicy, cpu, d=
ev);
>>                       up_read(&cpufreq_rwsem);
>>                       return ret;
>>               }
>> @@ -1100,7 +1118,10 @@ err_get_freq:
>>       if (cpufreq_driver->exit)
>>               cpufreq_driver->exit(policy);
>>  err_set_policy_cpu:
>> +     if (frozen)
>> +             cpufreq_policy_put_kobj(policy);
>>       cpufreq_policy_free(policy);
>> +
>>  nomem_out:
>>       up_read(&cpufreq_rwsem);
>>
>> @@ -1122,7 +1143,7 @@ static int cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif)
>>  }
>>
>>  static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *p=
olicy,
>> -                                        unsigned int old_cpu, bool =
frozen)
>> +                                        unsigned int old_cpu)
>>  {
>>       struct device *cpu_dev;
>>       int ret;
>> @@ -1130,10 +1151,6 @@ static int cpufreq_nominate_new_policy_cpu(st=
ruct cpufreq_policy *policy,
>>       /* first sibling now owns the new sysfs dir */
>>       cpu_dev =3D get_cpu_device(cpumask_any_but(policy->cpus, old_c=
pu));
>>
>> -     /* Don't touch sysfs files during light-weight tear-down */
>> -     if (frozen)
>> -             return cpu_dev->id;
>> -
>>       sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>>       ret =3D kobject_move(&policy->kobj, &cpu_dev->kobj);
>>       if (ret) {
>> @@ -1200,7 +1217,7 @@ static int __cpufreq_remove_dev_prepare(struct=
 device *dev,
>>               if (!frozen)
>>                       sysfs_remove_link(&dev->kobj, "cpufreq");
>>       } else if (cpus > 1) {
>> -             new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cp=
u, frozen);
>> +             new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cp=
u);
>>               if (new_cpu >=3D 0) {
>>                       update_policy_cpu(policy, new_cpu);
>>
>> @@ -1222,8 +1239,6 @@ static int __cpufreq_remove_dev_finish(struct =
device *dev,
>>       int ret;
>>       unsigned long flags;
>>       struct cpufreq_policy *policy;
>> -     struct kobject *kobj;
>> -     struct completion *cmp;
>>
>>       read_lock_irqsave(&cpufreq_driver_lock, flags);
>>       policy =3D per_cpu(cpufreq_cpu_data, cpu);
>> @@ -1253,22 +1268,8 @@ static int __cpufreq_remove_dev_finish(struct=
 device *dev,
>>                       }
>>               }
>>
>> -             if (!frozen) {
>> -                     down_read(&policy->rwsem);
>> -                     kobj =3D &policy->kobj;
>> -                     cmp =3D &policy->kobj_unregister;
>> -                     up_read(&policy->rwsem);
>> -                     kobject_put(kobj);
>> -
>> -                     /*
>> -                      * We need to make sure that the underlying ko=
bj is
>> -                      * actually not referenced anymore by anybody =
before we
>> -                      * proceed with unloading.
>> -                      */
>> -                     pr_debug("waiting for dropping of refcount\n")=
;
>> -                     wait_for_completion(cmp);
>> -                     pr_debug("wait complete\n");
>> -             }
>> +             if (!frozen)
>> +                     cpufreq_policy_put_kobj(policy);
>>
>>               /*
>>                * Perform the ->exit() even during light-weight tear-=
down,
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe cpufreq" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Best regards
Tianyu Lan
