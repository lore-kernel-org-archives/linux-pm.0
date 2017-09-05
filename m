From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v2 2/2] PM / i2c: designware: Clean up system sleep handling without ACPI
Date: Tue, 05 Sep 2017 16:46:11 +0200
Message-ID: <3930469.chvfik16I5@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <1729594.8Da7J7iljp@aspire.rjw.lan> <20170905144511.GX2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170905144511.GX2477@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 5, 2017 4:45:11 PM CEST Mika Westerberg wrote:
> On Mon, Sep 04, 2017 at 12:01:54PM +0200, Rafael J. Wysocki wrote:
> >  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> > -	.prepare = dw_i2c_plat_prepare,
> > -	.complete = dw_i2c_plat_complete,
> > -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> > -	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> > -			   dw_i2c_plat_resume,
> > -			   NULL)
> > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> 
> This seems to cause problem with intel-lpss MFD driver because it uses
> .suspend() and .resume() instead of .suspend_late() and .resume_early().

OK, so there is one more dependency here.

Can you please point me to this code?

> It only brings the device out of reset during .resume() which triggers
> this:
> 
> [  221.066302] PM: noirq resume of devices complete after 162.461 msecs
> [  221.079743] i2c_designware i2c_designware.0: Unknown Synopsys component type: 0x00000000
> [  221.079749] i2c_designware i2c_designware.1: Unknown Synopsys component type: 0x00000000
> [  221.079880] PM: early resume of devices complete after 13.538 msecs
> ...
> [  222.115656] i2c_designware i2c_designware.1: controller timed out
> [  222.756572] [drm] RC6 on
> [  226.276006] i2c_hid i2c-DLL06E4:01: failed to reset device.
> [  227.300012] i2c_designware i2c_designware.1: controller timed out
> [  227.300037] i2c_hid i2c-DLL06E4:01: failed to change power setting.
> [  227.300048] dpm_run_callback(): i2c_hid_resume+0x0/0xf0 [i2c_hid] returns -61
> [  227.300057] PM: Device i2c-DLL06E4:01 failed to resume async: error -61
> 
> and the touchpad does not work from this point forward.

Thanks for the testing!
