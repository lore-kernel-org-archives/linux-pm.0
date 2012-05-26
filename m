From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re:
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Sun, 27 May 2012 04:36:11 +0600
Message-ID: <20120526223611.GF5012@belkar.wrar.name>
References: <Pine.LNX.4.44L0.1205252157430.24286-100000@saphir.localdomain>
	<201205262316.30096.rjw@sisk.pl>
	<20120526214702.GE5012@belkar.wrar.name>
	<201205270006.01753.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1756377661774207678=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205270006.01753.rjw@sisk.pl>
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


--===============1756377661774207678==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 27, 2012 at 12:06:01AM +0200, Rafael J. Wysocki wrote:
> > > Andrey, Stephen,
> > >=20
> > > We still have problems with this patch in https://bugzilla.kernel.org=
/show_bug.cgi?id=3D43278
> > > so some more testing will be necessary, I'm afraid.
> > >=20
> > > I will send a series of ACPI and PCI patches I have collected so far,
> > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > 151b61284776 reverted.
> > >=20
> > > Please let me know if suspend/wakeup work for you with these patches =
applied.
> > I get the usual freeze on suspending with these patches.
>=20
> I see.
>=20
> Please try to unapply [4/4] and see if that helps.
It helps.

--=20
WBR, wRAR

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPwVrbAAoJEDNi9wMaSZLh+ggQAJrrbIVC+m8L8DOog8fPiw+E
9evUvzTwnGBEQifqGE9/LU3SB3ZCu/ndGBnyQgkF78OZP86y1vdD0P1jCCnH8TOa
cZl8AWuQdZs2THIq1sbXzogMzhk2mI0Ps6O0h0qxMS7fcKrB9HSL8TJgbPMxcqwj
QCPMOELqWM80uoDiylKUPC1mptqalGgmX911Udn0ZZxr9uwmo9A8BoCvbH0ZZ8fz
oavSLaR2GjKINW/M7sL7EWU/I37/ATSGA41mtGGQzn+VigEN+N1/GiSvhtIxuebP
VixEjFJzUowzlAEP18/IlrtmICquJUErneXiRl6l9eFdS84/xdmbAHbaOdKaMAxC
6OaFH5UEC8H7ZwYv9jBBFo1oWs/Oyldh3kgi+wjO8Nqv6jYu+6J8wQxRGteu4Jrz
gy+iExmdCJ/Rs4NzjWxCdZdZ6kOGdoFctyJnZbtfwkdtD0VSaSXzY0AXsR94LqHh
00UwVJOENSThd87+sgNvLFUBtjL6ojENgI+Vhlosw//h9Nea0ZtPVQuA9oDrM6rr
wsc8rny4sZZKCuFQSkOf0Gy4Hp4lKOHGLzKrgWAStYIMwUNqVjC2gFaSiphGMYL2
Z6tKEQ46r0ocN7oUDVyHUn0AvVLZEJ9oi5ZJ9DzbsXYIysvtnOmLIIdZyCMevmtr
j8JwtAkokelGr/6C53yx
=Y2n2
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

--===============1756377661774207678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1756377661774207678==--
