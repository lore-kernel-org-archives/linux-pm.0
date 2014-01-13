From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Mon, 13 Jan 2014 17:33:43 -0400
Message-ID: <52D45BB7.1090002@ti.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com> <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NGQPhjewLxrQWEFwcMVF9Nm7aGjhrDgQX"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56035 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418AbaAMVdv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jan 2014 16:33:51 -0500
In-Reply-To: <52D43810.6030801@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew Longnecker <mlongnecker@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, eduardo.valentin@ti.com

--NGQPhjewLxrQWEFwcMVF9Nm7aGjhrDgQX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-01-2014 15:01, Matthew Longnecker wrote:
> On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>>> This serie can support to turn governor for thermal zone in
>>> run time.
>>
>> Can you please explain why this is needed? Are you facing troubles wit=
h
>> current way to switch governors? If yes, can you please report them?

Looks like there is a need to switch governors from within kernel code,
but not explanation of use cases is provided.

>>
>=20
> ....
>=20
>>> Adds thermal_update_governor() function, so the thermal platform
>>> driver can use it to update governor.
>>
>> Here I cannot see why the platform driver would need to update a
>> governor, instead of a zone. Platform drivers are not supposed to be
>> aware of governors. For updating a zone we already have an API for tha=
t,
>> please check documentation.
>>
>=20
> I think we have a miscommunication. The purpose of
> thermal_update_governor is to *switch* governors at runtime (from withi=
n
> the kernel).
>=20
> Wei has used the term "update" in the sense of switch rather than
> "update" in the sense used by thermal_zone_device_update.

Fine, but why do you need it?

>=20
> Eduardo, what is your recommended technique for setting the governor of=

> a thermal zone device created via device tree?

So far the recommended (and existing) way is by user(land) decision.

>=20
> thanks,
> Matt
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--NGQPhjewLxrQWEFwcMVF9Nm7aGjhrDgQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLUW7cACgkQCXcVR3XQvP0C2wEA5zOlB2FcMGdMrzomdiLhbzJV
eN/sVX/lf917NLoNiecBAMEyMTb0AFLXYPX1MigLi4Zl3q7z82438cQrazTa1O8P
=rZAw
-----END PGP SIGNATURE-----

--NGQPhjewLxrQWEFwcMVF9Nm7aGjhrDgQX--
