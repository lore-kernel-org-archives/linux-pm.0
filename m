From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Wed, 25 Feb 2015 18:04:30 +0100
Message-ID: <54EE009E.8070206@free-electrons.com>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36790 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752646AbbBYREj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 12:04:39 -0500
In-Reply-To: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tyler Hall <tylerwhall@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hi Tyler,

On 10/02/2015 23:50, Tyler Hall wrote:
> The current register being used to read the temperature returns a noi=
sy value
> that is prone to variance and occasional outliers. The value in the t=
hermal
> manager control and status register appears to have the same scale bu=
t much
> less variability.
>=20
> Add a "marvell,armadaxp-filtered-thermal" config which is set up to r=
ead from
> the Thermal Manager Control and Status Register at 0x184c4 rather tha=
n the
> Thermal Sensor Status Register at 0x182b0. The only difference is the
> temperature value shift. The original "marvell,armadaxp-thermal" is r=
etained
> for device tree compatibility.
>=20
> This also fixes Armada XP clearing the disable bit in the wrong regis=
ter. Bit 0
> of the sensor register was being cleared but that bit is read-only. T=
he disable
> bit doesn't seem to have an effect on the temperature sensor value, h=
owever, so
> this doesn't make a material difference.
>=20
> This problem was detected when running with the watchdog(8) daemon po=
lling the
> thermal value. In one instance I observed a single read of over 200 d=
egrees C
> which caused a spurious watchdog-initiated reboot. I have since obser=
ved
> individual outliers of ~20 degrees C. With this change and the corres=
ponding
> device tree update, the temperature is much more stable.

I tried your patch on a OpenBlocks AX3. Without it I observed a tempera=
ture of
47=C2=B0C:
# cat /sys/class/thermal/thermal_zone0/temp
47233

Whereas with your patch I got a temperature of 228=C2=B0C!
# cat /sys/class/thermal/thermal_zone0/temp
228065

It should have an error somewhere in the values used.

>=20
> Signed-off-by: Tyler Hall <tylerwhall@gmail.com>
> ---
>=20
> If there's a better way to handle this than a separate binding, I'm o=
pen to
> suggestions.

Now that I thought more about it, I believe that it would make more
sens extending the current binding by adding a new optional named
register, indeed at the end we use the same sensor.

The binding would become:

thermal@182b0 {
		compatible =3D "marvell,armadaxp-thermal";
		reg =3D <0x182b0 0x4
			0x184d0 0x4
			0x184c4 0x4>;
		reg-names =3D "sensor", "ctrl", "filt-sens";
		status =3D "okay";
	};

and then in the probe function we got something like

res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "filt-sens")=
;
if res {
	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(priv->sensor))
		return PTR_ERR(priv->sensor);
} else {
	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
	priv->sensor =3D devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(priv->sensor))
		return PTR_ERR(priv->sensor);
}

My concern was that by introducing a new compatible string we don't
prevent to have 2 thermal nodes for the same hardware.

>=20
> My conclusions about these registers are based on experimental data. =
The
> documentation is very sparse, but the Thermal Manager Control and Sta=
tus
> Register looks like the preferred register given the way it is laid o=
ut in the
> public spec.

Ezequiel,

as you worked on this do you know why we used the Thermal Sensor Status=
 Register
instead of the Thermal Manager Control and Status Register ?
My first guess is that the giving the name of the registers the 1st one=
 made
more sens to use for a thermal sensor.


Thanks,

Gregory

>=20
> I have the small corresponding patch to the dts which I can submit se=
parately.
>=20
> Thanks
> Tyler
>=20
>  .../devicetree/bindings/thermal/armada-thermal.txt          |  8 +++=
+++++
>  drivers/thermal/armada_thermal.c                            | 13 +++=
++++++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal=
=2Etxt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index 4698e0e..0d6a3f1 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -7,6 +7,14 @@ Required properties:
>  		marvell,armada375-thermal
>  		marvell,armada380-thermal
>  		marvell,armadaxp-thermal
> +		marvell,armadaxp-filtered-thermal
> +
> +		Note: "marvell,armadaxp-filtered-thermal" is adjusted to read
> +		the hardware-filtered value in the thermal manager
> +		control/status register rather than the raw sensor value in the
> +		thermal sensor status register. "marvell,armadaxp-thermal"
> +		remains for backward compatibility. The sensor reg address must
> +		also point to the appropriate register.
> =20
>  - reg:		Device's register space.
>  		Two entries are expected, see the examples below.
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armad=
a_thermal.c
> index c2556cf..d3c2ad3 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -196,6 +196,15 @@ static const struct armada_thermal_data armadaxp=
_data =3D {
>  	.coef_div =3D 13825,
>  };
> =20
> +static const struct armada_thermal_data armadaxp_filt_data =3D {
> +	.init_sensor =3D armadaxp_init_sensor,
> +	.temp_shift =3D 1,
> +	.temp_mask =3D 0x1ff,
> +	.coef_b =3D 3153000000UL,
> +	.coef_m =3D 10000000UL,
> +	.coef_div =3D 13825,
> +};
> +
>  static const struct armada_thermal_data armada370_data =3D {
>  	.is_valid =3D armada_is_valid,
>  	.init_sensor =3D armada370_init_sensor,
> @@ -236,6 +245,10 @@ static const struct of_device_id armada_thermal_=
id_table[] =3D {
>  		.data       =3D &armadaxp_data,
>  	},
>  	{
> +		.compatible =3D "marvell,armadaxp-filtered-thermal",
> +		.data       =3D &armadaxp_filt_data,
> +	},
> +	{
>  		.compatible =3D "marvell,armada370-thermal",
>  		.data       =3D &armada370_data,
>  	},
>=20


--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
