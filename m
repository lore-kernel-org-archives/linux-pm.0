From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 06/11] mfd: axp20x: add separate MFD cell for AXP223
Date: Mon, 12 Dec 2016 16:51:35 +0100
Message-ID: <20161212155135.oyzzn3ssy3pilcgu@lukather>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20161209110419.28981-7-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fopm7hkd2bh7yrd6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:35978 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbcLLPvs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Dec 2016 10:51:48 -0500
Content-Disposition: inline
In-Reply-To: <20161209110419.28981-7-quentin.schulz@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, linux@armlinux.org.uk, lee.jones@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com


--fopm7hkd2bh7yrd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 12:04:14PM +0100, Quentin Schulz wrote:
> The AXP223 shares most of its logic with the AXP221 but has some
> differences for the VBUS power supply driver. Thus, to probe the driver
> with the correct compatible, the AXP221 and the AXP223 now have separate
> MFD cells.
>=20
> AXP221 MFD cells are renamed from axp22x_cells to axp221_cells to avoid
> confusion.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--fopm7hkd2bh7yrd6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYTseHAAoJEBx+YmzsjxAgcN4P/1PcLK2cv5LR/BrJLzIy4M2B
A46bOJZM2q0AcWHsL4mWr5JQDNjjxyPmWVMhTF833cRyUMMS7yPyjtD/M+8zFeuo
pe4rbMzxdW+QicD9BRFx16rNFknP26X/d4+Lh2rC9NEcOLXnq/viWXiG431J7HQD
k9bko3k205VNwp5iFKMtpi0BQGALw3pNKVfaWGXCU0rZ4LMsRXYcG0pyZGBz4Opf
3BR7oProrFXgryfJk0KF2MzWFNDAYpt+tYavffBuO3yA27tr7ZZDRyI/ihP5P2kh
+vsyY2GmwmllrKkPbcxAntkYrlbtQQXqD9Akc6cnX5XMg2c9v9G49J1xvnRjYjt9
wmxdd1xA341phI7S0trxUKcPwb3FGkKnt4oTo0XBEm1tFpQ0chzhw3AVQv79sLTy
enQVMuPkFnrXBU0eptVZQ93q1OilQOaQGRka93rULXi/sS1MOhrNWxqSjfBN72Hg
UANdDZcGKei+guTBS3ISnbqdDH5ufgA9NZZuhzOrMnQyH5Tt6Yhxt3hFwHbP4xiw
KO5EAKRO/GRO9TXd67ZdhruvEApCRER4pDa4qOZVtoIj1q4eCD7DyU6KwDYR4LZn
K9YhAEuOjxyGbOyCkSW4v8IClmmH0pG1Xl0rS6CzPmSE92/ySPH9+3k1on1D5jJn
rVk6+geloqgLTzPhjOTZ
=S+Eo
-----END PGP SIGNATURE-----

--fopm7hkd2bh7yrd6--
