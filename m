From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 6/8] PM / ACPI: Enable the runtime PM centric approach for system sleep
Date: Wed, 06 Sep 2017 02:02:41 +0200
Message-ID: <28965959.lSjY1gHxkl@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <2209426.5Z3u1iKN4i@aspire.rjw.lan> <CAPDyKFoTz3fFJwpJgmmwLfHQTzmWpyZL+NcVPY8D254nR2Mzag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58241 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753614AbdIFALb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Sep 2017 20:11:31 -0400
In-Reply-To: <CAPDyKFoTz3fFJwpJgmmwLfHQTzmWpyZL+NcVPY8D254nR2Mzag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Monday, September 4, 2017 3:21:15 PM CEST Ulf Hansson wrote:
> On 2 September 2017 at 17:38, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Friday, September 1, 2017 10:27:05 AM CEST Ulf Hansson wrote:
> >> On 29 August 2017 at 17:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Tuesday, August 29, 2017 4:56:48 PM CEST Ulf Hansson wrote:
> >> >> This change enables the ACPI PM domain to cope with drivers that deploys
> >> >> the runtime PM centric path for system sleep.
> >> >
> >> > [cut]
> >> >
> >> >> @@ -1052,11 +1066,20 @@ EXPORT_SYMBOL_GPL(acpi_subsys_complete);
> >> >>   * @dev: Device to handle.
> >> >>   *
> >> >>   * Follow PCI and resume devices suspended at run time before running their
> >> >> - * system suspend callbacks.
> >> >> + * system suspend callbacks. However, try to avoid it in case the runtime PM
> >> >> + * centric path is used for the device and then trust the driver to do the
> >> >> + * right thing.
> >> >>   */
> >> >>  int acpi_subsys_suspend(struct device *dev)
> >> >>  {
> >> >> -     pm_runtime_resume(dev);
> >> >> +     struct acpi_device *adev = ACPI_COMPANION(dev);
> >> >> +
> >> >> +     if (!adev)
> >> >> +             return 0;
> >> >> +
> >> >> +     if (!dev_pm_is_rpm_sleep(dev) || acpi_dev_needs_resume(dev, adev))
> >> >> +             pm_runtime_resume(dev);
> >> >> +
> >> >>       return pm_generic_suspend(dev);
> >> >>  }
> >> >>  EXPORT_SYMBOL_GPL(acpi_subsys_suspend);
> >> >
> >> > Well, I tried to avoid calling acpi_dev_needs_resume() for multiple times
> >> > and that's why I added the update_state thing.
> >> >
> >> > Moreover, the is_rpm_sleep flag here has to mean not only that
> >> > direct_complete should not be used with the device, but also that its driver
> >> > is fine with not resuming it.
> >>
> >> Let me try to explain this better. I realize the changelog is
> >> misleading around this particular section! Huh, apologize for that!
> >>
> >> First, patch1 makes the PM core treat the is_rpm_sleep flag as the
> >> direct_complete isn't allowed for the device.
> >>
> >> For that reason, when the is_rpm_sleep is set, there is no point
> >> calling acpi_dev_needs_resume() from acpi_subsys_prepare(), but
> >> instead that can be deferred to acpi_subsys_suspend() - because it
> >> doesn't matter if acpi_subsys_prepare() returns 0 or 1, in either case
> >> the acpi_subsys_suspend() will be called. That's really what goes on
> >> here.
> >>
> >> The end result is the same. If the acpi_dev_needs_resume() thinks that
> >> the device needs to be runtime resumed, pm_runtime_resume() is called
> >> for the device in acpi_subsys_suspend().
> >>
> >> So, this has nothing to do with whether the driver "is fine with not
> >> resuming it" thing.
> >
> > No, sorry.
> >
> > If is_rpm_sleep was not set, the ACPI PM domain would resume the device in
> > acpi_subsys_suspend() regardless of the acpi_dev_needs_resume() return value.
> 
> Yes, I believe I forgot about one scenario, when the direct_complete
> path has been abandoned by the PM core, because a child device was
> suspend before and it couldn't run the direct_complete path for it?
> 
> Just to be sure, that's the case you also had in mind?

Yes.

Thanks,
Rafael
