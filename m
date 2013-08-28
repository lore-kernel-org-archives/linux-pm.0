From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] cpufreq: Don't use smp_processor_id() in preemptible
 context
Date: Wed, 28 Aug 2013 09:26:54 -0700
Message-ID: <521E24CE.9090407@codeaurora.org>
References: <1377629249-1177-1-git-send-email-sboyd@codeaurora.org> <1377640884-16827-1-git-send-email-sboyd@codeaurora.org> <CAKohpo=RLmXK+vX9b7yBOGiS=d0ZEt3RpJETNvBeSRhYfoYWuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=RLmXK+vX9b7yBOGiS=d0ZEt3RpJETNvBeSRhYfoYWuA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On 08/27/13 23:34, Viresh Kumar wrote:
> On 28 August 2013 03:31, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index b9b20fd..523af48 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -137,7 +137,7 @@ void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
>>                 return;
>>
>>         if (!all_cpus) {
>> -               __gov_queue_work(smp_processor_id(), dbs_data, delay);
>> +               __gov_queue_work(policy->cpu, dbs_data, delay);
> This is probably wrong.. We wanted to queue work on current cpu and
> not policy->cpu.. Can you use raw_smp_processor_id()?

Ah right, for the case where the policy covers more than one cpu.
raw_smp_processor_id() would work but it probably also needs a large
comment. I'll resend with that.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation

