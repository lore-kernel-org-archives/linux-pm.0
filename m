From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH -mm 5/5] Hibernation: Introduce exportable
	suspend ioctls header
Date: Mon, 03 Sep 2007 11:43:47 +0200
Message-ID: <1188812627.14564.34.camel@johannes.berg>
References: <200709022315.59652.rjw@sisk.pl> <200709022328.20720.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8731980883213389113=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709022328.20720.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============8731980883213389113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YYBs75zdFajU9R/Aq3i5"


--=-YYBs75zdFajU9R/Aq3i5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-09-02 at 23:28 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>=20
> Move the definitions of hibernation ioctls to a separate header file in
> include/linux, which can be exported to the user space.

Missing the actual export to userspace:

--- include/linux/Kbuild
+++ include/linux/Kbuild
+header-y +=3D suspend_ioctls.h

johannes

--=-YYBs75zdFajU9R/Aq3i5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG29dT/ETPhpq3jKURAjY0AJ4sH4E9KH/wd683yr7Go6MlURyV3ACffUeU
3dI8eLNa7KdkrEifHfRJ8I4=
=vhK+
-----END PGP SIGNATURE-----

--=-YYBs75zdFajU9R/Aq3i5--


--===============8731980883213389113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8731980883213389113==--
