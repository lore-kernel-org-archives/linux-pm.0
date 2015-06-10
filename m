From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: sysfs: Bring back write to writeable
 properties
Date: Wed, 10 Jun 2015 16:46:28 +0200
Message-ID: <20150610144628.GB11618@earth>
References: <1433725788-13693-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52586 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbbFJOqc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Jun 2015 10:46:32 -0400
Content-Disposition: inline
In-Reply-To: <1433725788-13693-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 08, 2015 at 10:09:48AM +0900, Krzysztof Kozlowski wrote:
> The fix for NULL pointer exception related to calling uevent for not
> finished probe caused to set all writeable properties as non-writeable.
> This was caused by checking if property is writeable before the initial
> increase of power supply usage counter and in the same time using
> wrapper over property_is_writeable(). The wrapper returns ENODEV if the
> usage counter is still 0.
>=20
> The call trace looked like:
>   device probe:
>     power_supply_register()
>       use_cnt =3D 0;
>       device_add()
>         create sysfs entries
>           power_supply_attr_is_visible()
>             power_supply_property_is_writeable()
>               if (use_cnt =3D=3D 0) return -ENODEV;
>       use_cnt++;
>=20
> Replace the usage of wrapper with direct call to property_is_writeable()
> from driver. This should be safe call during device probe because
> implementations of this callback just return 0/1 for different
> properties and they do not access any of the driver's internal data.

Thanks, queued.

-- Sebastian

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVeE2/AAoJENju1/PIO/qaWS8P/1dWizZOaYbb3LmnIe4xgjla
YJxLiyEpJwNADu8iTvw662MHIxkvuAh/ABP2g8AsmWOzGYMwJG5Ituy5fShBHrnr
f3OeXTiiTLCuSjC2UNnMRK6Z/LmeOoaMIYbTlMhEMc4DAGJzz8V0xjZfpsrq+zJk
rGy37fztPPjRsb3XV8STjtk4urzqo8tT5g4mL/eDgGmtuH3IsYbGUjFBO7vhen2r
bOp2g21+NVJIckRoNTj52LMWD3cHZfLPPDt2oIBV54SlSkGawhtuZapP8iw6atSx
m7g1Cq2G/J9v4T4GZvU6Py3PnEjvY/OuemOEVtxEEeNOMpfDv5oSd+yJWjkB94yB
Lw1lWcfrlDoQvPzujzVbuw4pa3/ZWaXqSYGV19y0Np3pMD0u59rfMMg6eeL00TIX
knbU8gPDgWlORKEYV5hj3AQIolQP1DbYEdNpoAJa6jhb2yYXcbTl/uCDVRJQLwzY
vHd+2mJU2ap05T1ztriDlJH3ivrTrmdVyg9lVPskOd3YmNn/7zLfmN/zmqIfdRrb
TPMY4tow3sreWSWeAreAOAes9pkIqC2zyQjq0ySq35ETHBkuPUsfSzsY9v7rZxHP
StQev5D8obG9c2NOegZOr19HmvkpaIn/3IeJm/yYKbqOvtjBo8ZbytwDl0ng7mmJ
kg2/fIKP/sRbK0M20TKT
=NM6r
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
