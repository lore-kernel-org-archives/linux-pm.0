From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 2/2] cpufreq: qoriq: Don't look at clock implementation details
Date: Wed, 06 Jul 2016 18:30:17 -0700
Message-ID: <146785501714.73491.8643317356949121718@resonance>
References: <1466058085-19353-1-git-send-email-oss@buserror.net>
 <1466058085-19353-2-git-send-email-oss@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1466058085-19353-2-git-send-email-oss@buserror.net>
Sender: linux-clk-owner@vger.kernel.org
To: Scott Wood <oss@buserror.net>, Russell King <linux@armlinux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, yuantian.tang@nxp.com, leoyang.li@nxp.com, xiaofeng.ren@nxp.com, Scott Wood <scottwood@freescale.com>
List-Id: linux-pm@vger.kernel.org

Quoting Scott Wood (2016-06-15 23:21:25)
> -static struct device_node *cpu_to_clk_node(int cpu)
> +static struct clk *cpu_to_clk(int cpu)
>  {
> -       struct device_node *np, *clk_np;
> +       struct device_node *np;
> +       struct clk *clk;
>  
>         if (!cpu_present(cpu))
>                 return NULL;
> @@ -112,37 +80,28 @@ static struct device_node *cpu_to_clk_node(int cpu)
>         if (!np)
>                 return NULL;
>  
> -       clk_np = of_parse_phandle(np, "clocks", 0);
> -       if (!clk_np)
> -               return NULL;
> -
> +       clk = of_clk_get(np, 0);

Why not use devm_clk_get here?

> @@ -221,17 +180,12 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 goto err_nomem2;
>         }
>  
> -       pnode = of_parse_phandle(np, "clocks", 0);
> -       if (!pnode) {
> -               pr_err("%s: could not get clock information\n", __func__);
> -               goto err_nomem2;
> -       }
> +       count = clk_get_num_parents(policy->clk);

We already have of_clk_get_parent_count. This is found in
clk-provider.h, which doesn't fit perfectly here since the cpufreq
driver is not a clock provider, but instead a consumer.

> @@ -240,23 +194,11 @@ static int qoriq_cpufreq_cpu_init(struct cpufreq_policy *policy)
>                 goto err_pclk;
>         }
>  
> -       if (fmask)
> -               mask = fmask[get_cpu_physical_id(cpu)];
> -       else
> -               mask = 0x0;
> -
>         for (i = 0; i < count; i++) {
> -               clk = of_clk_get(pnode, i);
> +               clk = clk_get_parent_by_index(policy->clk, i);
>                 data->pclk[i] = clk;
>                 freq = clk_get_rate(clk);
> -               /*
> -                * the clock is valid if its frequency is not masked
> -                * and large than minimum allowed frequency.
> -                */
> -               if (freq < min_cpufreq || (mask & (1 << i)))
> -                       table[i].frequency = CPUFREQ_ENTRY_INVALID;
> -               else
> -                       table[i].frequency = freq / 1000;
> +               table[i].frequency = freq / 1000;

Hmm, so you change cpu clock rate by selecting different clock sources
from a cpu clock mux, right? I wonder if you can just have a child mux
clock that selects parents from .set_rate (via a .determine_rate
callback)? Then you could just call clk_set_rate() on your cpu mux clock
and maybe skip most of the stuff this driver does?

Regards,
Mike
