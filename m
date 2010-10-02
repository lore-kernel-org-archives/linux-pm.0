From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: Swsusp patches applied to suspend-2.6#linux-next
Date: Sat, 2 Oct 2010 18:49:46 +0200
Message-ID: <201010021849.54682.Martin__38538.6766320609$1286038345$gmane$org@lichtvoll.de>
References: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
	(sfid-20100927_095229_965698_B1F8A253)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2847481352643704969=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285566238-10966-1-git-send-email-nigel@tuxonice.net>
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
To: linux-pm@lists.linux-foundation.org
Cc: LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

--===============2847481352643704969==
Content-Type: multipart/signed;
  boundary="nextPart2714820.usHeie2QTy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2714820.usHeie2QTy
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Montag 27 September 2010 schrieb Nigel Cunningham:
> Hi again Rafael.

Hi Nigel and Rafael,

> As discussed, here are the patches, modified to apply against your
> current linux-next tree. A new first patch splits compression support
> out into its own file, removing the need to have two versions of the
> load_image and save_image routines, minimising the changes to the
> remainder of the patches and making things cleaner than would
> otherwise be the case.
>=20
> On my laptop, single-threaded compression actually slows writing down
> from 175MB/s to around 100-120MB/s (depending on how well the image
> compresses). Reading speed improves from 218MB/s to around 245MB/s. I
> expect that multithreaded writing would bring the writing (and
> reading) speeds back up. It's on my swsusp to do list :)

Testing this now (2.6.36-rc4-tp42-suspend-next-vmembase-0-00253-gab9b069-
dirty).

So far so fast:

shambhala:~> grep Image /var/log/syslog | tail -30
Sep 29 09:11:07 shambhala kernel: PM: Image restored successfully.
Sep 29 09:11:07 shambhala kernel: PM: Image written at 47 MB/s.
Sep 29 09:11:07 shambhala kernel: PM: Image read at 45 MB/s.
Sep 29 20:59:32 shambhala kernel: PM: Image restored successfully.
Sep 29 20:59:32 shambhala kernel: PM: Image written at 42 MB/s.
Sep 29 20:59:32 shambhala kernel: PM: Image read at 43 MB/s.
Sep 30 19:17:57 shambhala kernel: PM: Image restored successfully.
Sep 30 19:17:57 shambhala kernel: PM: Image written at 62 MB/s.
Sep 30 19:17:57 shambhala kernel: PM: Image read at 42 MB/s.
Oct  1 11:26:19 shambhala kernel: PM: Image restored successfully.
Oct  1 11:26:19 shambhala kernel: PM: Image written at 18 MB/s.
Oct  1 11:26:19 shambhala kernel: PM: Image read at 45 MB/s.
Oct  2 10:30:24 shambhala kernel: PM: Image restored successfully.
Oct  2 10:30:24 shambhala kernel: PM: Image written at 65 MB/s.
Oct  2 10:30:24 shambhala kernel: PM: Image read at 42 MB/s.
Oct  2 17:44:33 shambhala kernel: PM: Image restored successfully.
Oct  2 17:44:33 shambhala kernel: PM: Image written at 74 MB/s.
Oct  2 17:44:33 shambhala kernel: PM: Image read at 116 MB/s.
Oct  2 17:56:18 shambhala kernel: PM: Image restored successfully.
Oct  2 17:56:18 shambhala kernel: PM: Image written at 68 MB/s.
Oct  2 17:56:18 shambhala kernel: PM: Image read at 125 MB/s.
Oct  2 17:57:40 shambhala kernel: PM: Image restored successfully.
Oct  2 17:57:40 shambhala kernel: PM: Image written at 67 MB/s.
Oct  2 17:57:40 shambhala kernel: PM: Image read at 121 MB/s.
Oct  2 17:58:47 shambhala kernel: PM: Image restored successfully.
Oct  2 17:58:47 shambhala kernel: PM: Image written at 67 MB/s.
Oct  2 17:58:47 shambhala kernel: PM: Image read at 124 MB/s.
Oct  2 18:43:40 shambhala kernel: PM: Image restored successfully.
Oct  2 18:43:40 shambhala kernel: PM: Image written at 68 MB/s.
Oct  2 18:43:40 shambhala kernel: PM: Image read at 122 MB/s.
shambhala:~>

The read ahead patches bring a pretty nice performance upgrade ;).

I wonder a bit about:

Oct  1 11:26:19 shambhala kernel: PM: Image written at 18 MB/s.

This has been without read ahead patches which shouldn't interfere with=20
writing anyway.

Ciao,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart2714820.usHeie2QTy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkynYqsACgkQmRvqrKWZhMf+DwCfZEMoMzjine9tDmp2Y6Xmatan
dTEAoLADpnKO39ebARr1C4itVOhVXA3o
=aKpJ
-----END PGP SIGNATURE-----

--nextPart2714820.usHeie2QTy--

--===============2847481352643704969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2847481352643704969==--
