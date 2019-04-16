From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RESEND PATCH v3 1/2] power: supply: add input voltage limit
 property
Date: Tue, 16 Apr 2019 09:19:41 +0200
Message-ID: <20190416071941.GB14538@amd>
References: <20190415220049.14924-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415220049.14924-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-pm@vger.kernel.org, sre@kernel.org, Sameer Nanda <snanda@chromium.org>, bleung@chromium.org, rjw@rjwysocki.net, gwendal@chromium.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, groeck@chromium.org, Adam.Thomson.Opensource@diasemi.com, kernel@collabora.com
List-Id: linux-pm@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch exposes a new property, similar to input current limit, to
> re-configure the maximum voltage from the external supply at runtime
> based on system-level knowledge or user input.

Well, and I suspect it should expose input power limit, not input
voltage limit.

DC-DC convertor efficiency normally does not much depend on input
voltage....

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAly1gg0ACgkQMOfwapXb+vIwfACfdFHwprUPu+40TOX0mT/D2Q1Z
y/gAoKzB8tOLf82MCBIKKEQTadtoz1Q5
=Z/JO
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
