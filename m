From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] PM / ACPI / i2c: Runtime PM aware system sleep handling
Date: Tue, 29 Aug 2017 02:18:13 +0200
Message-ID: <4245176.X6JjkhnUAM@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 23, 2017 4:42:00 PM CEST Ulf Hansson wrote:
> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> isn't well optimized for system sleep.
> 
> What makes this driver particularly interesting is because it's a cross-SoC
> driver, which sometimes means there is an ACPI PM domain attached to the i2c
> device and sometimes not. The driver is being used on both x86 and ARM.
> 
> In principle, to optimize the system sleep support in i2c driver, this series
> enables the proven runtime PM centric path for the i2c driver. However, to do
> that the ACPI PM domain also have to collaborate and understand this behaviour.
> Therefore a number of changes, patch 1 to patch 7, makes the needed changes to
> the ACPI PM domain. In patch8 and patch 9, the i2c driver gets optimized and is
> converted to the runtime PM centric path for system sleep.
> 
> It shall be noted, the behaviour of the ACPI PM domain should remain intact,
> still taking benefit of using the direct_complete path during system sleep,
> except for those drivers that explicitly request it not to (via a new ACPI API
> added in this series).

The following is my take on this (untested so far).

Basically, the point is to allow i2c-designware-platdrv to point its late
suspend and early resume callbacks, respectively, to pm_runtime_force_suspend()
and pm_runtime_force_resume() which then will do the right thing regardless of
whether or not the device is runtime suspended when system suspend starts.

However, for this to work, the ACPI PM domain (and the LPSS driver which also
has to work with i2c-designware-platdrv) must do the right thing regardless of
whether or not the device is runtime suspended when system suspend starts too.

The primary problem with that is that acpi_subsys_suspend() has to decide
whether or not to runtime resume the device and then
acpi_subsys_suspend_late/resume_early() (and their counterparts in the ACPI
LPSS driver) need to know whether or not to run acpi_dev_suspend_late/resume_early(), respectively.

In order to make that decision, acpi_subsys_suspend() needs to know (a) if
the power state of the device has to be updated (in which case the device
should be runtime resumed) and (b) if the driver's callbacks that will be
run subsequently can cope with a runtime suspended device.  The former can
be figured out from the check done in acpi_subsys_prepare() (but its result
needs to be saved), but the latter is only known to the driver, so it needs a
way to tell the code above it about that.  Hence, the SAFE_SUSPEND flag
introduced by the first patch.

The second patch simply reworks the ACPI PM domain and the ACPI LPSS driver
to do all the checks etc as needed.

The third one finally updates i2c-designware-platdrv.

Thanks,
Rafael

