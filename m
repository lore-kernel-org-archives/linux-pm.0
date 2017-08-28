From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 5/9] PM / ACPI: Provide option to disable
 direct_complete for ACPI devices
Date: Mon, 28 Aug 2017 10:31:44 +0200
Message-ID: <CAPDyKFrRW3BLetxGW=89_Ksoxn4GW_7ebcADT1pyUrAT4ySpjA@mail.gmail.com>
References: <1503499329-28834-1-git-send-email-ulf.hansson@linaro.org>
 <6003495.864qntojfu@aspire.rjw.lan> <2333939.YcVPemMPxH@aspire.rjw.lan> <35832703.Y3V01Ybc1Y@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <35832703.Y3V01Ybc1Y@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-i2c <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 28 August 2017 at 03:30, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Friday, August 25, 2017 3:42:35 PM CEST Rafael J. Wysocki wrote:
>> On Thursday, August 24, 2017 11:50:40 PM CEST Rafael J. Wysocki wrote:
>> > On Thursday, August 24, 2017 6:35:49 PM CEST Rafael J. Wysocki wrote:
>> > > On Thursday, August 24, 2017 11:15:26 AM CEST Ulf Hansson wrote:
>> >
>> > [cut]
>> >
>> > > [BTW, it is not entirely clear to me why it ever is necessary to runtime resume
>> > > a device with direct_complete set after __device_suspend(), because it can only
>> > > have direct_complete set at that point if all of the hierarchy below it has
>> > > this flag set too and so runtime PM has to be disabled for all of those
>> > > devices as well.]
>> >
>> > Which makes me realize that we should take a step back and look at what
>> > problems there are.
>> >
>> > First, there are devices (I know about two examples so far and both are PCI)
>> > that may need to be runtime resumed during system suspend for reasons other
>> > than the ones checked by the ACPI PM domain (or the PCI bus type).  There needs
>> > to be a way to indicate that from the driver side.
>> >
>> > However, it still may be valuable to check the power-related conditions for
>> > leaving the device in runtime suspend over system suspend/resume in case
>> > it actually doesn't need to be runtime resumed during system suspend after
>> > all.  That's what the majority of my patch was about.
>> >
>> > The second problem is that the ACPI PM domain (and the PCI bus type)
>> > runtime resumes all devices unconditionally in its ->suspend callback,
>> > even though that may not be necessary for some devices.  Therefore there
>> > needs to be a way to indicate that too.  That still would be good to
>> > have *regardless* of the direct_complete mechanism, because the direct_complete
>> > flag may not be set very often due to dependencies and then the
>> > resume-during-suspend will take place unnecessarily.
>> >
>> > Accordingly, it looks like we need a "no need to resume me" flag in the first
>> > place.  That would indicate to interested pieces of code that, from the
>> > driver perspective, the device doesn't need to be runtime resumed before
>> > invoking its system suspend callbacks.  This should be clear enough to everyone
>> > IMO.
>> >
>> > [Note that if that flag is set for all devices, we may drop it along with
>> > direct_complete, but before that happens both are needed.]
>>
>> I think we are in agreement that direct_complete will not be necessary any
>> more when all drivers/bus types/PM domains and so on can do the "safe
>> suspend", but we're not there yet. :-)
>>
>> > To address the first issue I would add something like the flag in the patches
>> > I sent (but without the ACPI PM domain part which should be covered by the
>> > "no need to resume me" flag above), because that allows the device's ->suspend
>> > callback to run in principle and the driver may use that callback even to
>> > runtime resume the device if that's what it wants to do.  So something like
>> > "run my ->suspend callback even though I might stay in runtime suspend".
>> >
>> > I would probably add driver_flags to dev_pm_info for that to set at the probe
>> > time (and I would make the core clear that on driver removal).
>> >
>> > The complexity concern is there, but honestly I don't see a better way at
>> > this point.
>>
>> So below is a prototype patch.  It still is missing a documentation update, but
>> other than that it should be complete unless I missed something.
>>
>> The way it works is that the SAFE_SUSPEND flag is not looked at by the core
>> at all.  The ACPI PM domain looks at it and the PCI bus type can be modified
>> to take it into account in the future.  That is what causes the "runtime resume
>> during system suspend" to be skipped.
>>
>> In turn, the ALWAYS_SUSPEND flag is only looked at by the core and it causes
>> the decision on whether or not to use direct_complete to be deferred to the
>> __device_suspend_late() time.  If you set it for a PCI device, the effect is
>> equivalent to "no direct_complete".  If you set it for a device in the ACPI
>> PM domain, that depends on whether or not SAFE_SUSPEND is set.  If it isn't
>> set, the effect is equivalent to "no direct_complete" too, but if it is set,
>> the core may still try to use direct_complete for the device, but it will
>> make the decision on it in __device_suspend_late() and then it will not invoke
>> the ->suspend_late callback for the device if it is still runtime suspended.
>> [Note that you cannot runtime resume and runtime suspend again a device during
>> system suspend, so if it is runtime suspended in __device_suspend_late(), it
>> has been runtime suspend all the way since device_prepare().]
>>
>> So say you point the ->suspend_late and ->resume_early callbacks of
>> the designware i2c driver to pm_runtime_force_suspend() and
>> pm_runtime_force_resume(), respectively, and set both the SAFE_SUSPEND
>> and ALWAYS_SUSPEND flags for the device.
>>
>> If system suspend is started and the device is not runtime suspended,
>> direct_complete is not set for it and everything works as usual, so say
>> the device is runtime suspended in device_prepare().  Then, the ACPI PM
>> domain checks the other conditions for leaving it in runtime suspend and
>> returns either 0 or a positive number from acpi_subsys_prepare().
>>
>> If 0 is returned, direct_complete is not set by the core and
>> acpi_subsys_suspend() is called.  It checks the SAFE_SUSPEND flag and sees
>> that the device need not be runtime resumed, so it invokes the driver's
>> ->suspend callback (which is not present, so it doesn't do anything).
>> Next, in __device_suspend_late(), acpi_subsys_suspend_late() is invoked
>> and it calls pm_runtime_force_suspend(), which executes the driver's
>> ->runtime_suspend() callback, and then (if successful) calls
>> acpi_dev_suspend_late() to put the device into a low-power state.  The
>> resume path is a reverse of the above in this case.  So far, so good.
>
> Well, not really, because if the device remains runtime suspended,
> ->runtime_suspend() will not be called by pm_runtime_force_suspend() and
> acpi_dev_suspend_late() should not be called then.
>
> So more changes in the ACPI PM domain are needed after all.

Yes, that's what I thought as well.

Anyway, let me cook a new version of the series - trying to address
the first bits you have pointed out. Then we can continue with
fine-tuning on top, addressing further optimizations of the ACPI PM
domain.

Kind regards
Uffe
