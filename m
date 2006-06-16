From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 12:50:01 +1000
Message-ID: <200606161250.05076.ncunningham@linuxmail.org>
References: <Pine.LNX.4.64.0606141042260.5498@g5.osdl.org>
	<1150420537.7725.66.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1310101784=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606151839440.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1310101784==
Content-Type: multipart/signed; boundary="nextPart5332729.JciidDoogr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5332729.JciidDoogr
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 16 June 2006 12:28, Linus Torvalds wrote:
> On Fri, 16 Jun 2006, Benjamin Herrenschmidt wrote:
> > You can't save a consistent system image if your drivers aren't all
> > stopped and DMA is stopped.
>
> Read the whole thread to an end.
>
> You don't _need_ to save a consistent system image. There's no "single
> snapshot in time" needed.

Yes, you do. If you save an image that has, say, pages in the lru that are=
=20
also in the free lists or a similar situation with driver data, you're goin=
g=20
to get an oops some time after resume at best, and possibly ruin your=20
filesystem at worst.

That said, consistency doesn't need to equal atomicity. As I'm sure you kno=
w,=20
what we're after is something that's effectively atomic, which is why I've=
=20
happily saved the lru separate to the atomically copied pages for the last =
4=20
or so years. It works because I can be sure nothing's going to change the l=
ru=20
contents, so the image is effectively atomic.

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart5332729.JciidDoogr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkhxdN0y+n1M3mo0RAi7mAKC4+DN8MxKE9z5MaamrS1Rnlt1mCACgjzfZ
EyNg5uRmL1DtxKd89siLmVc=
=4Zmd
-----END PGP SIGNATURE-----

--nextPart5332729.JciidDoogr--

--===============1310101784==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1310101784==--
