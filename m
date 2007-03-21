From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: 32-bit user suspend program on 64-bit kernel?
Date: Wed, 21 Mar 2007 15:04:38 +0100
Message-ID: <1174485879.4230.36.camel@johannes.berg>
References: <1174468281.3769.7.camel@johannes.berg>
	<20070321122820.GA4523@elf.ucw.cz>
	<1174480277.4230.9.camel@johannes.berg>
	<200703211505.52812.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0449294344=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703211505.52812.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


--===============0449294344==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TbhcPECzeD2kZeKf774h"


--=-TbhcPECzeD2kZeKf774h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 15:05 +0100, Rafael J. Wysocki wrote:

> Unfortunately the numbers of ioctls are not portable due to my rookie mis=
take
> in the beginning (using void * in _IOW() and friends which passed with no
> objections).
>=20
> I'm ashamed of that, but it's probably too late to fix it. :-(

Bugger. What would be required to fix it?

Thing is, this is going to make powerpc distro's lives difficult since
part of uswsusp needs to live in the initrd which usually just contains
kernel modules + normal programs, and no powerpc distro I know of ships
64-bit userspace on a 32-bit kernel since, well, it doesn't really have
many advantages.

johannes

--=-TbhcPECzeD2kZeKf774h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGATt2/ETPhpq3jKURArXEAJ4n4sIXVmwFva7vKswhSvVrawVegwCfeZLV
O0HqRs7zzhyMVeLf6A0DtQs=
=U86T
-----END PGP SIGNATURE-----

--=-TbhcPECzeD2kZeKf774h--


--===============0449294344==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0449294344==--
