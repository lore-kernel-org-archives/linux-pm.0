From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: constify attribute_group structures.
Date: Fri, 30 Jun 2017 08:37:36 +0200
Message-ID: <20170630063736.GA2675@amd>
References: <ff23d3ae01b1a980eee8df412dfda4e64dfdc223.1498798163.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39149 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdF3Ghi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 02:37:38 -0400
Content-Disposition: inline
In-Reply-To: <ff23d3ae01b1a980eee8df412dfda4e64dfdc223.1498798163.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-06-30 10:22:14, Arvind Yadav wrote:
> attribute_groups are not supposed to change at runtime. All functions
> working with attribute_groups provided by <linux/sysfs.h> work with const
> attribute_group. So mark the non-const structs as const.
>=20
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    3802	    624	     32	   4458	   116a	kernel/power/main.o
>=20
> File size After adding 'const':
>    text	   data	    bss	    dec	    hex	filename
>    3866	    560	     32	   4458	   116a	kernel/power/main.o
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index d401c21..42bd800 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -705,7 +705,7 @@ static ssize_t pm_freeze_timeout_store(struct kobject=
 *kobj,
>  	NULL,
>  };
> =20
> -static struct attribute_group attr_group =3D {
> +static const struct attribute_group attr_group =3D {
>  	.attrs =3D g,
>  };
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllV8bAACgkQMOfwapXb+vLjhgCfalwxu8zlfvHUqAW4DVB4uJii
d1oAn1LGHXHcnVHwED+T3qrFBI1ZI2Au
=A7e2
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
