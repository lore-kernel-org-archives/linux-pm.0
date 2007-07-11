From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm 3/7] Freezer: Prevent new tasks from
	inheriting TIF_FREEZE set
Date: Thu, 12 Jul 2007 08:25:54 +1000
Message-ID: <200707120825.55426.nigel@nigel.suspend2.net>
References: <200707120006.50095.rjw@sisk.pl> <200707120012.04747.rjw@sisk.pl>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9044013274367768829=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120012.04747.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

--===============9044013274367768829==
Content-Type: multipart/signed; boundary="nextPart2828618.mN2mue4OKK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2828618.mN2mue4OKK
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 12 July 2007 08:12:03 Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Tasks should go to the refrigerator only if explicitly requested to do th=
at=20
by
> the freezer and not as a result of inheriting the TIF_FREEZE flag set fro=
m=20
the
> parent. =A0Make it happen.
>=20
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> ---
>  kernel/fork.c |    1 +
>  1 file changed, 1 insertion(+)
>=20
> Index: linux-2.6.22-rc6-mm1/kernel/fork.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.22-rc6-mm1.orig/kernel/fork.c	2007-07-11 20:48:04.000000000=
=20
+0200
> +++ linux-2.6.22-rc6-mm1/kernel/fork.c	2007-07-11 20:50:42.000000000 +0200
> @@ -932,6 +932,7 @@ static inline void copy_flags(unsigned l
>  	if (!(clone_flags & CLONE_PTRACE))
>  		p->ptrace =3D 0;
>  	p->flags =3D new_flags;
> +	clear_freeze_flag(p);
>  }

Acked-by: Nigel Cunningham <nigel@nigel.suspend2.net>

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2828618.mN2mue4OKK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGlVjzN0y+n1M3mo0RAn05AJ9TabOERYHTFsEgK+AmXnmhJ0ycMQCgnoY5
F3+OAoq1LRAWRM0vfhTiiE4=
=+K//
-----END PGP SIGNATURE-----

--nextPart2828618.mN2mue4OKK--

--===============9044013274367768829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9044013274367768829==--
