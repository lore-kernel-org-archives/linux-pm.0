From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 08:52:08 +0200
Message-ID: <20130813065208.GB7055@samfundet.no>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
 <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
 <CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

Around Tue 13 Aug 2013 10:41:39 +0530 or thereabout, Viresh Kumar wrote:
> On 13 August 2013 10:38, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> Thanks for your patch, I have folded below patch with your patch while
>> applying..
> 
> And actually this too, otherwise I need to do this separately in another
> patch..
> 
> diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
> index c586d3e..1d19fa5 100644
> --- a/drivers/cpufreq/at32ap-cpufreq.c
> +++ b/drivers/cpufreq/at32ap-cpufreq.c
> @@ -136,15 +136,12 @@ static int __init
> at32_cpufreq_driver_init(struct cpufreq_policy *policy)
> 
>         freq_table[steps - 1].frequency = CPUFREQ_TABLE_END;
> 
> -       retval = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> -       if (retval)
> -               goto out_err_kfree;
> -
> -       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
> -       printk("cpufreq: AT32AP CPU frequency driver\n");
> +       retval = cpufreq_table_validate_and_show(policy, freq_table);
> +       if (!retval) {
> +               printk("cpufreq: AT32AP CPU frequency driver\n");
> +               return 0;
> +       }
> 
> -       return 0;
> -out_err_kfree:
>         kfree(freq_table);
>  out_err_put_clk:
>         clk_put(cpuclk);

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Thanks for cleaning up (-:

-- 
mvh
Hans-Christian Egtvedt
