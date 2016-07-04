From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 4/4] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Mon, 4 Jul 2016 15:53:53 +0200
Message-ID: <CAMuHMdXeV71iH-wvq5RFsAoP7y6nz2-g7iLSAQqysSckSuc-EQ@mail.gmail.com>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
 <1463485296-22742-5-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdVM66516s_+Ups7fng5xpasdiUnW=3Ybz+vGHbgN+5mpQ@mail.gmail.com> <m2twgaqp0w.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <m2twgaqp0w.fsf@baylibre.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

On Fri, Jul 1, 2016 at 12:40 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> On Tue, May 17, 2016 at 1:41 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
>>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
>>>
>>> To make sure these helpers worked for all combinations and without
>>> introducing too much of complexity, the device was always resumed in
>>> pm_runtime_force_resume().
>>>
>>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
>>> unset, we needed to resume the device as the subsystem/driver couldn't
>>> rely on using runtime PM to do it.
>>>
>>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
>>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
>>> CONFIG_PM_RUNTIME.
>>>
>>> For this reason we can now rely on the subsystem/driver to use runtime PM
>>> to resume the device, instead of forcing that to be done in all cases. In
>>> other words, let's defer this to a later point when it's actually needed.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/base/power/runtime.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>>> index 09e4eb1..1db7b46 100644
>>> --- a/drivers/base/power/runtime.c
>>> +++ b/drivers/base/power/runtime.c
>>> @@ -1509,6 +1509,17 @@ int pm_runtime_force_resume(struct device *dev)
>>>         if (!pm_runtime_status_suspended(dev))
>>>                 goto out;
>>>
>>> +       /*
>>> +        * The PM core increases the runtime PM usage count in the system PM
>>> +        * prepare phase. If the count is greather than 1 at this point, someone
>>> +        * else has also increased it. In that case, invoke the runtime resume
>>> +        * callback for the device as that is likely what is expected. In other
>>> +        * case we trust the subsystem/driver to runtime resume the device when
>>> +        * it's actually needed.
>>> +        */
>>> +       if (atomic_read(&dev->power.usage_count) < 2)
>>> +               goto out;
>>> +
>>>         ret = pm_runtime_set_active(dev);
>>>         if (ret)
>>>                 goto out;
>>
>> This patch (commit eb13a0a1b6d5d5c2 in pm/linux-next) breaks resume on
>> sh73a0/kzm9g and r8a73a4/ape6evm. On these boards, the Ethernet controller is a
>> child of a local bus (bsc), whose clock (zb) is controlled through pm_clk and
>> simple-pm-bus, cfr.
>>
>>     arch/arm/boot/dts/r8a73a4-ape6evm.dts
>>     arch/arm/boot/dts/r8a73a4.dtsi
>>     arch/arm/boot/dts/sh73a0-kzm9g.dts
>>     arch/arm/boot/dts/sh73a0.dtsi
>>
>> During resume, the bus clock is not enabled, causing an imprecise abort
>> when accessing the Ethernet controller's registers.
>
> I have a hunch (without too much digging) that this may be an odd
> interaction with the direct_complete stuff since the simple-pm-bus has
> no callbacks.
>
> For kicks, could you add something like the hack below (untested) which
> will avoid the direct_complete path, and at least help indicate if
> that path is worth investigating further.

Thanks!
()
> diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
> index c5eb46cbf388..63b95fb21510 100644
> --- a/drivers/bus/simple-pm-bus.c
> +++ b/drivers/bus/simple-pm-bus.c
> @@ -36,6 +36,15 @@ static int simple_pm_bus_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int simple_pm_bus_prepare(struct device *dev)
> +{
> +       return pm_generic_prepare(dev);

This causes an infinite loop, as pm_generic_prepare just calls
dev->driver->pm->prepare(dev);

> +}
> +
> +static const struct dev_pm_ops simple_pm_bus_ops = {
> +       .prepare = simple_pm_bus_prepare,
> +};
> +
>  static const struct of_device_id simple_pm_bus_of_match[] = {
>         { .compatible = "simple-pm-bus", },
>         { /* sentinel */ }
> @@ -48,6 +57,7 @@ static struct platform_driver simple_pm_bus_driver = {
>         .driver = {
>                 .name = "simple-pm-bus",
>                 .of_match_table = simple_pm_bus_of_match,
> +               .pm = &simple_pm_bus_ops,
>         },
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
