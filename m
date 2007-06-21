From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 22:19:52 +0200
Message-ID: <200706212219.52699.rjw__15079.3546614752$1182456860$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211424170.14859-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 20:51, Alan Stern wrote:
> On Thu, 21 Jun 2007, David Brownell wrote:
>=20
> > On Thursday 21 June 2007, Alan Stern wrote:
> > > On Thu, 21 Jun 2007, David Brownell wrote:
> > >=20
> > > > > If a driver wants to find out whether some resource will be ava=
ilable
> > > > > in the target system state, the only way is to ask the resource=
's
> > > > > provider.  Hence the driver needs to have some cookie (represen=
ting the
> > > > > target state) that it can pass to the provider.
> > > >=20
> > > > Not true.  The provider knows the target state.  Just ask it whet=
her
> > > > the resource will be available.  It doesn't need a cookie to dist=
inguish
> > > > between multiple target states, since there can be only one.
> > >=20
> > > _How_ does the provider know what the next target state is?
> >=20
> > That's an interface between the provider and the platform's PM code.
> > Remember those two patches?
> >=20
> > =A0 http://lkml.org/lkml/2007/3/22/241
> > =A0 http://lkml.org/lkml/2007/3/22/242
> >=20
> > The second one does that by coupling one platform's pm_ops to its
> > clock framework using an internal interface.  That will be typical
> > for any SOC system, where the difference between states is mostly
> > just which oscillators/PLLs are active ... pm_ops being essentially
> > tasked with turning some stuff off.
>=20
> Now we're getting back to the question which started this thread. =20
> That patch takes care of one platform, but now consider an ACPI system.=
 =20
> How should the ACPI core learn what the next target system state will
> be?

Yes, this is what I'm interested in in the first place.

> And once it possess that knowledge, what's the best way for it to=20
> tell various subsystems which device states/functions will be
> supported?

I think it can be asked for that via a pair of callbacks, like:

platform->lowest_power_state_the_device_can_be_in(dev, wakeup)

and

platform->highest_power_state_the_device_can_be_in(dev)

where 'wakeup' tells the platform whether we want this device to be able =
to
wake up the system.

> > Of course, I believe we need to move away from "suspend_state_t"
> > being effectively just "standby" or "STR" (or "ON") so that more
> > of the hardware capabilities can be exposed.   Systems that have,
> > say, seven different hardware states can't fit into Linux today.
>=20
> I agree that the list of system states should be configurable and=20
> perhaps even adjustable at runtime.  However this is somewhat OT.

Agreed.

> > (Related, I think that target *run* states are under-appreciated.
> > That's the general runtime PM issue.  Interfaces should work for
> > run-state transitions as well as sleep-state ones...)
>=20
> Perhaps something like this: Resource providers have an API whereby
> drivers can find out what resources either are currently available or
> will be available in the next system state (a little awkward to specify
> which is needed).  Then drivers decide on a new device state based on
> the type of change requested and the available resources, and notify
> the providers via a second API about any change in resource usage.

Yes, something like this.
=20
> > > There could be a global next_pm_system_state() routine.  It would h=
ave
> > > to return _something_ -- and I think a cookie would be better than =
a
> > > struct.
> >=20
> > But *should* there be such a routine?  Interpreting it would
> > necessarily be very platform-specific.  Why should anyone care
> > about platform-specific calls ... except people writing the
> > platform-specific code to implement and use those calls?
>=20
> You forgot one thing.  Yes, the code that makes those calls and uses
> the results would be platform-specific.  But the code that gets called
> would be part of the PM core and hence not platform-specific -- even
> though the values it returns are.
>=20
> Now perhaps I'm beating a dead horse and the existing pm_ops callbacks=20
> already provide the necessary notifications.  If so I'll shut up.

No, they don't.

pm_ops->prepare() is now called after the drivers' .suspend() routines ha=
ve
been executed, so the ACPI core, for example, has no means of learning wh=
at
the next system state will be until all devices have been suspended.
=20
> > I still disagree.  Has anyone even proposed an example of a driver
> > caring about "what the target sleep state is"?  Every example we
> > have seen in the past several years is an example where the relevant
> > detail is something *else* ... something which is only loosely
> > associated with that state, in a very platform-specific way.
>=20
> Granted that the association is loose and platform-specific. =20
> Nevertheless, it is non-zero.

Agreed.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
