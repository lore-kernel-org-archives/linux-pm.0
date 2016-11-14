From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 14 Nov 2016 12:04:30 +0000
Message-ID: <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
References: <CAMz4ku+5=LebdDB9waDD8GYQmYM=uxuOqN6hYZ+E1HSALa1GMQ@mail.gmail.com>
 <87k2cttptn.fsf@notabene.neil.brown.name>
 <CAMz4kuJPenbqf935EGW67UeqOiP48_Ti1Jf5YfJ_K=DEcrz++Q@mail.gmail.com>
 <87a8dls7yn.fsf@notabene.neil.brown.name>
 <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
 <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
 <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
 <87eg2ek7ye.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iubflgcycjlp7ucb"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87eg2ek7ye.fsf-wvvUuzkyo1HefUI2i7LXDhCRmIWqnp/j@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-IBi9RG/b67k@public.gmane.org>
Cc: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Jun Li <jun.li-3arQi8VN3Tc@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ruslan Bilovol <ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, grygorii.strashko-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB <linux-usb-u79uwXL29TZUIDd8j+nm9g@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


--iubflgcycjlp7ucb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 14, 2016 at 03:21:13PM +1100, NeilBrown wrote:
> On Thu, Nov 10 2016, Baolin Wang wrote:

> > Fourth, we need integrate all charger plugin/out
> > event in one framework, not from extcon, maybe type-c in future.

> Why not extcon?  Given that a charger is connected by an external
> connector, extcon seems like exactly the right thing to use.

> Obviously extcon doesn't report the current that was negotiated, but
> that is best kept separate.  The battery charger can be advised of the
> available current either via extcon or separately via the usb
> subsystem.  Don't conflate the two.

Conflating the two seems like the whole point here.  We're looking for
something that sits between the power supply code and the USB code and
tells the power supply code what it's allowed to do which is the result
of a combination of physical cable detection and USB protocol.  It seems
reasonable that extcon drivers ought to be part of this but it doesn't
seem like they are the whole story.

> > word, we need one standard integration of this feature we need, though
> > like you said we should do some clean up or fix to make it better.

> But really, I'm not the person you need to convince.  I'm just a vaguely
> interested bystander who is rapidly losing interest.  You need to
> convince a maintainer, but they have so far shown remarkably little
> interest.  I don't know why, but I'd guess that reviewing a complex new
> subsystem isn't much fun.  Reviewing and applying clear bugfixes and
> incremental improvements is much easier and more enjoyable.  But that is
> just a guess.

OTOH having someone else having reviewed might help them apply something
they don't care about.

--iubflgcycjlp7ucb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYKahOAAoJECTWi3JdVIfQgYwH/151x17Rs33bn9KTSNJJ3Vtw
0DjF1ncbUYMEokTPNWNxo8/x3XCQv8tFU7TTVps9ZUq7LjP5Y8aZovugPas7FXhC
8ozwgmL/SdG004C2GS6Tec60k+J32Wd5AeudYj5xeUJA14d/ZKs+cDqp+I+i8YOH
x64g+8x9Nqs6nA282557HN3Wqf48SNHhYkZDs2xEsWxht4HYIpAQAFIxlId+6Y9u
vUQ9ZtujYytP/76SRWV4F0HwYzmB2rPKwd1ftNpu5yqNAcIczLmRIAYYv69VRQQV
mzQU76JEMjZP7USNrrgwjfeAgWqnmg0UwOPx8XZHD/uxSjCvdvmr0aePk/8KDlc=
=VjTf
-----END PGP SIGNATURE-----

--iubflgcycjlp7ucb--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
