From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH] thermal: offer TI thermal support only when ARCH_OMAP2PLUS
 is defined
Date: Fri, 4 Oct 2013 14:26:54 -0400
Message-ID: <524F086E.4020608@ti.com>
References: <3702969.8rn3SOscJE@amdc1032> <524F0766.8070302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0IEhg0ricjKXxCOJSLJjch1s1OGWFlMC9"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <524F0766.8070302@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

--0IEhg0ricjKXxCOJSLJjch1s1OGWFlMC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04-10-2013 14:22, Eduardo Valentin wrote:
> On 04-10-2013 08:35, Bartlomiej Zolnierkiewicz wrote:
>> Menu for Texas Instruments thermal support is visible on all
>> platforms and TI_SOC_THERMAL + TI_THERMAL config options can
>> be selected also on EXYNOS platform (on which ARCH_HAS_BANDGAP
>> config option is selected by SoCs config options to fulfill
>> EXYNOS_THERMAL config option dependency). Thus the code which
>> is never used can be build. Fix it by making TI menu dependent
>> on ARCH_OMAP2PLUS config option.
>>


Besides, you can always disable the driver if you are not interested in
compiling it.

>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  drivers/thermal/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 57e06a9..a709c63 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -193,6 +193,7 @@ config X86_PKG_TEMP_THERMAL
>>  	  notification methods.
>> =20
>>  menu "Texas Instruments thermal drivers"
>> +depends on ARCH_OMAP2PLUS
>=20
> No, this driver is not for ARCH_OMAP*, but for TI bandgap, with the
> option to offer thermal control. So, the HW supported is TI bandgap IP,=

> not ARCH_OMAP*. It happens to be so that OMAP2PLUS all have a
> (different) version of this device.
>=20
> However, DRA7 devices, for instance, also feature the bandgap IP
> (different version of those present in OMAP devices), and it is not
> ARCH_OMAP2PLUS.
>=20
> And because of that, the design of this driver is different. It is not
> expected to depend on an arch, but the arch code is expected to select
> ARCH_HAS_BANDGAP.
>=20
>>  source "drivers/thermal/ti-soc-thermal/Kconfig"
>>  endmenu
>> =20
>>
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--0IEhg0ricjKXxCOJSLJjch1s1OGWFlMC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJPCG4ACgkQCXcVR3XQvP02+wEAiF/OtHWy//+0Nb91PmqMr9qh
B7nml+Zfy/ctltDgbyEA/0c1y/Ckp/sgrk5SU+Zvvy125hqLBDexW4yAcbpwFOYC
=4UA2
-----END PGP SIGNATURE-----

--0IEhg0ricjKXxCOJSLJjch1s1OGWFlMC9--
