From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Sun, 27 May 2012 03:47:02 +0600
Message-ID: <20120526214702.GE5012@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<1338005001.13348.279.camel@gandalf.stny.rr.com>
	<201205262227.47442.rjw@sisk.pl> <201205262316.30096.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7506341559844067504=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205262316.30096.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============7506341559844067504==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2012 at 11:16:29PM +0200, Rafael J. Wysocki wrote:
> Andrey, Stephen,
>=20
> We still have problems with this patch in https://bugzilla.kernel.org/sho=
w_bug.cgi?id=3D43278
> so some more testing will be necessary, I'm afraid.
>=20
> I will send a series of ACPI and PCI patches I have collected so far,
> that I'd like you to test on top of kernel 3.4.0 with commit
> 151b61284776 reverted.
>=20
> Please let me know if suspend/wakeup work for you with these patches appl=
ied.
I get the usual freeze on suspending with these patches.

--=20
WBR, wRAR

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPwU9WAAoJEDNi9wMaSZLhyIsP/2uHK/u01jmlL48jOzwI7qQd
w1Yy0obtqeXJuqFKKf6R6R/Ny/nhzEGtGeQGY59zveVroRX9rNkg+Utn5wu+vord
qPyMBZaBCGBdKohSEJsay+13rJfpuA9twZBLEqmFQoIu3xkEsq7KR8Ywek3bkNvF
zZTREXXrspSbfggUR/82QHDmwDz2yQMPzWugl364BQm2b8roGlVfVhi0tdxzThog
zctqq1yyfwWZb7kJ3eRowNJflU62rlWxjmHPO+1PPJfYLFqhrZ8VrxHSlv2j+nux
mBkjIAx1/iOphVUCy8d4Wg1CEEBlndhh/0d6l1nRqYhmhbymDFjAHVl+JpJjp6IL
Up2QMMOBpZm+AI8gv8QZoL4nsJRwz/2hHZ0O2Dftr5tARZtiTaR/S5G3ttlYTdcp
c9Db9RW9xPSSnB6qdpfD3oOOQPNyUxqTvFgtpGrqOpmBS+Z+eF+axKRfnd7oXg1S
9F0d8zaujoqa1VgH7Z/fyY2gnJABxBZaxXzQ3NsaN9YaWS6+UsT7NFw51COhhJuk
yb/ONaHB2MQl4q4NToyvjiWplmMTL8/u1iv/SvF87/Km0SMUooVLGL6pK/m7shew
DUcuy9Q/w94V9cvBzZ8kUjtcvpjEOumyj3+SaBj6tpW5qvJth3n+t4bySZGLNsaL
mLjafQ2oizfplevpx26d
=aGQQ
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--

--===============7506341559844067504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7506341559844067504==--
