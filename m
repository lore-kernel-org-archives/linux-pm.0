From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Mon, 5 Oct 2015 10:15:11 -0500
Message-ID: <20151005151511.GA18784@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
 <20151002184909.GC12635@sirena.org.uk>
 <20151002191125.GC5552@saruman.tx.rr.com>
 <20151004225506.GD12635@sirena.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47163 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbbJEPQF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 11:16:05 -0400
Content-Disposition: inline
In-Reply-To: <20151004225506.GD12635@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2015 at 11:55:06PM +0100, Mark Brown wrote:
> On Fri, Oct 02, 2015 at 02:11:25PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 02, 2015 at 07:49:09PM +0100, Mark Brown wrote:
> > > On Fri, Oct 02, 2015 at 12:23:11PM -0500, Felipe Balbi wrote:
>=20
> > > > > Things more difficult, if nothing else it means we need to get wh=
atever
> > > > > userspace component deployed in all relevant userspace stacks with
> > > > > appropriate configuration in order to do things.
>=20
> > > > but that will be a thing for the kernel too. We will have to deploy=
 this new
> > > > kernel component in all relevant stacks with appropriate configurat=
ion in order
> > > > to do things :-) No changes there.
>=20
> > > Sure, but it's one project which is developed entirely in the open -
> > > that's a lot more manageable.
>=20
> > We can have a fully open source userland daemon too. Much like systemd,=
 bluez,
> > neard, and many, many others. Why wouldn't that be a thing ?
>=20
> The trouble is getting traction on adoption.  Vendors have a habit of doi=
ng
> things like finding problems and rather than reporting them deciding that=
 the
> open source solution isn't great and going and writing their own thing
> (especially when they're in stealth mode) rather than talking to anyone.
> Sometimes we manage to avoid that but it can be challenging, and often we=
 only
> even hear about the new thing after it's shipping and there's a lot of in=
ertia
> behind changing it.  The kernel ABIs tend to be a lot sticker than usersp=
ace
> things here.

but this is not a solid enough argument to push anything into the kernel.

> > Similar applies to power delivery charging profile themselves. Not all
> > profiles are mandatory. Some are optional and that will be completely
> > device/board specific. How an OEM implements that in the PCB is also
> > completely board-specific :-) Some might have a dumb IC hardcoding some
> > messages, some might have something largely more flexible.
>=20
> Right, and what I was trying to say was that it seems like the kernel oug=
ht to
> be worrying about the board specific bits and userspace worrying about wh=
at to
> do with those bits.

we're not saying anything different in this front. I, too, want kernel to d=
eal
with certain details and expose notifications. Where we disagree is how gra=
nular
should these notifications be and where they should be sent to.

 > > The things we've got with audio are a combination of tuning to taste a=
nd
> > > (even more importantly) very different ideas about what you want to do
> > > with an audio subsystem that influence how you set things up in a giv=
en
> > > use case.
>=20
> > the same thing will happen with Type-C and power delivery. There won't =
be tuning
> > to taste, of course :-) But there will be "very different ideas what wh=
at you
> > want to do with" your charging methodology.
>=20
> Are those very different things about the use cases ("don't bother with
> high speed data, get all the power you can" or whatever) or are they
> about the details of the board?

I'm pretty sure there will be interesting designs in the market. I'm pretty=
 sure
there will be type-C systems which won't support USB 3.1 for example, even
though they'll support USB Power Delivery in its entirety.

> > > > Actually, I was thinking about it in a more granular fashion. Kernel
> > > > exposes a charger/power_supply, a few regulators, a UDC view and th=
is
> > > > single userspace daemon figures out how to tie those together.
>=20
> > > That sounds worrying - it means that new hardware support needs
> > > supporting in every userspace (it seems inevitable that there will be=
 at
> > > least some reimplementations because that's fun) which gets old really
> > > fast, and every userspace needs to understand every topology.
>=20
> > very true, but it's also true for a kernel solution.
>=20
> > It seems like you want it in the kernel because of it being convenient =
:-)
>=20
> Yes, definitely - my experience both in terms of watching how people
> like handset vendors often work internally and in terms of getting
> things adopted is that it's a lot easier if you can have one component
> you need to update to handle new hardware rather than multiple ones that
> need to be upgraded for things that are purely board differences.

IMO, just because you have it in the kernel, it doesn't mean it'll be
adopted. Look at pm_runtime, for example; it's a very nice API and, yet, not
used by Android (or has that changed ?)

> > > > The view here isn't really a USB port, it's just a source of power.=
 But how much
> > > > power we can draw from it depends on, possibly, a ton of different =
chips and
> > > > different notifications.
>=20
> > > Right, yes - it's the power input/output associated with the USB port.
> > > The USB port is just the physical thing users can see so it's a good =
way
> > > to label it.  That could mean that we ought to move the aggregation b=
it
> > > into the power supply code of course, but then a lot of the decisions
> > > are going to be specific to USB.
>=20
> > in a sense, yes. But they can happen at a layer which knows nothing (or=
 very
> > little) about USB. Here's an example:
>=20
> > Not everybody follows USB Battery Charging class. Some chargers don't s=
hort
> > D+/D- to signify they are a wall charger. Some will use different resis=
tance
> > values on the ID pin to tell you how much current you can draw from the=
m.
>=20
> > From a PMIC (or something else) point of view, all it needs is a tiny c=
urrent
> > source and a an ADC, then it reports the ADC value to the upper layer. =
This
> > really doesn't even need to know that it's using an ID pin, or whatever.
>=20
> This doesn't seem much different to things like the various GPIO to
> subsystem X drivers we've got - we already have some for IIO type
> things IIRC.

that's really not what I was trying to point out :-)

> > > How different are the end goals of these designs really going to be
> > > though - that's more of the question for me?  Part of what the kernel=
 is
> > > doing is hiding implementation details from userspace.  I'd expect
> > > userspace to be interested in things like the maximum current allowed=
 in
> > > or out in a given mode rather than the details of how that is accompl=
ished.
>=20
> > okay, this is a fair point :-) I just don't see, as of now at least, ho=
w we can
> > get to that in a way that's somewhat future-proof. It seems like we will
> > add more and more notifications until we can't maintain this anymore.
>=20
> So we need to look at the new/upcoming USB specs and understand the

