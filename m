From: Martin Steigerwald <Martin@lichtvoll.de>
Subject: Re: [TuxOnIce-devel] Nigel's current for-rafael queue
Date: Tue, 28 Sep 2010 12:34:36 +0200
Message-ID: <201009281234.49454.Martin__45701.0707621977$1285670143$gmane$org@lichtvoll.de>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
	(sfid-20100925_095651_884433_67642C74)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435132257677408682=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

--===============0435132257677408682==
Content-Type: multipart/signed;
  boundary="nextPart4392928.sCKcRck9MC";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4392928.sCKcRck9MC
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Samstag 25 September 2010 schrieb Nigel Cunningham:
> Hi Rafael.
>=20
> Please find attached a slightly updated version of the patchset I sent
> a few months ago. The main change is that I've prepended and additional
> patch which lets the user see the speed at which the image is being
> read and written. This is accomplished by recording the MB/s in a
> single byte in the image header, and using a couple of __nosavedata
> variables to get the data back through the atomic restore. I realise
> the char limits us to 255MB/s at the moment. In future patches, I
> intend to address this by storing the data in a 'proper' image header
> (it's a real problem - TuxOnIce reads and writes on the same set up at
> speeds around 250MB/s).
>=20
> Results on my Dell XPS M1530, which has an SSD hard drive are:
>=20
> With just patch 1 applied:
> Attempt 1: Write 74MB/s; Read 52MB/s
> Attempt 2: Write 68MB/s; Read 52MB/s
> Attempt 3: Write 73MB/s; Read 53MB/s
>=20
> With the whole sequence:
> Attempt 1: Write 181MB/s; Read 52MB/s
> Attempt 2: Write 156MB/s; Read 53MB/s
> Attempt 3: Write 160MB/s; Read 52MB/s

Is doesn't get much stabler than=20

shambhala:~> grep "PM: Image.*at " /var/log/syslog
Sep 28 11:32:06 shambhala kernel: PM: Image written at 63 MB/s.
Sep 28 11:32:06 shambhala kernel: PM: Image read at 32 MB/s.
Sep 28 11:35:00 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 11:35:00 shambhala kernel: PM: Image read at 32 MB/s.
Sep 28 11:38:43 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 11:38:43 shambhala kernel: PM: Image read at 33 MB/s.
Sep 28 11:41:15 shambhala kernel: PM: Image written at 66 MB/s.
Sep 28 11:41:15 shambhala kernel: PM: Image read at 33 MB/s.
Sep 28 11:42:57 shambhala kernel: PM: Image written at 66 MB/s.
Sep 28 11:42:57 shambhala kernel: PM: Image read at 34 MB/s.
Sep 28 11:45:16 shambhala kernel: PM: Image written at 66 MB/s.
Sep 28 11:45:16 shambhala kernel: PM: Image read at 34 MB/s.
Sep 28 12:19:21 shambhala kernel: PM: Image written at 66 MB/s.
Sep 28 12:19:21 shambhala kernel: PM: Image read at 35 MB/s.
Sep 28 12:21:35 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 12:21:35 shambhala kernel: PM: Image read at 35 MB/s.
Sep 28 12:23:18 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 12:23:18 shambhala kernel: PM: Image read at 35 MB/s.
Sep 28 12:25:23 shambhala kernel: PM: Image written at 64 MB/s.
Sep 28 12:25:23 shambhala kernel: PM: Image read at 36 MB/s.
Sep 28 12:26:55 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 12:26:55 shambhala kernel: PM: Image read at 37 MB/s.
Sep 28 12:28:28 shambhala kernel: PM: Image written at 65 MB/s.
Sep 28 12:28:28 shambhala kernel: PM: Image read at 37 MB/s.

many attempts.

So - without readahead patch for now -

Tested-By: Martin Steigerwald <Martin@Lichtvoll.de>

on 2.6.36-rc5.

Thanks,
=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7

--nextPart4392928.sCKcRck9MC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyhxL4ACgkQmRvqrKWZhMfrRwCcDW5VPrSTl/PHco7EzjU5KFVH
ZUUAniRBL8Czg3EJgWpXd2dRfTPKi7Vu
=ImVY
-----END PGP SIGNATURE-----

--nextPart4392928.sCKcRck9MC--

--===============0435132257677408682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0435132257677408682==--
