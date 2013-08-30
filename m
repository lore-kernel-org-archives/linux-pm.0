From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Fri, 30 Aug 2013 08:36:17 -0400
Message-ID: <522091C1.5010507@ti.com>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>  <521F3BEE.5020608@ti.com> <1377851701.2652.1.camel@rzhang-lenovo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="omiw6V8Jgl3lq5pVdUsSDhCaQAXE0e2cP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab3H3Mg1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Aug 2013 08:36:27 -0400
In-Reply-To: <1377851701.2652.1.camel@rzhang-lenovo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Sachin Kamat <sachin.kamat@linaro.org>, linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, amit.daniel@samsung.com, patches@linaro.org

--omiw6V8Jgl3lq5pVdUsSDhCaQAXE0e2cP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30-08-2013 04:35, Zhang Rui wrote:
> On =E5=9B=9B, 2013-08-29 at 08:17 -0400, Eduardo Valentin wrote:
>> On 19-08-2013 02:28, Sachin Kamat wrote:
>>> Fixes some trivial typos.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>
>>
>> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>
> so are you going to take this patch series?
>=20

Yeah. already applied them in my next branch.

I will send a pull request with this one and ti-soc-thermal fixes when I
am done testing.

> thanks,
> rui
>>> ---
>>> This series is based on next branch of below tree:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>>>
>>> This is tested on Exynos4210 and 5250 based boards.
>>> ---
>>>  drivers/thermal/samsung/Kconfig |   10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsun=
g/Kconfig
>>> index b653f15..92492e4 100644
>>> --- a/drivers/thermal/samsung/Kconfig
>>> +++ b/drivers/thermal/samsung/Kconfig
>>> @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
>>>  	depends on ARCH_HAS_BANDGAP
>>>  	help
>>>  	  If you say yes here you get support for the TMU (Thermal Manageme=
nt
>>> -	  Unit) driver for SAMSUNG EXYNOS series of soc. This driver initia=
lises
>>> +	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initi=
alises
>>>  	  the TMU, reports temperature and handles cooling action if define=
d.
>>> -	  This driver uses the exynos core thermal API's and TMU configurat=
ion
>>> -	  data from the supported soc's.
>>> +	  This driver uses the Exynos core thermal APIs and TMU configurati=
on
>>> +	  data from the supported SoCs.
>>> =20
>>>  config EXYNOS_THERMAL_CORE
>>> -	bool "Core thermal framework support for EXYNOS SOC's"
>>> +	bool "Core thermal framework support for EXYNOS SOCs"
>>>  	depends on EXYNOS_THERMAL
>>>  	help
>>>  	  If you say yes here you get support for EXYNOS TMU
>>>  	  (Thermal Management Unit) common registration/unregistration
>>>  	  functions to the core thermal layer and also to use the generic
>>> -	  cpu cooling API's.
>>> +	  CPU cooling APIs.
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


--omiw6V8Jgl3lq5pVdUsSDhCaQAXE0e2cP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlIgkcEACgkQCXcVR3XQvP10jgEAga7KWGcpZLnpIyNHwOW/z4/r
1X601Heyt0/UnsyryFYBAJ3Av4gcW2Oo+HlDy3wViTYA0/CmmepNg4uMW7aCMw8D
=EFt+
-----END PGP SIGNATURE-----

--omiw6V8Jgl3lq5pVdUsSDhCaQAXE0e2cP--
