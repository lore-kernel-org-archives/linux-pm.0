From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Wed, 15 Jan 2014 10:04:29 -0400
Message-ID: <52D6956D.4080001@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com> <52D45BB7.1090002@ti.com> <52D4BA76.4040003@nvidia.com> <52D57901.5050300@ti.com> <52D67448.9020102@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dToWcOn7kcopSEA4B1Ob2s6leTMhEdSr6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57941 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbaAOOEk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2014 09:04:40 -0500
In-Reply-To: <52D67448.9020102@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

--dToWcOn7kcopSEA4B1Ob2s6leTMhEdSr6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15-01-2014 07:43, Wei Ni wrote:
> On 01/15/2014 01:50 AM, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> On 14-01-2014 00:17, Wei Ni wrote:
>>> On 01/14/2014 05:33 AM, Eduardo Valentin wrote:
>>>>> Old Signed by an unknown key
>>>>
>>>> On 13-01-2014 15:01, Matthew Longnecker wrote:
>>>>> On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>>>>>>> This serie can support to turn governor for thermal zone in
>>>>>>> run time.
>>>>>>
>>>>>> Can you please explain why this is needed? Are you facing troubles=
 with
>>>>>> current way to switch governors? If yes, can you please report the=
m?
>>>>
>>>> Looks like there is a need to switch governors from within kernel co=
de,
>>>> but not explanation of use cases is provided.
>>>
>>> In fact, with the of-thermal framework, the driver can't initialize t=
o
>>> any governor, even default governor, it may be a bug. As we discussed=
 in
>>> other mail list, we should not set governor in DT, and I think the
>>> platform driver should be able to set to any governors which it want,=
 so
>>> I this patch, the driver can call the thermal_update_governor() to
>>> switch to new governor in kernel space.
>>> For example, there have two thermal driver, using of-thermal to regis=
ter
>>> thermal zone device. One want to set to step_wise governor, another w=
ant
>>> fair_share, how can we do? I think after they calling the
>>> thermal_zone_of_sensor_register(), they can call the
>>> thermal_update_governor() to set the governor which they want.
>>>
>>>>
>>>>>>
>>>>>
>>>>> ....
>>>>>
>>>>>>> Adds thermal_update_governor() function, so the thermal platform
>>>>>>> driver can use it to update governor.
>>>>>>
>>>>>> Here I cannot see why the platform driver would need to update a
>>>>>> governor, instead of a zone. Platform drivers are not supposed to =
be
>>>>>> aware of governors. For updating a zone we already have an API for=
 that,
>>>>>> please check documentation.
>>>>>>
>>>>>
>>>>> I think we have a miscommunication. The purpose of
>>>>> thermal_update_governor is to *switch* governors at runtime (from w=
ithin
>>>>> the kernel).
>>>>>
>>>>> Wei has used the term "update" in the sense of switch rather than
>>>>> "update" in the sense used by thermal_zone_device_update.
>>>>
>>>> Fine, but why do you need it?
>>>
>>> Yes, I have consider to use "switch", but As my commit in the patch, =
in
>>> the future, the governor may be more complex, it may need governor
>>> parameter/configuration, and need to be tuned in run-time or in
>>> initialization.
>>
>> OK, I see you have a very complex governor coming. But you know,
>> prediction is very difficult, especially if it's about the future. :-)=

>=20
> Yes, absolutely agree.
>=20
>>
>> It would be very constructive if you could share the governor together=

>> with the proposed change. It is not fair to introduce a new API for a
>> non-existing user, don't you agree?
>>
>>> In fact we develop a new governor, based on PID logic. It will need s=
ome
>>> parameters, such as proportional, integral and derivative. these valu=
e
>>> will be initialized in different values for different thermal zone, s=
o
>>> we want to use the thermal_zone_device_update() to switch governor or=

>>> update the governor's parameters for different thermal zone.
>>
>> The parameters are a zone specific data right? Why should it be bound =
to
>> governor switch? The governor should be able to fetch the zone data wh=
en
>> needed.
>=20
> Let me consider it carefully again.

Let me make clear, I am not against your proposal for change, as long as
you provide enough info so that we can design the API properly. For new
APIs, it is hard to design it, see its benefits and understand why
existing APIs are not enough if we do not see at least one user of the
new API. In other words, yes, I am open to changes, as long as I can
properly understand it.

>=20
>>
>> Again, if you share the user of the API you are proposing we can work
>> together to make a better fit between API and users.
>>
>> For the existing governors, I don't see a need to have the stop and
>> start callbacks.
>>
>>>
>>>>
>>>>>
>>>>> Eduardo, what is your recommended technique for setting the governo=
r of
>>>>> a thermal zone device created via device tree?
>>>>
>>>> So far the recommended (and existing) way is by user(land) decision.=

>>>>
>>>>>
>>>>> thanks,
>>>>> Matt
>>>>>
>>>>> --=20
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-pm"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>
>>>>
>>>
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


--dToWcOn7kcopSEA4B1Ob2s6leTMhEdSr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLWlW0ACgkQCXcVR3XQvP3XwAD/RZ5jIEzAQsaQrajrTj6bP2+L
f9khhXizjdBxA+iGLiYA/1C01W8ZPAiI2m0X6CvxrtLbZKISzBdTYj6zwzH5ZuhW
=aHrt
-----END PGP SIGNATURE-----

--dToWcOn7kcopSEA4B1Ob2s6leTMhEdSr6--
