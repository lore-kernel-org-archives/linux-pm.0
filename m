From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
Date: Thu, 21 Jun 2018 11:01:42 +0200
Message-ID: <20180621090142.GB21807@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com>
 <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Theodore Ts'o <tytso@mit.edu>, Stephan Mueller <smueller@chronox.de>, Eric Biggers <ebiggers3@gmail.com>, Denis Kenzior <denkenz@gmail.com>
List-Id: linux-pm@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



On Wed 2018-06-20 17:40:51, Chen Yu wrote:
> crypto_hibernate is a user-space utility to generate
> 512bits AES key and pass it to the kernel via ioctl
> for hibernation encryption.(We can also add the key
> into kernel via keyctl if necessary, but currently
> using ioctl seems to be more straightforward as we
> need both the key and salt transit).

Ah, here you go:

https://en.wikipedia.org/wiki/Uswsusp

It can already do encryption. If you see problems there, patches will
be gladly accepted to fix them.

If you want to maintain uswsusp in kernel tree, I guess that would be
an option, too.

If you want to just help swsusp, I have some patches that reduce
duplicities between x86-32 and x86-64. It would be cool to clean them
up and get them merged.

> Suggested-by: "Theodore Ts'o" <tytso@mit.edu>

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsraXYACgkQMOfwapXb+vLpTACgoPaUypOAaz3Rq6lnFosS6iG0
uRYAmgPEWp/kWz9PDcNapGWIb3SAWlul
=SwCy
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
