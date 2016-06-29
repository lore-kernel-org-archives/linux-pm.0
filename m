From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: qcom-smbb: add extcon dependency
Date: Wed, 29 Jun 2016 23:09:58 +0200
Message-ID: <20160629210958.GB15422@earth>
References: <20160629143056.7405-1-arnd@arndb.de>
 <20160629143803.GA28325@earth>
 <57740F1A.5040007@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57740F1A.5040007@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Courtney Cavin <courtney.cavin@sonymobile.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 29, 2016 at 11:10:34AM -0700, Stephen Boyd wrote:
> On 06/29/2016 07:38 AM, Sebastian Reichel wrote:
> > On Wed, Jun 29, 2016 at 04:30:02PM +0200, Arnd Bergmann wrote:
> >> Building the smbb driver without extcon results in a link failure:
> >>
> >> drivers/power/built-in.o: In function `smbb_usb_valid_handler':
> >> :(.text+0x3190): undefined reference to `extcon_set_cable_state_'
> >> drivers/power/built-in.o: In function `smbb_charger_probe':
> >> :(.text+0x3880): undefined reference to `devm_extcon_dev_allocate'
> >> :(.text+0x3898): undefined reference to `devm_extcon_dev_register'
> >>
> >> This adds a Kconfig dependency.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Fixes: 56d7df8716b2 ("power: Add Qualcomm SMBB driver")
>=20
> extcon use was only recently introduced so this should be
>=20
> Fixes: 0b7fe26ae602 ("power: qcom_smbb: Make an extcon for usb cable
> detection")

Right, I didn't notice the Fixes line is wrong. Since I will have to
rebase now, I will just squash this into 0b7fe26ae602.

-- Sebastian

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXdDkhAAoJENju1/PIO/qalRYQAIyo4muGHvnIrYTrCNpt3f0z
ik/fP4qzw1jikeHujEheAVz1HYM/6YwhumPs61cAF6kTc7RQ8sUzo6AOrw/bN6yQ
7yGoBC88NIuWkk+5lG13he9EgzC/ttre3v5Jn45dgdby/Y2WGtv4svR4ZSBariML
KwgAKC5mHZAc0lN4x0VmjiJa5UjSwnwzS5ia8+iUV9B6pDz3I0EAYfVCHsTzUtxG
d0QOy4sGTUC5wY4tQxz/ecA0l7Z6xAz6PeiAqsE/t01OLYmeZEdeGQdVrEiUmvGS
WGT41hK1Nwy8s2FnaS3KVi1DBR3OjilKHkx+wZW8fILE+pz+7Rv2kxW3qinqXCfL
Tn4ZB/sz+P0IU/RRSsozhB1mlyHwaXatZ5r7cqeIlOLHG+YVp41H+MoJFCDDbquD
+zyPJAvkferAhviVefZvp9ya3m1P25caHPKj+aZAiyj/dNt8qxKFPoMVXsRlZIUy
e3zV2uzM2ZLKyyqYA403ldyTIwqfATE8zZRVZAfmhAlwG4hktmb1PM3HJi44124Z
HzGW/Z9FRMC5+OVpOV93YHUoXwZE7FYwJjX1JurmGHZT3mH4SY+MiyVX193EjIC3
t9ylUl8M8BpVX7USUwWEHhC9G4bf0G+Br7kNvyzF2gBcxSNMu+Eaflv+6p+u1UbZ
yzTKTgV5AQYwGq9GtRfg
=HSet
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
