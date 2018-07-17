From: Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v5 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW
 driver
Date: Tue, 17 Jul 2018 08:20:14 +0530
Message-ID: <6a75b366-8290-e820-571c-675c060e573e@codeaurora.org>
References: <1531418745-19742-1-git-send-email-tdas@codeaurora.org>
 <1531418745-19742-3-git-send-email-tdas@codeaurora.org>
 <CAE=gft7pVnhbEtOyR7Q8n_WuL_RsttrxN+sp=_EPyR=D3NPv9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE=gft7pVnhbEtOyR7Q8n_WuL_RsttrxN+sp=_EPyR=D3NPv9g@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@google.com>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, anischal@codeaurora.org, devicetree@vger.kernel.org, robh@kernel.org, Saravana Kannan <skannan@codeaurora.org>, amit.kucheria@linaro.org
List-Id: linux-pm@vger.kernel.org

Hello Evan,

Thank you for testing the patch.

On 7/17/2018 4:32 AM, Evan Green wrote:
> Hi Taniya,
> On Thu, Jul 12, 2018 at 11:06 AM Taniya Das <tdas@codeaurora.org> wrote:
>>
>> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
>> for changing the frequency of CPUs. The driver implements the cpufreq
>> driver interface for this hardware engine.
>>
>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/cpufreq/Kconfig.arm       |  10 ++
>>   drivers/cpufreq/Makefile          |   1 +
>>   drivers/cpufreq/qcom-cpufreq-hw.c | 344 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 drivers/cpufreq/qcom-cpufreq-hw.c
>>
> ...
>> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
>> new file mode 100644
>> index 0000000..fa25a95
>> --- /dev/null
>> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> ...
>> +static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>> +{
>> +       struct cpufreq_qcom *c;
>> +
>> +       c = qcom_freq_domain_map[policy->cpu];
>> +       if (!c) {
>> +               pr_err("No scaling support for CPU%d\n", policy->cpu);
>> +               return -ENODEV;
>> +       }
>> +
>> +       cpumask_copy(policy->cpus, &c->related_cpus);
>> +
>> +       policy->fast_switch_possible = true;
>> +       policy->freq_table = c->table;
>> +       policy->driver_data = c;
>> +
>> +       return 0;
> I haven't looked at this driver in detail, but I have tested it.
> Instead of the line above, I needed:
> 
> return cpufreq_table_validate_and_show(policy, c->table);
> 
> Without this the framework thinks that the min and max frequencies are
> zero, and then you get a warning about an invalid table. I also
> removed "policy->freq_table = c->table", since validate_and_show does
> this.
> -Evan
> 

The API is no longer supported,

https://patchwork.kernel.org/patch/10320897/

If you are using the 4.14 kernel, you do need to replace

-policy->freq_table = c->table;
+cpufreq_table_validate_and_show(policy, c->table);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--
