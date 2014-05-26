From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/2] cpufreq / OPP: Allow boost frequency to be looked
 up from device tree
Date: Mon, 26 May 2014 11:28:59 +0530
Message-ID: <CAKohpom02xmubyNMMmH9J59i8KCoAXpZoX+Gj9NP9gQ8B9qB3w@mail.gmail.com>
References: <1400852262-6290-1-git-send-email-thomas.ab@samsung.com>
	<1400852262-6290-2-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1400852262-6290-2-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

On 23 May 2014 19:07, Thomas Abraham <thomas.ab@samsung.com> wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
>
> Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
> support for CPU boost mode. This patch adds support for finding available
> boost frequencies from device tree and marking them as usable in boost mode.
>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  drivers/cpufreq/cpufreq_opp.c |   44 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
> index c0c6f4a..2b3905b 100644
> --- a/drivers/cpufreq/cpufreq_opp.c
> +++ b/drivers/cpufreq/cpufreq_opp.c
> @@ -19,6 +19,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/rcupdate.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>
>  /**
>   * dev_pm_opp_init_cpufreq_table() - create a cpufreq table for a device
> @@ -51,6 +52,10 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>         struct cpufreq_frequency_table *freq_table = NULL;
>         int i, max_opps, ret = 0;
>         unsigned long rate;
> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> +       int j, len;
> +       u32 *boost_freqs = NULL;
> +#endif
>
>         rcu_read_lock();
>
> @@ -82,6 +87,45 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
>
>         *table = &freq_table[0];
>
> +#ifdef CONFIG_CPU_FREQ_BOOST_SW
> +       if (of_find_property(dev->of_node, "boost-frequencies", &len)) {

Maybe:
if(!of_find_property(...))
        goto out;

To get rid of extra indentation levels below..

> +               struct cpufreq_frequency_table *ft;

Declare at the top with boost_freqs, etc..

> +               if (len == 0 || (len & (sizeof(u32) - 1)) != 0) {

s/len == 0/!len

And use IS_ALIGNED() instead of the right hand side of ||

> +                       dev_err(dev, "%s: invalid boost frequency\n", __func__);
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               boost_freqs = kzalloc(len, GFP_KERNEL);

Can we do a devm_kzalloc instead? And why not kmalloc BTW ?

> +               if (!boost_freqs) {
> +                       dev_warn(dev, "%s: no memory for boost freq table\n",

dev_err ?

> +                                       __func__);
> +                       ret = -ENOMEM;
> +                       goto out;
> +               }
> +               of_property_read_u32_array(dev->of_node, "boost-frequencies",
> +                       boost_freqs, len / sizeof(u32));


Create int count = len / sizeof(u32) instead.. You have used this
multiple times.

> +               for (j = 0; j < len / sizeof(u32); j++) {
> +                       ft = *table;
> +                       for (i = 0; ft->frequency != CPUFREQ_TABLE_END; i++) {

See if new macros can be used here instead. cpufreq_for_each_valid_entry().

> +                               if (boost_freqs[j] == ft->frequency) {
> +                                       ft->flags |= CPUFREQ_BOOST_FREQ;
> +                                       break;
> +                               }
> +                               ft++;
> +                       }
> +
> +                       if (ft->frequency == CPUFREQ_TABLE_END)
> +                               pr_err("%s: invalid boost frequency %d\n",
> +                                       __func__, boost_freqs[j]);

Maybe a pr_debug on the else part as well ? With boost freqs ..

> +               }
> +       }
> +
> +       kfree(boost_freqs);
> +#endif
> +
>  out:
>         rcu_read_unlock();
>         if (ret)
> --
> 1.7.9.5
>
