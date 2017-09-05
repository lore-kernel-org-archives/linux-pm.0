From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFT][PATCH 2/2] PM / i2c: designware: Clean up system sleep
 handling without ACPI
Date: Tue, 05 Sep 2017 18:46:57 +0300
Message-ID: <1504626417.25945.244.camel@linux.intel.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
         <6044272.h4jTMoqRfC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <6044272.h4jTMoqRfC@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-09-04 at 01:14 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit a23318feeff6 (i2c: designware: Fix system suspend)
> the i2c-designware-platdrv driver always resumes the device in its
> system sleep ->suspend callback which isn't particularly nice,
> even though it is technically correct.
> 
> A better approach would be to make the driver track the PM state of
> the device so that it doesn't need to resume it in ->suspend and
> to drop its ->prepare and ->complete callbacks which would only be
> marginally useful then, so implement it.
> 
> First, drop dw_i2c_plat_suspend() added by commit a23318feeff6 and
> rename dw_i2c_plat_runtime_suspend() back to dw_i2c_plat_suspend().
> 
> Second, point the driver's ->late_suspend and ->early_resume
> callbacks, rather than its ->suspend and ->resume callbacks,
> to dw_i2c_plat_suspend() and dw_i2c_plat_resume(), respectively,
> so that they are not executed in parallel with each other, for
> example if runtime resume of the device takes place during system
> suspend.  Also, since the driver enables runtime PM unconditionally
> in dw_i2c_plat_probe(), this change allows the
> pm_runtime_status_suspended() check to be used in the PM callbacks
> to determine whether or not the device needs to be either suspended
> or resumed (moving the callbacks into the late/early stages of
> system suspend/resume, respectively, guarantees the stability
> of the runtime PM status at the time when they are invoked).
> 
> Next, add a "skip_resume" flag to struct dw_i2c_dev and make
> dw_i2c_plat_suspend() and dw_i2c_plat_resume() use it to avoid
> resuming a previously runtime-suspended device during system resume.
> 
> Finally, drop the driver's ->prepare and ->complete PM callbacks,
> because returning "true" from ->prepare for runtime-suspended
> devices is marginally useful (the PM core may still ignore that
> return value and invoke the driver's ->suspend callback anyway)
> and ->complete is only needed because of what ->prepare does.

> +	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend,
> dw_i2c_plat_resume)

Luckily I2C doesn't use DMA.

For cases when we have a separate DMA controller devices (CherryTrail /
BayTrail) we have to be sure that I2C device is going to be suspended
first and resumed last to be operational. DMA itself uses LATE PM ops
IIRC (drivers/dma/dw/platform.c) and it becomes possible ordering issue
if both drivers are on the same level of PM ops.

P.S. For now, as I noted above, it would be not a problem, I think I
just need to mention this potential issue in the future with some
drivers (like SPI or UART, which are using DMA) on SoCs like CherryTrail
or if I2C going to support DMA.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
