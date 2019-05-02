From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power/poweroff.c: mark variables with __initdata and
 __maybe_unused
Date: Thu, 2 May 2019 12:15:00 +0200
Message-ID: <20190502101500.GA23980@amd>
References: <20190502074305.GA6039@vostro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190502074305.GA6039@vostro>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikitas Angelinas <nikitas.angelinas@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-05-02 00:43:05, Nikitas Angelinas wrote:
> There is no need to keep sysrq_poweroff_op after initialization, so mark
> it with __initdata.

Are you sure?

pavel@duo:/data/l/k$ grep -ri sysrq_key_op . | grep initdata
pavel@duo:/data/l/k$


									Pavel

> =20
> -static struct sysrq_key_op	sysrq_poweroff_op =3D {
> +static struct sysrq_key_op sysrq_poweroff_op __initdata =3D {
>  	.handler        =3D handle_poweroff,
>  	.help_msg       =3D "poweroff(o)",
>  	.action_msg     =3D "Power Off",

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzKwyMACgkQMOfwapXb+vLMRgCfdk7iKvloiJkSvH+FPrpjTsra
ZCcAn22sx6lE/WSXjd2YF0EmcFQamlbF
=vw8d
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
