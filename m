From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Fri, 2 Oct 2015 14:11:25 -0500
Message-ID: <20151002191125.GC5552@saruman.tx.rr.com>
References: <cover.1443057229.git.baolin.wang@linaro.org>
 <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
 <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
 <20151002184909.GC12635@sirena.org.uk>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RyB1I56Pcq42iZjE"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151002184909.GC12635-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--RyB1I56Pcq42iZjE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 07:49:09PM +0100, Mark Brown wrote:
> On Fri, Oct 02, 2015 at 12:23:11PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 02, 2015 at 05:47:43PM +0100, Mark Brown wrote:
>=20
> > > Can you elaborate on what the difficulties are and how punting to
> > > userspace helps?  If anything I'd expect punting to userspace to make
>=20
> > the difficulty was mainly making sure all involved parties talk the same
> > language. I mean, you plug cable and detect charger (this is usually do=
ne by the
> > PMIC or by a BQ-type device - probably done at drivers/power_supply).
>=20
> > First difficulty comes right here. Power_supply notifies that we're att=
ached to
> > a charger (sometimes it can't differentiate a host/hub charger from a w=
all
> > charger), a few ms later you get a notification from the gadget that it=
 got
> > enumerated with a 500mA configuration. Depending on the order of things=
, your
> > load will be configured either to 2A (maximum host/hub charger current)=
 or
> > 500mA. Yes, this can be mitigated :-)
>=20
> > Focussing on this alone, you can have as much as 4 different subsystems
> > involved, all throwing raw_notifiers at each other. Now each of these s=
ubsystems
> > need to maintain their own state machine about what notification we have
> > received and what are the valid next states.
>=20
> OK, so part of the goal here was to outsource all the state machines to
> some generic code - what you're describing here is definitely a problem
> and the idea was to provide a central place that has the logic and makes
> the decisions about what we should be doing.  If we don't have that it's
> going to get messy.
>=20
> > I would rather have userspace be the single place getting notifications=
 because
> > then we solve these details at a single location.
>=20
> No argument on the place, making that place be userspace I'm less sold
> on.

fair enough. This would be an entire new entity, though, and users (charger=
s,
battery chips, USB controllers, USB PHYs, etc) should blindly notify this e=
ntity
and no care about what happened before or what are possible next states.

As long as we can guarantee that, then I'd be okay adding this to the kerne=
l.

> > > Things more difficult, if nothing else it means we need to get whatev=
er
> > > userspace component deployed in all relevant userspace stacks with
> > > appropriate configuration in order to do things.
>=20
> > but that will be a thing for the kernel too. We will have to deploy thi=
s new
> > kernel component in all relevant stacks with appropriate configuration =
in order
> > to do things :-) No changes there.
>=20
> Sure, but it's one project which is developed entirely in the open -
> that's a lot more manageable.

We can have a fully open source userland daemon too. Much like systemd, blu=
ez,
neard, and many, many others. Why wouldn't that be a thing ?

> > > We do punt a lot of configuration to userspace for audio because there
> > > are substantial device specific policy elements in the configuration =
and
> > > it's a far from painless experience getting the code and configuration
> > > deployed where people need it, definitely a not great for users.
>=20
> > it's the same for this situation. We will have a ton of device specific
> > configuration, specially with power delivery class, billboard class, the
> > alternate modes and so on. If we already do this part in userland, addi=
ng all
> > those extras will be, IMO, far simpler.
>=20
> Can you elaborate a bit?  As far as I can tell all those are still in
> the generic USB space rather than the sort of device specifics I'm
> thinking of.

let's consider the billboard class, for example. With the new Type-C connec=
tor,
the extra CC pins get added and power delivery messaging goes on top of
that. Billboard class gives us the opportunity to send a power delivery req=
uest
to mux the data pins on the TypeC connector to something completely non-USB.

