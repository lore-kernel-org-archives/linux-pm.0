From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 6 Jul 2007 17:19:34 +1000
Message-ID: <200707061719.36054.nigel__37714.8262727589$1183706425$gmane$org@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl>
	<200707061707.23316.nigel@nigel.suspend2.net>
	<E1I6i0N-0003CY-00@dorka.pomaz.szeredi.hu>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3096534546293166382=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6i0N-0003CY-00@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, nigel@suspend2.net, linux-kernel@vger.kernel.org, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

--===============3096534546293166382==
Content-Type: multipart/signed; boundary="nextPart2001911.hDr84XMzzR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2001911.hDr84XMzzR
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 17:13:27 Miklos Szeredi wrote:
> > To get more serious and practical though, I think the solution is to
> > fuzz the userspace/kernelspace distinction. What we really want to
> > do is freeze things that submit I/O, then sync, then freeze anything
> > that processes I/O and needs to be frozen. In effect, redefine fuse
> > processes as freezeable kernel threads.
>=20
> Another myth, that has been debunked already.  The problem is: how do
> you define fuse processes?  There's no theoretical or even practial
> way to do that.

No theoretical or practical way?! I'll freely admit to being quite ignorant=
=20
about fuse, but surely there's some way by which they can be distinguished.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart2001911.hDr84XMzzR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGje0IN0y+n1M3mo0RAsI8AKDVne3j+dySUwP7nqn+n4PWYYY4nwCgtggq
iJIlnJzslub4sJ8LypH4e/0=
=p5BO
-----END PGP SIGNATURE-----

--nextPart2001911.hDr84XMzzR--

--===============3096534546293166382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3096534546293166382==--
