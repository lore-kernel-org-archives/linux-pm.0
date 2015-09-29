From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv5 PATCH 38/46] sched: scheduler-driven cpu frequency
 selection
Date: Mon, 28 Sep 2015 17:26:55 -0700
Message-ID: <5609DACF.7040505@linaro.org>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-39-git-send-email-morten.rasmussen@arm.com>
 <9hh8u7qa3rq.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9hh8u7qa3rq.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, mturquette@baylibre.com
Cc: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Punit,

On 09/28/2015 09:48 AM, Punit Agrawal wrote:
> Hi Mike,
> 
> I ran into an issue when using this patch. Posting it here as this is
> the latest posting I can find.
> 
> Morten Rasmussen <morten.rasmussen@arm.com> writes:
> 
>> From: Michael Turquette <mturquette@baylibre.com>
>>
...
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 1f2c9a1..30241c9 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -494,6 +494,9 @@ extern struct cpufreq_governor cpufreq_gov_ondemand;
>>  #elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE)
>>  extern struct cpufreq_governor cpufreq_gov_conservative;
>>  #define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_conservative)
>> +#elif defined(CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV)
>> +extern struct cpufreq_governor cpufreq_gov_sched_gov;
>> +#define CPUFREQ_DEFAULT_GOVERNOR	(&cpufreq_gov_sched)
>>  #endif
> 
> You have extra 'gov' in CONFIG_CPU_FREQ_DEFAULT_GOV_SCHED_GOV and
> cpufreq_gov_sched_gov above.

Thanks, this was pointed out earlier and will be fixed in subsequent
revisions of the patchset.