So we could run NATIVE PCIe (single lane though) on top of this. Native
DisplayPort, Native Thunderbolt (which the Fruit company announced will swi=
tch
to type-C, so that will be a thing), native VGA... the list goes on and on.

At that point, this is not entirely USB realm anymore :-)

Similar applies to power delivery charging profile themselves. Not all prof=
iles
are mandatory. Some are optional and that will be completely device/board
specific. How an OEM implements that in the PCB is also completely
board-specific :-) Some might have a dumb IC hardcoding some messages, some
might have something largely more flexible.

> The things we've got with audio are a combination of tuning to taste and
> (even more importantly) very different ideas about what you want to do
> with an audio subsystem that influence how you set things up in a given
> use case.

the same thing will happen with Type-C and power delivery. There won't be t=
uning
to taste, of course :-) But there will be "very different ideas what what y=
ou
want to do with" your charging methodology.

> > > I think that where we can do it the bit where work out how the various
> > > components are connected and aggregate their functionality together is
> > > definitely a kernel job.  It means that userspace doesn't need to wor=
ry
> > > about implementation details of the particular system and instead get=
s a
> > > consistent, standard view of the device (in this case a USB port and =
how
> > > much power we can draw from it).
>=20
> > Actually, I was thinking about it in a more granular fashion. Kernel ex=
poses a
> > charger/power_supply, a few regulators, a UDC view and this single user=
space
> > daemon figures out how to tie those together.
>=20
> That sounds worrying - it means that new hardware support needs
> supporting in every userspace (it seems inevitable that there will be at
> least some reimplementations because that's fun) which gets old really
> fast, and every userspace needs to understand every topology.

very true, but it's also true for a kernel solution.

It seems like you want it in the kernel because of it being convenient :-)

> > The view here isn't really a USB port, it's just a source of power. But=
 how much
> > power we can draw from it depends on, possibly, a ton of different chip=
s and
> > different notifications.
>=20
> Right, yes - it's the power input/output associated with the USB port.
> The USB port is just the physical thing users can see so it's a good way
> to label it.  That could mean that we ought to move the aggregation bit
> into the power supply code of course, but then a lot of the decisions
> are going to be specific to USB.

in a sense, yes. But they can happen at a layer which knows nothing (or very
little) about USB. Here's an example:

Not everybody follows USB Battery Charging class. Some chargers don't short
D+/D- to signify they are a wall charger. Some will use different resistance
values on the ID pin to tell you how much current you can draw from them.

=46rom a PMIC (or something else) point of view, all it needs is a tiny cur=
rent
source and a an ADC, then it reports the ADC value to the upper layer. This
really doesn't even need to know that it's using an ID pin, or whatever.

> > > For the policy stuff we do want to have userspace be able to control
> > > things but we need to think about how to do that - for example does t=
he
> > > entire flow need to be in userspace, or can we just expose settings
> > > which userspace can manage?
>=20
> > considering the amount of different designs that are already out there =
and all
> > the extras that are going to show up due to type-c, I think we'd be bet=
ter off
> > exposing as much to userspace as possible.
>=20
> How different are the end goals of these designs really going to be
> though - that's more of the question for me?  Part of what the kernel is
> doing is hiding implementation details from userspace.  I'd expect
> userspace to be interested in things like the maximum current allowed in
> or out in a given mode rather than the details of how that is accomplishe=
d.

okay, this is a fair point :-) I just don't see, as of now at least, how we=
 can
get to that in a way that's somewhat future-proof. It seems like we will
add more and more notifications until we can't maintain this anymore.

Say, we get a "certifiable" USB BC1.2 solution in the kernel. Current syste=
ms
are happy, we drop yet another out-of-tree set of patches from AOSP, every =
holds
hands and sings Kumbaya.

In another year or so, power delivery will be *the* thing. Now all the work=
 done
assuming BC1.2 is gone, outdated. Adding power delivery brings an entire ne=
w set
of requirements. A new protocol stack (yes! it runs on CC pins, remember ?)=
, new
messages, etc etc...

