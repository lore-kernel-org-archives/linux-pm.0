From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] power: supply: cpcap-battery: Fix
 platform_get_irq_byname's error checking
Date: Fri, 1 Dec 2017 16:30:44 +0100
Message-ID: <20171201153044.syty3b37rnjciqte@earth>
References: <638d9bb5ac4c0ef44d3e83cc0f74d6e80cddcf7d.1511542695.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="76zkddtbew62c754"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdLAPat (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Dec 2017 10:30:49 -0500
Content-Disposition: inline
In-Reply-To: <638d9bb5ac4c0ef44d3e83cc0f74d6e80cddcf7d.1511542695.git.arvind.yadav.cs@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--76zkddtbew62c754
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 24, 2017 at 10:31:40PM +0530, Arvind Yadav wrote:
> The platform_get_irq_byname() function returns -1 if an error occurs.
> zero or positive number on success. platform_get_irq_byname() error
> checking for zero is not correct.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index ee71a2b..98ba078 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -586,8 +586,8 @@ static int cpcap_battery_init_irq(struct platform_dev=
ice *pdev,
>  	int irq, error;
> =20
>  	irq =3D platform_get_irq_byname(pdev, name);
> -	if (!irq)
> -		return -ENODEV;
> +	if (irq < 0)
> +		return irq;
> =20
>  	error =3D devm_request_threaded_irq(ddata->dev, irq, NULL,
>  					  cpcap_battery_irq_thread,
> --=20
> 2.7.4
>=20

--76zkddtbew62c754
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlohdaQACgkQ2O7X88g7
+ppoCxAAmGMQAx5Bah0EQTlLSWPIB1gdaIY66wUneMdNBt5mNJQgkYnaAel+HlPB
lKZmW8XCr2Cu+74ClIuj+fyEyw+8X3gHZDb9ajO15cZEFa2f8O8lw/hjKVQFKYCb
lH/MVg+i9Nu+eFMi0pOorFNkJoQdiP+zEV7+4TuzgYwhBEt7X+PhFMXfjA92qbFM
z2pF+GMQ9Shapc+qlWbZQ9qUh1WMq/b6gjUnOvZ9BgV2H9rQCtJJx2sZP3s4KiJq
2W7/Iw5Wz6OCdrUxgSMSgpMHgOM6VGPmu/FEqDxoryBpiGYaZ1R3edkzZTTUiN9/
ffTvGnvzU7hJjudaQAv5PrqMoy4JuZAgvHEmtXovNDFy1yjqXvgzfeNxAesYM5y4
ZzxmdR0encyfJ8sYsU7iXd/GfQ08+AReoL/EamuN9FjiK2t45Qb2STwpZPvb+SjL
I+pyK7tmXDDqR+ZZxdzzo4ondvJxHUalG1zWOOH+Bz0XO8DGj2fZBhsAOK6J9+xd
NvP0+WOQVPPZqpHTUcLqvPqH2h5JJtxeXD1nt4fk3kqIycwUoS8Oah3dAJG7ogOP
67FTpaS15V/nAHtNSkcjaPEVHo5Tgi3sphWCoc1jkAB1R9+itKv7OHxBsxGPwHy2
DQeYDjGjuxPq1ka55CSTWoWdKrFO+WdTVJ0pnfA4owOquR1R8r8=
=k1cW
-----END PGP SIGNATURE-----

--76zkddtbew62c754--
