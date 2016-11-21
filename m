From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v18 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Mon, 21 Nov 2016 17:17:12 +0000
Message-ID: <20161121171712.wo2qsnnqnnsnej26@sirena.org.uk>
References: <CAMz4kuJdp+ijur_mDjcG3aghn8Q1gnJsTfFWBEiKWcdVQPMj7g@mail.gmail.com>
 <871sytqrqh.fsf@notabene.neil.brown.name>
 <CAMz4kuJV5wiCpWJF=-YpTf1sjNrOqjc53iRYmGoEQepqtrfUdA@mail.gmail.com>
 <87a8dbni27.fsf@notabene.neil.brown.name>
 <CAMz4ku+qY4U7=v5nEBEdPTjwki8j10jYbQuokz785NEy5SzYmg@mail.gmail.com>
 <87eg2ek7ye.fsf@notabene.neil.brown.name>
 <20161114120430.hpnetdedyofhlkad@sirena.org.uk>
 <87mvh1iw32.fsf@notabene.neil.brown.name>
 <20161116161605.smif6kf3mdhdhyhd@sirena.org.uk>
 <87fumqhadm.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cxmo24i4btjcftds"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87fumqhadm.fsf@notabene.neil.brown.name>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neilb@suse.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, John Stultz <john.stultz@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel>
List-Id: linux-pm@vger.kernel.org


--cxmo24i4btjcftds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2016 at 05:46:13PM +1100, NeilBrown wrote:
> On Thu, Nov 17 2016, Mark Brown wrote:

> > To me that's pretty much what's being done here, the code just happens
> > to sit in USB instead but fundamentally it's just a blob of helper code,
> > you could replace the notifier with a callback if that's the big concern
> > here.

> It is a lot more than "just a blob of helper code".  It duplicates
> existing infrastructure instead of fixing and using the
> infrastructure.... but I've said all this before.  Repeatedly.

My read on that is that the question of what we want to be responsible
for aggregating the information about what power the system is allowed
to draw from a given USB port hasn't been resolved yet and that apart
=66rom that you're fairly close.  It seems to me like that's really what
the difference between your two positions is.  Fixing the existing
notifiers implies that things have to be aggregated in the power supply
drivers but Baolin is proposing doing that in the USB code instead.  It
does seem at least worth considering if that's a good idea since the
current situation doesn't look terribly thought through.

There are a whole bunch of things that need to be sorted out whatever
the decision is like the extcon related cleanups you mentioned in your
mail the other day (steps 1 and 2), it seems like those could be moved
forwards independently.

By the way it occurred to me recently that we have a use case for
multiple USB ports that could supply power - USB C.  Things with more
than one port like things in a laptop form factor are going to want to
be able to use all of them interchangably for power support (likely only
one at a time, at least initially, but still more than one port).

--cxmo24i4btjcftds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYMywXAAoJECTWi3JdVIfQ+/UH/A6pWKUZE6+wTRLp6JQ6Dv5x
uC2Wkmf6YCsXS5Qw4qsk9B2qhVYlDADvljoaHbUboEbZ7Eq/MyOfUR6Lj9P2k/FZ
jf8EN9E0gFhypi7h9iAfCEeRIVBiYbreKsRvESs/JdXCnziKsp1f4pEdALFZFUSm
VqwAtcvjBc6ATMt+YpIEdS8HAL4vFMxuv2r1qJbJMM98cd1Oih2i+TkuQbxyMI9q
nUTKuOEboATKnacIwFBs+JKdBPou4cHFiYEuxtJY0OL4iuVtwtQNfohveY35FE7r
UZM1Cp23mvRwrzQsVC3V91sdVwsOyuq4Olkg/fyt+TFubomAKfj+DE4mOP8fqk4=
=Je91
-----END PGP SIGNATURE-----

--cxmo24i4btjcftds--
