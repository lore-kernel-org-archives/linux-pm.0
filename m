From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 14:51:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0706211424170.14859-100000__8755.85928229175$1182451994$gmane$org@iolanthe.rowland.org>
References: <200706211102.37724.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706211102.37724.david-b@pacbell.net>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, 21 Jun 2007, David Brownell wrote:

> On Thursday 21 June 2007, Alan Stern wrote:
> > On Thu, 21 Jun 2007, David Brownell wrote:
> >=20
> > > > If a driver wants to find out whether some resource will be avail=
able
> > > > in the target system state, the only way is to ask the resource's
> > > > provider.  Hence the driver needs to have some cookie (representi=
ng the
> > > > target state) that it can pass to the provider.
> > >=20
> > > Not true.  The provider knows the target state.  Just ask it whethe=
r
> > > the resource will be available.  It doesn't need a cookie to distin=
guish
> > > between multiple target states, since there can be only one.
> >=20
> > _How_ does the provider know what the next target state is?
>=20
> That's an interface between the provider and the platform's PM code.
> Remember those two patches?
>=20
> =A0 http://lkml.org/lkml/2007/3/22/241
> =A0 http://lkml.org/lkml/2007/3/22/242
>=20
> The second one does that by coupling one platform's pm_ops to its
> clock framework using an internal interface.  That will be typical
> for any SOC system, where the difference between states is mostly
> just which oscillators/PLLs are active ... pm_ops being essentially
> tasked with turning some stuff off.

Now we're getting back to the question which started this thread. =20
That patch takes care of one platform, but now consider an ACPI system. =20
How should the ACPI core learn what the next target system state will
be?  And once it possess that knowledge, what's the best way for it to
tell various subsystems which device states/functions will be
supported?

> Of course, I believe we need to move away from "suspend_state_t"
> being effectively just "standby" or "STR" (or "ON") so that more
> of the hardware capabilities can be exposed.   Systems that have,
> say, seven different hardware states can't fit into Linux today.

I agree that the list of system states should be configurable and=20
perhaps even adjustable at runtime.  However this is somewhat OT.

> (Related, I think that target *run* states are under-appreciated.
> That's the general runtime PM issue.  Interfaces should work for
> run-state transitions as well as sleep-state ones...)

Perhaps something like this: Resource providers have an API whereby
drivers can find out what resources either are currently available or
will be available in the next system state (a little awkward to specify
which is needed).  Then drivers decide on a new device state based on
the type of change requested and the available resources, and notify
the providers via a second API about any change in resource usage.

> > There could be a global next_pm_system_state() routine.  It would hav=
e
> > to return _something_ -- and I think a cookie would be better than a
> > struct.
>=20
> But *should* there be such a routine?  Interpreting it would
> necessarily be very platform-specific.  Why should anyone care
> about platform-specific calls ... except people writing the
> platform-specific code to implement and use those calls?

You forgot one thing.  Yes, the code that makes those calls and uses
the results would be platform-specific.  But the code that gets called
would be part of the PM core and hence not platform-specific -- even
though the values it returns are.

Now perhaps I'm beating a dead horse and the existing pm_ops callbacks=20
already provide the necessary notifications.  If so I'll shut up.

> I still disagree.  Has anyone even proposed an example of a driver
> caring about "what the target sleep state is"?  Every example we
> have seen in the past several years is an example where the relevant
> detail is something *else* ... something which is only loosely
> associated with that state, in a very platform-specific way.

Granted that the association is loose and platform-specific. =20
Nevertheless, it is non-zero.

Alan Stern
