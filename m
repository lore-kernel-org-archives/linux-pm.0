From: Jim Gettys <jg@laptop.org>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sun, 25 Mar 2007 12:23:34 -0400
Message-ID: <1174839814.5695.5.camel@localhost>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703241349.19964.david-b@pacbell.net> <46064E68.8030302@gmail.com>
	<200703250820.18095.david-b@pacbell.net>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703250820.18095.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

Just to prove that all generalizations have exceptions:

On the OLPC system, we want the wireless (which, unfortunately, is USB
based), to be able to wake the system from suspend to RAM.

Of course, we have arranged there be an out of band signal from the USB
wireless to wake up the system.  So we don't use USB wakeup for that.
			- Jim

On Sun, 2007-03-25 at 08:20 -0700, David Brownell wrote:
> =

> If userspace wants the USB host to be able to wake the
> system from sleep, then the simple rule is:  don't use
> the suspend-to-RAM mode.  Nothing software does can ever
> change that restriction; "slow clock mode" doesn't run
> the 48 MHz clock, wakeup doesn't work without that clock.
> =

> By forcing the system into suspend-to-RAM mode, rather
> than using runtime PM to minimize power usage, userspace
> has already said that being fully functional isn't the
> top issue just then.
> =

> Keep in mind that most users are already trained in that
> model.  Even if it didn't already make sense, that's what
> MS-Windows has done forever.  Those little checkboxes in
> each driver's GUI properties, saying "let it wake up the
> system"?  They're boolean, and only reflect the details
> of the ACPI tables in so far not having the checkbox if
> that device is known to ACPI and isn't in that table.
> It's a simple model, easily understood and generalized.
> =

> - Dave
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
-- =

Jim Gettys
One Laptop Per Child
