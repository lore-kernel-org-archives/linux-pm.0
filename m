From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v3 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Wed, 14 May 2014 19:16:38 +0530
Message-ID: <CAJuA9agfoVwqa88=JB+SirjcO0dXy0s0fTc8=dP=u7H8uarSyg@mail.gmail.com>
References: <1400029380-5372-1-git-send-email-thomas.ab@samsung.com>
	<1400029380-5372-2-git-send-email-thomas.ab@samsung.com>
	<CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:42949 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbaENNqk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 09:46:40 -0400
In-Reply-To: <CAKohponnPSRAotJUu+5a9y8j97QF8Jqgc5DA5WQnwGWCnVY-aA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <rob.herring@linaro.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Nishanth Menon <nm@ti.com>

On Wed, May 14, 2014 at 9:10 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 14 May 2014 06:32, Thomas Abraham <ta.omasab@gmail.com> wrote:
>> From: Thomas Abraham <thomas.ab@samsung.com>
>>
>> Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
>> support for CPU boost mode. This patch adds support for finding available
>> boost frequencies from device tree and marking them as usable in boost mode.
>>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Lukasz Majewski <l.majewski@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>> ---
>>  drivers/cpufreq/cpufreq_opp.c |   39 +++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 39 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
>> index c0c6f4a..e3c97f3 100644
>> --- a/drivers/cpufreq/cpufreq_opp.c
>> +++ b/drivers/cpufreq/cpufreq_opp.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/pm_opp.h>
>>  #include <linux/rcupdate.h>
>>  #include <linux/slab.h>
>> +#include <linux/of.h>
>>
>>  /**
>>   * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
>> @@ -51,6 +52,10 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>         struct cpufreq_frequency_table *freq_table = NULL;
>>         int i, max_opps, ret = 0;
>>         unsigned long rate;
>> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
>> +       int j, len;
>> +       u32 *boost_freqs = NULL;
>> +#endif
>>
>>         rcu_read_lock();
>>
>> @@ -82,6 +87,40 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>>
>>         *table = &freq_table[0];
>>
>> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
>> +       if (of_find_property(dev->of_node, "boost-frequency", &len)) {
>
> Does this mean another block inside the cpu node ? Like this: ?
>
> cpu@0 {
>         compatible = "arm,cortex-a9";
>         reg = <0>;
>         next-level-cache = <&L2>;
>         operating-points = <
>                 /* kHz    uV */
>                 792000  1100000
>                 396000  950000
>                 198000  850000
>         >;
>         boost-frequency = <
>                 792000
>                 198000
>         >;
> };
>
> I think it we might better add another field in the opp block as these
> OPPs are rather boost one..
>
> @Rob/Rafael: Opinion please ..
>
>> +               if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {
>> +                       dev_err(dev, "%s: invalid boost frequency\n", __func__);
>> +                       ret = -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               boost_freqs = kzalloc(len, GFP_KERNEL);
>> +               if (!boost_freqs) {
>> +                       dev_warn(dev, "%s: no memory for boost freq table\n",
>> +                                       __func__);
>> +                       ret = -ENOMEM;
>> +                       goto out;
>> +               }
>> +               of_property_read_u32_array(dev->of_node, "boost-frequency",
>> +                       boost_freqs, len / sizeof(u32));
>> +       }
>> +
>> +       for (j = 0; j < len / sizeof(u32) && boost_freqs; j++) {
>
> Why is this present outside of above if {} ? as boost_freqs is guaranteed to
> be NULL without that.

Just to reduce indentation by one tab. No technical reasons. The code
had to wrap at 80 column was becoming unreadable.

>
>> +               for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
>> +                       if (boost_freqs[j] == freq_table[i].frequency) {
>
> Use cpufreq_frequency_table_get_index() instead.

Okay. Thanks for pointing out.

>
>> +                               freq_table[i].flags |= CPUFREQ_BOOST_FREQ;
>> +                               break;
>> +                       }
>> +               }
>> +               if (freq_table[i].frequency == CPUFREQ_TABLE_END)
>> +                       pr_err("%s: invalid boost frequency %d\n",
>> +                               __func__, boost_freqs[j]);
>> +       }
>> +
>> +       kfree(boost_freqs);
>> +#endif
>> +
>>  out:
>>         rcu_read_unlock();
>>         if (ret)
>> --
>> 1.7.4.4
>>
