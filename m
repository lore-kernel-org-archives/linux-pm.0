From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 10:38:14 +0530
Message-ID: <CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:39699 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476Ab3HMFIP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 01:08:15 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so10048648obc.10
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 22:08:14 -0700 (PDT)
In-Reply-To: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>

On 13 August 2013 00:40, Hans-Christian Egtvedt <egtvedt@samfundet.no> wrote:
> This patch adds a dynamically calculated frequency table to the at32ap driver.
> In short the architecture can scale in power of two between a maximum and
> minimum frequency. Min, max, and the steps in between are added to the table.
>
> Signed-off-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
> ---
>  drivers/cpufreq/at32ap-cpufreq.c | 47 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
> index 6544887..dbf3f3d 100644
> --- a/drivers/cpufreq/at32ap-cpufreq.c
> +++ b/drivers/cpufreq/at32ap-cpufreq.c
> @@ -19,8 +19,10 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/slab.h>
>
>  static struct clk *cpuclk;
> +static struct cpufreq_frequency_table *freq_table;
>
>  static int at32_verify_speed(struct cpufreq_policy *policy)
>  {
> @@ -85,13 +87,19 @@ static int at32_set_target(struct cpufreq_policy *policy,
>
>  static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
>  {
> +       unsigned int frequency;
> +       int retval;
> +       int steps;
> +       int i;
> +
>         if (policy->cpu != 0)
>                 return -EINVAL;
>
>         cpuclk = clk_get(NULL, "cpu");
>         if (IS_ERR(cpuclk)) {
>                 pr_debug("cpufreq: could not get CPU clk\n");
> -               return PTR_ERR(cpuclk);
> +               retval = PTR_ERR(cpuclk);
> +               goto out_err;
>         }
>
>         policy->cpuinfo.min_freq = (clk_round_rate(cpuclk, 1) + 500) / 1000;
> @@ -101,9 +109,46 @@ static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
>         policy->min = policy->cpuinfo.min_freq;
>         policy->max = policy->cpuinfo.max_freq;
>
> +       /*
> +        * AVR32 CPU frequency rate scales in power of two between maximum and
> +        * minimum, also add space for the table end marker.
> +        *
> +        * Further validate that the frequency is usable, and append it to the
> +        * frequency table.
> +        */
> +       steps = fls(policy->cpuinfo.max_freq / policy->cpuinfo.min_freq) + 1;
> +       freq_table = kzalloc(steps * sizeof(struct cpufreq_frequency_table),
> +                       GFP_KERNEL);
> +       if (!freq_table) {
> +               retval = -ENOMEM;
> +               goto out_err_put_clk;
> +       }
> +
> +       frequency = policy->cpuinfo.max_freq;
> +       for (i = 0; i < (steps - 1); i++) {
> +               unsigned int rate = clk_round_rate(cpuclk, frequency * 1000);
> +               rate /= 1000;
> +               if (rate != frequency)
> +                       freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
> +               else
> +                       freq_table[i].frequency = frequency;
> +               frequency /= 2;
> +       }
> +       freq_table[steps - 1].frequency = CPUFREQ_TABLE_END;
> +
> +       retval = cpufreq_frequency_table_cpuinfo(policy, freq_table);
> +       if (retval)
> +               goto out_err_kfree;
> +
>         printk("cpufreq: AT32AP CPU frequency driver\n");
>
>         return 0;
> +out_err_kfree:
> +       kfree(freq_table);
> +out_err_put_clk:
> +       clk_put(cpuclk);
> +out_err:
> +       return retval;
>  }
>
>  static struct cpufreq_driver at32_driver = {

Thanks for your patch, I have folded below patch with your patch while
applying..

diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index eaac7cb..c586d3e 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -87,10 +87,8 @@ static int at32_set_target(struct cpufreq_policy *policy,

 static int __init at32_cpufreq_driver_init(struct cpufreq_policy *policy)
 {
-       unsigned int frequency;
-       int retval;
-       int steps;
-       int i;
+       unsigned int frequency, rate;
+       int retval, steps, i;

        if (policy->cpu != 0)
                return -EINVAL;
@@ -126,20 +124,23 @@ static int __init
at32_cpufreq_driver_init(struct cpufreq_policy *policy)

        frequency = policy->cpuinfo.max_freq;
        for (i = 0; i < (steps - 1); i++) {
-               unsigned int rate = clk_round_rate(cpuclk, frequency * 1000);
-               rate /= 1000;
+               rate = clk_round_rate(cpuclk, frequency * 1000) / 1000;
+
                if (rate != frequency)
                        freq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
                else
                        freq_table[i].frequency = frequency;
+
                frequency /= 2;
        }
+
        freq_table[steps - 1].frequency = CPUFREQ_TABLE_END;

        retval = cpufreq_frequency_table_cpuinfo(policy, freq_table);
        if (retval)
                goto out_err_kfree;

+       cpufreq_frequency_table_get_attr(freq_table, policy->cpu);
        printk("cpufreq: AT32AP CPU frequency driver\n");

        return 0;
