From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Wed, 9 Jan 2019 13:38:25 +0530
Message-ID: <8bb26f9b-4aa1-a0e7-ec48-667f096b961f@codeaurora.org>
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
 <20181221205752.GD261387@google.com>
 <2977f340-cd4e-86bc-da3a-8845676e39ed@codeaurora.org>
 <20190108000214.GR261387@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108000214.GR261387@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, evgreen@google.com
List-Id: linux-pm@vger.kernel.org



On 1/8/2019 5:32 AM, Matthias Kaehlcke wrote:
> Hi Taniya.
> 
> On Mon, Dec 24, 2018 at 12:29:18AM +0530, Taniya Das wrote:
> 
>> Could you help validating with the patch below?
> 
> ...
> 
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c
>> b/drivers/cpufreq/qcom-cpufreq-hw.c
>> index 7559b87..23338b2 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
>> @@ -81,7 +81,6 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>          u32 volt;
>>          unsigned int max_cores = cpumask_weight(policy->cpus);
>>          struct cpufreq_frequency_table  *table;
>> -       unsigned long cpu_r;
>>
>>          table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>>          if (!table)
>> @@ -110,6 +109,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>                          table[i].frequency = freq;
>>                          dev_dbg(dev, "index=%d freq=%d, core_count %d\n", i,
>>                                  freq, core_count);
>> +                       dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +                                       freq * 1000, volt);
>>                  }
>>
>>                  /*
>> @@ -126,6 +127,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>                          if (prev_cc != max_cores) {
>>                                  prev->frequency = prev_freq;
>>                                  prev->flags = CPUFREQ_BOOST_FREQ;
>> +                               dev_pm_opp_add(get_cpu_device(policy->cpu),
>> +                                               prev_freq * 1000, volt);
>>                          }
>>
>>                          break;
>> @@ -133,12 +136,9 @@ static int qcom_cpufreq_hw_read_lut(struct device *dev,
>>
>>                  prev_cc = core_count;
>>                  prev_freq = freq;
>> -
>> -               freq *= 1000;
>> -               for_each_cpu(cpu_r, policy->cpus)
>> -                       dev_pm_opp_add(get_cpu_device(cpu_r), freq, volt);
>>          }
>>
>> +       dev_pm_opp_set_sharing_cpus(get_cpu_device(policy->cpu),
>> policy->cpus);
>>          table[i].frequency = CPUFREQ_TABLE_END;
>>          policy->freq_table = table;
>>
>> @@ -245,6 +245,7 @@ static int qcom_cpufreq_hw_cpu_exit(struct
>> cpufreq_policy *policy)
>>   {
>>          void __iomem *base = policy->driver_data - REG_PERF_STATE;
>>
>> +       dev_pm_opp_cpumask_remove_table(policy->cpus);
> 
> Evan found that this doesn't actually remove dynamically added
> OPPs. You'll have to use the shiny new dev_pm_opp_remove_all_dynamic()
> (https://lore.kernel.org/patchwork/patch/1028942/) instead.
> 
> Cheers
> 
> Matthias
> 

Thanks, updated the next patch to use the new API.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
