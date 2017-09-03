From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFT][PATCH v2 0/3] PM / ACPI / i2c: Runtime PM aware system sleep handling
Date: Mon, 04 Sep 2017 00:57:34 +0200
Message-ID: <1529572.3Syt3kfoAo@aspire.rjw.lan>
References: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1551534.5XKjjnxbAy@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-acpi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, August 30, 2017 2:00:27 AM CEST Rafael J. Wysocki wrote:
> Hi,
> 
> The point here is to avoid runtime resuming i2c designware devices during
> system suspend in the generic ACPI PM domain and the ACPI LPSS driver if
> that is not necessary.  The ordering issue between i2c designware and
> other devices relying on it for their PM is not addressed here (but it can
> be addressed on top of this to some extent).
> 
> For this to work, the ACPI PM domain and the LPSS driver (which also has to
> work with i2c-designware-platdrv) have to track the status of the device in
> order to handle it correctly regardless of whether or not the device is
> runtime-suspended when system suspend starts.
> 
> The primary problem with that is that acpi_subsys_suspend() has to decide
> whether or not to runtime resume the device and then
> acpi_subsys_suspend_late/resume_early() (and their counterparts in the ACPI
> LPSS driver) need to know whether or not to run acpi_dev_suspend_late/resume_early(), respectively.
> 
> In order to make that decision, acpi_subsys_suspend() needs to know (a) if
> the power state of the device has to be updated (in which case the device
> should be runtime resumed) and (b) if the driver's callbacks that will be
> run subsequently can cope with a runtime suspended device.  The former can
> be figured out from the check done in acpi_subsys_prepare() (the result of it
> needs to be saved), but the latter is only known to the driver, so it needs a
> way to tell the code above it about that.  Hence, the SAFE_SUSPEND flag
> introduced by the first patch.
> 
> The second patch simply reworks the ACPI PM domain and the ACPI LPSS driver
> to carry out all the checks etc as needed.
> 
> The third one finally updates i2c-designware-platdrv (details in the changelog).
> 
> The cases to consider are the following: i2c-designware-platdrv without ACPI
> (either the ACPI PM domain or the ACPI LPSS driver), i2c-designware-platdrv
> with the generic ACPI PM domain (direct_complete set or unset) and
> i2c-designware-platdrv with the ACPI LPSS driver (direct_complete set or unset).
> 
> First, for i2c-designware-platdrv without ACPI, the first two patches don't
> matter and the third one moves the callbacks to a later phase of suspend
> and an earlier phase of resume and drops ->prepare and ->complete.  The effect
> of dropping ->prepare is that it will not return 1 any more, so the core will
> never set power.direct_complete for this device.  The effect of the other
> change is that system suspend will always call dw_i2c_plat_suspend() after
> all invocations of dw_i2c_plat_resume() by runtime resume and system resume
> will always call the latter before any post-resume runtime PM operations.
> If the device is not runtime-suspended before system suspend, dw_i2c_plat_suspend()
> (executed as the ->suspend_late callback) will see the "suspended" flag unset
> and it will suspend the device.  Otherwise, it will see the "suspended" flag set
> and it will return early, but it will set "suspend_skipped".  During system resume,
> dw_i2c_plat_resume() will always see "suspended" set (it won't see "suspended"
> set when invoked as the runtime resume callback), but if it sees "suspend_skipped"
> set (which can only be set during system suspend), it will return early (it
> needs to clear "suspend_skipped" then in case it is invoked shortly as the
> runtime resume callback).  Otherwise, it will resume the device.
> 
> Next, consider i2c-designware-platdrv with the ACPI PM domain and say that the
> device is not runtime-suspended when system suspend is started.  In that case
> the core will not set power.direct_complete for the device and
> acpi_subsys_suspend() will run.  It will see that the device is not runtime-
> suspended, so it will only update power.update_state (the driver's ->suspend
> callback could be run too, but it is not present).  During late suspend,
> acpi_subsys_suspend_late() will be called.  It will run the driver's
> ->suspend_late callback (which will suspend the device, because it will see
> "suspended" unset) and because power.update_state is set,
> acpi_dev_suspend_late() will be called to change the power state and wakeup
> settings of the device.  During resume, acpi_subsys_resume_early() will
> see power.update_state set, so it will call acpi_dev_resume_early() to power-up
> the device and it will call the driver's ->resume_early (which will see
> "suspend_skipped" unset, so it will resume the device).
> 
> If the device is runtime-suspended when system suspend starts, there are a
> few possibilities.  If the device's power state doesn't need to be updated,
> the PM domain's ->prepare will return 1 and the core may or may not set
> power.direct_complete for the device.  If it is set, the callbacks will
> not be invoked and the PM domain's ->complete will queue up runtime resume
> of the device to update its power state.  If power.direct_complete is not set,
> acpi_subsys_suspend() will run again, but this time the device *is* runtime-
> suspended.  Then, as a rule, power.update_state will not be set and the
> function will return without doing anything (so far, so good).  Next, (unless
> the device is runtime resumed in the meantime) acpi_dev_suspend_late() will
> call the driver's ->suspend_late (which will see "suspended" set, so it will
> return early) and then it will return early because of power.update_state
> unset.  During resume, acpi_subsys_resume_early() will skip powering up
> the device and will call the driver's ->resume_early (which will see
> "suspend_skipped" set and will return early), so still OK.
> 
> If the device is runtime-suspended when system suspend starts, but its power
> settings need to be updated, the bus type's ->prepare will return 0 and
> power.direct_complete will not be set for the device, so acpi_subsys_suspend()
> will run.  However, this time it will see power.update_state set, so it will
> runtime resume the device.  From this point on, this case is analogous to the
> one when the device was not runtime-suspended to start with.
> 
> The "i2c-designware-platdrv with the ACPI LPSS driver" case should be analogous
> to the one with the generic ACPI PM domain if I haven't overlooked anything,
> so to my eyes it should work.
> 
> Please test if you can and let me know if anything breaks.

To on-going discussion with Ulf made me think that it would be better to
make the driver do the right thing when the ACPI PM domain is not present
and then worry about what to do when it is there.

So, please scratch this series and I will post an alternative one just for
i2c-designware-platdrv shortly.

Thanks,
Rafael

