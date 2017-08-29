From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep
 handling
Date: Tue, 29 Aug 2017 12:29:27 +0200
Message-ID: <20170829102927.5lpjkfj2jbtpxadm@sig21.net>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <4245176.X6JjkhnUAM@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4245176.X6JjkhnUAM@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tue, Aug 29, 2017 at 02:18:13AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, August 23, 2017 4:42:00 PM CEST Ulf Hansson wrote:
> > The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> > isn't well optimized for system sleep.
> > 
> > What makes this driver particularly interesting is because it's a cross-SoC
> > driver, which sometimes means there is an ACPI PM domain attached to the i2c
> > device and sometimes not. The driver is being used on both x86 and ARM.
...
> Basically, the point is to allow i2c-designware-platdrv to point its late
> suspend and early resume callbacks, respectively, to pm_runtime_force_suspend()
> and pm_runtime_force_resume() which then will do the right thing regardless of
> whether or not the device is runtime suspended when system suspend starts.

I'd like to point out a comment added by Hans de Goede in
https://bugzilla.kernel.org/show_bug.cgi?id=193891#c99

  The D0 / D3 methods of some devices use ACPI OpRegions on the PMIC which is
  attached to I2C7, these methods get executed by acpi_dev_suspend_late /
  acpi_dev_resume_early. Since the i2c-designware driver uses regular suspend /
  resume callbacks it is already suspended at the time those calls happen,
  leading to a device-suspend error and the system not suspending at all.

It's the reason for the Cherrytrail I2C7 special treatment in
i2c-designware-platdrv.c and pm_disabled = true in i2c-designware-baytrail.c,
however pm_disabled seems to be a problem for S0ix support.
To solve it, i2c-designware-platdrv needs to suspend after all
devices using ACPI OpRegions for suspend.


Johannes
