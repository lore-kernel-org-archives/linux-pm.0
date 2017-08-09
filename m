From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: add const to bin_attribute structures
Date: Wed, 9 Aug 2017 17:49:35 +0200
Message-ID: <20170809154543.yt2jbi6jxtsovwt3@earth>
References: <1501669778-25033-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jedo5intgoq2znox"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43090 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752403AbdHIPzB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Aug 2017 11:55:01 -0400
Content-Disposition: inline
In-Reply-To: <1501669778-25033-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--jedo5intgoq2znox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 02, 2017 at 03:59:38PM +0530, Bhumika Goyal wrote:
> Add const to bin_attribute structures as they are only passed to the
> functions sysfs_{remove/create}_bin_file or
> device_{remove/create}_bin_file. The corresponding parameters
> passed are of type const, so declare the structures to be const.
>=20
> Done using Coccinelle:
>=20
> @m disable optional_qualifier@
> identifier s;
> position p;
> @@
> static struct bin_attribute s@p=3D{...};
>=20
> @okay1@
> position p;
> identifier m.s;
> @@
> (
> sysfs_create_bin_file(...,&s@p,...)
> |
> sysfs_remove_bin_file(...,&s@p,...)
> )
>=20
> @bad@
> position p!=3D{m.p,okay1.p};
> identifier m.s;
> @@
> s@p
>=20
> @change depends on !bad disable optional_qualifier@
> identifier m.s;
> @@
> static
> +const
> struct bin_attribute s=3D{...};
>=20
> Same script was modified for device_{create/remove}_bin_file functions.
>=20
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---

Thanks, applied.

> Could not find an architecture to cross compile olpc_battery.o file.

OLPC is a 32 bit x86 system.

>  drivers/power/supply/ds2780_battery.c | 4 ++--
>  drivers/power/supply/ds2781_battery.c | 4 ++--
>  drivers/power/supply/olpc_battery.c   | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

-- Sebastian

--jedo5intgoq2znox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmLLw8ACgkQ2O7X88g7
+pqYLg//RAf+2yHGCk+p8Z9OWB6ARYJgQpR3y0SmnWw2ZgIksq/zpEu58JWH5+eR
9RbEUUfz6Rkj+qEe4+8PgLGRAiSpAM+3qmaPWcyAkNdZSgHeuuGqCtoBedi4edAy
Yk9BZ652IeDhJhq9Lhgwx59qxfrhALJ8vqdlH7/s9CpDoCJ60hQ5CqfEgDyuZ+52
JSS1xWCwXuT7xTaexIpr3O7ZvxY15Qu5rDsSJSFeKvNNEVqWl7HrJXWo9ar9NkYQ
bzEgADAUzR/dZWo7b4oodlw7SdngvTnbISdkW1a10mrfbnOBHJH/G+M0ohDbPK25
+OypHvCZNEi3rrEicabYwmOZVPxDA+KUZ7/AvLdptUTo2beGH5gU/NtMnMaVby1c
fLu1tmkz9XEhhABRUwUXJs06SoKWjYrj9y5o+iIAOJsT+UMCgMgfUp6A75rPPZoY
i/pQveEpGQpF9luPHkBng4ttZpeCd6vZ4UZto9QXwvB/nCbeiCEBpi53ojgU+5Wy
Xos7o7L2AUPDlJM1xxIW/m1LTCOJFrVFt09DNNQs7Z5Rcfghkk3l4PW6HJFyGJ2s
Wu4RhRAIcMG8Jnadoe+FmF+OnxMn1mPwbfL7qNWOV7iLQyFwt3Wwrb61C7a6MJw5
Fee93sNkGYNczhjpxLkigYW8P2X+xkUgC8QROk/Y0gSdSzdB/bY=
=XpZt
-----END PGP SIGNATURE-----

--jedo5intgoq2znox--
