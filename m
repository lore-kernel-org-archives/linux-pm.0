From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 6/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Thu, 22 Jun 2017 16:38:03 +0200
Message-ID: <4327771.heNtWYIbhO@aspire.rjw.lan>
References: <1498072888-14782-1-git-send-email-ulf.hansson@linaro.org> <CAJZ5v0h71LNPgmU1ri3S0VJMPb-1_AHkGksNAaYn68rrLyAR2A@mail.gmail.com> <CAPDyKFqW+QhzMhVgdp9-7t0eP0ePdV8pHqysQZU1OWT3A8Q56Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqW+QhzMhVgdp9-7t0eP0ePdV8pHqysQZU1OWT3A8Q56Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 22, 2017 11:35:35 AM Ulf Hansson wrote:
> On 21 June 2017 at 23:42, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Wed, Jun 21, 2017 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> In some cases a driver for an ACPI device needs to be able to prevent the
> >> ACPI PM domain from using the direct_complete path during system sleep.
> >>
> >> One typical case is when the driver for the device needs its device to stay
> >> runtime enabled, during the __device_suspend phase. This isn't the case
> >> when the direct_complete path is being executed by the PM core, as it then
> >> disables runtime PM for the device in __device_suspend(). Any following
> >> attempts to runtime resume the device after that point, just fails.
> >>
> >> A workaround to this problem is to let the driver runtime resume its device
> >> from its ->prepare() callback, as that would prevent the direct_complete
> >> path from being executed. However, that may often be a waste, especially if
> >> it turned out that no one really needed the device.
> >>
> >> For this reason, invent acpi_dev_disable|enable_direct_complete(), to allow
> >> drivers to inform the ACPI PM domain to change its default behaviour during
> >> system sleep, and thus control whether it may use the direct_complete path
> >> or not.
> >>
> >> Typically a driver should call acpi_dev_disable_direct_comlete() during
> >> ->probe() and acpi_dev_enable_direct_complete() in ->remove().
> >>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >> ---
> >>  drivers/acpi/device_pm.c | 37 ++++++++++++++++++++++++++++++++++++-
> >>  include/acpi/acpi_bus.h  |  1 +
> >>  include/linux/acpi.h     |  4 ++++
> >>  3 files changed, 41 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> >> index ee51e75..2393a1a 100644
> >> --- a/drivers/acpi/device_pm.c
> >> +++ b/drivers/acpi/device_pm.c
> >> @@ -879,6 +879,41 @@ EXPORT_SYMBOL_GPL(acpi_subsys_runtime_resume);
> >>
> >>  #ifdef CONFIG_PM_SLEEP
> >>  /**
> >> + * acpi_dev_disable_direct_complete - Disable the direct_complete path for ACPI.
> >> + * @dev: Device to disable the path for.
> >> + *
> >> + * Per default the ACPI PM domain tries to use the direct_complete path for its
> >> + * devices during system sleep. This function allows a user, typically a driver
> >> + * during probe, to disable the direct_complete path from being used by ACPI.
> >> + */
> >> +void acpi_dev_disable_direct_complete(struct device *dev)
> >> +{
> >> +       struct acpi_device *adev = ACPI_COMPANION(dev);
> >> +
> >> +       if (adev)
> >> +               adev->no_direct_complete = true;
> >
> > We have an analogous flag in PCI now and it is called needs_resume, so
> > it would be good to be consistent with that.
> 
> I was trying to come up with a nice name, however I couldn't find
> anything better than no_direct_complete.
> 
> However as the next patch somewhat, extends the flag to also be use
> for the runtime PM centric path, I should perhaps choose something
> more related to that?
> 
> I think make "needs_resume" is going to e bit confusing, especially
> while extending the usage for the flag it in the next patch, no?

OK, fair enough, but I still think the name isn't really nice. :-)

In fact, I'm not sure if the new flag is necessary at all.

If the driver is expected to use pm_runtime_force_suspend|resume() along with
it every time, why not to make the ACPI PM domain code check if the driver's
callback pointers point to pm_runtime_force_suspend|resume() and work
accordingly?

Thanks,
Rafael

