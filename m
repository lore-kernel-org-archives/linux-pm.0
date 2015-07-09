From: Pi-Cheng Chen <pi-cheng.chen-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Thu, 9 Jul 2015 09:55:17 +0800
Message-ID: <CALx668Xp051A-BBGwwNxpiQCt318Bh5fnA5jcAXBg-9vPcqpvg@mail.gmail.com>
References: <1435717005-20012-1-git-send-email-pi-cheng.chen@linaro.org>
 <1435717005-20012-3-git-send-email-pi-cheng.chen@linaro.org>
 <20150708113455.GF1805@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20150708113455.GF1805@linux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linaro Kernel Mailman List <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Jul 8, 2015 at 7:34 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 01-07-15, 10:16, Pi-Cheng Chen wrote:
>> This patch implements MT8173 cpufreq driver.
>
> Now that you are going to resend this patchset, a few more comments.
>
> Please describe your SoC a bit here, so that reviewers know what are
> we going to implement.

Yes. I will add it.

>
>> +static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>> +{
>> +     struct device *cpu_dev;
>> +     struct regulator *proc_reg = ERR_PTR(-ENODEV);
>> +     struct regulator *sram_reg = ERR_PTR(-ENODEV);
>> +     struct clk *cpu_clk = ERR_PTR(-ENODEV);
>> +     struct clk *inter_clk = ERR_PTR(-ENODEV);
>> +     struct dev_pm_opp *opp;
>> +     unsigned long rate;
>> +     int ret;
>> +
>> +     cpu_dev = get_cpu_device(cpu);
>> +     if (!cpu_dev) {
>> +             pr_err("failed to get cpu%d device\n", cpu);
>> +             return -ENODEV;
>> +     }
>> +
>> +     ret = of_init_opp_table(cpu_dev);
>> +     if (ret) {
>> +             pr_warn("no OPP table for cpu%d\n", cpu);
>> +             return ret;
>> +     }
>
> Initialize opp table only when you know other resources are available.
> i.e. we aren't going to abort due to EPROBE_DEFER.

Will do it.

>
>> +     cpu_clk = clk_get(cpu_dev, "cpu");
>> +     if (IS_ERR(cpu_clk)) {
>> +             if (PTR_ERR(cpu_clk) == -EPROBE_DEFER)
>> +                     pr_warn("cpu clk for cpu%d not ready, retry.\n", cpu);
>> +             else
>> +                     pr_err("failed to get cpu clk for cpu%d\n", cpu);
>> +
>> +             ret = PTR_ERR(cpu_clk);
>> +             goto out_free_opp_table;
>> +     }
>> +}
>
>
>> +static int mt8173_cpufreq_probe(struct platform_device *pdev)
>> +{
>> +     int ret;
>> +
>> +     ret = cpufreq_register_driver(&mt8173_cpufreq_driver);
>> +     if (ret)
>> +             pr_err("failed to register mtk cpufreq driver\n");
>> +
>> +     return ret;
>> +}
>> +
>> +static struct platform_driver mt8173_cpufreq_platdrv = {
>> +     .driver = {
>> +             .name   = "mt8173-cpufreq",
>> +     },
>> +     .probe          = mt8173_cpufreq_probe,
>> +};
>> +
>> +static int mt8173_cpufreq_driver_init(void)
>> +{
>> +     struct platform_device *pdev;
>> +     int err;
>> +
>> +     if (!of_machine_is_compatible("mediatek,mt8173"))
>> +             return -ENODEV;
>
> Why do you need to check this ? Its going to be the right SoC, others
> can't even compile it.

Originally I was thinking this driver should be generic to other Mediatek
SoCs, so I add this check to filter out those SoCs that are not yet
confirmed with this driver supported. Since it's targeted to MT8173 only
now, I will remove this check.

>
>> +     err = platform_driver_register(&mt8173_cpufreq_platdrv);
>> +     if (err)
>> +             return err;
>> +
>> +     pdev = platform_device_register_simple("mt8173-cpufreq", -1, NULL, 0);
>> +     if (IS_ERR(pdev)) {
>> +             pr_err("failed to register mtk-cpufreq platform device\n");
>> +             return PTR_ERR(pdev);
>> +     }
>
> This is simply crap. You register the driver and then its device from
> the same function. If you are so sure that this driver is required,
> then why to get into the shit of device-driver model ?
>
> Just call cpufreq_register_driver() from here :), no device/driver
> required.

That's what I did in previous version. But the reason I use the device-
driver model is to handle the defer probing issue. Since there's no
arch/arm64/mach-mediatek/ directory to hold the device registration
code anymore, no device tree way to match cpufreq driver
(please correct me if there's any), and initcall seems not handle
defer probing either, therefore I put both device and driver
registration in this function. I know it's crappy. :(
Do you have any suggestion to do it right and handle defer probing
properly?

Thanks.

Best Regards,
Pi-Cheng

>
> --
> viresh
