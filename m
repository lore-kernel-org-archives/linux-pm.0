From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 0/6]  thermal: add devm_ version of thermal_zone
 register and driver for max77620
Date: Wed, 9 Mar 2016 10:29:43 -0800
Message-ID: <20160309182941.GA2422@localhost.localdomain>
References: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457529010-6538-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, rklein@nvidia.com
List-Id: linux-pm@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Laxman,


On Wed, Mar 09, 2016 at 06:40:04PM +0530, Laxman Dewangan wrote:
> The series add the devm_ version of thermal_zone_of_sensor_register/
> unregister, interface details, and use this in new thermal driver
> for max77620.
>=20
> The header file for max77620 is part of MFD patch
> 	https://lkml.org/lkml/2016/2/11/186
>=20
> Changes from V1:
> - Run checkpatch with --strict and fix all warnings.
> - Added details of interfaces in spifs-api.txt
> - Added DT binding doc.

Thanks a lot for working on the comments. I don't see anything specific
right now. So, I am starting a couple of automated testing on this
series. If I find something, I will let you know.


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW4GuRAAoJEMLUO4d9pOJWZpgH/0trb9THVANsjjjBDWoSgvyF
dFkEuCa/I0XUDuAeM7XLeEBFKzKaiDoQXoHYTyXKUiZgNANqjzGbYS79Y7VvmAv9
tHtZCT94VIjBNfW3bcG6qTMtJERpq6UpiDGI6LSS8EBekQQkVNhtMLxV/xnYTbi9
pCrRuN6HtbRWhKZc12Zt0e1u3tS8KLPZqdDqG3nDeinN2UTHdNbBmcdOgBlyMAfP
qbWwpFQ5x+1r3apms3OusnvKA+CM+2bPGeyndyl79NeSLr5DNg7kl58/v5mL1lLV
Yp6P5qUW1lyImNe3HqCEwuCj1YlycWbJitWu6sxFoGH2QMO8cF2YMDgv7G8yMUA=
=Jpol
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