not upcoming, it's already out there.

> problem space, and how much of it we need to worry about right now in
> this scope.
>=20
> > With Type-C there's no port type anymore. What we used to refer as Host=
/Hub
> > Charger, Standard Port, Charging Port, Wall Charger, etc, now becomes a=
 single
> > type (let's call it type-c for short) which can provide profiles. These=
 profiles
> > are negotiated using that new stack I pointed out above, not by checking
> > resistance on data lines or ID pin.
>=20
> Yup, which is a really cool feature and keeps us all employed too! :)
> This is one reason for attaching things to the USB stack, right now it
> does a limited negotiation but in future like you say there's more and
> more features coming.

keep in mind that the same stack used to change a charging current, will al=
so be
used to tell the other end to mux those lines differently.

> > Add to that the fact that the same power delivery pipe (the CC pins) ca=
n be used
> > to tell the other end of remux the pins to e.g. PCIe, and s**t just hit=
 the fan
> > :-)
>=20
> > In short, whatever we do, needs to consider coping with incoming reques=
ts from
> > userspace at a minimum because userspace will need control over the port
> > alternate modes. I mean, don't get me wrong, these is all uber-cool to =
me, but
> > it'll be a pain to make a flexible/generic solution :-)
>=20
> That seems to make sense to me - anything the kernel is able to do
> autonomously for USB C should probably be pretty dumb.  Older USB
> standards are already pretty dumb themselves (although inconsistently
> standardised).

right.

> > > > The real difficulty here is coming up with an interface which we're=
 agreeing to
> > > > supporting for the next 30 years. Whatever that is, as soon as it g=
ets exposed
> > > > to userland, we will have to support it.
>=20
> > > To me that sounds like an argument for hiding things :)
>=20
> > the problem with hiding, though, is that once something new comes about=
, it
> > might not fit our current abstraction and it might be big PITA to suppo=
rt "old"
> > and new systems.
>=20
> Does the problem not get easier if we break it down to just the charger
> elements and realise that the USB C modes are going to have a lot more
> policy in them?

the thing with USB C is that it's not only for negotiating a charging power
(with power delivery you're not necessarily tied to 5V, btw), that very sta=
ck
will also be used to change to other alternate modes, and those can be anyt=
hing:
Thunderbolt, PCIe, DisplayPort, etc.

> > > > And this another reason I think a more granular approach is better,=
 as it allows
> > > > us to easily add more pieces as they come along.
>=20
> > > OTOH it's more work for the system as a whole.
>=20
> > it's more work outside the kernel, yes. The total amount of work (kerne=
l +
> > userspace) will be the same, regardless if you hide it in the kernel or=
 in userspace.
>=20
> Like I say I'm worried about deployment issues for the split solutions
> making things harder than they should be.

and I'm worried about us having too much inside the kernel and that making
things harder than they should be :-)

--=20
balbi

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEpP/AAoJEIaOsuA1yqRE3yoP/2dcZkOefpBkKcEy1FgcM5mx
AC9Q6eAjoPhQ3SP/7Rp8kJK2BfPYBvQymudLvKXniOVmjWYWw5+kavecQvFT99aa
xKMlB4n3ImyEzynJT7lHCR3Fad7aTmWuKoO6TbPzGUcBKglv9N7mZgHcnD2v5EmQ
qO+pxKkIUVNdI4meFeSRJuq2YY4hF2FgzqVOW27j1w49tXWt/qNn6G1IU/QK4Aot
f5SI8IOuxx3wfGib6oWxSAM9Y0a5O0by8N4/CfcKzGK4EFuzPY9fkrP1WohRCuFF
oUJNv8e7ZFyjc4lytBT2e230jFWlkWMwm0viZYINxP5GgpsANrGflwQnulGt5yCt
EF19fjvdT10pr1EWNhP9Ckw+g00yCQTiLh/Q2Em+8EYsyRm8bB1l/bbLYsf7XnAw
t9JAr3jDgi/dKrLo17b4vgoaVAxYkLXJqtejVp3miP+ExR5FQn0SlVPnz+q9pF5r
H7ztqieAhrM0+D9hbjTQMQeHdP5zeuSr1ZzFh2mMOxprzTObuEBQ6aWDrFS382dl
g6u1IGKa2ICPvO3jtJeEv48urGCYfbsIWhOUfmdaeqs2Ygv86uKZyTeTR6pXp2Yg
aTphOEoQ49cTAzXtm6IGLceAHz6CETU9brxI8dmXy5DldPcv8sTToIDEdc6dNVdF
jn28jFPCK/DLkVFi+Vlg
=c68c
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
