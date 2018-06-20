From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change
 notification
Date: Wed, 20 Jun 2018 11:35:58 +0100
Message-ID: <20180620103558.GA6242@sirena.org.uk>
References: <20180619135518.8990-1-geert+renesas@glider.be>
 <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com>
 <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
 <2523505.Jaak4fIuPm@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2523505.Jaak4fIuPm@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 20, 2018 at 10:02:41AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
> > On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> w=
rote:
> > > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven

> > In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
> > driver-specific "backup_mode" sysfs file.
> > In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/3=
45),
> > I changed that to use the standard "wakeup" file in sysfs, in response =
to
> > a comment from Mark Brown.

> Well, I'm not convinced that this is the right approach, though.

The original description of the changes made it sound like this
controlled if the power switch would make the device resume from suspend
or not which seems like a wakeup to me.  Honestly as things are I've no
idea what the hardware designers were thinking or how to explain what
this stuff is doing.

> > Do you still prefer a driver-specific sysfs file?

> Yes, I do.

The flip side of that is that either suspend and resume or poweroff are
broken for userspace unless they know about this magic sysfs file which
isn't great either. =20

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsqLgsACgkQJNaLcl1U
h9A1WAf/W+iAzmIxCA5P/0REMQRGGV0f8DvyQNyWjw14r2tgeam4ICyj2O9MDiPK
6eBbLg2K2l0Mb8H70GN0pStm68Eu0Cezl3E0h3Reup6iEIJ3vU+AhMlmjW5Fsi+R
wkOJV7DIdicsDCT5laA+D/RESmrZs8xjKDiZCLnkbjlZ/1IH/TQvMsk+9ms5YrSa
odXmHYBBTEwoc/ovHdZeWZXD6JaHYF/59nyXWE9Xi/hPSzHINRuxbiXh5ypAtKxz
bFt+OANtju9USl5yiT7SaONKYKxXsi3XIaR8GlXG7CkkAg0fYWOtwNRdMvfT8tPi
Xg82aAzpzLnDPXh3sbP9L/khnllCEg==
=I5Ee
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
