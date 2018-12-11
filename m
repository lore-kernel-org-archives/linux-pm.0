From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / sleep: convert to DEFINE_SHOW_ATTRIBUTE
Date: Tue, 11 Dec 2018 18:42:42 +0100
Message-ID: <20181211174242.GA11538@amd>
References: <20181211162048.21906-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211162048.21906-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-12-11 11:20:48, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  kernel/power/main.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
>=20
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 35b50823d83b..98e76cad128b 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -318,23 +318,12 @@ static int suspend_stats_show(struct seq_file *s, v=
oid *unused)
> =20
>  	return 0;
>  }
> -
> -static int suspend_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, suspend_stats_show, NULL);
> -}
> -
> -static const struct file_operations suspend_stats_operations =3D {
> -	.open           =3D suspend_stats_open,
> -	.read           =3D seq_read,
> -	.llseek         =3D seq_lseek,
> -	.release        =3D single_release,
> -};
> +DEFINE_SHOW_ATTRIBUTE(suspend_stats);
> =20
>  static int __init pm_debugfs_init(void)
>  {
>  	debugfs_create_file("suspend_stats", S_IFREG | S_IRUGO,
> -			NULL, NULL, &suspend_stats_operations);
> +			NULL, NULL, &suspend_stats_fops);
>  	return 0;
>  }
> =20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwP9xIACgkQMOfwapXb+vKOTACfQkC9w7fYmHq5sQtRwojm06t3
AlIAoJLYeRpmPZXu2SVWl06YDMp3n2zx
=m7Lp
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
