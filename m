From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH v2 29/38] thermal: exynos: Support both Exynos4x12 SoCs
Date: Mon, 17 Jun 2013 19:34:34 -0400
Message-ID: <51BF9D0A.6050706@ti.com>
References: <1371486863-12398-1-git-send-email-t.figa@samsung.com>
 <1371486863-12398-30-git-send-email-t.figa@samsung.com>
 <201306172159.15352.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1814755704598604387=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201306172159.15352.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, Tomasz Figa <t.figa@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Thomas Abraham <thomas.abraham@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Olof Johansson <olof@lixom.net>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

--===============1814755704598604387==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="----enig2NBOEBLWTOCPXXMTQBFPN"

------enig2NBOEBLWTOCPXXMTQBFPN
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Arnd,

On 17-06-2013 15:59, Arnd Bergmann wrote:
> On Monday 17 June 2013, Tomasz Figa wrote:
>> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos=
_thermal.c
>> index 788b1dd..4cbe3ee 100644
>> --- a/drivers/thermal/exynos_thermal.c
>> +++ b/drivers/thermal/exynos_thermal.c
>> @@ -817,7 +817,8 @@ static struct exynos_tmu_platform_data const exyno=
s4210_default_tmu_data =3D {
>>  #define EXYNOS4210_TMU_DRV_DATA (NULL)
>>  #endif
>> =20
>> -#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412)
>> +#if defined(CONFIG_SOC_EXYNOS5250) || defined(CONFIG_SOC_EXYNOS4412) =
|| \
>> +       defined(CONFIG_SOC_EXYNOS4212)
>>  static struct exynos_tmu_platform_data const exynos_default_tmu_data =
=3D {
>>         .threshold_falling =3D 10,
>>         .trigger_levels[0] =3D 85,
>=20
> The patch is correct, but generally speaking I think we should get away=
 from
> having the drivers get configured per SoC on such a fine-grained level.=

> Better make this driver (and others) always work on all exynos variants=
=2E

Amit, correct if I am wrong, but:

The driver will work on supported exynos variants. Those that have the
need for thermal sensing. And each of them have specific thermal needs
(trigger points, thresholds, etc). That is what this file tries to
isolate. And there is specific data structures for each soc version.


>=20
> 	Arnd
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


------enig2NBOEBLWTOCPXXMTQBFPN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlG/nQoACgkQCXcVR3XQvP0XcgD/eL7yR7H66Sqa/fDDI4o7perH
l4/xXXIdF9IlmImNNHMBALBX3T09rmnEEKCvsX3ayB4Hn4QqBw8TNxyHquekYNBv
=fMUg
-----END PGP SIGNATURE-----

------enig2NBOEBLWTOCPXXMTQBFPN--


--===============1814755704598604387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1814755704598604387==--
