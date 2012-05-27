From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: [RFT] PCI changes related to wakeup (was: Re: [linux-pm]
 ehci_hcd related S3 lockup on ASUS laptops, again)
Date: Mon, 28 May 2012 03:17:14 +0600
Message-ID: <20120527211714.GC4994@belkar.wrar.name>
References: <20120526223611.GF5012@belkar.wrar.name>
 <Pine.LNX.4.44L0.1205271238040.14937-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205271238040.14937-100000@netrider.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Steven Rostedt <rostedt@goodmis.org>, linux-pm@lists.linux-foundation.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 27, 2012 at 12:41:43PM -0400, Alan Stern wrote:
> > > > > Andrey, Stephen,
> > > > >=20
> > > > > We still have problems with this patch in https://bugzilla.kernel=
=2Eorg/show_bug.cgi?id=3D43278
> > > > > so some more testing will be necessary, I'm afraid.
> > > > >=20
> > > > > I will send a series of ACPI and PCI patches I have collected so =
far,
> > > > > that I'd like you to test on top of kernel 3.4.0 with commit
> > > > > 151b61284776 reverted.
> > > > >=20
> > > > > Please let me know if suspend/wakeup work for you with these patc=
hes applied.
> > > > I get the usual freeze on suspending with these patches.
> > >=20
> > > I see.
> > >=20
> > > Please try to unapply [4/4] and see if that helps.
> > It helps.
>=20
> Andrey, can you try out Rafael's patches 1-3 (with 151b... reverted) =20
> and see what happens if the EHCI controllers' power/wakeup sysfs
> atributes are first set to "disabled"?
It freezes.

--=20
WBR, wRAR

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPwpnZAAoJEDNi9wMaSZLhzHEP/jC1Jr3NuO19PRlunsJlIhq2
UEkE/QY0e+xoDSdO6xcsDF8NwMHsQy+hSN8M2H4U9VpnHL0BPUinpS8v8GUVsMd5
l7aYKbT+OVS3E+42yJ/hyN0vYLtwL7osSNslDo/LKvYjXYBq7AqTKSSMeYNybqk0
Qn2LDL5BH3W+HgRHVQ9XMs799lEBkswDVG3zVPHNcrj6YCG0kO2lh4DYiQerI2ge
VN9hDk6O7kMrcnSHHEenzINdB26uhQfq77v7JHozNKB8pRWDibZ/apoA1t1HB+8A
gDafLB8mzF5vne4JW4unYLzYvx2Pu7XL6wcB/gSkxnl0junQCkMz/Tr+JElDD4s9
Aagvgbs33y6BTh/vYHjsVx0qoMMXktaejPI3MUQMKhjQuunDV4AjszeXeawuq1O4
W59uAgA/jk0QVY/aMD8EsFjBp+ak75SpZxhUfC39g3rvcaTxpvTcXaebtVGou8xm
EFh3lOGkyvkKt00DYmek/Ng0DCVhq8JPHltHBITFPOMmqp5Va7nPm4ZTweEQm+2D
uSwRYL3vMJzhuGOGXyKH2/loO73ifwWASd4dRcfomx0862vyNdFa9XO+fsOuYqRv
0Pv7BkhIGgoCHlD9WJsFoAUG+O7f6iSGupT+uz6dvWOtpFYgopgHRvUHg3H+h66X
MWBxZsoLC3BWkcBmMZkJ
=H6vI
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--
