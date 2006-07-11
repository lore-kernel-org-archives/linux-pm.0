From: David Brownell <david-b@pacbell.net>
Subject: Re: RFC -- updated Documentation/power/devices.txt
Date: Tue, 11 Jul 2006 09:51:48 -0700
Message-ID: <200607110951.48349.david-b@pacbell.net>
References: <EA12F909C0431D458B9D18A176BEE4A5068E0468@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A5068E0468@dlee02.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 11 July 2006 12:56 am, Woodruff, Richard wrote:
> One trivial comment would be to use number bullets instead of asterisks
> as ordering is important.

OK ... though with ASCII text, that means manual re-numbering when
things change.  It'd be nice if <ol> worked.  :)


> >    *	class.suspend(dev) is called after tasks are frozen, for devices
> > 	associated with a class that has such a method.
> =

> Should/is call.suspend be called before bus.suspend_preapare? If it is
> it should be documented first.  Stopping class level things before bus
> level which services it seems more natural. =


The suspend_prepare() is new, and it's called at that point; there's no
generic class.suspend_prepare().

However class.suspend() is called before bus.suspend(), and bus.suspend()
is what drivers currently provide.  ISTR the notion is that we'll be moving
some code out of driver suspend() methods into reusable class methods,
say for networking, and the suspend_prepare() solves much earlier issues
like needing to handshake with userspace.


> The resume bullets are documented this way.

Bug, now fixed; thanks.  Driver has early and normal opportunities to
resume, then class gets a chance to reactivate after the hardware works.


> > Low Power (suspend) States
> > --------------------------
> > ...
> > Some details here may be platform-specific.  Systems may have devices
> > that may be fully active in certain sleep states, ...
> =

> Partial system idle states generally involve several devices.  There
> doesn't seem to be a grouping mechanism to define these relationships.

Not in the standard infrastructure, no; but then those groupings exist
regardless of whether they're used in a "partial system idle" state.


> To take device relationships into account we currently look to scripted
> user space groupings and notification accesses via extended driver sysfs
> endpoints.

Those things are out-of-scope for this writeup, since we don't have
such grouping APIs.

>From my perspective, the groupings are part of a product-specific definition
of the different system states.  Those can be "run" states (operating point=
s)
or "sleep" states ... where of course the line between a partially-off "run"
state and a partially-on "sleep" state can be very fuzzy!


> > Runtime Power Management
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > ...
> > In each device's directory, there is a 'power' directory, which
> > contains at least a 'state' file. Reading from this file displays what
> > power state the device is currently in. Writing to this file initiates
> > a transition to the specified power state, which must currently be a
> > number: '0' for 'on', or either '2' or '3' for 'suspended' (which
> > sometimes also implies reset, especially in conjunction with deeper
> > system sleep states).
> =

> It would be nice if some of the previous 'on-ness' discussions would
> result in some movement here.

True; that's also in line with Andrew's comment, and the deprecation warning
I stuck in for those /sys/devices/.../power/state files.  But all that would
be new behavior, and at this point I was just aiming to correctly describe
the stuff that's there now (and have it make some sense).

If those discussions bear fruit, that section will need updating.

- Dave
