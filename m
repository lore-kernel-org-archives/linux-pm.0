From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Re: lockdep report in hibernate code
Date: Wed, 24 Oct 2007 10:40:20 +0200
Message-ID: <1193215220.4097.8.camel@johannes.berg>
References: <Pine.LNX.4.44L0.0710231750370.21581-100000@netrider.rowland.org>
	<200710240018.02655.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0040732186051266871=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710240018.02655.rjw@sisk.pl>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--===============0040732186051266871==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YJw7nOOTUmOuaPMD0MFy"


--=-YJw7nOOTUmOuaPMD0MFy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 00:18 +0200, Rafael J. Wysocki wrote:

> Yes, which is what I think is happening in this particular case.  More
> precisely, we get pm_mutex while holding a buffer mutex, so lockdep is wa=
rning
> when we get another buffer mutex afterwards.

Precisely. That's why I copied Greg on the second mail :) It seems that
sysfs already uses nested locks, but that only protects against lockdep
reporting a false positive for nested locks, not this case.

johannes

--=-YJw7nOOTUmOuaPMD0MFy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx8E86Vg1VMiehFYAQK5SA/9FfOZOiqUdUYB+25t/djt06XHpon0A15h
I50swi6dwQEstLhZUH3pmH8Xr4oqgkivD/IBEqF9FAut4L80yMY4zX7MH2zn2ftQ
OHlQHdl8jfHEm7uREjFp2RjUqomUBYd5lPEwpgtH/jsVOQiiH0e9jMQeCorTh17D
ir7yJoabDvQP9ND4pJNDlLVazGcGZv879kIMMTJTNdi1yhYti/6EFe3v8szHVhDm
QqqXcDbwYWhK6r7K5eHweTP8zh7daXi5l8oVaufb3A5+xODZulU9RP0Ct4Kgs+TL
nZoTEpqcK099ydveYiknmqaMV6r3jvDLsVMZXv9NXGjEksNiRZKYQEOXkAn3cFbS
0TtLkpYXY0k/rn326pkmVD/WrW9myvdDqhzDrodQ8sqfgxZHrdqOGrxbc+8qSWAI
d19fe3vRx0Xhvew6UYqab6afB+bPZd8qOFh9juoTgdORxka0m9ZoETa07i+ALnYs
PlQGF4GOHR4LXkdoc6r/pnHxJ2VTE+JacCUrfxIpInTNOVSNXlly73YRVOgn9AGO
WWz0bzmPvqdEcTsTEc4AE+e6C4LokhydSeM/wyig3n/cp2sOBLbY6EWcTeWBGvx8
u3qFckYq1Qsbd1ybsrA/KzCOnNIEWqZjfExuMiP1COOpMVkSwP3pQt1whssSzBhH
rXmj/o02xdM=
=Rwy/
-----END PGP SIGNATURE-----

--=-YJw7nOOTUmOuaPMD0MFy--


--===============0040732186051266871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0040732186051266871==--
