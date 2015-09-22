From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power_supply: max8998: Use devm_power_supply_register
Date: Tue, 22 Sep 2015 17:14:10 +0200
Message-ID: <20150922151409.GB2533@earth>
References: <20150813045440.GA21920@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43834 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbbIVPON (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 11:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20150813045440.GA21920@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2015 at 10:24:41AM +0530, Vaishali Thakkar wrote:
> Use managed resource function devm_power_supply_register instead
> of power_supply_register to simplify the error path by allowing
> unregister to happen automatically on error. To be compatible with
> the change, replace various gotos by direct returns and remove
> unneeded label err.
>=20
> Also, remove max8998_battery_remove as it is now redundant.

Thanks, queued.

-- Sebastian

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBCgAGBQJWAXBBAAoJENju1/PIO/qaxuIP9116Srq2VbNVn2rabhNNvZG4
fHlDNsAZsE8DQRf/oN6NEO4RLJnoHhOXzeSt8cgU0EFLcsSwVT7+gSLmEMdZrWQs
lNPht5u9c+ltin/499IQk4VNnpm5w4UDn+PgCO2rA6Gw5gLFu08eMvDdrh+cZuMm
MKjMpmc3hDPKxWK4qwWUvx0h0B6Y+YE/abUtigL7q/SjmURferRts37fkNq5RgfO
jG9r3IkiRyjApEis/hwvPFXnmVyWifYmsjReKKPBvfqgq+0/XdhIXqop200j1Sc8
z+u5zbQ49UyumV4FsLc1HWzzWmZbRVLE3HWuAz8CIyt34oskUeQTFm34vsWm3SqG
hqL8kqkJeY3BrtmljjSJuHlBAfefGnMZ7TPVHhndTrY76vnCKT8StHSZPM1R11GX
xRtoAAE4Qn/r3JDVh2903r8V9t28n2xdetdnbMLcbmsBJ8SWyyrAIerozHEC0wiV
BGRNLOYKAW3KTQux56mAaxMs+G9LQ3TesivOOk7jGcDIBGiEUKu6KA8PEa7NHw6I
uo3WUsgPnNoYiiNpYSwZuztagfuRUwzsFrxCfrjeKRvixROXe51o/pjT3qMqiAOA
4t+wV9MrH3HW5Q15WT1OqaMp5Xpl0DLgp4OELWkFN7zsvftLmji+Fp/KMBVCqLoR
SFo5RmaQPJ+Tv0DdJpY=
=qu17
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
