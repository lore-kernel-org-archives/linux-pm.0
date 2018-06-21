From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Date: Thu, 21 Jun 2018 21:04:01 +0200
Message-ID: <20180621190401.GA14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd>
 <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Ted Ts'o <tytso@mit.edu>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers3@gmail.com>, Denis Kenzior <denkenz@gmail.com>
List-Id: linux-pm@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-21 14:10:06, Rafael J. Wysocki wrote:
> On Thu, Jun 21, 2018 at 11:01 AM, Pavel Machek <pavel@ucw.cz> wrote:
> >
> >
> > On Wed 2018-06-20 17:40:51, Chen Yu wrote:
> >> crypto_hibernate is a user-space utility to generate
> >> 512bits AES key and pass it to the kernel via ioctl
> >> for hibernation encryption.(We can also add the key
> >> into kernel via keyctl if necessary, but currently
> >> using ioctl seems to be more straightforward as we
> >> need both the key and salt transit).
> >
> > Ah, here you go:
> >
> > https://en.wikipedia.org/wiki/Uswsusp
>=20
> No, not really.
>=20
> > It can already do encryption. If you see problems there, patches will
> > be gladly accepted to fix them.
>=20
> By whom?

By me.

> > If you want to maintain uswsusp in kernel tree, I guess that would be
> > an option, too.
>=20
> No, it isn't an option due to the dependencies on crypto libraries.

Why not?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsr9qEACgkQMOfwapXb+vLiMgCfTsxaT+klE7ncAIKDZJ94dkAT
ClQAn07ioHsAuzcmn+a1TOL8S6lYDxhY
=XdVo
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
