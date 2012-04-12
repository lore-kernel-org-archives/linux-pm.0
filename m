From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ehci_hcd related S3 lockup on ASUS laptops, again
Date: Fri, 13 Apr 2012 00:21:34 +0600
Message-ID: <20120412182134.GF12852@belkar.wrar.name>
References: <20120412181031.GE12852@belkar.wrar.name>
	<Pine.LNX.4.44L0.1204121416050.1496-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5258883063648331754=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1204121416050.1496-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: jrnieder@gmail.com, Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org


--===============5258883063648331754==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 02:17:27PM -0400, Alan Stern wrote:
> > > Here's a diagnostic patch that will give us a little more information=
=2E =20
> > > Keep the previous change (so that pci_prepare_to_sleep gets called=20
> > > whether ehci-hcd is bound or not) and let's see what it says.  Try=20
> > > doing it both with and without ehci-hcd bound.  Running this with "ec=
ho=20
> > > devices >/sys/power/pm_test" ought to be good enough.
> > If bound: "target 3 wakeup 1 error 0" for both controllers. If not boun=
d,
> > pci_prepare_to_sleep is not called for ehci_hcd.
>=20
> It should be called, because earlier I asked you to add a call to it=20
> inside pci_pm_suspend_noirq.  Make sure you that line is still present=20
> when you test.
Right, it just prints "pci" instead of "ehci_hcd". It's still "target 3
wakeup 1 error 0", right after "Refused to change power state, currently
in D0".

--=20
WBR, wRAR

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPhx0tAAoJEDNi9wMaSZLh5aIP+wcFYHwYYxveKbDmjvuCJeYt
Pa643hz8knNDQMCpb4T3zs96BTEwzCOnIUY1lQonacofAt/JLy1+QYYRcu36eDYM
A/GGQJn7HjRsVGF6jl1iAjMYErMDZWTGH2zadfjAAeUqhF/zn4lv9W9YBNYzIfR7
QRT4vOacfBxcNr1bxDA3dkamSwRHOTnQWjIeJt2gM5b28zvNnGkbdf5XIbhJCTFi
puO2ojkuyd0IJS6mG5wRkg77VydoPsArcRfJI3jbUg5CIwIr2HSC/KL4OPDjaPKd
pCpoQ/BvnRDF5hRgNALtXaVEds7R4LLejaW8amkv4s/aWLw4VbAd83tZYkCuVJu/
4BiQ+lOXZ7reMW+qNf9FFHXxa8SGxlCMZ+2NKBrmcnH/aRKcD5n86OmQBtaVakQp
kyE9FCNRacaLlsyPgwUOA26SrdXbAT78KWyyF8WyPTDXYzGtd6aU90tbeasdAAQd
B+y+KHqoUgwnWK4TdvFRP7u/2+7O1pwc3GI4BCMuEyeMhSMU0e+Z3mx7zwSTShJN
CRbbpWPkCmykUeeOkDwE6nm3pZn2W324aN4xc5vpM/Ic8j42EAo9dA4nWQG7DXQc
L8IoayIIlvTAGbO9NURd9RkMc+x3ByrMlrGp20i40L8bt5zGcjFzQjDs7xCvZ6yU
M8WuKjDjoO+VRJS6v7hv
=SdlD
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--

--===============5258883063648331754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5258883063648331754==--
