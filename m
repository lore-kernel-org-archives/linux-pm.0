From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 2 Jan 2018 11:51:05 +0100
Message-ID: <20180102105105.GA15376@wunner.de>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:52003 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbeABKvH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 05:51:07 -0500
Content-Disposition: inline
In-Reply-To: <4069324.Q7yJt6I4hJ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Tue, Jan 02, 2018 at 01:56:28AM +0100, Rafael J. Wysocki wrote:
> +	if (atomic_read(&dev->power.usage_count) <= 1 &&
> +	    atomic_read(&dev->power.child_count) == 0)
> +		pm_runtime_set_suspended(dev);
>  
> -	pm_runtime_set_suspended(dev);

The ->runtime_suspend callback *has* been executed at this point.
If the status is only updated conditionally, it may not reflect
the device's actual power state correctly.  That doesn't seem to
be a good idea.

The kerneldoc says:

    Typically this function may be invoked from a system suspend callback
    to make sure the device is put into low power state.

That portion is not modified by your patch.

"Typically" implies that it's legal to call pm_runtime_force_suspend() in
*other* contexts than as a ->suspend hook.

Let's say pm_runtime_force_suspend() is invoked at runtime, outside of
a system sleep transition.  Due to updating the power state only
conditionally, users will see an incorrect power state in sysfs.

The reason I'm speaking up here or taking an interest in the
pm_runtime_force_*() functions is that I would like to use them
for manual power control in vga_switcheroo, the kernel subsystem
for switchable Laptop graphics.  It currently supports two modes of
operation for each GPU, automatic power control (autosuspend via
runtime PM) or manual power control (by echoing ON and OFF to a
debugfs file).

Manual power control is currently a mess because it switches the GPU
off behind the PM core's back, causing all sorts of issues during a
system sleep transition.

Potentially pm_runtime_force_*() could be used as a clean way to
reimplement manual power control because it wouldn't happen behind
the PM core's back.  However your patch seems to break this potential
use case because:

a) the device's power state may not be reflected correctly because
   it's only updated conditionally (see above),

b) pm_runtime_force_resume(), despite its name, is no longer guaranteed
   to force the device on (it now allows the device to continue
   slumbering).

One addition that would be really helpful:  pm_runtime_force_suspend()
should also force-suspend all children and consumers of the given
device.  Likewise, those should be resumed on pm_runtime_force_resume().
Then I could just add a device link from the audio PCI device on the GPU
to the graphics PCI device and just call pm_runtime_force_*() on the
graphics device (supplier) to magically power them both off and on.

Thanks,

Lukas
