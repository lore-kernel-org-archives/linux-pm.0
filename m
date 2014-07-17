From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] cpufreq: move policy kobj to policy->cpu at resume
Date: Thu, 17 Jul 2014 05:51:55 +0530
Message-ID: <CAKohpo=Wx-wr0RT6GWoxcmuFyrTr+jKUN2q2bmqda7vMsL5ETg@mail.gmail.com>
References: <1eff59d9b51f8ade67bc1cf9f10683f9463ec9f6.1404996041.git.viresh.kumar@linaro.org>
	<9320264.Zgy80Rpl1d@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9320264.Zgy80Rpl1d@vostro.rjw.lan>
Sender: stable-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Saravana Kannan <skannan@codeaurora.org>, "Bu, Yitian" <ybu@qti.qualcomm.com>, Stable <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 17 July 2014 04:48, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> +static int update_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu,
>> +                          struct device *cpu_dev)
>>  {
>> +     int ret;
>> +
>>       if (WARN_ON(cpu == policy->cpu))
>> -             return;
>> +             return 0;
>> +
>> +     /* Move kobject to the new policy->cpu */
>> +     ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
>> +     if (ret) {
>> +             pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
>> +             return ret;
>
> Previously, we returned -EINVAL in the kobject_move() failure case.  Why are
> we changing that now?

We should have preserved return value of kobject_move() earlier in
cpufreq_nominate_new_policy_cpu() and sent that, but we returned
-EINVAL. And I realized that its more appropriate to return the error
returned by kobject_move().

>>  static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>> @@ -1154,7 +1166,7 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>        * by invoking update_policy_cpu().
>>        */
>>       if (recover_policy && cpu != policy->cpu)
>> -             update_policy_cpu(policy, cpu);
>> +             WARN_ON(update_policy_cpu(policy, cpu, dev));
>
> This is an arbitrary difference in the handling of update_policy_cpu() return
> value.  Why do we want the WARN_ON() here and not in the other place?

We really can't recover in this case. We have reached here after a suspend/
resume, and probing first cpu of a non-boot cluster. And we *have* to make
it policy-master.

But in the other case, we are removing a CPU in PREPARE stage and so
we can actually fail from there and let everybody know. Though I am not
aware of anycase in which kobject_move() can fail there.

> Don't we want to recover from kobject_move() failures here as well?

In the other case, we have just removed the link from the new policy->cpu
and so we try to recover for that in failures, but don't have something
similar here.

>>       else
>>               policy->cpu = cpu;
>>
>> @@ -1307,38 +1319,11 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
>>       return __cpufreq_add_dev(dev, sif);
>>  }
>>
>> -static int cpufreq_nominate_new_policy_cpu(struct cpufreq_policy *policy,
>> -                                        unsigned int old_cpu)
>> -{
>> -     struct device *cpu_dev;
>> -     int ret;
>> -
>> -     /* first sibling now owns the new sysfs dir */
>> -     cpu_dev = get_cpu_device(cpumask_any_but(policy->cpus, old_cpu));
>> -
>> -     sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>> -     ret = kobject_move(&policy->kobj, &cpu_dev->kobj);
>> -     if (ret) {
>> -             pr_err("%s: Failed to move kobj: %d\n", __func__, ret);
>> -
>> -             down_write(&policy->rwsem);
>> -             cpumask_set_cpu(old_cpu, policy->cpus);
>> -             up_write(&policy->rwsem);
>
> Why don't we need the above three lines in the new code?

It was probably meaningful when this was added initially, but later
some commit moved the cpumask_clear_cpu() to
__cpufreq_remove_dev_finish(). And so we don't really need to
set the cpu to policy->cpus again, as it was never cleared by this
stage..

>> -
>> -             ret = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
>> -                                     "cpufreq");
>> -
>> -             return -EINVAL;
>> -     }
>> -
>> -     return cpu_dev->id;
>> -}
>> -
>>  static int __cpufreq_remove_dev_prepare(struct device *dev,
>>                                       struct subsys_interface *sif)
>>  {
>>       unsigned int cpu = dev->id, cpus;
>> -     int new_cpu, ret;
>> +     int ret;
>>       unsigned long flags;
>>       struct cpufreq_policy *policy;
>>
>> @@ -1378,14 +1363,28 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>>       if (cpu != policy->cpu) {
>>               sysfs_remove_link(&dev->kobj, "cpufreq");
>>       } else if (cpus > 1) {
>> -             new_cpu = cpufreq_nominate_new_policy_cpu(policy, cpu);
>> -             if (new_cpu >= 0) {
>> -                     update_policy_cpu(policy, new_cpu);
>> +             /* Nominate new CPU */
>> +             int new_cpu = cpumask_any_but(policy->cpus, cpu);
>> +             struct device *cpu_dev = get_cpu_device(new_cpu);
>>
>> -                     if (!cpufreq_suspended)
>> -                             pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
>> -                                      __func__, new_cpu, cpu);
>> +             sysfs_remove_link(&cpu_dev->kobj, "cpufreq");
>> +             ret = update_policy_cpu(policy, new_cpu, cpu_dev);
>> +             if (ret) {
>> +                     /*
>> +                      * To supress compilation warning about return value of
>> +                      * sysfs_create_link().
>> +                      */
>> +                     int temp;
>> +
>> +                     /* Create link again if we failed. */
>> +                     temp = sysfs_create_link(&cpu_dev->kobj, &policy->kobj,
>> +                                              "cpufreq");
>
> And this is *ugly*.

Absolutely, Let me know what can we do to work around this.
It was like this earlier as well, just that I added a descriptive
comment this time.

--
viresh
