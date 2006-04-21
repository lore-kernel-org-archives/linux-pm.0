From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 11:30:05 -0700
Message-ID: <200604211130.05650.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604211003.41049.david-b@pacbell.net>
	<20060421171249.GA18617@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15405198856688762=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060421171249.GA18617@isilmar.linta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============15405198856688762==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 April 2006 10:12 am, Dominik Brodowski wrote:
> On Fri, Apr 21, 2006 at 10:03:40AM -0700, David Brownell wrote:
> > > We need to distinguish two aspects here -- the "whole system states", which
> > > in fact create a multi-dimensional problem, and one specific attribute of
> > > one specific device.
> > 
> > Individual device operating points are multi-dimensional too.  Controllers
> > are just mini-systems after all, and some of the device attributes will
> > be constrained by system attributes ...
> 
> Exactly, that is what I was referring to as well :)

Good, it helps when folk are on the same page!


> > The embedded CPUs I've worked with wouldn't
> > have much need for "idle" and "throttling" controls, either.
> 
> Other embedded CPUs do, though... and we're trying to abstract things here,
> right?

Not exactly.  I'd hope we're solving problems.  Generalization makes
solutions work in multiple contexts, and abstraction helps generalization,
but IMO the goal is problem solving.

I've certainly seen cases where abstracting creates/causes problems, rather
than solving them.  And creating abstractions that don't make sense on the
hardware is a good start on such confusion...


> > > Well, the big problem with names and anything "system specific" is that it
> > > makes _abstractions_ harder. It makes userspace's life harder, as it needs
> > > to know what "idle" means on a specific system, instead.
> > 
> > If by "userspace" we can mean just "what writes the /sys/power/state file",
> > it's straightforward for a given system to provide mappings between some
> > common tokens ("standby", "mem", etc) to a system-specific meaning.
> 
> Uh. Not /sys/power/state. But /sys/devices/...../power/{[a],[b],[c]} where
> [a], [b] and [c] need sensible names.

Well, "on" could have one defined meaning.  Maybe it's the only option
available, until drivers add intelligence.  I don't see any problem
with the other names being system-specific, since it's rather unlikely
that a PCI_D3hot state will ever appear on most embedded ARM boxes.
And if any userspace code tries to set power states, it had darn well
better understand exactly what's going on.


> > Of course, those tokens don't necessarily expose all the meanings that
> > are wanted for managing power on that system.  But they're probably a
> > reasonable start.  The code behind a system's pm_ops will package a lot
> > of decisions about the operating points associated with "standby" etc,
> > and it's a bit of work to make sure any given operating point is both
> > sensible and functional.
> 
> The "on-ness" thingy was about device power sates, AFAIK, but not about
> /sys/power/state. So not about what some call "operating points" of the
> system, but only about specific settings of a "device" or "part of the
> system".

Hence my confusion in reading the original note ... Len said it applied
to both, but I found a bias towards CPU power states (rather than device
or system states).


> > The same points hold for "ACPI_D0"..."ACPI_D3" states.  If a device may need
> > up to four clocks for its fully operational state, but doesn't need all of
> > them for more typical reduced-function (and reduced-power) states, there's
> > not necesssarily going to be a natural linear/"strict" sequencing of those
> > states.  "More power for task one and less power to task two" might be just
> > as much power as "more-for-two/less-for-one" ... and from the userspace
> > perspective, they could act just like "full power for both" for drivers
> > that automatically handle the transitions.
> 
> Yes. That's why there is talk about having different files describing a
> device, and not just one. So you might have four files describing these four
> clocks... and yet another file for describing the non-working states.

That seems too complicated to me.  When debugging, I want to visualize the
entire tree ... so I'd want a /sys/kernel/debug/clocktree file, with lots
of system-specific information.  (Which gate bits are set/cleared?  What
speeds? etc.)  Or else I just want to know which state the driver is in,
like "mostly one".  Some of that is taste, but also don't forget that each
attribute in sysfs has a cost.

- Dave

--===============15405198856688762==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15405198856688762==--
