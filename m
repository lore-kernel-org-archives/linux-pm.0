From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 00/11] Add throttler driver for non-thermal throttling
Date: Thu, 28 Jun 2018 20:52:16 +0200
Message-ID: <20180628185216.GA5316@amd>
References: <20180607181214.30338-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>
List-Id: linux-pm@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-07 11:12:03, Matthias Kaehlcke wrote:
> This series adds the throttler driver, for non-thermal throttling of
> CPUs and devfreq devices. A use case for non-thermal throttling could
> be the detection of a high battery discharge voltage, close to the

voltage -> current.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAls1LmAACgkQMOfwapXb+vIyfACgsyILgIb3RCimjdyeOSMPEUfR
fHIAn2/X/IZxbUejdst4yYgL0rFAX+yF
=o9eh
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
