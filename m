From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/5] power_supply: max77693: Properly handle error
 conditions
Date: Wed, 25 Feb 2015 21:46:23 +0100
Message-ID: <20150225204622.GG13695@earth>
References: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424771687-7976-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 24, 2015 at 10:54:43AM +0100, Krzysztof Kozlowski wrote:
> Re-work and fix handling of errors when retrieving power supply
> properties:
>=20
> 1. Return errno values directly from get_property() instead of storing
>    'unknown' as intval for given property.
>=20
> 2. Handle regmap_read() errors when getting 'online' and 'present'
>    proprties and return errno code. Previously the regmap_read() return
>    code was ignored so an uninitialized value from the stack could be
>    used for calculating the property.

Thanks, whole patchset pulled into battery-2.6.git.

-- Sebastian

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU7jSeAAoJENju1/PIO/qaki0QAKB6weKoBF3N/FxEo4/P/MAI
0G+aitCqcF/SoNjmbWH8KZOh1Xr0YeQNH0vzeIJ4wqxnHyNVITt3eQWzGFILGIz2
aaK3+9Pc+PGwijejWqGs5zMXWA68gCBMgidI63t6xTBccb12AhKYmDnkkAxPNFa/
uDzwiAjI/jC+0TOTJw/uexBcs6b2yWOkPglMKsJlW7CqDB+ZJi3J3Xd9aPAcE2Us
bC+BvljewhMaif/6UDxABMxNcQkyIwZAcvv8CtQgnr7+6a7jvXHfVGW1FFTWP0lW
jitliBCKycsVEGSZ8io4+sqVpbNXBSR5WQugXgaa40k5EuomI1P6mUKvNxqU8daI
pTBSizAyPp9FyEnP1ntA79DUCdNsvZaKoWYaTZfM72TKcjnjeEZek2YOz8Ol6Hm6
vyIKkk1oFvSQ93znsi6lRNXhcnMWIDPie6fOZm3oxh24UWGskr7wv2l+DiD916WM
2ndPHdxCVDBq1kgU5dzvghPaU7I41/FIvhCBKj36v9a0FEoCviCacO6X6/YBjQ53
plEu87Oqtfc2MC7DgjpaXsI8ctpjuk+7iWgbobhsVmESehF64f4720JPDGk+pcUR
wfVIBTOzCA5pgpF78cmyytSvbjnQ5ZFz8Jg5nRtcpozQbeaAVmx9vISYncB02ah4
FJ7SPLvLJsyOWKY16/+h
=FPL+
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
