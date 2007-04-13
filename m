From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: 2.6.21-rc5: swsusp: Not enough free memory
Date: Fri, 13 Apr 2007 22:21:36 +1000
Message-ID: <1176466896.7112.159.camel@nigel.suspend2.net>
References: <460B6E4B.3060004@gmail.com> <200704122336.57600.rjw@sisk.pl>
	<4af2d03a0704130314s78d0d831ja52fe8f92efe097a@mail.gmail.com>
	<200704131400.12021.rjw@sisk.pl>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0989315889=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200704131400.12021.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-pm@lists.osdl.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org


--===============0989315889==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-mkceuk3h5Uk8zTq6tD29"


--=-mkceuk3h5Uk8zTq6tD29
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

On Fri, 2007-04-13 at 14:00 +0200, Rafael J. Wysocki wrote:
> >=20
> > Shrinking memory...  Pages needed: 128103 normal, 0 highmem
> > Pages needed: 125226 normal, 0 highmem
> > Pages needed: -5757 normal, 0 highmem
> > Pages needed: -5757 normal, 0 highmem
> > Pages needed: -5757 normal, 0 highmem
> > Pages needed: -5757
> > Pages needed: 127953 normal, 0 highmem
> > Pages needed: 125076 normal, 0 highmem
> > Pages needed: -6043 normal, 0 highmem
> > Pages needed: -6043 normal, 0 highmem
> > Pages needed: -6043 normal, 0 highmem
> > Pages needed: -6043
> > done (200 pages freed)
> > Freed 800 kbytes in 0.16 seconds (5.00 MB/s)
> > Suspending console(s)
> > ...
> > CPU1 is down
> > swsusp: critical section:
> > swsusp: Need to copy 131358 pages
> > swsusp: Normal pages needed: 131358
> > swsusp: Normal pages needed: 131358 + 1024 + 22, available pages: 13060=
7
>=20
> Well, it looks like someone allocated about 6000 pages after we had freed
> enough memory for suspending.

We have a tunable allowance in Suspend2 for this, because fglrx
allocates a lot of pages in its suspend routine if DRI is enabled. I
think some other drivers do too, but fglrx is the main one I know.

Nigel


--=-mkceuk3h5Uk8zTq6tD29
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGH3XQN0y+n1M3mo0RAuS5AJ9mug/OU4FsWTvpszg8pQfjo81lBQCfdZ5O
NpGLgwEnKMhXy3nkbqvSaYs=
=52K3
-----END PGP SIGNATURE-----

--=-mkceuk3h5Uk8zTq6tD29--


--===============0989315889==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0989315889==--
