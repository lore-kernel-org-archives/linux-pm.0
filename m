From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 4/4] power: Add an axp20x-usb-power driver
Date: Fri, 24 Jul 2015 17:10:21 +0200
Message-ID: <20150724151020.GH27569@earth>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-4-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Z7/5fzWRHDJ0o7Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35221 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbGXPKZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:10:25 -0400
Content-Disposition: inline
In-Reply-To: <1435316357-26606-4-git-send-email-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com


--+Z7/5fzWRHDJ0o7Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 26, 2015 at 12:59:17PM +0200, Hans de Goede wrote:
> This adds a driver for the usb power_supply bits of the axp20x PMICs.
>=20
> I initially started writing my own driver, before coming aware of
> Bruno Pr=E9mont's excellent earlier RFC with a driver for this.
>=20
> My driver was lacking CURRENT_MAX and VOLTAGE_MIN support Bruno's
> drvier has, so I've copied the code for those from his driver.
>=20
> Note that the AC-power-supply and battery charger bits will need separate
> drivers. Each one needs its own devictree child-node so that other
> devicetree nodes can reference the right power-supply, and thus each one
> will get its own mfd-cell / platform_device and platform-driver.

Once the other comments have been taken care of, the driver looks ok
to me.

-- Sebastian

--+Z7/5fzWRHDJ0o7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVslVTAAoJENju1/PIO/qaJ1IQAKWE5Sktm+FAJrTEDBQIAshE
yqRApCLufkp34pqxHrKbbieO0e0MXq/f/42QcBTRs5Oqznsz8SnjzDsAxteGa+SO
XsdFG1fVqsdgJNYFAfFBPWxrh8tM8nbROv5S2EQrqd7jaAkiQC921QRYo9FrER4e
TFpPLJ4HJG7AmpHDwyxz3+YaGtVPsRNM5oI9FdWftOycrSzCA22sUQ9MRFojzVIm
CHg9aJ0YCBhNSE1jlFLxn65mpCiUW0y3SiwYKao3p2q6UiUOnxiSfCL6oSwwsTlS
HaCXXYVgzIAX8nZIbK8f9TVu+0fds9AI5alXfNbx9BBFM3SiOjlm8fnFIXE4F6AU
zyHFda8KZjUdGLjFRUS03fr6VDxJk44Qq3VFJnu7MyUk02pqBVjid9gvm8TPwRlz
8voK1dErGh6R0p4phfoMhNVZIZVves+x21MpAzwq7q52UFf3yEfYZDqOHRWYnPpz
Ly3hbistz+zXGthFiF8C9rluepp5V6orKBAsLJuhoA4Tggk3wJsl/+B2GePiHy5Z
WOwWdrsFXG1B69azQuTYMKrfWPh+IPHLT8IXTUE1FPVKDtuCEmicCivhmuscnybH
eCLQCNOC//52vSrccQ2juRSINAe+1AiDSWFof3XsV1KOWfXB3MWSjZ78LSeRmAOg
5neoIdN8AgU9/gOOu/IO
=ALq0
-----END PGP SIGNATURE-----

--+Z7/5fzWRHDJ0o7Q--
