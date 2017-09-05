From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [RFT][PATCH v2 2/2] PM / i2c: designware: Clean up system sleep
 handling without ACPI
Date: Tue, 5 Sep 2017 18:41:47 +0300
Message-ID: <20170905154147.GC2477@lahna.fi.intel.com>
References: <3023226.l5IfJK6GIc@aspire.rjw.lan>
 <1524365.Uf1AH187pl@aspire.rjw.lan>
 <20170905150744.GA2477@lahna.fi.intel.com>
 <3495106.6fP2YzlEUn@aspire.rjw.lan>
 <20170905152458.GB2477@lahna.fi.intel.com>
 <CAJZ5v0hXQEoULXuexn53jqo+ANB+gbtWDAL32wfvcwfh2Hm_VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hXQEoULXuexn53jqo+ANB+gbtWDAL32wfvcwfh2Hm_VA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 05, 2017 at 05:32:07PM +0200, Rafael J. Wysocki wrote:
> On Tue, Sep 5, 2017 at 5:24 PM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Tue, Sep 05, 2017 at 05:04:21PM +0200, Rafael J. Wysocki wrote:
> >> On Tuesday, September 5, 2017 5:07:44 PM CEST Mika Westerberg wrote:
> >> > On Tue, Sep 05, 2017 at 04:55:44PM +0200, Rafael J. Wysocki wrote:
> >> > > On Tuesday, September 5, 2017 4:58:35 PM CEST Mika Westerberg wrote:
> >> > > > On Tue, Sep 05, 2017 at 04:46:11PM +0200, Rafael J. Wysocki wrote:
> >> > > > > On Tuesday, September 5, 2017 4:45:11 PM CEST Mika Westerberg wrote:
> >> > > > > > On Mon, Sep 04, 2017 at 12:01:54PM +0200, Rafael J. Wysocki wrote:
> >> > > > > > >  static const struct dev_pm_ops dw_i2c_dev_pm_ops = {
> >> > > > > > > - .prepare = dw_i2c_plat_prepare,
> >> > > > > > > - .complete = dw_i2c_plat_complete,
> >> > > > > > > - SET_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> >> > > > > > > - SET_RUNTIME_PM_OPS(dw_i2c_plat_runtime_suspend,
> >> > > > > > > -                    dw_i2c_plat_resume,
> >> > > > > > > -                    NULL)
> >> > > > > > > + SET_LATE_SYSTEM_SLEEP_PM_OPS(dw_i2c_plat_suspend, dw_i2c_plat_resume)
> >> > > > > >
> >> > > > > > This seems to cause problem with intel-lpss MFD driver because it uses
> >> > > > > > .suspend() and .resume() instead of .suspend_late() and .resume_early().
> >> > > > >
> >> > > > > OK, so there is one more dependency here.
> >> > > > >
> >> > > > > Can you please point me to this code?
> >> > > >
> >> > > > It is in drivers/mfd/intel-lpss.c. See intel_lpss_resume().
> >> > > >
> >> > >
> >> > > Looking at it, but I don't quite see how this is related to the
> >> > > i2c-designware-platedv suspend/resume ...
> >> >
> >> > intel-lpss is the parent device for i2c-designware-platdrv. It is
> >> > supposed to handle all LPSS specific stuff, like bringing the PCI device
> >> > out of reset before the i2c-designware-platdrv does its own resume
> >> > things.
> >>
> >> Yes, I see.
> >>
> >> OK, so what about moving its suspend/resume to the late/early stages?
> >>
> >> Would the parent of it be confused?
> >
> > It seems to work. I did following change and now suspend/resume works
> > fine with your patch series.
> 
> OK, thanks!
> 
> > diff --git a/drivers/mfd/intel-lpss.h b/drivers/mfd/intel-lpss.h
> > index 694116630ffa..c987f7fe6c74 100644
> > --- a/drivers/mfd/intel-lpss.h
> > +++ b/drivers/mfd/intel-lpss.h
> > @@ -38,8 +38,8 @@ int intel_lpss_resume(struct device *dev);
> >  #ifdef CONFIG_PM_SLEEP
> >  #define INTEL_LPSS_SLEEP_PM_OPS                        \
> >         .prepare = intel_lpss_prepare,          \
> > -       .suspend = intel_lpss_suspend,          \
> > -       .resume = intel_lpss_resume,            \
> > +       .suspend_late = intel_lpss_suspend,     \
> > +       .resume_early = intel_lpss_resume,      \
> >         .freeze = intel_lpss_suspend,           \
> >         .thaw = intel_lpss_resume,              \
> >         .poweroff = intel_lpss_suspend,         \
> 
> Of course, freeze/thaw, poweroff/restore need to be moved to the
> late/early stages too.

Right.

> I'll add this patch to the series and resend, then.

Thanks!

> BTW, is the parent of intel-lpss in this case a PCI device or
> something else?

It is the PCI host bridge:

00:00.0 Host bridge: Intel Corporation Skylake Host Bridge/DRAM Registers (rev 07)
00:01.0 PCI bridge: Intel Corporation Skylake PCIe Controller (x16) (rev 07)
00:02.0 VGA compatible controller: Intel Corporation HD Graphics 530 (rev 06)
00:04.0 Signal processing controller: Intel Corporation Skylake Processor Thermal Subsystem (rev 07)
00:14.0 USB controller: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller (rev 31)
00:14.2 Signal processing controller: Intel Corporation Sunrise Point-H Thermal subsystem (rev 31)

The following are the two LPSS I2C devices where intel-lpss binds to:

00:15.0 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #0 (rev 31)
00:15.1 Signal processing controller: Intel Corporation Sunrise Point-H Serial IO I2C Controller #1 (rev 31)
