From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: ASUS K53E fails to suspend if ehci_hcd is loaded
Date: Fri, 17 Jun 2011 21:57:39 +0600
Message-ID: <20110617155739.GE4307__6030.55382748625$1308326312$gmane$org@belkar.wrar.name>
References: <20110617145302.GD4307@belkar.wrar.name>
	<Pine.LNX.4.44L0.1106171109370.2143-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2583786263617743105=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1106171109370.2143-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============2583786263617743105==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 17, 2011 at 11:17:01AM -0400, Alan Stern wrote:
> Okay, then you must have seen all the verbose PM debugging messages. =20
> Which means the last suspend callback to run was for the 1-1 device
> rather than the usb1 device, right?
>=20
> If so, it means I was looking in the wrong place.  1-1 is the internal
> rate-matching hub, whereas usb1 is the EHCI controller's root hub.
>=20
> Can you add your own dev_info() statements to the hub_quiesce() and=20
> hub_suspend() routines in drivers/usb/core/hub.c, or should I send a=20
> patch?
After "usb 1-1.1: usb suspend" I see a full "start hub_suspend,
hub_quiesce, rest of hub_suspend" path for 1-1:1.0 (I've used &intf->dev
in suspend and hub->intfdev in quiesce as a 1st arg for dev_info()), then
"usb 1-1: usb suspend" and after that it hangs.

--=20
WBR, wRAR

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+3lzAAoJEDNi9wMaSZLh5LMP/jLCKeZBi65fdu+B9BFl/Yqi
rxfd8j5hod/KsHTWQHpjQ3ivmtszE3ixybocCfZddFH4a4RaO19aBpPFmzPRKuxW
PsDbGAnoH1VqL4ucnw4chu/0LdS9Rcyr6HpoOnK25JWyQi2Vti8554avuXzjmsVA
3X4SHoJ/z1rOOQoMHitsq1d4LhY1GXb9Jj2gVnhUeSE0BwErm07EoHwSOTW7qzUO
P/7RpC0UTxEDXSL4/UXKxrRqyyo75ypbs2VkWE3NmB8bZ3N//ojX4ZLq79/xVRdn
iGe6n3dWzxW/svfcVg0VD2dbcFd53UFtVlKChdYlTwFWXZvlmrhiM3hxanQuDw0W
3B8sH+A6+No5160LwdEPKwXKQ4XXiowM9z5SdHGqtnbnQnXoUmfW766zUiMKST9w
hj7RtUWcvCEe2Z1fgXdxsHX+6Bj/gY8Oj7P0MWNM6DJr1oEp6SKILD6irxIycQ8x
w+jiqcB+cMdncrlm3PdHTUGreeqTKpwx/oL/DZfyrHYYkF9vqfa4xr7lcDck0B3a
r505xI8sCrRszSDzNBS5mkbI21JP4Tdjg3PEtFpnsgZiT94XHhnfJv+OPE8mHIAH
MFIOHBozxvYsgh1VvQm8H9wzsTYeitlqlWkKP0mankJNjkWhxoxeOdvbvyxUcrId
d15cRIXSJMaehPpnWBYX
=bB8i
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--

--===============2583786263617743105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2583786263617743105==--
