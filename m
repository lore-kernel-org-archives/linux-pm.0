From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3][RFC] Introduce the in-kernel hibernation encryption
Date: Thu, 21 Jun 2018 10:53:33 +0200
Message-ID: <20180621085332.GA21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1529486870.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> As security becomes more and more important, we add the in-kernel
> encryption support for hibernation.
=2E..
> There was a discussion on the mailing list on whether this key should
> be derived in kernel or in user space. And it turns out to be generating
> the key by user space is more acceptable[1]. So this patch set is divided
> into two parts:
> 1. The hibernation snapshot encryption in kernel space,
> 2. the key derivation implementation in user space.

uswsusp was created so that this kind of stuff could be kept in
userspace. You get graphical progress bar (etc) too. As you already
have userspace component for key derivation, I see no advantages to
uswsusp.

If you have some, please explain.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsrZ4wACgkQMOfwapXb+vJZqQCgkly9SD276j3k5iMXoRJ79poD
UusAoKGQUGD1m96jkOVVxTiFwHuFCNYe
=iseQ
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
