From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power:lp8727_charger: use the private data instead
 of updating I2C device platform data
Date: Tue, 22 Sep 2015 15:14:49 +0200
Message-ID: <20150922131448.GC23334@earth>
References: <1440482828-7004-1-git-send-email-milo.kim@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33917 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757917AbbIVNOx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 09:14:53 -0400
Content-Disposition: inline
In-Reply-To: <1440482828-7004-1-git-send-email-milo.kim@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 25, 2015 at 03:07:07PM +0900, Milo Kim wrote:
> Currently, lp8727 charger driver parses the DT and copies values into the
> 'cl->dev.platform_data' if 'of_node' exists.
> This may have architectural issue. Platform data is configurable through
> the DT or I2C board info inside the platform area.
> However, lp8727 driver changes this configuration when it is loaded.
>=20
> The driver should get data from the platform side and use the private
> data, 'lp8727_chg->pdata' instead of changing the original platform data.
>=20
> _probe() procedure is changed as follows.
>   1. lp8727_parse_dt() returns the pointer of lp8727_platform_data.
>      The driver uses this allocated platform data. So it should keep
>      original platform data, 'dev->platform_data'.
>   2. In _probe(), check the return value of lp8727_parse_dt().
>      If an error is found, then exit as PTR_ERR(pdata).
>   3. If 'of_node' is not found, then the driver just gets the platform da=
ta
>      from the I2C device structure.
>   4. Map the platform data to private data structure.

Thanks, I queued both patches.

-- Sebastian

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAVRIAAoJENju1/PIO/qafdIP/A+ElbFYUc93u8X1S92umcVu
rCohpRx8pErR/d/VZ/xoOrte8SLMszYp2KjxehOBLFHpVw0Rl4NElG3KnB1PuMvd
udTF2Z4/JNzvULriSQl1npHnW1Zo0TpP37gTCcfPejXbZ7HpuQPN3FPj+UXEiwRM
Yc2HMN34rfdKNMjjQ7NRzis8M/+DpsRJ4ql1QZLSepngDnFYhelXTVNq/X2yfSjE
ButdvmnpyjzTAqu9WjyK0/pJgNKJU6Sql3YCIratvd9O6JzpKfFTpUS7StLSnJOu
W17FSPBXPZECoN2iFriAx3ziYypy6IAluSUkWiqSizCe7pPC+tgbyfX6Xcsvl7hG
5EzUxHuRWfqiph51mzAONbQDDhKqIvDQPN6a1Wl2zMw/CIBOf8Wozcg4Jvd3knPr
lYd4G2AFzE9Wiu7Zsvqlqchmck5U3wR/gLMc9B0Elt5gIXD6hz70WkaGJ4SGpe4g
lh0ASatNoEtGSX8hl9akbSgoD8nB6TN0bvB0vLXqGL+/srlSIU0QCvuFFXoBvSGr
AsoHCy20fGyuiSm8kohWVX1eTfBW7nNgMlkOyAilwPNpG/tkKagMvIXwoBBXkz54
LNC1IcI6GPFkuH+0oKEdr+ozOaBjtIymT9ps4d1DfgpGJNW4wOhIFVRREpa7zbs9
MwKrT0Zc+g/DjiQumlKg
=xZpF
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
