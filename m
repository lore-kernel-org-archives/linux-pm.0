From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable direct_complete for ACPI devices
Date: Thu, 24 Aug 2017 23:50:40 +0200
Message-ID: <6003495.864qntojfu@aspire.rjw.lan>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFrj6RdsG4Qf847OvLQMgqHeyh1=YyeKZMeaGgQ2du3cNA@mail.gmail.com> <12333551.k204JYSgao@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <12333551.k204JYSgao@aspire.rjw.lan>
Sender: linux-i2c-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, August 24, 2017 6:35:49 PM CEST Rafael J. Wysocki wrote:
> On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:

[cut]

> [BTW, it is not entirely clear to me why it ever is necessary to runtime resume
> a device with direct_complete set after __device_suspend(), because it can only
> have direct_complete set at that point if all of the hierarchy below it has
> this flag set too and so runtime PM has to be disabled for all of those
> devices as well.]

Which makes me realize that we should take a step back and look at what
problems there are.

First, there are devices (I know about two examples so far and both are PCI)
that may need to be runtime resumed during system suspend for reasons other
than the ones checked by the ACPI PM domain (or the PCI bus type).  There needs
to be a way to indicate that from the driver side.

However, it still may be valuable to check the power-related conditions for
leaving the device in runtime suspend over system suspend/resume in case
it actually doesn't need to be runtime resumed during system suspend after
all.  That's what the majority of my patch was about.

The second problem is that the ACPI PM domain (and the PCI bus type)
runtime resumes all devices unconditionally in its ->suspend callback,
even though that may not be necessary for some devices.  Therefore there
needs to be a way to indicate that too.  That still would be good to
have *regardless* of the direct_complete mechanism, because the direct_complete
flag may not be set very often due to dependencies and then the
resume-during-suspend will take place unnecessarily.

Accordingly, it looks like we need a "no need to resume me" flag in the first
place.  That would indicate to interested pieces of code that, from the
driver perspective, the device doesn't need to be runtime resumed before
invoking its system suspend callbacks.  This should be clear enough to everyone
IMO.

[Note that if that flag is set for all devices, we may drop it along with
direct_complete, but before that happens both are needed.]

To address the first issue I would add something like the flag in the patches
I sent (but without the ACPI PM domain part which should be covered by the
"no need to resume me" flag above), because that allows the device's ->suspend
callback to run in principle and the driver may use that callback even to
runtime resume the device if that's what it wants to do.  So something like
"run my ->suspend callback even though I might stay in runtime suspend".

I would probably add driver_flags to dev_pm_info for that to set at the probe
time (and I would make the core clear that on driver removal).

The complexity concern is there, but honestly I don't see a better way at
this point.

Thanks,
Rafael
