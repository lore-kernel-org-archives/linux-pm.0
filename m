From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: cpu0: Extend support beyond CPU0
Date: Fri, 27 Jun 2014 07:56:39 +0530
Message-ID: <CAKohpo=a6y1=aRi_7kZLQx56HXzvDJ-B2j8YiMevD8Wt6BvsEw@mail.gmail.com>
References: <cover.1403684824.git.viresh.kumar@linaro.org>
	<e9c0eef07745e561b9d12dcb50c3e2f7eb3e8880.1403684824.git.viresh.kumar@linaro.org>
	<53AB1CC1.4010907@codeaurora.org>
	<CAKohpo=Q7eWNwcK6KF9_U-zD0g=96QHW9hiQupLpV5GqoWE+mA@mail.gmail.com>
	<53ACB568.4000903@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53ACB568.4000903@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Shawn Guo <shawn.guo@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Mike Turquette <mturquette@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-arm-msm@vger.kernel.org, Sachin Kamat <spk.linux@gmail.com>, Thomas P Abraham <thomas.ab@samsung.com>, Nishanth Menon <nm@ti.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On 27 June 2014 05:36, Stephen Boyd <sboyd@codeaurora.org> wrote:
> I gave it a spin. It looks mostly good except for the infinite loop:

Great !!

> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index b7ee67c4d1c0..6744321ae33d 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -138,8 +138,10 @@ try_again:
>                 }
>
>                 /* Try with "cpu-supply" */
> -               if (reg == reg_cpu0)
> +               if (reg == reg_cpu0) {
> +                       reg = reg_cpu;
>                         goto try_again;
> +               }
>
>                 dev_warn(cpu_dev, "failed to get cpu%d regulator: %ld\n",
>                          cpu, PTR_ERR(cpu_reg));

Awesome code, I wrote it. Thanks for fixing it.

> and I think we just want reg_cpu to be "cpu", not "cpu-supply" because I
> think the regulator core adds in the "-supply" part already.

Okay.

> After fixing that I can get cpufreq going. I'm currently working on
> populating the OPPs at runtime without relying on DT. So eventually I'll
> need this patch:

I see..

> diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
> index b7ee67c4d1c0..6744321ae33d 100644
> --- a/drivers/cpufreq/cpufreq-cpu0.c
> +++ b/drivers/cpufreq/cpufreq-cpu0.c
> @@ -239,11 +241,6 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
>         }
>
>         ret = of_init_opp_table(cpu_dev);
> -       if (ret) {
> -               dev_err(cpu_dev, "failed to init OPP table: %d\n", ret);
> -               goto out_put_node;
> -       }
> -
>         ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
>         if (ret) {
>                 dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
>
> which I hope is ok.

I need to see details of these routines once again, but will surely make
it work for you.
