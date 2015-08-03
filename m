From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Mon, 3 Aug 2015 19:29:51 +0200
Message-ID: <20150803172951.GE4856@earth>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
 <20150802065343.GA32270@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33493 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbbHCR35 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 3 Aug 2015 13:29:57 -0400
Content-Disposition: inline
In-Reply-To: <20150802065343.GA32270@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 02, 2015 at 08:53:43AM +0200, Pavel Machek wrote:
> On Fri 2015-07-24 17:28:13, Vaishali Thakkar wrote:
> > Use devm_kasprintf instead of kasprintf. Also, remove various
> > gotos by direct returns and drop unneeded label err_free_name.
>=20
> What happens if some /sys file is still open when the device is
> removed?

There is currently discussion about this on LKML:

https://lkml.org/lkml/2015/7/15/731

-- Sebastian

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVv6UPAAoJENju1/PIO/qatagP/iEWwgG8T0HM20mzQs7StBNK
T8LP4WLa9Zz2GuBb0SOw7sXQIKgfzFYzV+fWDzsuxdJGmkFjtXjGo11/NCf5BLXG
LkDG5TSgHqGYpq5SiXJWVtlJVS/rhl/ZnocjxVpepuHKgZhBDep2t3FZxwb2vWCF
fIt3OP7kIliSa7UxBOUs43qxPLu9PlhYgI6Q+f8rRDbZTty46TZJSxjEUuMullFs
mPRsCZ5dOqWOT6mmTIlUXbwBd9Tj0f8Bd9ppmkSOXJkvyr/3VHQPvxIfr9GR7lpN
mdpdo2DFRUZj/Hez0LKYNpTjm1PQZ94OhPysoJCXgq7Dp954vMraRUCmX+EKtln8
AVIjlxYQCgPGCRus0/GvU73Y6vBVs2GpfYmkcxZ/9sV6ijhLd/npwYyhbI0/dsxg
7sinSTE7ObgV3qJEBw7UuhS/SPMnyHXfv+4dV/+RoScGLDnruQNEFuBmf5syu6VE
DBCB6A++e3hM1hTyk3U33PD8nudrejuzQBJE4eANCdcBJTDpJHfEU2I9nAg0zJQJ
k66nMS4afp/Tsyv4shUvEu5td4mqoLeXkqxkrOBTN38V1qZH7aWA05RGPYrAFQmA
OB0TICP/+lrOJv35jtkU0HJ8mf6jlgI/cVAn1PW3o96n4ALWMpd0gOilSl5TS7JQ
jB16RdfW1uLeStS5VwXA
=woUg
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
