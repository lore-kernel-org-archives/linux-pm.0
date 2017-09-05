From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH v2 2/2] PM / i2c: designware: Clean up system sleep
 handling without ACPI
Date: Tue, 5 Sep 2017 23:22:09 +0200
Message-ID: <CAJZ5v0jc8oTwtVKoNZ6Wci8Am0S0q4-K8SwqpTPuREuoFbti4g@mail.gmail.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <1524365.Uf1AH187pl@aspire.rjw.lan>
 <20170905150744.GA2477@lahna.fi.intel.com> <3495106.6fP2YzlEUn@aspire.rjw.lan>
 <20170905152458.GB2477@lahna.fi.intel.com> <CAJZ5v0hXQEoULXuexn53jqo+ANB+gbtWDAL32wfvcwfh2Hm_VA@mail.gmail.com>
 <20170905154147.GC2477@lahna.fi.intel.com> <20170905210034.57b4pqg3suz4m3bl@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170905210034.57b4pqg3suz4m3bl@sig21.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 5, 2017 at 11:00 PM, Johannes Stezenbach <js@sig21.net> wrote:
> On Tue, Sep 05, 2017 at 06:41:47PM +0300, Mika Westerberg wrote:
>> On Tue, Sep 05, 2017 at 05:32:07PM +0200, Rafael J. Wysocki wrote:
>> > On Tue, Sep 5, 2017 at 5:24 PM, Mika Westerberg wrote:
>> > > diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
>> > > index 694116630ffa..c987f7fe6c74 100644
>> > > --- a/drivers/mfd/intel-lpss.h
>> > > +++ b/drivers/mfd/intel-lpss.h
>> > > @@ -38,8 +38,8 @@ int intel_lpss_resume(struct device *dev);
>> > >  #ifdef CONFIG_PM_SLEEP
>> > >  #define INTEL_LPSS_SLEEP_PM_OPS                        \
>> > >         .prepare = intel_lpss_prepare,          \
>> > > -       .suspend = intel_lpss_suspend,          \
>> > > -       .resume = intel_lpss_resume,            \
>> > > +       .suspend_late = intel_lpss_suspend,     \
>> > > +       .resume_early = intel_lpss_resume,      \
>> > >         .freeze = intel_lpss_suspend,           \
>> > >         .thaw = intel_lpss_resume,              \
>> > >         .poweroff = intel_lpss_suspend,         \
>> >
>> > Of course, freeze/thaw, poweroff/restore need to be moved to the
>> > late/early stages too.
>>
>> Right.
>
> I tested the patches on Asus E200HA with the above + freeze_late/thaw_early,
> works fine.  Then, wrt Rafael's comment in earlier mail about
> ordering of i2c designware vs. other drivers calling it via
> ACPI OpRegion, I changed it to noirq:
> (probably it's off-topic here but I tested while at it)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 335b2b236faa..6b1b3938c405 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -475,7 +475,7 @@ static int dw_i2c_plat_resume(struct device *dev)
>  }
>
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> -       SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> +       SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>         SET_RUNTIME_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume, NULL)
>  };
>
> diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> index 694116630ffa..7069d67160a0 100644
> --- a/drivers/mfd/intel-lpss.h
> +++ b/drivers/mfd/intel-lpss.h
> @@ -38,10 +38,10 @@ int intel_lpss_resume(struct device *dev);
>  #ifdef CONFIG_PM_SLEEP
>  #define INTEL_LPSS_SLEEP_PM_OPS                        \
>         .prepare = intel_lpss_prepare,          \
> -       .suspend = intel_lpss_suspend,          \
> -       .resume = intel_lpss_resume,            \
> -       .freeze = intel_lpss_suspend,           \
> -       .thaw = intel_lpss_resume,              \
> +       .suspend_noirq = intel_lpss_suspend,            \
> +       .resume_noirq = intel_lpss_resume,              \
> +       .freeze_noirq = intel_lpss_suspend,             \
> +       .thaw_noirq = intel_lpss_resume,                \
>         .poweroff = intel_lpss_suspend,         \
>         .restore = intel_lpss_resume,
>  #else
>
> It causes errors in dmesg:
>
> [   62.460369] PM: late suspend of devices complete after 35.484 msecs
> [   62.492283] i2c_designware 808622C1:02: timeout in disabling adapter
> [   62.519527] i2c_designware 808622C1:01: timeout in disabling adapter
> [   62.546930] i2c_designware 808622C1:00: timeout in disabling adapter
> [   62.565844] PM: noirq suspend of devices complete after 105.431 msecs
> [   62.565853] PM: suspend-to-idle
> ...
> [   65.590077] Suspended for 3.104 seconds
> [   65.591669] i2c_designware 808622C1:00: Unknown Synopsys component type: 0xffffffff
> [   65.591689] i2c_designware 808622C1:01: Unknown Synopsys component type: 0xffffffff
> [   65.591704] i2c_designware 808622C1:02: Unknown Synopsys component type: 0xffffffff
> [   65.612136] PM: noirq resume of devices complete after 21.451 msecs
> [   65.615059] PM: resume from suspend-to-idle
>
> But at least keyboard attached to 808622C1:00 still worked, it is:
> [    3.264799] input: PDEC3393:00 0B05:8585 as /devices/pci0000:00/808622C1:00/i2c-0/i2c-PDEC3393:00/0018:0B05:8585.0001
> /input/input5
> [    3.266476] asus 0018:0B05:8585.0001: input,hidraw0: I2C HID v1.00 Keyboard [PDEC3393:00 0B05:8585] on i2c-PDEC3393:00

That probably goes too far, at least for the time being.

When I was making that comment I was not aware of the entire
complexity involved here, sorry about that.
