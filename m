From: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH 1/2] i2c: designware: switch to suspend_late/resume_early
Date: Wed, 20 Sep 2017 15:42:49 -0700
Message-ID: <CAA93t1oyJvSj78hTLc5Ki9pNtqg-W8d448BZokNwajZ2Z5phcA@mail.gmail.com>
References: <20170920223152.100641-1-rajatja@google.com>
Reply-To: rajatxjain@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170920223152.100641-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, furquan@google.com
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 20, 2017 at 3:31 PM, Rajat Jain <rajatja@google.com> wrote:
> Ref: https://lkml.org/lkml/2017/9/19/649
>
> The bus controllers should suspend the bus operations only after
> all of the devices on the bus have suspended their device
> completely. Since the i2c_client drivers could be talking to
> their devices in their suspend_late() calls, lets ensure that the
> bus is alive by that time. Thus moving the controller suspend logic to
> suspend_late().
>
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---

Forgot to mention, this was needed because we were seeing problems
when the ACPI routines (called at resume_early() time) for the i2c
client device were trying to access one of the I2C devices, and were
failing because the bus was not ready.

Thanks,

Rajat


>  drivers/i2c/busses/i2c-designware-platdrv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0e65b97842b4..66dd7f844c40 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -468,7 +468,7 @@ static int dw_i2c_plat_suspend(struct device *dev)
>  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
>         .prepare = dw_i2c_plat_prepare,
>         .complete = dw_i2c_plat_complete,
> -       SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> +       SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
>         SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
>                            dw_i2c_plat_resume,
>                            NULL)
> --
> 2.14.1.821.g8fa685d3b7-goog
>
