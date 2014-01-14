From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Tue, 14 Jan 2014 13:44:02 -0400
Message-ID: <52D57762.8070609@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com> <52D45BB7.1090002@ti.com> <52D4BA76.4040003@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NTkiNBbS0uHoFLWPaHtcjemnKhBaoGSKM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751594AbaANRoJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jan 2014 12:44:09 -0500
In-Reply-To: <52D4BA76.4040003@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

--NTkiNBbS0uHoFLWPaHtcjemnKhBaoGSKM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Wei,

On 14-01-2014 00:17, Wei Ni wrote:
> On 01/14/2014 05:33 AM, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> On 13-01-2014 15:01, Matthew Longnecker wrote:
>>> On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>>>>> This serie can support to turn governor for thermal zone in
>>>>> run time.
>>>>
>>>> Can you please explain why this is needed? Are you facing troubles w=
ith
>>>> current way to switch governors? If yes, can you please report them?=

>>
>> Looks like there is a need to switch governors from within kernel code=
,
>> but not explanation of use cases is provided.
>=20
> In fact, with the of-thermal framework, the driver can't initialize to
> any governor, even default governor, it may be a bug. As we discussed i=
n

I see. Using default governor is not a bug. The thermal zone shall not
be defined in way that it is specific to a policy. We must remember that
DT is not used for specifying policies, but only describing hardware.

> other mail list, we should not set governor in DT, and I think the
> platform driver should be able to set to any governors which it want, s=
o

OK. But still, because you believe the platform driver has to set the
governor, this is not a bug. Defining which policy is used to control a
zone can be a later decision in the boot process. Specially because the
critical requirements are not dealt by the governors anyway.

> I this patch, the driver can call the thermal_update_governor() to
> switch to new governor in kernel space.

I see.

> For example, there have two thermal driver, using of-thermal to registe=
r
> thermal zone device. One want to set to step_wise governor, another wan=
t
> fair_share, how can we do? I think after they calling the
> thermal_zone_of_sensor_register(), they can call the
> thermal_update_governor() to set the governor which they want.

OK. Now I get a better view of what you are trying to achieve with this
series. However, why can't you hand this decision off to userland,
during, say very early boot sequence?


>=20
>>
>>>>
>>>
>>> ....
>>>
>>>>> Adds thermal_update_governor() function, so the thermal platform
>>>>> driver can use it to update governor.
>>>>
>>>> Here I cannot see why the platform driver would need to update a
>>>> governor, instead of a zone. Platform drivers are not supposed to be=

>>>> aware of governors. For updating a zone we already have an API for t=
hat,
>>>> please check documentation.
>>>>
>>>
>>> I think we have a miscommunication. The purpose of
>>> thermal_update_governor is to *switch* governors at runtime (from wit=
hin
>>> the kernel).
>>>
>>> Wei has used the term "update" in the sense of switch rather than
>>> "update" in the sense used by thermal_zone_device_update.
>>
>> Fine, but why do you need it?
>=20
> Yes, I have consider to use "switch", but As my commit in the patch, in=

> the future, the governor may be more complex, it may need governor
> parameter/configuration, and need to be tuned in run-time or in
> initialization.
> In fact we develop a new governor, based on PID logic. It will need som=
e
> parameters, such as proportional, integral and derivative. these value
> will be initialized in different values for different thermal zone, so
> we want to use the thermal_zone_device_update() to switch governor or
> update the governor's parameters for different thermal zone.
>=20
>>
>>>
>>> Eduardo, what is your recommended technique for setting the governor =
of
>>> a thermal zone device created via device tree?
>>
>> So far the recommended (and existing) way is by user(land) decision.
>>
>>>
>>> thanks,
>>> Matt
>>>
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--NTkiNBbS0uHoFLWPaHtcjemnKhBaoGSKM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLVd2IACgkQCXcVR3XQvP3vDgEAnSn6jm0DqIYKc2buuF5gzwLj
Ax6puLIaiglKohSSGckA/jp54bUII1B8BQP8zIEB67zrS7MOcEQEOXK5s23ecHCC
=gcmR
-----END PGP SIGNATURE-----

--NTkiNBbS0uHoFLWPaHtcjemnKhBaoGSKM--