With Type-C there's no port type anymore. What we used to refer as Host/Hub
Charger, Standard Port, Charging Port, Wall Charger, etc, now becomes a sin=
gle
type (let's call it type-c for short) which can provide profiles. These pro=
files
are negotiated using that new stack I pointed out above, not by checking
resistance on data lines or ID pin.

If we're not careful, it will be really difficult to make power delivery fit
into this.

Add to that the fact that the same power delivery pipe (the CC pins) can be=
 used
to tell the other end of remux the pins to e.g. PCIe, and s**t just hit the=
 fan
:-)

In short, whatever we do, needs to consider coping with incoming requests f=
rom
userspace at a minimum because userspace will need control over the port
alternate modes. I mean, don't get me wrong, these is all uber-cool to me, =
but
it'll be a pain to make a flexible/generic solution :-)

> > > I'm not sure that the NFC model is working well for everyone - it's OK
> > > if you happen to be running Android but if you aren't you're often le=
ft
> > > sitting there working out what to do with an Android HAL.  We can do =
the
>=20
> > NFC works pretty well for neard, afaict. And without android.
>=20
> Ah, that looks better than it was now - it looks like they're providing
> a reasonable hardware abstraction for messaging.  Still, there's other
> examples of this model that are less successful where the kernel
> interface isn't generic.
>=20
> > The real difficulty here is coming up with an interface which we're agr=
eeing to
> > supporting for the next 30 years. Whatever that is, as soon as it gets =
exposed
> > to userland, we will have to support it.
>=20
> To me that sounds like an argument for hiding things :)

the problem with hiding, though, is that once something new comes about, it
might not fit our current abstraction and it might be big PITA to support "=
old"
and new systems.

> > And this another reason I think a more granular approach is better, as =
it allows
> > us to easily add more pieces as they come along.
>=20
> OTOH it's more work for the system as a whole.

it's more work outside the kernel, yes. The total amount of work (kernel +
userspace) will be the same, regardless if you hide it in the kernel or in =
userspace.

--=20
balbi

--RyB1I56Pcq42iZjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWDtbdAAoJEIaOsuA1yqREUbEQAJNlKD9vsqmGf5B7dEQaBdgI
BHzglMfaTlsjToBVWd9LoTvy0xTQajSUOl9dgFCCZ6/3GtbP/WP/mTGtf3qS/Nfs
IE5Q4b5HgXRi2H/+R32dYUXmnkRT+BIXGjDwBLTZNxTbPx7Bqy/mu7Z8tZOyU7NV
5ZW2XqGh9wuDUihtnYqFcWQkp6MKhe9fbIh6ZWYXO1cYK8ZZd+cGyQ0kQeKYmh9F
C/bzmTKAJYG9WkJ8emXTWBq4gSEjY9rh/pjk3VYud0fPJt42Loi4RFgm20uo0ruU
qogKo+aSR5BErIDjsiZUZn6iAbHn9PQk8Tb/+9rYDZvc0l7G76lp8JvcsohjYODf
QTW+6uwv6D57fY8Tf6oWFQ9Sb15ajYTWPj64gRT2MC7CetTYokwWaivPW6ljq6E8
ZXmJ871n0QXYtdd2+dMWNd4uwDZ2fF4v50j+tYfAMK5CzlXkEX6tAqT15FS1XBIC
K9Fi/MViLTAiQmQ2OCSPRX8Qhpim/3TyQI3117wEe38p9SuIUuU19n876WSA15ic
j/1udEDoQ5vAcwcZ5F+O2mB6j5nxSxjChvfDODYxjw4lL9ieDS/orcc5hWXPzGoG
V4BWQXVXW+4/1Y1EbzPNeJ9MUgGvrL/c38xCF2H4hPMKwvM7hNIUa53Zq+/x2Sq8
MJcnfs32fI/ZHBhLlWyp
=n7tF
-----END PGP SIGNATURE-----

--RyB1I56Pcq42iZjE--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
