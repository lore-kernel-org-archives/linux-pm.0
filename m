From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 08:49:42 +0200
Message-ID: <20130813064942.GA7055@samfundet.no>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
 <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:34036 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab3HMGtr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 02:49:47 -0400
Content-Disposition: inline
In-Reply-To: <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

Around Tue 13 Aug 2013 10:38:14 +0530 or thereabout, Viresh Kumar wrote:
> On 13 August 2013 00:40, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
>> This patch adds a dynamically calculated frequency table to the at32ap driver.
>> In short the architecture can scale in power of two between a maximum and
>> minimum frequency. Min, max, and the steps in between are added to the table.
>>
>> Signed-off-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
>> ---
>>  drivers/cpufreq/at32ap-cpufreq.c | 47 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 46 insertions(+), 1 deletion(-)

<snipp diff>

> Thanks for your patch, I have folded below patch with your patch while
> applying..
> 
> diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
> index eaac7cb..c586d3e 100644
> --- a/drivers/cpufreq/at32ap-cpufreq.c
> +++ b/drivers/cpufreq/at32ap-cpufreq.c
> @@ -87,10 +87,8 @@ static int at32_set_target(struct cpufreq_policy *policy,
> 
>  static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
>  {
> -       unsigned int frequency;
> -       int retval;
> -       int steps;
> -       int i;
> +       unsigned int frequency, rate;
> +       int retval, steps, i;
> 
>         if (policy->cpu != 0)
>                 return -EINVAL;
> @@ -126,20 +124,23 @@ static int __init
> at32_cpufreq_driver_init(struct cpufreq_policy *policy)
> 
>         frequency = policy->cpuinfo.max_freq;
>         for (i = 0; i < (steps - 1); i++) {
> -               unsigned int rate = clk_round_rate(cpuclk, frequency * 1000);
> -               rate /= 1000;
> +               rate = clk_round_rate(cpuclk, frequency * 1000) / 1000;
> +
>                 if (rate != frequency)
>                         freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
>                 else
>                         freq_table[i].frequency = frequency;
> +
>                 frequency /= 2;
>         }
> +
>         freq_table[steps - 1].frequency = CPUFREQ_TABLE_END;
> 
>         retval = cpufreq_frequency_table_cpuinfo(policy, freq_table);
>         if (retval)
>                 goto out_err_kfree;
> 
> +       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
>         printk("cpufreq: AT32AP CPU frequency driver\n");
> 
>         return 0;
> 

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

-- 
mvh
Hans-Christian Egtvedt
