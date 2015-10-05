From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Mon, 5 Oct 2015 11:29:04 -0500
Message-ID: <20151005162904.GF18784@saruman.tx.rr.com>
References: <20151001172932.GG4469@saruman.tx.rr.com>
 <20151001174308.GL12635@sirena.org.uk>
 <20151001175849.GH4469@saruman.tx.rr.com>
 <20151002164743.GR12635@sirena.org.uk>
 <20151002172311.GI5552@saruman.tx.rr.com>
 <20151002184909.GC12635@sirena.org.uk>
 <20151002191125.GC5552@saruman.tx.rr.com>
 <20151004225506.GD12635@sirena.org.uk>
 <20151005151511.GA18784@saruman.tx.rr.com>
 <20151005161833.GZ12635@sirena.org.uk>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bFsKbPszpzYNtEU6"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151005161833.GZ12635-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--bFsKbPszpzYNtEU6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 05, 2015 at 05:18:33PM +0100, Mark Brown wrote:
> On Mon, Oct 05, 2015 at 10:15:11AM -0500, Felipe Balbi wrote:
> > On Sun, Oct 04, 2015 at 11:55:06PM +0100, Mark Brown wrote:
>=20
> > > The trouble is getting traction on adoption.  Vendors have a habit of=
 doing
> > > things like finding problems and rather than reporting them deciding =
that the
> > > open source solution isn't great and going and writing their own thing
> > > (especially when they're in stealth mode) rather than talking to anyo=
ne.
> > > Sometimes we manage to avoid that but it can be challenging, and ofte=
n we only
> > > even hear about the new thing after it's shipping and there's a lot o=
f inertia
> > > behind changing it.  The kernel ABIs tend to be a lot sticker than us=
erspace
> > > things here.
>=20
> > but this is not a solid enough argument to push anything into the kerne=
l.
>=20
> To my mind it is a concern when considering design - it's not the only
> consideration certainly but it should influence if or how we split
> things.

sure

> > > > the same thing will happen with Type-C and power delivery. There wo=
n't be tuning
> > > > to taste, of course :-) But there will be "very different ideas wha=
t what you
> > > > want to do with" your charging methodology.
>=20
> > > Are those very different things about the use cases ("don't bother wi=
th
> > > high speed data, get all the power you can" or whatever) or are they
> > > about the details of the board?
>=20
> > I'm pretty sure there will be interesting designs in the market. I'm pr=
etty sure
> > there will be type-C systems which won't support USB 3.1 for example, e=
ven
> > though they'll support USB Power Delivery in its entirety.
>=20
> That's sounding like generic USB stuff to me.
>=20
> > > Yes, definitely - my experience both in terms of watching how people
> > > like handset vendors often work internally and in terms of getting
> > > things adopted is that it's a lot easier if you can have one component
> > > you need to update to handle new hardware rather than multiple ones t=
hat
> > > need to be upgraded for things that are purely board differences.
>=20
> > IMO, just because you have it in the kernel, it doesn't mean it'll be
> > adopted. Look at pm_runtime, for example; it's a very nice API and, yet=
, not
> > used by Android (or has that changed ?)
>=20
> That's always been a bit of a myth - most Android systems use runtime PM
> extensively when they're running, the discussion is really about the
> edge case where you're idling the system.  The Android suspend behaviour
> is about the system idle case and is as much about providing a simple
> way to go into an idle state, especially bearing in mind that they have
> apps installed from the app store there, as anything else.  It's the
> making sure things are idle part of things that's different.

okay

> > > > okay, this is a fair point :-) I just don't see, as of now at least=
, how we can
> > > > get to that in a way that's somewhat future-proof. It seems like we=
 will
> > > > add more and more notifications until we can't maintain this anymor=
e.
>=20
> > > So we need to look at the new/upcoming USB specs and understand the
>=20
> > not upcoming, it's already out there.
>=20
> I assume there's ongoing work on further revisions to the spec though?

that'd be a correct assumption

> > > Does the problem not get easier if we break it down to just the charg=
er
> > > elements and realise that the USB C modes are going to have a lot more
> > > policy in them?
>=20
> > the thing with USB C is that it's not only for negotiating a charging p=
ower
> > (with power delivery you're not necessarily tied to 5V, btw), that very=
 stack
> > will also be used to change to other alternate modes, and those can be =
anything:
> > Thunderbolt, PCIe, DisplayPort, etc.
>=20
> Surely these features have sufficient orthogonality to allow us to split
> things up and deal with some of the problems while providing spaces for
> future work?

yeah, might. As long as we keep that voice in our heads that things are lik=
ely
to change.

--=20
balbi

--bFsKbPszpzYNtEU6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEqVQAAoJEIaOsuA1yqREcbYP/RBFBvirYK/nxz2UOoqvxCWr
1FHMSHrC6IGFukPZcy+4H0V0msW1xJfqeM4Tmv8DNt6EZODPUf8FlIxcSVmxBKuE
JIxTgWszQqQev/qUC9FunXALkhObhv1+yIXjKt6ichFDvp9lW465jyv4bgewudPI
EtNjtTo6Rw+BYmbjBo3TRM/bL9WKw118D1acH43WX/MHS69U69oTSkGT5F9I7YQq
gnGydYzR/259YLx4Kuc0zKX4LXoNv2xPyQVr1KfTo5UqA464ry2CEKSTmQBihhQC
TE3WLNu9kRcnb8lQgYoak/VLbqhsy9dFwZD9yVd3766fhsHFMpV6chDtkiIY0k9A
4QS33H0IwPPn4bkaQZLFFAmc5A/nauN+/WkOzQMbUnU/WqT7/4UwC+GlwU00rVMz
/MK/D9J8oxrrAuJSG9skAo3ymjUGIb1ZqamA4xIlQ6pLaFoHrSBgclVR71gEUpHO
i9IyQ++XqJizc93qBuI/HYlvl4vHJrrW5jTGbxrK2Geo5FskwUGlTVFv2bu5904q
eBI8HULhQ+5HxE5Qy2mQW21CNEj5gNc+30rfrmd7UA1tR8uOuPJrnY6bWS6flTmK
DgXTQMGFyOVywHDadFobE7boOjLor3DYbnifRP6Idch+7VDVs57YixmXamxtF66T
ryg9nN/l3G3f0wQ4ZyZ+
=6OnF
-----END PGP SIGNATURE-----

--bFsKbPszpzYNtEU6--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
