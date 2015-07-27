From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 7/7] cpufreq: Separate CPU device removal from CPU online
Date: Mon, 27 Jul 2015 22:56:09 +0200
Message-ID: <CAJZ5v0gT4e2=VRPcF5S2fSBUiNZ3+dAeOrt5rRy_PAT5-+Y4Ow@mail.gmail.com>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
	<3874727.Jpay9zgokc@vostro.rjw.lan>
	<1739669.kedIsxdRK2@vostro.rjw.lan>
	<20150727150655.GI18535@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150727150655.GI18535@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 27, 2015 at 5:06 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 27-07-15, 16:09, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> To separate the CPU online interface from the CPU device removal
>> one,
>
> Why do you call this cpu device removal code?

By mistake.

Of course, that should be addition/registration.

>> split cpufreq_online() out of cpufreq_add_dev() and make
>> cpufreq_cpu_callback() call the former, while the latter will only
>> be used as the CPU device removal subsystem interface callback.
>>
>> While at it, notice that the return value of sif->add_dev() is
>> ignored in bus_probe_device(), so (the new) cpufreq_add_dev()
>> doesn't need to bother with returning anything different from 0
>> and cpufreq_online() may be a void function.
>
> That is going to change in 4.3:
>
> https://lkml.org/lkml/2015/6/26/132

There are some problems with access to klml.org today and I'm not sure
what you mean.

Can you explain your points in addition to sending links to stuff, please?

>> Moreover, since the return value of cpufreq_add_policy_cpu() is
>> going to be ignored now too, make a void function of it as well.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Suggested-by: Russell King <linux@arm.linux.org.uk>
>> ---
>>  drivers/cpufreq/cpufreq.c |  125 ++++++++++++++++++++++------------------------
>>  1 file changed, 61 insertions(+), 64 deletions(-)
>>
>> Index: linux-pm/drivers/cpufreq/cpufreq.c
>> ===================================================================
>> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
>> +++ linux-pm/drivers/cpufreq/cpufreq.c
>> @@ -1056,19 +1056,17 @@ static int cpufreq_init_policy(struct cp
>>       return cpufreq_set_policy(policy, &new_policy);
>>  }
>>
>> -static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
>> +static void cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cpu)
>>  {
>> -     int ret = 0;
>> -
>>       /* Has this CPU been taken care of already? */
>>       if (cpumask_test_cpu(cpu, policy->cpus))
>> -             return 0;
>> +             return;
>>
>>       if (has_target()) {
>> -             ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
>> +             int ret = __cpufreq_governor(policy, CPUFREQ_GOV_STOP);
>
> Why should we move the definition of ret here and ...

We don't have to, but then we don't need the variable outside of the
blocks it is used in.

>>               if (ret) {
>>                       pr_err("%s: Failed to stop governor\n", __func__);
>> -                     return ret;
>> +                     return;
>>               }
>>       }
>

I'll send a new version of this patch.

Thanks,
Rafael
