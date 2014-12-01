From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq drivers
Date: Mon, 1 Dec 2014 18:59:20 +0530
Message-ID: <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
	<7885354.QleDlR7NUO@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:38679 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbaLAN3W (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Dec 2014 08:29:22 -0500
Received: by mail-oi0-f44.google.com with SMTP id e131so7380175oig.17
        for <linux-pm@vger.kernel.org>; Mon, 01 Dec 2014 05:29:21 -0800 (PST)
In-Reply-To: <7885354.QleDlR7NUO@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Rob Herring <rob.herring@linaro.org>, Grant Likely <grant.likely@linaro.org>, Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Chander Kashyap <k.chander@samsung.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "olof@lixom.net" <olof@lixom.net>

On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
> Thanks a lot for working on this, we really need to figure it out one day!

:)

> Your patches seem well-implemented, so if everybody thinks the general
> approach is the best solution, we should do that. From my point of view,
> there are two things I would do differently:
>
> - In the DT binding, I would strongly prefer anything but the root compatible
>   property as the key for the new platforms. Clearly we have to keep using
>   it for the backwards-compatibility case, as you do, but I think there
>   are more appropriate places to put it. Sorting from most favorite to least
>   favorite, my list would be:
>         1. a new property in /cpus/
>         2. a new property each /cpus/cpu@... node.

I did it this way earlier and named it dvfs-method but probably putting this
into the /cpus/ node is far better. But then Sudeep asked to utilize
compatible property only..

Are you fine with the name here? "dvfs-method"

>         3. the compatible property of the /cpus node
>         4. a top-level device node that gets turned into a platform device
>         5. a new property in the / node
>         6. a new property in the /chosen node
>         7. the compatible property in the / node
>
> - Implementation-wise, I don't think it's helpful to have a global function
>   that registers a platform device to be consumed by the device driver. I'd
>   rather just see a module_init function in each driver that rather than

Okay, this might work better in longer run. I am fine with it.

> [PATCH, RFC] cpufreq: dt: simplify and generalize probing
>
> We should not have to create a platform device from platform specific code
> in order to use the completely generic cpufreq-dt driver. This adds
> a simpler method by creating a new standard property of the "/cpus" node
> to look for, with a fallback for existing users. The list of existing
> users needs to be completed, and the same change done for the other
> DT based drivers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 6f5f5615fbf1..697b4dc47715 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -345,13 +345,50 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>         .attr = cpufreq_generic_attr,
>  };
>
> -static int dt_cpufreq_probe(struct platform_device *pdev)
> +/*
> + * these machines are using the driver but provide no standard
> + * probing method, only for old machines with existing dtbs.
> + */
> +static struct of_device_id legacy_machines = {
> +       { .compatible = "calxeda,highbank" },
> +       { .compatible = "renesas,sh7372" },
> +       { .compatible = "renesas,sh73a0"  },
> +       { .compatible = "samsung,exynos5250" },
> +       { .compatible = "samsung,exynos4210" },
> +       { .compatible = "xlnx,zynq-7000" },
> +};
> +
> +static bool dt_cpufreq_available(void)
> +{
> +       struct device_node *node;
> +       bool ret;
> +
> +       node = of_find_node_by_path("/cpus");
> +       if (!node)
> +               return 0;
> +
> +       /* the specific property needs to be debated */
> +       ret = of_property_read_bool("linux,cpu-frequency-scaling");

How can this be a bool? We need to differentiate on which binding
wants to go for arm-bl or cupfreq-dt or any other driver. So we surely
need a string ?

> +       of_node_put(node);
> +       if (ret)
> +               return 1;
> +
> +       node = of_find_node_by_path("/");
> +       ret = of_match_device(&legacy_machines, node);
> +       of_node_put(node);
> +
> +       return ret;
> +}
> +
> +static int __init dt_cpufreq_probe(void)
>  {
>         struct device *cpu_dev;
>         struct regulator *cpu_reg;
>         struct clk *cpu_clk;
>         int ret;
>
> +       if (!dt_cpufreq_available())
> +               return -ENXIO;
>         /*
>          * All per-cluster (CPUs sharing clock/voltages) initialization is done
>          * from ->init(). In probe(), we just need to make sure that clk and
> @@ -367,29 +404,19 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
>         if (!IS_ERR(cpu_reg))
>                 regulator_put(cpu_reg);
>
> -       dt_cpufreq_driver.driver_data = dev_get_platdata(&pdev->dev);
> -

We still need this, and its about how clocks are shared between CPUs.

>         ret = cpufreq_register_driver(&dt_cpufreq_driver);
>         if (ret)
>                 dev_err(cpu_dev, "failed register driver: %d\n", ret);
>
>         return ret;
>  }
> +module_init(dt_cpufreq_probe);
>
> -static int dt_cpufreq_remove(struct platform_device *pdev)
> +static void __exit dt_cpufreq_remove(void)
>  {
>         cpufreq_unregister_driver(&dt_cpufreq_driver);
> -       return 0;
>  }
> -
> -static struct platform_driver dt_cpufreq_platdrv = {
> -       .driver = {
> -               .name   = "cpufreq-dt",
> -       },
> -       .probe          = dt_cpufreq_probe,
> -       .remove         = dt_cpufreq_remove,
> -};
> -module_platform_driver(dt_cpufreq_platdrv);
> +module_exit(dt_cpufreq_remove);
>
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
>
