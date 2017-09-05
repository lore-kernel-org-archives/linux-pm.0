From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v2 2/2] PM / i2c: designware: Clean up system sleep handling without ACPI
Date: Tue, 05 Sep 2017 16:55:44 +0200
Message-ID: <1524365.Uf1AH187pl@aspire.rjw.lan>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan> <3930469.chvfik16I5@aspire.rjw.lan> <20170905145835.GZ2477@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20170905145835.GZ2477@lahna.fi.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 5, 2017 4:58:35 PM CEST Mika Westerberg wrote:
> On Tue, Sep 05, 2017 at 04:46:11PM +0200, Rafael J. Wysocki wrote:
> > On Tuesday, September 5, 2017 4:45:11 PM CEST Mika Westerberg wrote:
> > > On Mon, Sep 04, 2017 at 12:01:54PM +0200, Rafael J. Wysocki wrote:
> > > >  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> > > > -	.prepare = dw_i2c_plat_prepare,
> > > > -	.complete = dw_i2c_plat_complete,
> > > > -	SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> > > > -	SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> > > > -			   dw_i2c_plat_resume,
> > > > -			   NULL)
> > > > +	SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> > > 
> > > This seems to cause problem with intel-lpss MFD driver because it uses
> > > .suspend() and .resume() instead of .suspend_late() and .resume_early().
> > 
> > OK, so there is one more dependency here.
> > 
> > Can you please point me to this code?
> 
> It is in drivers/mfd/intel-lpss.c. See intel_lpss_resume().
> 

Looking at it, but I don't quite see how this is related to the
i2c-designware-platedv suspend/resume ...
