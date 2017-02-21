From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH/RFC 4/6] drivers: firmware: psci: Fix non-PMIC wake-up if
 SYSTEM_SUSPEND cuts power
Date: Tue, 21 Feb 2017 12:07:30 +0100
Message-ID: <20170221110730.GF5021@amd>
References: <1487622809-25127-1-git-send-email-geert+renesas@glider.be>
 <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sDKAb4OeUBrWWL6P"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1487622809-25127-5-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Rob Herring <robh+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--sDKAb4OeUBrWWL6P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-02-20 21:33:27, Geert Uytterhoeven wrote:
> Nothing in the PSCI specification requires the SoC to remain powered and
> to support wake-up sources when suspended using SYSTEM_SUSPEND.
> If the firmware implements the PSCI SYSTEM_SUSPEND operation by cutting
> power to the SoC, the only possibly wake-up sources are thus the ones
> connected to the PMIC.
>=20
> Document and add support for an "arm,psci-system-suspend-is-power-down"
> DT property, so Linux uses a different suspend method when other wake-up
> sources (e.g. wake on LAN, UART or GPIO) are enabled.

Should we make PSCI return that information? (At least in next
specification version?)

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--sDKAb4OeUBrWWL6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlisH3IACgkQMOfwapXb+vKzXwCfQ6p0JaA1LF0N14R18duC62oM
BtQAniCV7LGV4EYlWZaVKjV9HXIMJfFp
=+vMA
-----END PGP SIGNATURE-----

--sDKAb4OeUBrWWL6P--
