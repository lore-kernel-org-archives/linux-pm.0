From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 12:23:11 -0500
Message-ID: <20151002172311.GI5552@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JIpyCmsTxyPLrmrM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51307 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbbJBRYE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 13:24:04 -0400
Content-Disposition: inline
In-Reply-To: <20151002164743.GR12635@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org

--JIpyCmsTxyPLrmrM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 02, 2015 at 05:47:43PM +0100, Mark Brown wrote:
> On Thu, Oct 01, 2015 at 12:58:49PM -0500, Felipe Balbi wrote:
> > On Thu, Oct 01, 2015 at 06:43:08PM +0100, Mark Brown wrote:
> > > On Thu, Oct 01, 2015 at 12:29:32PM -0500, Felipe Balbi wrote:
>=20
> > > > Frankly, I wanted all of this to be decided in userland with the
> > > > kernel just providing notification and basic safety checks (we don't
> > > > want to allow a bogus userspace daemon frying anybody's devices).
>=20
> > > What's the advantage of pushing this to userspace?  By the time we
> > > provide enough discoverability to enable userspace to configure itself
> > > it seems like we'd have enough information to do the job anyway.
>=20
>=20
> > you're going to be dealing with a setup where each vendor does one thing
> > differently. Some will have it all in the SoC part of a single IP (dwc3=
 can be
> > configured that way), some will push it out to companion IC, some might=
 even use
> > some mostly discrete setup and so on...
>=20
> Right, and that was exactly what this was supposed to be all about when
> I was discussing this originally with Baolin (who's on holiday until
> sometime next week BTW, hence me answering).
>=20
> > We're gonna be dealing with a decision that involves information from m=
ultiple
> > subsystems (USB, regulator, hwmon, power supply to name a few).
>=20
> Sure, that was part of the idea here - provide a central point
> representing the logical port where we can aggregate all the information
> we get in and distribute it to consumers. =20
>=20
> > We tried doing it all in the kernel back in N800, N810 and N900/N9 days=
 and it's
> > just plain difficult. To make matters worse, N900 had two USB PHYs, one=
 for
> > actual runtime use and another just for detecting the charger type on t=
he other
> > end.
>=20
> Can you elaborate on what the difficulties are and how punting to
> userspace helps?  If anything I'd expect punting to userspace to make

the difficulty was mainly making sure all involved parties talk the same
language. I mean, you plug cable and detect charger (this is usually done b=
y the
PMIC or by a BQ-type device - probably done at drivers/power_supply).

First difficulty comes right here. Power_supply notifies that we're attache=
d to
a charger (sometimes it can't differentiate a host/hub charger from a wall
charger), a few ms later you get a notification from the gadget that it got
enumerated with a 500mA configuration. Depending on the order of things, yo=
ur
load will be configured either to 2A (maximum host/hub charger current) or
500mA. Yes, this can be mitigated :-)

Focussing on this alone, you can have as much as 4 different subsystems
involved, all throwing raw_notifiers at each other. Now each of these subsy=
stems
need to maintain their own state machine about what notification we have
received and what are the valid next states.

I would rather have userspace be the single place getting notifications bec=
ause
then we solve these details at a single location.

> Things more difficult, if nothing else it means we need to get whatever
> userspace component deployed in all relevant userspace stacks with
> appropriate configuration in order to do things.

but that will be a thing for the kernel too. We will have to deploy this new
kernel component in all relevant stacks with appropriate configuration in o=
rder
to do things :-) No changes there.

> We do punt a lot of configuration to userspace for audio because there
> are substantial device specific policy elements in the configuration and
> it's a far from painless experience getting the code and configuration
> deployed where people need it, definitely a not great for users.

it's the same for this situation. We will have a ton of device specific
configuration, specially with power delivery class, billboard class, the
alternate modes and so on. If we already do this part in userland, adding a=
ll
those extras will be, IMO, far simpler.

> > On top of all that, we still need to figure out what to do when a parti=
cular
> > configuration gets chosen, and what to do when the bus goes into the di=
fferent
> > suspend levels.
>=20
> > It's going to be a lot of policy getting added to the kernel. On top of=
 all
> > that, when Type C and power delivery is finally a thing, there will an =
entire
> > new stack for USB C commands (using the Type C CC pins or modulated on =
VBUS for
> > legacy connectors) which we will have to add to the kernel. And differe=
nt
> > devices will support different charging profiles (there are at least 6 =
of those,
> > IIRC).
>=20
> Yes, USB C was part of the thinking with starting this work - it's going
> to make ensuring that the system is paying attention to limits much more
> important.  I think there's two things here.  One is working out how the
> system is glued together and the other thing is working out what to do
> with that system.

right, and IMO, what to do should be a decision made outside of the kernel =
as
long as kernel provides safety.

