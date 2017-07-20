From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] PM / OPP: Don't check not plugged in CPUs to avoid error
Date: Thu, 20 Jul 2017 09:01:58 +0530
Message-ID: <20170720033158.GH352@vireshk-i7>
References: <20170713122201.30048-1-waldemarx.rymarkiewicz@intel.com>
 <20170713234226.GE22780@codeaurora.org>
 <20170717071234.GK352@vireshk-i7>
 <CAHKzcEP5+btsJ1Tog4KQAynmmbBSixfWAxO9V0EFWeP5pP5M=w@mail.gmail.com>
 <20170718043536.GT352@vireshk-i7>
 <CAHKzcENsE=So2omU2v27XoHEbvcpW1gmB5P0NM=Z-Bg=f_O_4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34523 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbdGTDcE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Jul 2017 23:32:04 -0400
Received: by mail-pg0-f48.google.com with SMTP id 123so8644060pgj.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Jul 2017 20:32:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHKzcENsE=So2omU2v27XoHEbvcpW1gmB5P0NM=Z-Bg=f_O_4g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, linux-pm@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>

On 19-07-17, 16:10, Waldemar Rymarkiewicz wrote:
> Anyway, below a proposal how we can solve the problem of getting
> shared CPUs when hotplug is used.
> 
> 
> @@ -555,8 +576,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
>  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>                                    struct cpumask *cpumask)
>  {
> -       struct device_node *np, *tmp_np;
> -       struct device *tcpu_dev;
> +       struct device_node *np, *tmp_np, *cpu_np;
>         int cpu, ret = 0;
> 
>         /* Get OPP descriptor node */
> @@ -572,22 +592,16 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
>         if (!of_property_read_bool(np, "opp-shared"))
>                 goto put_cpu_node;
> 
> -       for_each_possible_cpu(cpu) {
> +       for_each_node_by_type(cpu_np, "cpu") {
> +               cpu = of_device_node_get_cpu(cpu_np);

Actually you can keep the original loop as it is and use
of_get_cpu_node() here. We better open code of_device_node_get_cpu()
here.

> +
>                 if (cpu == cpu_dev->id)
>                         continue;
> 
> -               tcpu_dev = get_cpu_device(cpu);
> -               if (!tcpu_dev) {
> -                       dev_err(cpu_dev, "%s: failed to get cpu%d device\n",
> -                               __func__, cpu);
> -                       ret = -ENODEV;
> -                       goto put_cpu_node;
> -               }
> -
>                 /* Get OPP descriptor node */
> -               tmp_np = _of_get_opp_desc_node(tcpu_dev);

I see dev_pm_opp_of_get_opp_desc_node() here, not sure how you got
above change..

> +               tmp_np = of_parse_phandle(cpu_np, "operating-points-v2", 0);

I would create _opp_of_get_opp_desc_node(np) and use it everywhere,
i.e. from dev_pm_opp_of_get_opp_desc_node() as well.

>                 if (!tmp_np) {
> -                       dev_err(tcpu_dev, "%s: Couldn't find tcpu_dev node.\n",
> +                       dev_err(cpu_dev, "%s: Couldn't find tcpu_dev node.\n",
>                                 __func__);
>                         ret = -ENOENT;
>                         goto put_cpu_node;

Thanks.

-- 
viresh
