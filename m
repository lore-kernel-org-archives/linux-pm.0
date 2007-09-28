From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 11:23:39 +0200
Message-ID: <1190971419.31636.38.camel__21027.8563354679$1190993555$gmane$org@twins>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
	<1190962752.31636.15.camel@twins>
	<92cbf19b0709280127yba48b60wfe58e532944894ca@mail.gmail.com>
	<1190968800.31636.26.camel@twins>
	<92cbf19b0709280201o3778f945mf1d8d61cbb3d0558@mail.gmail.com>
	<1190970729.31636.29.camel@twins>
	<92cbf19b0709280220o7cdd4b1cua37a8776af68ac25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8144961561127025856=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <92cbf19b0709280220o7cdd4b1cua37a8776af68ac25@mail.gmail.com>
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
To: Chakri n <chakriin5@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, nfs@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============8144961561127025856==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6L5l2lrn9QSVICL21ufD"


--=-6L5l2lrn9QSVICL21ufD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

 [ and one copy for the list too ]

On Fri, 2007-09-28 at 02:20 -0700, Chakri n wrote:
> It's 2.6.23-rc6.

Could you try .23-rc8-mm2. It includes the per bdi stuff.

--=-6L5l2lrn9QSVICL21ufD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/MgbXA2jU0ANEf4RAlRtAKCOr5llD1VvWGyDFlYDq2rtx5ux1gCfQhUe
h96SD0We8xHaqudJfr1QKSw=
=bwEO
-----END PGP SIGNATURE-----

--=-6L5l2lrn9QSVICL21ufD--


--===============8144961561127025856==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8144961561127025856==--
