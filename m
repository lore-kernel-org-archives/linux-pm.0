From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: A unresponsive file system can hang all I/O in the
	system on linux-2.6.23-rc6 (dirty_thresh problem?)
Date: Fri, 28 Sep 2007 08:59:12 +0200
Message-ID: <1190962752.31636.15.camel__41063.8401903727$1190993194$gmane$org@twins>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<20070927235034.ae7bd73d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9075451629583142124=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070927235034.ae7bd73d.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: nfs@lists.sourceforge.net, linux-pm <linux-pm@lists.linux-foundation.org>, Chakri n <chakriin5@gmail.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============9075451629583142124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-B1Ooclvwi4GWFafBgg8h"


--=-B1Ooclvwi4GWFafBgg8h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-09-27 at 23:50 -0700, Andrew Morton wrote:

> What we _don't_ want to happen is for other processes which are writing t=
o
> other, non-dead devices to get collaterally blocked.  We have patches whi=
ch
> might fix that queued for 2.6.24.  Peter?

Nasty problem, don't do that :-)

But yeah, with per BDI dirty limits we get stuck at whatever ratio that
NFS server/mount (?) has - which could be 100%. Other processes will
then work almost synchronously against their BDIs but it should work.

[ They will lower the NFS-BDI's ratio, but some fancy clipping code will
  limit the other BDIs their dirty limit to not exceed the total limit.
  And with all these NFS pages stuck, that will still be nothing. ]



--=-B1Ooclvwi4GWFafBgg8h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/KZAXA2jU0ANEf4RAjISAJ9TSkJmNAVhOu/vmw1bCp3sJRQ79QCeOjWE
ulcriUmObG9ScdbPLab3h9I=
=Lkx1
-----END PGP SIGNATURE-----

--=-B1Ooclvwi4GWFafBgg8h--


--===============9075451629583142124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9075451629583142124==--
