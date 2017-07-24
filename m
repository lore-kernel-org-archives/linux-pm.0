From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power/reset: Convert to using %pOF instead of full_name
Date: Mon, 24 Jul 2017 20:52:07 +0200
Message-ID: <20170724185207.becsoxhqbu4z2vo3@earth>
References: <20170718214339.7774-44-robh@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ku4d5afpujxv3oxn"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170718214339.7774-44-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ku4d5afpujxv3oxn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 18, 2017 at 04:43:24PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/power/reset/at91-sama5d2_shdwc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/res=
et/at91-sama5d2_shdwc.c
> index 55fce8b75245..31080c254124 100644
> --- a/drivers/power/reset/at91-sama5d2_shdwc.c
> +++ b/drivers/power/reset/at91-sama5d2_shdwc.c
> @@ -171,8 +171,8 @@ static u32 at91_shdwc_get_wakeup_input(struct platfor=
m_device *pdev,
>=20
>  	for_each_child_of_node(np, cnp) {
>  		if (of_property_read_u32(cnp, "reg", &wk_input)) {
> -			dev_warn(&pdev->dev, "reg property is missing for %s\n",
> -				 cnp->full_name);
> +			dev_warn(&pdev->dev, "reg property is missing for %pOF\n",
> +				 cnp);
>  			continue;
>  		}

Thanks, applied to power-supply's for-next branch.

-- Sebastian

--ku4d5afpujxv3oxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2QdcACgkQ2O7X88g7
+pq5GQ/9H2HOxwqGPOj24VdHAsd/f4X3v/y/vCmZla4GZA5LQjWc7XE6NA3JbNWB
yvRLQgyXapNFawasj+dEf7EkDP5eOovQqsWtOZfciqAOnq9uMO8Qn+oTwVX0OV/V
9QtDAEra1lp6CB/LEjKyxC1A4+ofm7mGl7laQynMTfghyNBHIYFUgl2RtWJTTrOG
Fhofrps66aVKv+1V8fq7xuOkeYhRnZJ10aDMndHZxhlui2uv2oWxMvjTTmd5cuNQ
N4vtGWffcdme19GDj4M1WmYL+um4SVs4HD/6p0TIbghXrzxO0VvV4V/7DAfLZQ5x
aCHrEgOAkHSaZ1JYiY0Qg7V9Rwo4wiKrRRIjlOGNQDK+uSl/fCyPZqKHT+kghHxp
S7Mj591NoXhPryYsJedNhNt+nN8CLhFXpw87FDSt8EMlrkQ7I/bcRue3MHFykqdM
9SEeDBx6qwPUNvWTL1AXZ2D9YeN8N4gTtZvQiAE9VGNqqgfe1GK7Zq6e6REavhwk
1vruPv7L5EKGvqtqUFXi0BI6IUNE1oUXlrXGYw9FK8Trjtbpt5iLJc8zcAZWvSUr
X5Ij22gTTqSTx9X1S7uDxA1kpK8aS82BxM2uwghcL1LWBbgCaULCmuxc1xngnE3j
7q2KQGa5c/cA7frmcRI+6iqeC4wDzA39/LkcwGrmOTQXk5Pl1II=
=OBmc
-----END PGP SIGNATURE-----

--ku4d5afpujxv3oxn--
