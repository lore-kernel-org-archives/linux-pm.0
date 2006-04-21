From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 10:03:40 -0700
Message-ID: <200604211003.41049.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<200604210827.33274.david-b@pacbell.net>
	<20060421154044.GA29233@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35111848693812608=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060421154044.GA29233@isilmar.linta.de>
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

--===============35111848693812608==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 21 April 2006 8:40 am, Dominik Brodowski wrote:
> On Fri, Apr 21, 2006 at 08:27:32AM -0700, David Brownell wrote:
> > > > The only issue I see with numbers is that they imply order,
> > > > and it may be that some operating points might not have
> > > > such a strict order.
> > 
> > In my observation, "strict order" would be the exception not
> > the rule.  There are often three or four orthogonal factors,
> > and they don't naturally fit any two-dimensional linear order.
> 
> We need to distinguish two aspects here -- the "whole system states", which
> in fact create a multi-dimensional problem, and one specific attribute of
> one specific device.

Individual device operating points are multi-dimensional too.  Controllers
are just mini-systems after all, and some of the device attributes will
be constrained by system attributes ...


> The performance level of one specific networking device, 
> for example. Or its sleep state.

... e.g. if it's suspended during system-wide "slow clock mode" it might
be pretty well unusable, except maybe for PHY based wakeup events; but
if it's suspended during a more functional system state, enough clocks
may be available for wake-on-LAN may behave.

And then there can be PM-aware drivers that keep idle devices in low
power states whenever that's possible (activating on TX or from
wake-on-LAN RX) ... so there might be no hardware-level differences
between states before and after suspend(), other than that suspend()
always shutting down the network stack state (TX queues etc) too.


> Or, if you can describe sub-aspects of a 
> networking device, the performance level or the sleep state of that
> sub-device. So each strict-order parameter has its own file (that's why
> the RFC mentioned three files for CPUs in the ACPI-model, for performance,
> idle and throttling; different CPUs in different, especially embedded
> surroundings may require additional files).

I seem to have missed some RFC... the note on "on-ness" I responded to
had some musings, but no evident proposal.  (It wasn't even clear
what it was describing...)  The embedded CPUs I've worked with wouldn't
have much need for "idle" and "throttling" controls, either.


> > > Yes, inventing good names may be tricky in some cases, but in other
> > > cases names are very natural (arm has sleep, deep sleep and big sleep,
> > > iirc).... And we can always fall back to state0..state5.
> > 
> > Well, OMAP is one implementation that uses ARM, and it certainly has
> > "deep sleep" and "big sleep".  But other ARM based SOCs provide very
> > different power abstractions (consider "slow clock mode", "idle",
> > "frozen", "standby", "stop", "sleep") and may use the same names to
> > indicate different things.  System state names are system specific.
> 
> Well, the big problem with names and anything "system specific" is that it
> makes _abstractions_ harder. It makes userspace's life harder, as it needs
> to know what "idle" means on a specific system, instead.

If by "userspace" we can mean just "what writes the /sys/power/state file",
it's straightforward for a given system to provide mappings between some
common tokens ("standby", "mem", etc) to a system-specific meaning.

Of course, those tokens don't necessarily expose all the meanings that
are wanted for managing power on that system.  But they're probably a
reasonable start.  The code behind a system's pm_ops will package a lot
of decisions about the operating points associated with "standby" etc,
and it's a bit of work to make sure any given operating point is both
sensible and functional.


> > If ACPI wants to use names like "ACPI_S0".."ACPI_S5", that's fine;
> > but Linux should not inflict such an approach on systems that don't
> > use ACPI.  Developers might find it handy to contrast one SOC's
> > "deep sleep" to "ACPI_S3" (or to "deep sleep" on another SOC), but
> > it won't be an exact match; square peg, round hole.
> 
> Here you're talking about "system states" instead of "device states" again.

The same points hold for "ACPI_D0"..."ACPI_D3" states.  If a device may need
up to four clocks for its fully operational state, but doesn't need all of
them for more typical reduced-function (and reduced-power) states, there's
not necesssarily going to be a natural linear/"strict" sequencing of those
states.  "More power for task one and less power to task two" might be just
as much power as "more-for-two/less-for-one" ... and from the userspace
perspective, they could act just like "full power for both" for drivers
that automatically handle the transitions.

And those might all map to ACPI_D0 states ... there's still the same peg/hole
problem, coming from thinking that details of the ACPI model should apply.

(That is, the ACPI model makes general sense when talking about different
device and system states  but not when trying to define details -- which
should be system-specific! -- about what those states should be/model, and
how they should behave.)

- Dave


--===============35111848693812608==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35111848693812608==--
