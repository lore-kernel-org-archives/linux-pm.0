From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 19:12:49 +0200
Message-ID: <20060421171249.GA18617@isilmar.linta.de>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604210827.33274.david-b@pacbell.net>
	<20060421154044.GA29233@isilmar.linta.de>
	<200604211003.41049.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14593745417725357=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604211003.41049.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============14593745417725357==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 21, 2006 at 10:03:40AM -0700, David Brownell wrote:
> > We need to distinguish two aspects here -- the "whole system states", which
> > in fact create a multi-dimensional problem, and one specific attribute of
> > one specific device.
> 
> Individual device operating points are multi-dimensional too.  Controllers
> are just mini-systems after all, and some of the device attributes will
> be constrained by system attributes ...

Exactly, that is what I was referring to as well :)

> > The performance level of one specific networking device, 
> > for example. Or its sleep state.
> 
> ... e.g. if it's suspended during system-wide "slow clock mode" it might
> be pretty well unusable, except maybe for PHY based wakeup events; but
> if it's suspended during a more functional system state, enough clocks
> may be available for wake-on-LAN may behave.

Sure. But again you're mixing system state and device state. Of course the
former may constrain the latter, and vice versa.

> > Or, if you can describe sub-aspects of a 
> > networking device, the performance level or the sleep state of that
> > sub-device. So each strict-order parameter has its own file (that's why
> > the RFC mentioned three files for CPUs in the ACPI-model, for performance,
> > idle and throttling; different CPUs in different, especially embedded
> > surroundings may require additional files).
> 
> I seem to have missed some RFC... the note on "on-ness" I responded to
> had some musings, but no evident proposal.

Mis-naming on my part - I was just referring to the "on-ness" proposal too.

> The embedded CPUs I've worked with wouldn't
> have much need for "idle" and "throttling" controls, either.

Other embedded CPUs do, though... and we're trying to abstract things here,
right?

> > Well, the big problem with names and anything "system specific" is that it
> > makes _abstractions_ harder. It makes userspace's life harder, as it needs
> > to know what "idle" means on a specific system, instead.
> 
> If by "userspace" we can mean just "what writes the /sys/power/state file",
> it's straightforward for a given system to provide mappings between some
> common tokens ("standby", "mem", etc) to a system-specific meaning.

Uh. Not /sys/power/state. But /sys/devices/...../power/{[a],[b],[c]} where
[a], [b] and [c] need sensible names.

> Of course, those tokens don't necessarily expose all the meanings that
> are wanted for managing power on that system.  But they're probably a
> reasonable start.  The code behind a system's pm_ops will package a lot
> of decisions about the operating points associated with "standby" etc,
> and it's a bit of work to make sure any given operating point is both
> sensible and functional.

The "on-ness" thingy was about device power sates, AFAIK, but not about
/sys/power/state. So not about what some call "operating points" of the
system, but only about specific settings of a "device" or "part of the
system".

> The same points hold for "ACPI_D0"..."ACPI_D3" states.  If a device may need
> up to four clocks for its fully operational state, but doesn't need all of
> them for more typical reduced-function (and reduced-power) states, there's
> not necesssarily going to be a natural linear/"strict" sequencing of those
> states.  "More power for task one and less power to task two" might be just
> as much power as "more-for-two/less-for-one" ... and from the userspace
> perspective, they could act just like "full power for both" for drivers
> that automatically handle the transitions.

Yes. That's why there is talk about having different files describing a
device, and not just one. So you might have four files describing these four
clocks... and yet another file for describing the non-working states.

	Dominik

--===============14593745417725357==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14593745417725357==--
