From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [RFC][PATCH -mm] PM: Do not sync filesystems from
	within the freezer
Date: Fri, 6 Jul 2007 19:13:56 +1000
Message-ID: <200707061914.02972.nigel@nigel.suspend2.net>
References: <200707041658.59588.rjw@sisk.pl>
	<1183712394.3388.128.camel@localhost.localdomain>
	<E1I6jlB-0003TC-00@dorka.pomaz.szeredi.hu>
Reply-To: nigel@suspend2.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8787863231800761471=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6jlB-0003TC-00@dorka.pomaz.szeredi.hu>
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

--===============8787863231800761471==
Content-Type: multipart/signed; boundary="nextPart34817502.2AvyaTg7Yt";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart34817502.2AvyaTg7Yt
Content-Type: text/plain;
  charset="cp 850"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Friday 06 July 2007 19:05:53 Miklos Szeredi wrote:
> > On Fri, 2007-07-06 at 09:13 +0200, Miklos Szeredi wrote:
> > >=20
> > > Another myth, that has been debunked already.  The problem is: how do
> > > you define fuse processes?  There's no theoretical or even practial
> > > way to do that.
> >=20
> > It could if they told the kernel via some black magic ...
> >=20
> > But that still suck. The freezer sucks :-)
>=20
> Yeah, and it wouldn't work in practice, since the auxilary tasks might
> be part of a library which is not even aware of being used by a "fuse
> task".

This is why I think the whole concept of filesystems in userspace is broken=
=2E=20
Trying to shift things that need special privilege and special handling to=
=20
userspace is just asking for trouble. You can say it's the kernel code's=20
fault, but then you have to explain why it's only fuse (yeah ok, and XFS)=20
that have problems.

Regards,

Nigel
=2D-=20
See http://www.tuxonice.net for Howtos, FAQs, mailing
lists, wiki and bugzilla info.

--nextPart34817502.2AvyaTg7Yt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGjgfaN0y+n1M3mo0RAhwxAKCzBfzlaBBw8ZQK+deMRbrqU05hqQCcDgwt
rNGPIjV3/BoDmcZ0xLMknOc=
=fnLG
-----END PGP SIGNATURE-----

--nextPart34817502.2AvyaTg7Yt--

--===============8787863231800761471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8787863231800761471==--
