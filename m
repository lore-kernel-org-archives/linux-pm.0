From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [RFD] How to tell ACPI drivers what the target
	sleep state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 11:02:36 -0700
Message-ID: <200706211102.37724.david-b__13129.2532234967$1182449096$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0706211303120.3547-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0706211303120.3547-100000@iolanthe.rowland.org>
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

On Thursday 21 June 2007, Alan Stern wrote:
> On Thu, 21 Jun 2007, David Brownell wrote:
>=20
> > > If a driver wants to find out whether some resource will be availab=
le
> > > in the target system state, the only way is to ask the resource's
> > > provider.  Hence the driver needs to have some cookie (representing=
 the
> > > target state) that it can pass to the provider.
> >=20
> > Not true.  The provider knows the target state.  Just ask it whether
> > the resource will be available.  It doesn't need a cookie to distingu=
ish
> > between multiple target states, since there can be only one.
>=20
> _How_ does the provider know what the next target state is?

That's an interface between the provider and the platform's PM code.
Remember those two patches?

=A0 http://lkml.org/lkml/2007/3/22/241
=A0 http://lkml.org/lkml/2007/3/22/242

The second one does that by coupling one platform's pm_ops to its
clock framework using an internal interface.  That will be typical
for any SOC system, where the difference between states is mostly
just which oscillators/PLLs are active ... pm_ops being essentially
tasked with turning some stuff off.

Of course, I believe we need to move away from "suspend_state_t"
being effectively just "standby" or "STR" (or "ON") so that more
of the hardware capabilities can be exposed.   Systems that have,
say, seven different hardware states can't fit into Linux today.
(Related, I think that target *run* states are under-appreciated.
That's the general runtime PM issue.  Interfaces should work for
run-state transitions as well as sleep-state ones...)


> Right now=20
> there's no way for that information to get from the PM core to the
> provider other than pm_message_t, and the pm_message_t will generally
> be passed to the provider _after_ it is passed to the lower-level
> drivers.

No, providers don't get a pm_message_t ... that goes to drivers.


> There could be a global next_pm_system_state() routine.  It would have
> to return _something_ -- and I think a cookie would be better than a
> struct.

But *should* there be such a routine?  Interpreting it would
necessarily be very platform-specific.  Why should anyone care
about platform-specific calls ... except people writing the
platform-specific code to implement and use those calls?
Is there any way that driver code could ever make use of such
a suspend_state_t value?


> There are other possible ways to disseminate the information.  The=20
> details don't matter much, and relatively few drivers would care. =20
> However the form of the information is a legitimate concern at this=20
> point.

I still disagree.  Has anyone even proposed an example of a driver
caring about "what the target sleep state is"?  Every example we
have seen in the past several years is an example where the relevant
detail is something *else* ... something which is only loosely
associated with that state, in a very platform-specific way.

The same PCI chip may need to act very differently based on whether
the system uses ACPI (or not), and how it's wired on that particular
mainboard.  That's platform-specific behavior which is not coupled
directly to a sleep state.

- Dave
