From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: syscon-reboot: add a mask property
Date: Fri, 5 Apr 2019 17:18:05 +0200
Message-ID: <20190405151805.fr3ie3q2vspljhr7@earth.universe>
References: <20190308074930.15270-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4iycinlwha4fbtrm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308074930.15270-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Schiller <ms@dev.tdt.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, fkan@apm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--4iycinlwha4fbtrm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 08, 2019 at 08:49:30AM +0100, Martin Schiller wrote:
> Make the syscon-reboot driver accept value and mask instead of
> just value.
>=20
> Prior to this patch, the property name for the value was 'mask'. If
> only the mask property is defined on a node, maintain compatibility
> by using it as the value.
>=20
> This patch is based on commit
> f2c199db477e ("power: reset: syscon-poweroff: add a mask property")
> and does the same change for the syscon-reboot driver.
>=20
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---

thanks, queued.

-- Sebastian

>  .../devicetree/bindings/power/reset/syscon-reboot.txt | 11 +++++++++--
>  drivers/power/reset/syscon-reboot.c                   | 19 +++++++++++++=
++++--
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.=
txt b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> index 11906316b43d..e23dea8344f8 100644
> --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.txt
> @@ -3,13 +3,20 @@ Generic SYSCON mapped register reset driver
>  This is a generic reset driver using syscon to map the reset register.
>  The reset is generally performed with a write to the reset register
>  defined by the register map pointed by syscon reference plus the offset
> -with the mask defined in the reboot node.
> +with the value and mask defined in the reboot node.
> =20
>  Required properties:
>  - compatible: should contain "syscon-reboot"
>  - regmap: this is phandle to the register map node
>  - offset: offset in the register map for the reboot register (in bytes)
> -- mask: the reset value written to the reboot register (32 bit access)
> +- value: the reset value written to the reboot register (32 bit access)
> +
> +Optional properties:
> +- mask: update only the register bits defined by the mask (32 bit)
> +
> +Legacy usage:
> +If a node doesn't contain a value property but contains a mask property,=
 the
> +mask property is used as the value.
> =20
>  Default will be little endian mode, 32 bit access only.
> =20
> diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/sy=
scon-reboot.c
> index 7d0d269a0837..5a6bb638c331 100644
> --- a/drivers/power/reset/syscon-reboot.c
> +++ b/drivers/power/reset/syscon-reboot.c
> @@ -27,6 +27,7 @@
>  struct syscon_reboot_context {
>  	struct regmap *map;
>  	u32 offset;
> +	u32 value;
>  	u32 mask;
>  	struct notifier_block restart_handler;
>  };
> @@ -39,7 +40,7 @@ static int syscon_restart_handle(struct notifier_block =
*this,
>  					restart_handler);
> =20
>  	/* Issue the reboot */
> -	regmap_write(ctx->map, ctx->offset, ctx->mask);
> +	regmap_update_bits(ctx->map, ctx->offset, ctx->mask, ctx->value);
> =20
>  	mdelay(1000);
> =20
> @@ -51,6 +52,7 @@ static int syscon_reboot_probe(struct platform_device *=
pdev)
>  {
>  	struct syscon_reboot_context *ctx;
>  	struct device *dev =3D &pdev->dev;
> +	int mask_err, value_err;
>  	int err;
> =20
>  	ctx =3D devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> @@ -64,8 +66,21 @@ static int syscon_reboot_probe(struct platform_device =
*pdev)
>  	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
>  		return -EINVAL;
> =20
> -	if (of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask))
> +	value_err =3D of_property_read_u32(pdev->dev.of_node, "value", &ctx->va=
lue);
> +	mask_err =3D of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask=
);
> +	if (value_err && mask_err) {
> +		dev_err(dev, "unable to read 'value' and 'mask'");
>  		return -EINVAL;
> +	}
> +
> +	if (value_err) {
> +		/* support old binding */
> +		ctx->value =3D ctx->mask;
> +		ctx->mask =3D 0xFFFFFFFF;
> +	} else if (mask_err) {
> +		/* support value without mask*/
> +		ctx->mask =3D 0xFFFFFFFF;
> +	}
> =20
>  	ctx->restart_handler.notifier_call =3D syscon_restart_handle;
>  	ctx->restart_handler.priority =3D 192;
> --=20
> 2.11.0
>=20

--4iycinlwha4fbtrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynca0ACgkQ2O7X88g7
+popCA//dK7Dexr7cJnG6mdmK2NQzYdDB/9PyWQmOBWxP0WgBqKNUyqj0E9TCkNi
EbrvppE4s4QTKAZ4pc9pUJEqNDqFPhRi82Xaj1NUp2cPAeyPUJr4O/kjM6VmLpbj
lgTFkjn/d2IvHT5s/HAs+AMDzqVaSrVxRemgFk+7Ccux5dfnZAKGaDLJANYi/dxW
w/kaiYiw0rQMq3b7sEEaEI7D3OR11qo/BV3SC3154PeqSKohroRE5o6YUsC7zUSJ
4hA+i+NjNekqfKkQKY6FsgRLoSuKXpWBIf4EhYuLVPxAXEsEWtd/Hs8jjVxoYgpq
biiPoi3EdgMs364O3kTFrJbfe946F4AiH04rVX4m4wHZ83WIERO3y2DnvQ3Y67td
Hu7J01uKjMuulrjGF9si3EoUui6ppxW6Lmbof6/GUCt3LdVon+gC517uJjtW7a8t
EjM+gbSttmOblGWYcVb3RvM/FQrIoslE9V2BXLXbIALXF1bOHi1GTJXWxeHI1FNN
YrARbBM0Cp1/ESBlF6PtrKLfI4fn8U6XYu5JEN+lTYPuDuSBTs7KhsRbkLAIuYbe
oYHYh6XCEGQGaRkwNYilda5Uz6iClzdZPOwTlAOixfDDBu1Ne33h7c3CBt1V8nOb
2tLA9q96c9qGAGt4xP1lFmroHdvFCaq4zr7fzIm2PtqzsmKQ1gY=
=VyQN
-----END PGP SIGNATURE-----

--4iycinlwha4fbtrm--
