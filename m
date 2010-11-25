From: Thomas Kahle <tomka@gentoo.org>
Subject: Re: Freezes on resume from S2R
Date: Thu, 25 Nov 2010 11:13:38 +0100
Message-ID: <20101125101338.GG2503@denkmatte.mittag-leffler.se>
References: <20101124095618.GC5982@denkmatte.mittag-leffler.se>
	<201011242101.08157.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1560569400760642311=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201011242101.08157.rjw@sisk.pl>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org


--===============1560569400760642311==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21:01 Wed 24 Nov     , Rafael J. Wysocki wrote:
> On Wednesday, November 24, 2010, Thomas Kahle wrote:
> > https://lists.linux-foundation.org/pipermail/linux-pm/2010-November/029=
299.html
>=20
> This warning means that resume took more that 10 s, which is suspicious, =
but
> not a bug by itself.

Well, the resume is very quick, at least the display comes up and the
computer starts to react for a very short time, but then freezes.

> > These problems appear to me as a regression since everything is
> > reproducibly fine with kernels <=3D2.6.34, and 2.6.35 seems to be fine =
too
> > (although I have tested that less).  I started a bisect, see below.
>=20
> Well, it would be good if you could find the commit that broke things for
> you, but it might be a few different things - ACPI, PCI, graphics driver,=
 etc.

How do you avoid non booting kernels during bisect? I seem to run into
non-bootable kernels frequently.

> Please check if you can reproduce the symptom using pm_test:
>=20
> # echo core > /sys/power/pm_test
> # echo mem > /sys/power/state
>=20
> (it should simulate a suspend-resume cycle and get back to the command pr=
ompt
> in 5-10 sec).  You can try to run that in a loop and see if that
> breaks things.

Which kernel options do you recommend for this debugging?  Currently I
don't have the /sys/power/pm_test node.

Cheers,
Thomas



--=20
Thomas Kahle
http://dev.gentoo.org/~tomka/

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iJwEAQEIAAYFAkzuNtIACgkQQYXt1pFHaaEaDwQAt19E6VfZbbYrBExJb+xD257D
TOGvgLVw0X5lhCg9f8WcQjYZSqdsFkppR3xhcZKSckCMiu1HCu0t74zI2suhXm08
+mVwQp0oX0myMobX4ajBxYJkzmAE0NMoTbcPu/dFXwgQ+B/UfRF+cBr/0TkzqVhe
vzu5F9I+j1m8laRFAbY=
=8AqT
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--

--===============1560569400760642311==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1560569400760642311==--
