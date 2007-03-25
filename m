From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sun, 25 Mar 2007 08:20:17 -0700
Message-ID: <200703250820.18095.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703241349.19964.david-b@pacbell.net>
	<46064E68.8030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46064E68.8030302@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Sunday 25 March 2007 3:26 am, Dmitry Krivoschekov wrote:
> David Brownell wrote:
> > On Friday 23 March 2007 1:39 pm, Rafael J. Wysocki wrote:
> >
> >> 	After we have frozen tasks, we need to
> >> call something like device_suspend(some_argument) where the argument s=
hould
> >> tell drivers what to do. =

> >
> > That parameter can't suffice, since the exact details depend on
> > system-dependent context.  Example, on one system a given sleep
> > state will allow a given device to issue wakeups ... on another,
> > it won't.
> >
> What do you mean? Capability of h/w to be a wakeup source or
> design decisions, when wakeup capability of a given device
> is disabled intentionally for some reason?

Both ways; device_may_wakeup(dev) is there to flag whether
the driver suspend() method should try to kick in wakeup
machinery, whether the restriction is from hardware or from
software (userspace) policy.


> System may have a number of devices that all are able to wakeup
> the system from *all* sleep (low power) states the system
> supports.Normally, such devices should be marked as "can_wakeup"
> to demonstrate the capability,

That flag doesn't indicate wakeup from "all" states, but
instead from "any" state.  There's no micromanagement
going on... just a simple way for userspace to say whether
they'd like to try using that device's wakeup machinery.

If the device can't wake from the target system state,
the driver won't be able to kick in that machinery.
Hardware trumps software, as it were.


> So, it is reasonable idea to permit some devices to be
> wakeup sources for one system-wide state but restrict
> the wakeup ability for another system-wide state.

That restriction being done in hardware or, if for some
reason userspace wants, by updating the sysfs "wakeup"
attribute for the relevant device before writing to the
/sys/power/state file.


> But, it seems not quite reasonable to hardcode this
> in platform-specific code, unless your platform is
> designed for very specific needs. In general,
> every wakeup source (which is capable to wakeup
> at any system state) should be available via sysfs
> (../power/wakeup interface of device)

Right, which is why I never suggested hardwiring any
of that in platform-specific code.  The only thing
that platform-specific code should handle is whether
the device can be a wakeup event source *at all*, which
is hardware-controlled.


> > You seem to have overlooked the clk_must_disable() patches I
> > recently re-sent.  In conjunction with the driver model wakeup
> > flags, that can solve the problem on every SOC platform I've
> > had a reason to look at ... see how it works for AT91 USB.
> =

> As I pointed above, user may want to choose between wakeup
> sources and he(she) must be sure the choice won't be ignored,

If the user sets a policy the hardware can't implement in
that particular context, then of course that choice can't
apply.  It's not "ignored", just irrelevant.


> but your changes for atmel_serial.c and at91_udc.c,
> seems restrict user with that.

The restriction is from hardware, not software.  And that
patch doesn't change that behavior; it couldn't!  :)

If userspace wants the USB host to be able to wake the
system from sleep, then the simple rule is:  don't use
the suspend-to-RAM mode.  Nothing software does can ever
change that restriction; "slow clock mode" doesn't run
the 48 MHz clock, wakeup doesn't work without that clock.

By forcing the system into suspend-to-RAM mode, rather
than using runtime PM to minimize power usage, userspace
has already said that being fully functional isn't the
top issue just then.

Keep in mind that most users are already trained in that
model.  Even if it didn't already make sense, that's what
MS-Windows has done forever.  Those little checkboxes in
each driver's GUI properties, saying "let it wake up the
system"?  They're boolean, and only reflect the details
of the ACPI tables in so far not having the checkbox if
that device is known to ACPI and isn't in that table.
It's a simple model, easily understood and generalized.

- Dave
