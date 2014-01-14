From: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Tue, 14 Jan 2014 13:50:57 -0400
Message-ID: <52D57901.5050300@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com> <52D45BB7.1090002@ti.com> <52D4BA76.4040003@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="diVRVM8daTl9el16N3QO2xAlR1wWq4rEj"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D4BA76.4040003-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>, Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--diVRVM8daTl9el16N3QO2xAlR1wWq4rEj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

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
> other mail list, we should not set governor in DT, and I think the
> platform driver should be able to set to any governors which it want, s=
o
> I this patch, the driver can call the thermal_update_governor() to
> switch to new governor in kernel space.
> For example, there have two thermal driver, using of-thermal to registe=
r
> thermal zone device. One want to set to step_wise governor, another wan=
t
> fair_share, how can we do? I think after they calling the
> thermal_zone_of_sensor_register(), they can call the
> thermal_update_governor() to set the governor which they want.
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

OK, I see you have a very complex governor coming. But you know,
prediction is very difficult, especially if it's about the future. :-)

It would be very constructive if you could share the governor together
with the proposed change. It is not fair to introduce a new API for a
non-existing user, don't you agree?

> In fact we develop a new governor, based on PID logic. It will need som=
e
> parameters, such as proportional, integral and derivative. these value
> will be initialized in different values for different thermal zone, so
> we want to use the thermal_zone_device_update() to switch governor or
> update the governor's parameters for different thermal zone.

The parameters are a zone specific data right? Why should it be bound to
governor switch? The governor should be able to fetch the zone data when
needed.

Again, if you share the user of the API you are proposing we can work
together to make a better fit between API and users.

For the existing governors, I don't see a need to have the stop and
start callbacks.

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
>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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


--diVRVM8daTl9el16N3QO2xAlR1wWq4rEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLVeQEACgkQCXcVR3XQvP3AqgD/aoN0sM4sfgN7wuMqfmTcrslp
EbVfg+pYxW70MjnG0YYA/1THe+vHzgku4MapJXCKnJ7lnm6DVGh/fQXtaPhGfVlu
=j0qu
-----END PGP SIGNATURE-----

--diVRVM8daTl9el16N3QO2xAlR1wWq4rEj--