> I think that where we can do it the bit where work out how the various
> components are connected and aggregate their functionality together is
> definitely a kernel job.  It means that userspace doesn't need to worry
> about implementation details of the particular system and instead gets a
> consistent, standard view of the device (in this case a USB port and how
> much power we can draw from it).

Actually, I was thinking about it in a more granular fashion. Kernel expose=
s a
charger/power_supply, a few regulators, a UDC view and this single userspace
daemon figures out how to tie those together.

The view here isn't really a USB port, it's just a source of power. But how=
 much
power we can draw from it depends on, possibly, a ton of different chips and
different notifications.

> For the policy stuff we do want to have userspace be able to control
> things but we need to think about how to do that - for example does the
> entire flow need to be in userspace, or can we just expose settings
> which userspace can manage?

considering the amount of different designs that are already out there and =
all
the extras that are going to show up due to type-c, I think we'd be better =
off
exposing as much to userspace as possible.

> > With all these different things going on, it's best to do what e.g. NFC=
 folks
> > did. Just a small set of hooks in the kernel, but actual implementation=
 done by
> > a userspace daemon. This makes it even easier for middleware developmen=
t since
> > we can provide a higher level API for middleware to talk to the chargin=
g daemon.
>=20
> I'm not sure that the NFC model is working well for everyone - it's OK
> if you happen to be running Android but if you aren't you're often left
> sitting there working out what to do with an Android HAL.  We can do the

NFC works pretty well for neard, afaict. And without android.

> middleware thing without going quite that far, we do already have power
> management daemons in userspace even on desktop (GNOME has upowerd for
> example).

right

> > Another benefit is that this charging daemon can also give hints to pow=
er
> > management policy that e.g. we're charging at 10W or 100W and we can e.=
g. switch
> > to performance governor safely even though battery is rather low.
>=20
> We definitely want userspace to be able to see the current state, even
> if it just passes it straight on to the user it's a common part of UIs
> on both desktop and mobile operating systems.
>=20
> > Anyway, there's really a lot that needs to happen and shuving it all in=
 the
> > kernel is, IMHO, the wrong decision. I would be much happier with minim=
al safety
> > requirements in the kernel and let a userspace daemon (which we should =
certainly
> > provide a reference implementation) figure out what to do. This might b=
e better
> > for things like Chromebooks and Android phones too which might make com=
pletely
> > different decisions given a certain charging profile.
>=20
> Saying we don't want to have absolutely everything in kernel space
> doesn't mean we should have nothing at all there, doing that seems like
> going too far in the other direction.

we _have_ to have something in the kernel :-) I'm arguing that we might not=
 want
as much as you think we do :-)

The real difficulty here is coming up with an interface which we're agreein=
g to
supporting for the next 30 years. Whatever that is, as soon as it gets expo=
sed
to userland, we will have to support it.

And this another reason I think a more granular approach is better, as it a=
llows
us to easily add more pieces as they come along.

--=20
balbi

--JIpyCmsTxyPLrmrM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDr1/AAoJEIaOsuA1yqREeP4P/3sEfki5d9fYMA+T0ToXZXAo
ZWzt49P9QJPi1FxNbiLhTeww8mkSEYNeUlEgmbudFjflONcr1kafqk7CDnCQ1rh0
pJQs6xtqkfCtWEVGzQ7EF33VcadTCbhYZk4s3Yxdk5QPACV7cuqlGAlKJPHQ06hq
XCLbsx96NZASGfFR78YysuaoswMXRUStGWFFr3Pk4RmsZNuxtRGZuW1GU4UcuThG
we28spH6YT8KXJlOXWuSCr64OFfsIQ2hLnD8RK0Vdf8v+oOGceqBre8HXeI/2Ofn
MfYa9+/Uc9Oa3knHLRNGHVBUY5RvY7reDqB9nNo9RqAgzpGRSEOid7XRJpiZtJmX
U4aM1T5zlaIPHkjp3O6P/GPN05jA9y0ndzfnQ6oBKLKkcnsfNOgSKXVDLscD9ejy
hVr4EvRCa3BImLz/+zSrEHYYpyWORTCI7aqUapHlE0g1sXmSLwVq+z0oKwa7x7xZ
rwb/AKl/W6c1H9KZojOXNK/CieoEt70zxrzE6y6Cy1RuIHvsnhCiScAdbI9nMvSL
5i7Pq6T+UUGel6jdz/RQ+wpqrRlkAoPrfIb+MuUmI1eoPhEhejPfb08DCo/qAWhw
ErfAVpyWk+x2zu984Ct7lESwsB8uDS3hQdR/ZGA1FBfrppM9Ge3vfs/r4HDyVcuZ
l4ldR3HBpMSZd3DH+Vtf
=PBIy
-----END PGP SIGNATURE-----

--JIpyCmsTxyPLrmrM--
