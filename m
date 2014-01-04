From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/1] thermal: fix cpu_cooling max_level behavior
Date: Sat, 4 Jan 2014 09:53:28 -0400
Message-ID: <52C81258.1020500@ti.com>
References: <1384366269-1655-1-git-send-email-eduardo.valentin@ti.com>  <52A1D697.5030601@ti.com> <1388635350.3739.79.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rr9CDh3x70Sln9NMIGBqIct0uWbCtkeo4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58371 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753152AbaADNxf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 4 Jan 2014 08:53:35 -0500
In-Reply-To: <1388635350.3739.79.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

--rr9CDh3x70Sln9NMIGBqIct0uWbCtkeo4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 02-01-2014 00:02, Zhang Rui wrote:
> On Fri, 2013-12-06 at 09:52 -0400, Eduardo Valentin wrote:
>> On 13-11-2013 14:11, Eduardo Valentin wrote:
>>> As per Documentation/thermal/sysfs-api.txt, max_level
>>> is an index, not a counter. Thus, in case a CPU has
>>> 3 valid frequencies, max_level is expected to be 2, for instance.
>>>
>>> The current code makes max_level =3D=3D number of valid frequencies,
>>> which is bogus. This patch fix the cpu_cooling device by
>>> ranging max_level properly.
>>>
> good catch.
>>> Reported-by: Carlos Hernandez <ceh@ti.com>
>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>
>> Rui,
>>
>> Can you please consider pushing this fix?
>>
> applied.
>=20
>>> ---
>>>  drivers/thermal/cpu_cooling.c | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cool=
ing.c
>>> index d179028..d0f8f8b5 100644
>>> --- a/drivers/thermal/cpu_cooling.c
>>> +++ b/drivers/thermal/cpu_cooling.c
>>> @@ -173,6 +173,8 @@ static int get_property(unsigned int cpu, unsigne=
d long input,
>>>  		freq =3D table[i].frequency;
>>>  		max_level++;
>>>  	}
>>> +	/* max_level is an index, not a counter */
>>> +	max_level--;
>>>
> I think we should check the max_level first, like the patch I attached
> below.
>=20
> thanks,
> rui
>=20
>>From a116776f7b6052599df0c67db29c30ea9d69d7ee Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Thu, 2 Jan 2014 11:57:48 +0800
> Subject: [PATCH] Thermal cpu cooling: return error if no valid cpu freq=
uency
>  entry
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/cpu_cooling.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_coolin=
g.c
> index cc556a8..bb486b4 100644
> --- a/drivers/thermal/cpu_cooling.c
> +++ b/drivers/thermal/cpu_cooling.c
> @@ -173,6 +173,11 @@ static int get_property(unsigned int cpu, unsigned=
 long input,
>  		freq =3D table[i].frequency;
>  		max_level++;
>  	}
> +
> +	/* No valid cpu frequency entry */
> +	if (max_level =3D=3D 0)
> +		return -EINVAL;
> +

Agreed. For the patch above:

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

>  	/* max_level is an index, not a counter */
>  	max_level--;
> =20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--rr9CDh3x70Sln9NMIGBqIct0uWbCtkeo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLIElgACgkQCXcVR3XQvP3IlwEA/bwvpE7juqYxw+AHFzB1THOI
ROys+bNNv3IMz/k766cBAMZMdRpmR2uS/fXduNLik9uZ4UqEwdUUOgA15nRbk/1w
=e7HY
-----END PGP SIGNATURE-----

--rr9CDh3x70Sln9NMIGBqIct0uWbCtkeo4--
