From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sun, 25 Mar 2007 09:55:04 -0700
Message-ID: <200703250955.04947.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703250820.18095.david-b@pacbell.net>
	<1174839814.5695.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174839814.5695.5.camel@localhost>
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
To: jg@laptop.org
Cc: ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Sunday 25 March 2007 9:23 am, Jim Gettys wrote:
> Just to prove that all generalizations have exceptions:
> =

> On the OLPC system, we want the wireless (which, unfortunately, is USB
> based), to be able to wake the system from suspend to RAM.
> =

> Of course, we have arranged there be an out of band signal from the USB
> wireless to wake up the system.  So we don't use USB wakeup for that.

That would be a case of a USB _peripheral_ waking the system,
albeit through agency of the host controller.

You imply that on OLPC, USB remote wakeup doesn't work from
STR ... which isn't the most common setup, though I've seen
it on systems that are particularly aggressive about power
savings.  Turning off VBUS power on USB ports shrinks the
power budget by at least the 0.5 mA per port most suspended
devices may draw, on top of whatever the transceivers draw
and whatever the system needs to monitor the relevant
transceiver state change events ... GPIOs might suffice.

Doesn't seem like much of an exception to me.  The USB stack
still follows USB rules.  The driver for that WLAN adapter can
have platform-specific extensions, no problem; if that's the
usual sort of wakeup irq signal, it's just a case of that
suspend() method having a bit more work to do.

And of course, it's not running on an AT91 system, so those
AT91-specific rules couldn't apply in any case! :)

- Dave


> 			- Jim
> =

> On Sun, 2007-03-25 at 08:20 -0700, David Brownell wrote:
> > =

> > If userspace wants the USB host to be able to wake the
> > system from sleep, then the simple rule is:  don't use
> > the suspend-to-RAM mode.  Nothing software does can ever
> > change that restriction; "slow clock mode" doesn't run
> > the 48 MHz clock, wakeup doesn't work without that clock.

That was with reference to the at91_udc driver, although the
same rule also applies to its USB host (OHCI) too.

Most x86 systems don't have a USB peripheral mode, so they
couldn't be woken up by an external USB host in any case.
The x86 systems generally have a USB host controller, and
it's usually wired so it can be used as a wakeup source by
an external USB peripheral.


> > By forcing the system into suspend-to-RAM mode, rather
> > than using runtime PM to minimize power usage, userspace
> > has already said that being fully functional isn't the
> > top issue just then.
> > =

> > Keep in mind that most users are already trained in that
> > model.  Even if it didn't already make sense, that's what
> > MS-Windows has done forever.  Those little checkboxes in
> > each driver's GUI properties, saying "let it wake up the
> > system"?  They're boolean, and only reflect the details
> > of the ACPI tables in so far not having the checkbox if
> > that device is known to ACPI and isn't in that table.
> > It's a simple model, easily understood and generalized.
> > =

> > - Dave
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> -- =

> Jim Gettys
> One Laptop Per Child
> =

> =
