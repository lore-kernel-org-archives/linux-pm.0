From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Initialize counter_delay
 field for TI DRA752 sensors
Date: Thu, 29 Aug 2013 08:19:21 -0400
Message-ID: <521F3C49.3020402@ti.com>
References: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gSUgGo1o2Fn21xvQJLIwbpNnjfhNQcUL1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52240 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab3H2MTa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Aug 2013 08:19:30 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id r7TCJUJs010599
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2013 07:19:30 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r7TCJU43004213
	for <linux-pm@vger.kernel.org>; Thu, 29 Aug 2013 07:19:30 -0500
In-Reply-To: <1377274103-27770-1-git-send-email-ranganath@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ranganath Krishnan <ranganath@ti.com>
Cc: linux-pm@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Praneeth Bajjuri <praneeth@ti.com>

--gSUgGo1o2Fn21xvQJLIwbpNnjfhNQcUL1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 23-08-2013 12:08, Ranganath Krishnan wrote:
> Initialize MPU, GPU, CORE, DSPEVE and IVA thermal sensors of DRA752 ban=
dgap
> with the counter delay mask.
>=20
> Signed-off-by: Ranganath Krishnan <ranganath@ti.com>


Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
>  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/dri=
vers/thermal/ti-soc-thermal/dra752-thermal-data.c
> index e5d8326..a492927 100644
> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> @@ -42,6 +42,7 @@ dra752_core_temp_sensor_registers =3D {
>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK=
,
>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK,
>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE_MAS=
K,
> @@ -77,6 +78,7 @@ dra752_iva_temp_sensor_registers =3D {
>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK=
,
>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK,
>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_MASK=
,
> @@ -112,6 +114,7 @@ dra752_mpu_temp_sensor_registers =3D {
>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK=
,
>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK,
>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_MASK=
,
> @@ -147,6 +150,7 @@ dra752_dspeve_temp_sensor_registers =3D {
>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK=
,
>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK,
>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPEVE_M=
ASK,
> @@ -182,6 +186,7 @@ dra752_gpu_temp_sensor_registers =3D {
>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MASK=
,
>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK,
>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_MASK=
,
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--gSUgGo1o2Fn21xvQJLIwbpNnjfhNQcUL1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIfPEwACgkQCXcVR3XQvP3+ugEAv5BMsOnsOO4rrMYRCu+2yHgO
wB85BYrajNkUvfwGVN4A/0vmG/JCJXFi7PBkJh1e7XklvpZrEl2hpuBGTezuDCTh
=HUW3
-----END PGP SIGNATURE-----

--gSUgGo1o2Fn21xvQJLIwbpNnjfhNQcUL1--
