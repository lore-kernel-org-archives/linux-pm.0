From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: armada: read stable temp on Armada XP
Date: Tue, 24 Feb 2015 14:36:18 -0400
Message-ID: <20150224183616.GD3448@developer.amazonguestwifi.org>
References: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:46414 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbbBXSgY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Feb 2015 13:36:24 -0500
Content-Disposition: inline
In-Reply-To: <1423608615-6575-1-git-send-email-tylerwhall@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tyler Hall <tylerwhall@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Tyler,

On Tue, Feb 10, 2015 at 05:50:15PM -0500, Tyler Hall wrote:
> The current register being used to read the temperature returns a noisy v=
alue
> that is prone to variance and occasional outliers. The value in the therm=
al
> manager control and status register appears to have the same scale but mu=
ch
> less variability.
>=20
> Add a "marvell,armadaxp-filtered-thermal" config which is set up to read =
=66rom
> the Thermal Manager Control and Status Register at 0x184c4 rather than the
> Thermal Sensor Status Register at 0x182b0. The only difference is the
> temperature value shift. The original "marvell,armadaxp-thermal" is retai=
ned
> for device tree compatibility.
>=20
> This also fixes Armada XP clearing the disable bit in the wrong register.=
 Bit 0
> of the sensor register was being cleared but that bit is read-only. The d=
isable
> bit doesn't seem to have an effect on the temperature sensor value, howev=
er, so
> this doesn't make a material difference.
>=20
> This problem was detected when running with the watchdog(8) daemon pollin=
g the
> thermal value. In one instance I observed a single read of over 200 degre=
es C
> which caused a spurious watchdog-initiated reboot. I have since observed
> individual outliers of ~20 degrees C. With this change and the correspond=
ing
> device tree update, the temperature is much more stable.
>=20
> Signed-off-by: Tyler Hall <tylerwhall@gmail.com>
> ---
>=20
> If there's a better way to handle this than a separate binding, I'm open =
to
> suggestions.


The fix seams reasonable. Although, it remains the question what is
applicability to other Armada chips? Besides, shouldn't we simply use it
by default? Also, do you plan to send updates in the DTS files?


I would appreciate if you get a Review-by, from Ezequiel for instance,
before we apply this.


Ezequiel, any objections before I move forward with this one?

BR,

Eduardo Valentin
>=20
> My conclusions about these registers are based on experimental data. The
> documentation is very sparse, but the Thermal Manager Control and Status
> Register looks like the preferred register given the way it is laid out i=
n the
> public spec.
>=20
> I have the small corresponding patch to the dts which I can submit separa=
tely.
>=20
> Thanks
> Tyler
>=20
>  .../devicetree/bindings/thermal/armada-thermal.txt          |  8 ++++++++
>  drivers/thermal/armada_thermal.c                            | 13 +++++++=
++++++
>  2 files changed, 21 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
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
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_th=
ermal.c
> index c2556cf..d3c2ad3 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -196,6 +196,15 @@ static const struct armada_thermal_data armadaxp_dat=
a =3D {
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
> @@ -236,6 +245,10 @@ static const struct of_device_id armada_thermal_id_t=
able[] =3D {
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
> --=20
> 2.3.0
>=20

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7MSVAAoJEMLUO4d9pOJWoRkH/1gAy2yBVeYxJzuHoOoBb4wA
ndR3OwIYpb7iSSCQ7eSvbyCcLhc5n2RMaGMH+84M+FJTwvLyTGxWc6lsc5kFhbta
AZf3jYo5KHe9Lldx6eKb/lzaFKeigM4fhdCFr2bIQ8dLucQirpebwWsWovsBUw9Q
b/MlA7VfZUCShMlNK09FFdj53dfX6YsUIz8U6rKNhdv4UGMYHNYgptfaFmyYetQk
NmVDEcZAPPcCva2LEWlWUa+cn5bSC0ZYEXm/Av1cQE0uYcOkFXeRqYodNdLLyCm/
4SNY+ycZVAR772pcJ/6UGZeOG7ESRLFjHe1J5FCQnmzZfQNUf87A+vkLKwbKfmc=
=Uj5K
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
