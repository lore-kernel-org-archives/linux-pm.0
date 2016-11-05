From: Pavel Machek <pavel@ucw.cz>
Subject: Thinkpad power management (was Re: v4.8-rc1: thinkpad x60: running
 at low frequency even during kernel build)
Date: Sat, 5 Nov 2016 20:24:43 +0100
Message-ID: <20161105192443.GA5018@amd>
References: <20161104083849.GA32688@amd>
 <20161104085830.GA4089@amd>
 <20161104091037.GD3414@vireshk-i7>
 <20161104092636.GA30729@amd>
 <20161104093105.GE3414@vireshk-i7>
 <20161105182121.GC17290@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161105182121.GC17290@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, rui.zhang@intel.com, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat 2016-11-05 16:21:21, Henrique de Moraes Holschuh wrote:
> On Fri, 04 Nov 2016, Viresh Kumar wrote:
> > On 04-11-16, 10:26, Pavel Machek wrote:
> > > How would I know if it is thermal capping? There's nothing in dmesg.
> >=20
> > I am not sure what code is responsible for doing that in case of x86, m=
aybe
> > Rafael and Rui can explain it that better.
> >=20
> > But surely it involves userspace in this case as scaling_max_freq is ge=
tting
> > changed.
>=20
> Note that a X60 might limit the maximum frequency through ACPI when on
> AC *and* its battery is not installed or not in working order.
>=20
> The EC tries to detect the power brick type (65W, 90W), which often
> doesn't work well on non-Lenovo power bricks, and signals the BIOS to
> limit the maximum frequency if it thinks its only power source is a 65W
> power brick.

> This behavior would be readly visible by the X60 refusing to reach the
> maximum clock frequency *at all* -- it is a static limit, only removed
> when a sufficiently charged battery becomes available.

Umm. I don't think it is this -- maximum frequency is reached when
machine is cold. It does have reasonably good battery. I guess I
should also mention that it is currently running off 19V, 50.5W power
brick. [If EC can figure it out, I guess it will hate me :-)]

> Anyway, this overheating thinkpad very, very likely needs a hardware
> repair (on top of the kernel bug fixes ;-) ).

Ok, lets do kernel fixes, first :-).

> Regardless of any kernel/userspace bugs, the X60 was engineered to not
> require thermal capping on reasonable indoor environmental temperature
> ranges.  If it needs the kernel to do something at all to avoid
> overheating just because it has been running at full CPU power, and
> ambient temperature is below 28=B0C, it very likely has a hardware issue
> (lint on the heatsink/fan, and/or cracked thermal interface between
> heatsink and processor).
>=20
> Every old-style ThinkPad (like the X60) that I have ever seen
> overheating when running at full CPU power (after fan lint was removed)
> in a cool place (say, 26=B0C), stopped overheating after a heatsink reseat
> and thermal compound replacement (and if you're going to do it, use
> non-shelf-aged Arctic Silver 5 or something better, and "cure" it
> properly -- something rather easy to do on a ThinkPad X60).

Aha, thanks, good to know. Temperature is something like 19C, so it is
not hot here, but a) I'm using it on soft surface and b) the legs are
long gone.

I was actually looking at newer thinkpad, but anything newer than X220
seems to have horrible keyboard... X220 looks reasonably nice, but
people warned me that X60s are built from better materials, and I
realize that X220 may have rowhammer bug...

So I guess X60 is going to stay a bit longer :-).

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgeMfsACgkQMOfwapXb+vIluACfSVWWVxy+x6eWkCg4qDY9Eq1I
q1IAnioz1rxBEK//PNpfEVMK5gOrtAff
=WyK1
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
