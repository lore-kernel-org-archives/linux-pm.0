From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: [PATCH v5] cpufreq: split the cpufreq_driver_lock and use the
 rcu (was cpufreq: cpufreq_driver_lock is hot on large systems)
Date: Mon, 1 Apr 2013 12:17:59 -0500
Message-ID: <5159C147.70800@sgi.com>
References: <5140E6A1.20107@sgi.com> <1364830382-1271-1-git-send-email-nzimmer@sgi.com> <CAKohpokv46CZEqGPx7AeJagyVx87L1RKhA9O2Ef=qAm24WUqtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokv46CZEqGPx7AeJagyVx87L1RKhA9O2Ef=qAm24WUqtw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/01/2013 11:28 AM, Viresh Kumar wrote:
> Hi Nathan,
>
> Welcome back :)
>
> On 1 April 2013 21:03, Nathan Zimmer <nzimmer@sgi.com> wrote:
>
> You need to resent this patch as we don't want current mail subject as commit
> subject.. You could have used the area after three dashes "-" inside the
> commit for logs which you don't want to commit.
Ok.
>> The cpufreq_driver_lock is hot with some configs.
>> This lock covers both cpufreq_driver and cpufreq_cpu_data so part one of the
> s/ so/, so/
>
>> proposed fix is to split up the lock abit.
> s/abit/a bit/
>
> What's the other part?
>
>> cpufreq_cpu_data is now covered by the cpufreq_data_lock.
>> cpufreq_driver is now covered by the cpufreq_driver lock and the rcu.
>>
>> This means that the cpufreq_driver_lock is no longer hot.
>> There remains some measurable heat on the cpufreq_data_lock it is significantly
> s/it/but it/

>> less then previous measured though.
>>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
>> Signed-off-by: Nathan Zimmer <nzimmer@sgi.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 305 +++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 222 insertions(+), 83 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> @@ -329,11 +339,23 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>>                                  struct cpufreq_governor **governor)
>>   {
>>          int err = -EINVAL;
>> -
>> -       if (!cpufreq_driver)
>> +       struct cpufreq_driver *driver;
>> +       int (*setpolicy)(struct cpufreq_policy *policy);
>> +       int (*target)(struct cpufreq_policy *policy,
>> +                     unsigned int target_freq,
>> +                     unsigned int relation);
> You can keep bools here instead of complex function pointers.
> setpolicy_supported and target_supported
Good point.  In a few places I needed the function pointer but not here.
I'll convert the unneeded ones to bools and resend.

>> +       rcu_read_lock();
>> +       driver = rcu_dereference(cpufreq_driver);
>> +       if (!driver) {
>> +               rcu_read_unlock();
>>                  goto out;
>> +       }
>> +       setpolicy = driver->setpolicy;
>> +       target = driver->target;
>> +       rcu_read_unlock();
>>
>> -       if (cpufreq_driver->setpolicy) {
>> +       if (setpolicy) {
>>                  if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
>>                          *policy = CPUFREQ_POLICY_PERFORMANCE;
>>                          err = 0;
>> @@ -342,7 +364,7 @@ static int cpufreq_parse_governor(char *str_governor, unsigned int *policy,
>>                          *policy = CPUFREQ_POLICY_POWERSAVE;
>>                          err = 0;
>>                  }
>> -       } else if (cpufreq_driver->target) {
>> +       } else if (target) {
>>                  struct cpufreq_governor *t;
>>
>>                  mutex_lock(&cpufreq_governor_mutex);
>> @@ -731,6 +766,8 @@ static int cpufreq_add_dev_interface(unsigned int cpu,
>>   {
>>          struct cpufreq_policy new_policy;
>>          struct freq_attr **drv_attr;
>> +       struct cpufreq_driver *driver;
>> +       int (*exit)(struct cpufreq_policy *policy);
> Declare it in the block which used it.
>
>>          if (ret) {
>>                  pr_debug("setting policy failed\n");
>> -               if (cpufreq_driver->exit)
>> -                       cpufreq_driver->exit(policy);
>> +               rcu_read_lock();
>> +               exit = rcu_dereference(cpufreq_driver)->exit;
>> +               if (exit)
>> +                       exit(policy);
>> +               rcu_read_unlock();
>> +
>>          }
>> @@ -1002,32 +1059,42 @@ static int __cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif
>>          unsigned int cpu = dev->id, ret, cpus;
>>          unsigned long flags;
>>          struct cpufreq_policy *data;
>> +       struct cpufreq_driver *driver;
>>          struct kobject *kobj;
>>          struct completion *cmp;That
>>          struct device *cpu_dev;
>> +       int (*target)(struct cpufreq_policy *policy,
>> +                      unsigned int target_freq,
>> +                      unsigned int relation);
> can be bool?
>
>> +       int (*exit)(struct cpufreq_policy *policy);
>>
>
> One more generic comment: What about a reader-writer lock for
> cpufreq_data_lock??
I had been looking for ways to use the rcu but wasn't having much success.
Let me try a rwlock and grab some numbers after lunch.
