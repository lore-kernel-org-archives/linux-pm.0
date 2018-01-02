From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 2 Jan 2018 12:02:18 +0100
Message-ID: <CAJZ5v0hYaEWPhqEuBkj7yusQiY1wfeJAn7QDfp-gmOYyNXatEg@mail.gmail.com>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan> <20180102105105.GA15376@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180102105105.GA15376@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 2, 2018 at 11:51 AM, Lukas Wunner <lukas@wunner.de> wrote:
> On Tue, Jan 02, 2018 at 01:56:28AM +0100, Rafael J. Wysocki wrote:
>> +     if (atomic_read(&dev->power.usage_count) <= 1 &&
>> +         atomic_read(&dev->power.child_count) == 0)
>> +             pm_runtime_set_suspended(dev);
>>
>> -     pm_runtime_set_suspended(dev);
>
> The ->runtime_suspend callback *has* been executed at this point.
> If the status is only updated conditionally, it may not reflect
> the device's actual power state correctly.  That doesn't seem to
> be a good idea.

It doesn't matter, because this is done with runtime PM disabled, isn't it?

So what matters is the status after the subsequent
pm_runtime_force_resume() returns, and that should reflect the actual
state of the device correctly.  Doesn't it?

> The kerneldoc says:
>
>     Typically this function may be invoked from a system suspend callback
>     to make sure the device is put into low power state.
>
> That portion is not modified by your patch.
>
> "Typically" implies that it's legal to call pm_runtime_force_suspend() in
> *other* contexts than as a ->suspend hook.

It should only be used during system suspend anyway, however.

> Let's say pm_runtime_force_suspend() is invoked at runtime, outside of
> a system sleep transition.

That will disable runtime PM for you until you call
pm_runtime_force_resume() for the device.

> Due to updating the power state only
> conditionally, users will see an incorrect power state in sysfs.

But that's with runtime PM disabled, so it doesn't matter.

> The reason I'm speaking up here or taking an interest in the
> pm_runtime_force_*() functions is that I would like to use them
> for manual power control in vga_switcheroo, the kernel subsystem
> for switchable Laptop graphics.  It currently supports two modes of
> operation for each GPU, automatic power control (autosuspend via
> runtime PM) or manual power control (by echoing ON and OFF to a
> debugfs file).
>
> Manual power control is currently a mess because it switches the GPU
> off behind the PM core's back, causing all sorts of issues during a
> system sleep transition.
>
> Potentially pm_runtime_force_*() could be used as a clean way to
> reimplement manual power control because it wouldn't happen behind
> the PM core's back.  However your patch seems to break this potential
> use case because:

No, it doesn't break anything.

It actually doesn't even change anything for real except for dropping
some manipulations of the device's parent usage counter.

> a) the device's power state may not be reflected correctly because
>    it's only updated conditionally (see above),
>
> b) pm_runtime_force_resume(), despite its name, is no longer guaranteed
>    to force the device on (it now allows the device to continue
>    slumbering).

It does that without the patch too.  The name is just confusing. :-)

> One addition that would be really helpful:  pm_runtime_force_suspend()
> should also force-suspend all children and consumers of the given
> device.  Likewise, those should be resumed on pm_runtime_force_resume().
> Then I could just add a device link from the audio PCI device on the GPU
> to the graphics PCI device and just call pm_runtime_force_*() on the
> graphics device (supplier) to magically power them both off and on.

Actually, the assumption is that pm_runtime_force_suspend() must be
called for the children before it is called for the parent even
without my patch, so it is just not going to work this way.

Thanks,
Rafael
