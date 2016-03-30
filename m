From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [Update][PATCH v7 7/7] cpufreq: schedutil: New governor based on
 scheduler utilization data
Date: Wed, 30 Mar 2016 13:31:16 +0200
Message-ID: <CAJZ5v0iB_7zZSu5-H-px7NYiaZ_P6DW3dqx-bKs7eohWudwxvQ@mail.gmail.com>
References: <7262976.zPkLj56ATU@vostro.rjw.lan>
	<6666532.7ULg06hQ7e@vostro.rjw.lan>
	<145931680.Kk1xSBT0Ro@vostro.rjw.lan>
	<20160330053011.GF8773@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160330053011.GF8773@vireshk-i7>
Sender: linux-acpi-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

[cut]

> The current version of this looks good to me and takes care of all the issues I
> raised earlier. Thanks.
>
>> +static int sugov_limits(struct cpufreq_policy *policy)
>> +{
>> +     struct sugov_policy *sg_policy = policy->governor_data;
>> +
>> +     if (!policy->fast_switch_enabled) {
>> +             mutex_lock(&sg_policy->work_lock);
>> +
>> +             if (policy->max < policy->cur)
>> +                     __cpufreq_driver_target(policy, policy->max,
>> +                                             CPUFREQ_RELATION_H);
>> +             else if (policy->min > policy->cur)
>> +                     __cpufreq_driver_target(policy, policy->min,
>> +                                             CPUFREQ_RELATION_L);
>> +
>> +             mutex_unlock(&sg_policy->work_lock);
>> +     }
>> +
>> +     sg_policy->need_freq_update = true;
>
> I am wondering why we need to do this for !fast_switch_enabled case?

That will cause the rate limit to be ignored in the utilization update
handler which may be necessary if it is set to a relatively large
value (like 1 s).

>> +     return 0;
>> +}
>
> Apart from that:
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks,
Rafael
