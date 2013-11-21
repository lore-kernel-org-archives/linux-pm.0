From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: Thermal:about a BUG
Date: Thu, 21 Nov 2013 12:06:40 -0400
Message-ID: <528E2F90.80407@ti.com>
References: <201311201707055318198@gmail.com> <1385004811.2379.28.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ga56uGGkXPEdW0gAdilX8D52LSMxdAUcg"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33074 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab3KUQGv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Nov 2013 11:06:51 -0500
In-Reply-To: <1385004811.2379.28.camel@rzhang-lenovo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "xulinuxkernel@gmail.com" <xulinuxkernel@gmail.com>, "eduardo.valentin" <eduardo.valentin@ti.com>, linux-pm <linux-pm@vger.kernel.org>

--Ga56uGGkXPEdW0gAdilX8D52LSMxdAUcg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 20-11-2013 23:33, Zhang Rui wrote:
> Hi,
>=20
> thanks for reporting the problem.
>=20
> On =E4=B8=89, 2013-11-20 at 17:07 +0800, xulinuxkernel@gmail.com wrote:=

>> =20
>> Hi  all=20
>> Recently I porting the thermal driver,I think there will be a bug
>> following,I am Just not sure about it,
>> In functon get_target_state (),
>> ...
>> case THERMAL_TREND_DROPPING:
>> if (cur_state =3D=3D instance->lower) {
>> if (!throttle)
>> next_target =3D THERMAL_NO_TARGET;
>> } else {
>>     next_target =3D cur_state - 1;
>>     if (next_target > instance->upper)
>>         next_target =3D instance->upper;
>> }
>> break;
>> case THERMAL_TREND_DROP_FULL:
>> if (cur_state =3D=3D instance->lower) {
>> if (!throttle)
>>         next_target =3D THERMAL_NO_TARGET;
>> } else
>>     next_target =3D instance->lower;
>> break;
>> ..
>> =20
>> For case THERMAL_TREND_DROPPING
>> if cur_state=3D0,instance->lower=3D2,
>> so next_state =3D0xffffffff ,so next_target > instance->upper will be
>> right,
>> =20
>> I think In this case will be wrong.
>> and I think this will be okay.
>> =20
>> if (cur_state <=3D instance->lower) {
>> if (!throttle)
>> next_target =3D THERMAL_NO_TARGET;
>> } else {
>>     next_target =3D cur_state - 1;
>>     if (next_target > instance->upper)
>>         next_target =3D instance->upper;
>> }
>=20
> this should fix the problem for you, plus we may also needs this change=

> for THERMAL_TREND_DROPPING_FULL case.
> But my question would be:
> How could a cooling device be in a cooling state that is lower than the=

> lower limit of an active thermal_instance?
> This seems like that the cooling device' cooling state is changed beyon=
d
> thermal core, and I do not think the current code handles this situatio=
n
> well. IMO, we need a bigger fix for this issue. Let me think about it
> and reply to you later.

I think it is better to investigate further before we come up with a fix.=


Xu, can you please describe the thermal zone you are using? Also what
cooling device are you using? Is the cooling device in mainline?

Do you really see this error happening? Can you please describe the
scenario that leads to the error ?

>=20
> thanks,
> rui
>=20
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--Ga56uGGkXPEdW0gAdilX8D52LSMxdAUcg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKOL5AACgkQCXcVR3XQvP2gGgEA5e8jUzELlDFulCbeSdj3m/Pv
ke6202HNQA+Jrifx62QBAO0k7TQgST6Og+PSlnnvHhFxoWfqLfVFNJO2youfZCv9
=krTB
-----END PGP SIGNATURE-----

--Ga56uGGkXPEdW0gAdilX8D52LSMxdAUcg--
