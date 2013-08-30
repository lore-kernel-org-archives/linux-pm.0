From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/3] thermal: ti-soc-thermal: Initialize counter_delay
 field for TI DRA752 sensors
Date: Fri, 30 Aug 2013 08:35:16 -0400
Message-ID: <52209184.9090706@ti.com>
References: <1377274103-27770-1-git-send-email-ranganath@ti.com>  <521F3C49.3020402@ti.com> <1377852125.2652.3.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AIuLIGcQJeTWLOjCm8w5CIMQroEFHiDXA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34430 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab3H3MfY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Aug 2013 08:35:24 -0400
In-Reply-To: <1377852125.2652.3.camel@rzhang-lenovo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Ranganath Krishnan <ranganath@ti.com>, linux-pm@vger.kernel.org, Praneeth Bajjuri <praneeth@ti.com>

--AIuLIGcQJeTWLOjCm8w5CIMQroEFHiDXA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30-08-2013 04:42, Zhang Rui wrote:
> On =E5=9B=9B, 2013-08-29 at 08:19 -0400, Eduardo Valentin wrote:
>> On 23-08-2013 12:08, Ranganath Krishnan wrote:
>>> Initialize MPU, GPU, CORE, DSPEVE and IVA thermal sensors of DRA752 b=
andgap
>>> with the counter delay mask.
>>>
>>> Signed-off-by: Ranganath Krishnan <ranganath@ti.com>
>>
>>
>> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>
> are you going to take this patch series?

Yes, I applied them on my next branch.


I will be sending you a pull request when I finish testing.

>=20
> thanks,
> rui
>>> ---
>>>  .../thermal/ti-soc-thermal/dra752-thermal-data.c   |    5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/d=
rivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> index e5d8326..a492927 100644
>>> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
>>> @@ -42,6 +42,7 @@ dra752_core_temp_sensor_registers =3D {
>>>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_CORE_MASK,
>>>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_CORE_MASK,
>>>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
>>> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MA=
SK,
>>>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_CORE_MASK,
>>>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_CORE_MASK,
>>>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_CORE_M=
ASK,
>>> @@ -77,6 +78,7 @@ dra752_iva_temp_sensor_registers =3D {
>>>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_IVA_MASK,
>>>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_IVA_MASK,
>>>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
>>> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MA=
SK,
>>>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_IVA_MASK,
>>>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_IVA_MASK,
>>>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_IVA_MA=
SK,
>>> @@ -112,6 +114,7 @@ dra752_mpu_temp_sensor_registers =3D {
>>>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_MPU_MASK,
>>>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_MPU_MASK,
>>>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
>>> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MA=
SK,
>>>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_MPU_MASK,
>>>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_MPU_MASK,
>>>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_MPU_MA=
SK,
>>> @@ -147,6 +150,7 @@ dra752_dspeve_temp_sensor_registers =3D {
>>>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_2_MASK_HOT_DSPEVE_MASK,
>>>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_2_MASK_COLD_DSPEVE_MASK,
>>>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
>>> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MA=
SK,
>>>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_2_FREEZE_DSPEVE_MASK,
>>>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_DSPEVE_MASK,
>>>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_2_CLEAR_ACCUM_DSPEVE=
_MASK,
>>> @@ -182,6 +186,7 @@ dra752_gpu_temp_sensor_registers =3D {
>>>  	.mask_hot_mask =3D DRA752_BANDGAP_CTRL_1_MASK_HOT_GPU_MASK,
>>>  	.mask_cold_mask =3D DRA752_BANDGAP_CTRL_1_MASK_COLD_GPU_MASK,
>>>  	.mask_sidlemode_mask =3D DRA752_BANDGAP_CTRL_1_SIDLEMODE_MASK,
>>> +	.mask_counter_delay_mask =3D DRA752_BANDGAP_CTRL_1_COUNTER_DELAY_MA=
SK,
>>>  	.mask_freeze_mask =3D DRA752_BANDGAP_CTRL_1_FREEZE_GPU_MASK,
>>>  	.mask_clear_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_GPU_MASK,
>>>  	.mask_clear_accum_mask =3D DRA752_BANDGAP_CTRL_1_CLEAR_ACCUM_GPU_MA=
SK,
>>>
>>
>>
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--AIuLIGcQJeTWLOjCm8w5CIMQroEFHiDXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIgkYQACgkQCXcVR3XQvP2pDAD/X6s4Zz+v9+jm95MFsXreuBn1
VTch3KmeBzenuWS27AAA/ieXsSPE8k0ukLTma5HwOwwLanXFDqK/IW1btemkdft8
=GI3D
-----END PGP SIGNATURE-----

--AIuLIGcQJeTWLOjCm8w5CIMQroEFHiDXA--
