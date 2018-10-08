From: Quentin Schulz <quentin.schulz@bootlin.com>
Subject: Re: [PATCH v2 0/6] AXP8x3 AC and battery power supply support
Date: Mon, 8 Oct 2018 09:11:48 +0200
Message-ID: <20181008071148.ownj4qcnhcfomoxq@qschulz>
References: <20181004193410.7265-1-oskari@lemmela.net>
 <20181006211836.28253-1-oskari@lemmela.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i44lbaa3bc7msglc"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181006211836.28253-1-oskari@lemmela.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oskari Lemmela <oskari@lemmela.net>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Lee Jones <lee.jones@linaro.org>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--i44lbaa3bc7msglc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Oskari,

On Sun, Oct 07, 2018 at 12:18:30AM +0300, Oskari Lemmela wrote:
> AXP813 AC power supply support with input current and
> voltage limiting support.
>=20
> AXP803 AC and battery power supply support.
>=20

Great to see a new developer taking interest in those PMICs :)

I received the v2 patch series as answers of the v1 patch series, you
would want to fix that by sending a separate patch series. Using the
name of the cover letter of the patch series and the author, it's
usually good enough to find previous versions if we need to, you don't
need to send the new patch series as answers of the first patch series.

Thanks,
Quentin

--i44lbaa3bc7msglc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEXeEYjDsJh38OoyMzhLiadT7g8aMFAlu7AzQACgkQhLiadT7g
8aOYRhAAm3kvNqnB7Dtx1+jtEmkzB/mNr45+kkOD62HL7NFOVGG2MujW5tUx0coQ
d/ixFpzfZJSnqVLV+sEIX/DCA0DkfED7biIeHvjkfcc3btYx2BFOdAeZLoiMpkDz
mfz4rVNvci+U2LmCNpi24Zq75+xATt50i91M5ZIeeLDc0Wmi5Ttw56thmOY9mZ75
MBKdp9yXVZFq9S1TBVOeZbXJwUETfkJ6Bo32AKcZMMu3S5bAxSyLYmmxAllL1biB
k5unczXza3ZbzJ+FLj5JVPPkMyGonkyveo/3/zEGD9qmQpqNfmkfXV0mIodfbmP4
AjSL3rgF/8AUQl0t/TKSY/T7Q9JQgTvCZrQR4CxsbBnhEy2XyHZwsDmKSORGxKIo
hAH2SWFaGX1EsU/H66bLqxi7YP+D1J6uSjA0bgQDmq6Wlct2lii6gvUibDzS1AhA
0f+tGQgUnxM1t0qWffAQ7u3F75dhj2osGPLbjd3MYnHfRY9nglGcISCEe6/9Z0eD
m7rg/VRIqpu5Q832dfBPAvp9ysNxltRgGXtIEGHJ3b+sAPSLBmngUxBTVwuR5fZy
Bdr06Iw+zrdc3lgfC2Zeprb82W8QQCUYx/8dT3DymMo7uBN0cgl73eC3ooh+4tqs
55uoYqy0opzYDaGERBiYvJELt63w7oSEdY1Z9+Qcaz+DoxFBYBc=
=dhIy
-----END PGP SIGNATURE-----

--i44lbaa3bc7msglc--
