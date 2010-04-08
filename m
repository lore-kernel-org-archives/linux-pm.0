From: Tony Vroon <tony@linx.net>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Thu, 08 Apr 2010 23:37:43 +0100
Message-ID: <1270766263.5923.3.camel__27949.9361794025$1270766988$gmane$org@localhost>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<201004072149.23791.rjw@sisk.pl>
	<20100408094905.GA3948@tiehlicka.suse.cz>
	<201004082243.18393.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1296424452405570483=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004082243.18393.rjw@sisk.pl>
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
Cc: linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Michal Hocko <mhocko@suse.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


--===============1296424452405570483==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-K/0H93rql4k+36vEP5IJ"


--=-K/0H93rql4k+36vEP5IJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rafael,

I have the exact same "lid close =3D powering back on" regression on a
Fujitsu-Siemens Lifebook S6420. Totally missed this thread before, but
I'm glad that I'm not alone with this one.
Happy to test any patches you may come up with; will an acpidump do for
you or do you need additional data?

Regards,
--=20
Tony Vroon
UNIX systems administrator
London Internet Exchange Ltd, Trinity Court, Trinity Street,
Peterborough, PE1 1DA
Registered in England number 3137929
E-Mail: tony@linx.net

--=-K/0H93rql4k+36vEP5IJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAku+WrcACgkQp5vW4rUFj5o7LwCfao+JJhSbsGs69iLeUt7ISO6Z
ZNsAn2T42zn2P3Buv+oehxpNa6gDBs35
=MZQ4
-----END PGP SIGNATURE-----

--=-K/0H93rql4k+36vEP5IJ--


--===============1296424452405570483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1296424452405570483==--
