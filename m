From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] i2c: designware: Do nothing in system suspend/resume when
 RT suspended
Date: Tue, 25 Apr 2017 11:24:24 +0200
Message-ID: <CAPDyKFqfDYg1ZzcJ2Z7md5CD6tYWRMwi4N8M82DesG_ybVKHMw@mail.gmail.com>
References: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35586 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758282AbdDYJYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 05:24:31 -0400
Received: by mail-qk0-f177.google.com with SMTP id f76so59169259qke.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 02:24:30 -0700 (PDT)
In-Reply-To: <20170330120444.12499-1-jarkko.nikula@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, John Stultz <john.stultz@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On 30 March 2017 at 14:04, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
> There is possibility to enter dw_i2c_plat_suspend() callback twice
> during system suspend under certain cases which is causing here warnings
> from clk_core_disable() and clk_core_unprepare() as well as accessing the
> registers that can be power gated.
>
> Commit 8503ff166504 ("i2c: designware: Avoid unnecessary resuming during
> system suspend") implemented a prepare callback that checks for runtime
> suspended device which allow PM core to set direct_complete flag and
> skip system suspend and resume callbacks.
>
> However it can still happen if nothing resumes the device prior system
> syspend (e.g. acpi_subsys_suspend()) and there is a slave device which
> unsets the direct_complete flag of the parent in __device_suspend() thus
> causing PM code to not skip the system suspend/resume callbacks.
>
> Avoid this by checking runtime status in suspend and resume callbacks
> and return directly if device is runtime suspended. This affects only
> system suspend/resume since during runtime suspend/resume runtime status
> is suspending (not suspended) or resuming.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I'm able to trigger system suspend callback while device is runtime
> suspended by removing the pm_runtime_resume() call from
> drivers/mfd/intel-lpss.c: resume_lpss_device() and having unbound I2C
> slave (ACPI enumerated but doesn't bind due an error in probe function).
> In that case __device_suspend() for that unbound device has NULL suspend
> callback, and thus doesn't cause any runtime resume chain but still unsets
> the parent's direct_complete flag.
> John Stult <john.stultz@linaro.org> has reported he can trigger this on
> HiKey board too.
>
> I'm not sure is this the right thing to do. It feels something the PM core
> should do but I'm not sure that either. One alternative could be to resume
> runtime suspended parent in in __device_suspend() right after where
> parent's direct_complete flag is unset.
> ---
>  drivers/i2c/busses/i2c-designware-platdrv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index a597ba32de7e..42a9cd09aa64 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -377,6 +377,9 @@ static int dw_i2c_plat_suspend(struct device *dev)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>
> +       if (pm_runtime_suspended(dev))
> +               return 0;

This looks weird. I don't find any other drivers that needs this, what
is so different with this one?

> +
>         i2c_dw_disable(i_dev);
>         i2c_dw_plat_prepare_clk(i_dev, false);
>
> @@ -388,6 +391,9 @@ static int dw_i2c_plat_resume(struct device *dev)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct dw_i2c_dev *i_dev = platform_get_drvdata(pdev);
>
> +       if (pm_runtime_suspended(dev))
> +               return 0;
> +

Ditto.

>         i2c_dw_plat_prepare_clk(i_dev, true);
>         i2c_dw_init(i_dev);
>
> --
> 2.11.0
>

I have been following the development for the i2c-designware driver
for a while. Some time back I also tried to fix the similar problems
as you are currently [1] are. Back then, I picked the same approach as
John Stultz did recently [2].

To summarize my view, I don't understand the justification of using
the direct_complete feature for i2c-designware. To me, it just add
complexity to the driver that we really should try to avoid. I think
we need something else here.

To me, the proper solution is to use the
pm_runtime_force_suspend|resume() helpers to deal with system
suspend/resume. However I understand that the behavior of the ACPI PM
domain currently prevents us from doing this. That said, perhaps we
should instead try to make the ACPI PM domain to better collaborate
with drivers using pm_runtime_force_suspend|resume()? I have been
investigating that and started to cook some patches, although I have
not yet been able to post something. If you think it could make sense,
I can pick it up.

[1]
https://www.spinics.net/lists/arm-kernel/msg511277.html

[2]
https://patchwork.ozlabs.org/patch/745041/

Kind regards
Uffe
