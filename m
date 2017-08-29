From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep handling
Date: Tue, 29 Aug 2017 18:44:02 +0200
Message-ID: <5440066.jm2MzmQIeF@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <1512684.bFXWtdU0Ox@aspire.rjw.lan> <CAPDyKFq-XDYE0xr2qONwO7_w8_jHfv5=iCwx4QdH7OHWqJ1e-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq-XDYE0xr2qONwO7_w8_jHfv5=iCwx4QdH7OHWqJ1e-Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johannes Stezenbach <js@sig21.net>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.>
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 29, 2017 5:05:20 PM CEST Ulf Hansson wrote:
> On 29 August 2017 at 16:43, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, August 29, 2017 1:44:11 PM CEST Ulf Hansson wrote:
> >> On 29 August 2017 at 12:29, Johannes Stezenbach <js@sig21.net> wrote:
> >> > Hi,
> >> >
> >> > On Tue, Aug 29, 2017 at 02:18:13AM +0200, Rafael J. Wysocki wrote:
> >> >> On Wednesday, August 23, 2017 4:42:00 PM CEST Ulf Hansson wrote:
> >> >> > The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> >> >> > isn't well optimized for system sleep.
> >> >> >
> >> >> > What makes this driver particularly interesting is because it's a cross-SoC
> >> >> > driver, which sometimes means there is an ACPI PM domain attached to the i2c
> >> >> > device and sometimes not. The driver is being used on both x86 and ARM.
> >> > ...
> >> >> Basically, the point is to allow i2c-designware-platdrv to point its late
> >> >> suspend and early resume callbacks, respectively, to pm_runtime_force_suspend()
> >> >> and pm_runtime_force_resume() which then will do the right thing regardless of
> >> >> whether or not the device is runtime suspended when system suspend starts.
> >> >
> >> > I'd like to point out a comment added by Hans de Goede in
> >> > https://bugzilla.kernel.org/show_bug.cgi?id=193891#c99
> >> >
> >> >   The D0 / D3 methods of some devices use ACPI OpRegions on the PMIC which is
> >> >   attached to I2C7, these methods get executed by acpi_dev_suspend_late /
> >> >   acpi_dev_resume_early. Since the i2c-designware driver uses regular suspend /
> >> >   resume callbacks it is already suspended at the time those calls happen,
> >> >   leading to a device-suspend error and the system not suspending at all.
> >>
> >> Yes, that's why I moved those operation to be managed at the
> >> ->suspend_late() in my series, and at the same time prevent the
> >> direct_complete patch from executed for this device.
> >>
> >> >
> >> > It's the reason for the Cherrytrail I2C7 special treatment in
> >> > i2c-designware-platdrv.c and pm_disabled = true in i2c-designware-baytrail.c,
> >> > however pm_disabled seems to be a problem for S0ix support.
> >> > To solve it, i2c-designware-platdrv needs to suspend after all
> >> > devices using ACPI OpRegions for suspend.
> >> >
> >> >
> >> > Johannes
> >>
> >> Did you try out my series (v2) if that could fix this problem in a
> >> more flexible manner?
> >>
> >> In other words, is it fine if the device remains runtime PM enabled
> >> during the entire device_suspend() phase, and also not being suspended
> >> until ->suspend_late()?
> >
> > Ulf, please, this is a *different* problem.
> 
> Yes, it is!
> 
> Just wanted to point out that if the device remains runtime PM enabled
> the entire device_suspend() phase, that *could* solve the problem.
> 
> >
> > Can we focus on one problem at a time?
> 
> Yes!
> 
> However, there is lots of things following when we try to enable the
> runtime PM centric path for ACPI. :-)

Which, I guess, we won't do after all ...

So I would prefer to think about addressing problems instead of trying to
"enable the runtime PM centric path for ACPI" just for the sake of it.

Thanks,
Rafael

