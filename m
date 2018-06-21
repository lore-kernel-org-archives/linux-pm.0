From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Thu, 21 Jun 2018 21:14:43 +0200
Message-ID: <20180621191443.GB14623@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <20180621085332.GA21807@amd>
 <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0izS8CNzhsd_bjB40xTkZxaxh13NtHsJi9LYXEr84MoMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-06-21 14:08:40, Rafael J. Wysocki wrote:
> On Thu, Jun 21, 2018 at 10:53 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > Hi!
> >
> >> As security becomes more and more important, we add the in-kernel
> >> encryption support for hibernation.
> > ...
> >> There was a discussion on the mailing list on whether this key should
> >> be derived in kernel or in user space. And it turns out to be generati=
ng
> >> the key by user space is more acceptable[1]. So this patch set is divi=
ded
> >> into two parts:
> >> 1. The hibernation snapshot encryption in kernel space,
> >> 2. the key derivation implementation in user space.
> >
> > uswsusp was created so that this kind of stuff could be kept in
> > userspace. You get graphical progress bar (etc) too. As you already
> > have userspace component for key derivation, I see no advantages to
> > uswsusp.
> >
> > If you have some, please explain.
>=20
> Not having to transfer plain text kernel memory to user space is one
> IMO.

Well, AFAICT in this case userland has the key and encrypted data are
on disk. That does not seem to be improvement.

> Besides, the user space part of what you are calling uswsusp has not
> been actively maintained for years now and honestly I don't know how
> many users of it there are.

I'd assume distros want progress bars so they still use it?

Anyway, there's solution for encrypted hibernation. If Intel wants to
invent different solution for that, and put it into kernel, they
should explain what the advantages are, relative to existing solution.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsr+SMACgkQMOfwapXb+vKDngCfXJJv3RBXD2AhfIHRs03Y2uhR
osYAoJ6Irtf8oJPZDOtvLwfAcgsM1EMA
=yyF8
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
