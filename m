From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system
 suspend callbacks
Date: Wed, 20 Sep 2017 14:28:16 +0200
Message-ID: <CAPDyKFrPGA9OproyQHwVTY5EfAQJnLZuHL+cnJv+1fPYXLLW2w@mail.gmail.com>
References: <1849600.vI30ccvhCD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1849600.vI30ccvhCD@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 20 September 2017 at 02:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It quite often is necessary to resume devices from runtime suspend
> during system suspend for various reasons (for example, if their
> wakeup settings need to be changed), but that requires middle-layer
> or subsystem code to follow additional rules which currently are not
> clearly documented.
>
> Namely, if a driver calls pm_runtime_resume() for the device from
> its ->suspend (or equivalent) system sleep callback, that may not
> work if the middle layer above it has updated the state of the
> device from its ->prepare or ->suspend callbacks already in an
> incompatible way.  For this reason, all middle layers must follow
> the rule that, until the ->suspend callback provided by the device's
> driver is invoked, the only way in which the device's state can be
> updated is by calling pm_runtime_resume() for it, if necessary.
> Fortunately enough, all middle layers in the code base today follow
> this rule, but it is not explicitly stated anywhere, so do that.
>
> Note that calling pm_runtime_resume() from the ->suspend callback
> of a driver will cause the ->runtime_resume callback provided by the
> middle layer to be invoked, but the rule above guarantees that this
> callback will nest properly with the middle layer's ->suspend
> callback and it will play well with the ->prepare one invoked before.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Still, some comments below..

> ---
>
> This is a follow-up for the system suspend callbacks discussion during
> the Power Management and Energy-Awareness session at the LPC last week.
>
> In particular, I have been thinking about using pm_runtime_resume() from
> driver ->suspend callbacks and it actually appears to be quite defendable to
> me as long as it is guaranteed that middle layers will not mess up with the
> device state before the driver's ->suspend callback is invoked.  If that
> is the case, and I *think* that it currently is the case for all of the
> middle layers in the tree unless I overlook something (USB anyone?), the
> middle layer callbacks involved (->prepare, ->suspend and ->runtime_resume)
> should actually nest properly and there should not be problems with that.
> So, my proposal here would be to simply go ahead and document the rules
> regarding this case without modifying the code.
>
> At the same time, I see at least two general problems with calling
> pm_runtime_force_suspend() from the ->suspend callbacks of device drivers
> (unless the middle layers involved are trivial).
>
> First, note that the middle layer callbacks involved in that case are
> ->prepare, ->suspend, ->runtime_suspend (called indirectly from within the
> former) and then *also* ->suspend_late and ->suspend_noirq, because the PM
> core will call the last two from the middle layer as it has no information
> that pm_runtime_force_suspend() was called for the device in the "suspend"
> phase.  Of course, in general, what the middle layer ->suspend_late and
> ->suspend_noirq do is not guaranteed to play well with what its
> ->runtime_suspend does even if ->suspend itself is OK (but for ->runtime_resume
> all of that actually works, because the state it leaves the device in should
> be compatible with the system suspend callbacks invoked in the later phases).
>
> Second, leaving devices in runtime suspend in the "suspend" phase of system
> suspend is fishy even when their runtime PM is disabled, because that doesn't
> guarantee anything regarding their children or possible consumers.  Runtime
> PM may still be enabled for those devices at that time and runtime resume may
> be triggered for them later, in which case it all quickly falls apart.

This is true, although to me this is a about a different problem and
has very little to do with pm_runtime_force_suspend().

More precisely, whether runtime PM becomes disabled in the suspend
phase or suspend_late phase, really doesn't matter. Because in the end
this is about suspending/resuming devices in the correct order.

>
> IOW, there are reasons why the PM core bumps up the runtime PM usage counters
> of all devices during system suspend and they also apply to runtime suspend
> callbacks being invoked directly with runtime PM disabled for the given device.
> Frankly, it generally is only safe to leave a device in runtime suspend during
> system suspend if it can be guarateed that the system suspend callbacks in the
> subsequent suspend phases will not be invoked for it at all.

I understand this is perfectly true for some of the non-trivial middle
layers, however just to be clear, this statement don't have to serve
as a general rule for all cases, right?

Moreover, bumping the runtime PM usage count
(pm_runtime_get_noresume()) in the device_prepare/suspend() phase, was
originally added to prevent the runtime PM core from runtime
suspending a device, in cases when runtime PM has been enabled for it.
Preventing the ->runtime_suspend() callback from being invoked when
runtime PM is disabled, just doesn't make any sense to me.

>
> Thanks,
> Rafael
>
> ---
>  Documentation/driver-api/pm/devices.rst |   25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> Index: linux-pm/Documentation/driver-api/pm/devices.rst
> ===================================================================
> --- linux-pm.orig/Documentation/driver-api/pm/devices.rst
> +++ linux-pm/Documentation/driver-api/pm/devices.rst
> @@ -328,7 +328,10 @@ the phases are: ``prepare``, ``suspend``
>         After the ``->prepare`` callback method returns, no new children may be
>         registered below the device.  The method may also prepare the device or
>         driver in some way for the upcoming system power transition, but it
> -       should not put the device into a low-power state.
> +       should not put the device into a low-power state.  Moreover, if the
> +       device supports runtime power management, the ``->prepare`` callback
> +       method must not update its state in case it is necessary to resume it
> +       from runtime suspend later on.
>
>         For devices supporting runtime power management, the return value of the
>         prepare callback can be used to indicate to the PM core that it may
> @@ -356,6 +359,16 @@ the phases are: ``prepare``, ``suspend``
>         the appropriate low-power state, depending on the bus type the device is
>         on, and they may enable wakeup events.
>
> +       However, for devices supporting runtime power management, the
> +       ``->suspend`` methods provided by subsystems (bus types and PM domains
> +       in particular) must follow an additional rule regarding what can be done
> +       to the devices before their drivers' ``->suspend`` methods are called.
> +       Namely, they can only resume the devices from runtime suspend by
> +       calling :c:func:`pm_runtime_resume` for them, if that is necessary, and
> +       they must not update the state of the devices in any other way at that
> +       time (in case the drivers need to resume the devices from runtime
> +       suspend in their ``->suspend`` methods).
> +
>      3. For a number of devices it is convenient to split suspend into the
>         "quiesce device" and "save device state" phases, in which cases
>         ``suspend_late`` is meant to do the latter.  It is always executed after
> @@ -729,6 +742,16 @@ state temporarily, for example so that i
>  disabled.  This all depends on the hardware and the design of the subsystem and
>  device driver in question.
>
> +If it is necessary to resume a device from runtime suspend during a system-wide
> +transition into a sleep state, that can be done by calling
> +:c:func:`pm_runtime_resume` for it from the ``->suspend`` callback (or its
> +couterpart for transitions related to hibernation) of either the device's driver
> +or a subsystem responsible for it (for example, a bus type or a PM domain).
> +That is guaranteed to work by the requirement that subsystems must not change
> +the state of devices (possibly except for resuming them from runtime suspend)
> +from their ``->prepare`` and ``->suspend`` callbacks (or equivalent) *before*
> +invoking device drivers' ``->suspend`` callbacks (or equivalent).
> +
>  During system-wide resume from a sleep state it's easiest to put devices into
>  the full-power state, as explained in :file:`Documentation/power/runtime_pm.txt`.
>  Refer to that document for more information regarding this particular issue as
>

Kind regards
Uffe
