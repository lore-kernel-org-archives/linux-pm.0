From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: small formatting fixes
Date: Wed, 11 Jan 2017 21:03:45 +0100
Message-ID: <20170111200345.GB29366@amd>
References: <20161212072541.28435-1-nick.desaulniers@gmail.com>
 <20161212085620.GA738@amd>
 <20161212175654.ydc7rx3edqoacnp7@lostoracle.net>
 <1481567955.1764.28.camel@perches.com>
 <20161212222216.GA18201@amd>
 <20161212232043.vc5alwqzvspg2ade@lostoracle.net>
 <1481584942.29291.9.camel@perches.com>
 <20161213190001.GA8676@amd>
 <20161223031942.jrgjt567m6bdeke3@lostoracle.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161223031942.jrgjt567m6bdeke3@lostoracle.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Joe Perches <joe@perches.com>, rjw@rjwysocki.net, len.brown@intel.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2016-12-22 19:19:43, Nick Desaulniers wrote:
> On Tue, Dec 13, 2016 at 08:00:01PM +0100, Pavel Machek wrote:
> > Actually.. the ACPI cleanup is fine. You did well :-).
> > 									Pavel
>=20
> Cool, so (forgive the naive question) what happens next?  Maybe I'm too
> used to the immediate gratification from Github of having a Pull Request
> get merged.  Is this something that you have cherry picked into your
> tree, then will ask Linus to pull from at the end of the merge window?

> Do you have a tree that public that I am able to view? On
> git.kernel.org, there seems to be one tree with your name on it but it
> seems to be related to the (Nokia?) n900 and it's latest updated branch
> is from 9 weeks ago.

I don't maintain a tree for power management stuff. Rafael does.

There are tricks that can be done for easy but not trivial fixes.

Ouch and if you want code that needs clean ups / fixes... just let me
know :-).


> Or is there more approvals I have to get to get the patch merged?

No, you did well, just wait.

								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh2j6EACgkQMOfwapXb+vKHjwCgnz/hcx3lj1RXRwsQUAo+frgQ
d+0An2ZmNdE68vlph0wsFfs3kAWm5i/d
=IATO
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
