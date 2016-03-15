From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 05/12] thermal: tegra: add Tegra210 specific SOC_THERM
 driver
Date: Tue, 15 Mar 2016 14:59:52 +0800
Message-ID: <56E7B2E8.8070100@nvidia.com>
References: <1457665825-29837-1-git-send-email-wni@nvidia.com> <20160314185739.GA1872@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314185739.GA1872-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 02:57, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:10:25AM +0800, Wei Ni wrote:
>> Add Tegra210 specific SOC_THERM driver.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/tegra/Makefile            |   1 +
>>  drivers/thermal/tegra/soctherm-fuse.c     |  11 ++
>>  drivers/thermal/tegra/soctherm.c          |   6 ++
>>  drivers/thermal/tegra/soctherm.h          |   4 +
>>  drivers/thermal/tegra/tegra210-soctherm.c | 173 +++++++++++++++++++=
+++++++++++
>=20
> No Kconfig change?

Yes, we doesn't need Kconfig change.

As discussed with Thierry in [V1,03/10] thermal: tegra: split tegra_soc=
therm
driver, he said:
"I'd like to do this differently to reduce the number of Kconfig symbol=
s.
The alternate proposal would be for the TEGRA_SOCTHERM symbol to remain
as it is and then build in driver support depending on the selected
ARCH_TEGRA_*_SOC options."

So we only have "config TEGRA_SOCTHERM" in the Kconfig, and in Makefile=
, we add
tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.o
tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.o

>=20
>>  5 files changed, 195 insertions(+)
>>  create mode 100644 drivers/thermal/tegra/tegra210-soctherm.c
>>
>> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/=
Makefile
>> index d5fb15377b97..bf9e028eba28 100644
>> --- a/drivers/thermal/tegra/Makefile
>> +++ b/drivers/thermal/tegra/Makefile
>> @@ -2,3 +2,4 @@ obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra-soctherm.o
>> =20
>>  tegra-soctherm-y				:=3D soctherm.o soctherm-fuse.o
>>  tegra-soctherm-$(CONFIG_ARCH_TEGRA_124_SOC)	+=3D tegra124-soctherm.=
o
>> +tegra-soctherm-$(CONFIG_ARCH_TEGRA_210_SOC)	+=3D tegra210-soctherm.=
o
>> diff --git a/drivers/thermal/tegra/soctherm-fuse.c b/drivers/thermal=
/tegra/soctherm-fuse.c
>> index 931c299ab0e8..29963180c453 100644
>> --- a/drivers/thermal/tegra/soctherm-fuse.c
>> +++ b/drivers/thermal/tegra/soctherm-fuse.c
>> @@ -28,7 +28,18 @@
>>  #define FUSE_TSENSOR_COMMON			0x180
>> =20
>>  /*
>> + * Tegra210: Layout of bits in FUSE_TSENSOR_COMMON:
>> + *    3                   2                   1                   0
>> + *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+
>> + * |       BASE_FT       |      BASE_CP      | SHFT_FT | SHIFT_CP  =
|
>> + * +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+
>> + *
>>   * Tegra12x, etc:
>> + * In chips prior to Tegra210, this fuse was incorrectly sized as 2=
6 bits,
>> + * and didn't hold SHIFT_CP in [31:26]. Therefore these missing six=
 bits
>> + * were obtained via the FUSE_SPARE_REALIGNMENT_REG register [5:0].
>> + *
>>   * FUSE_TSENSOR_COMMON:
>>   *    3                   2                   1                   0
>>   *  1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegr=
a/soctherm.c
>> index f56e5a11384e..52a33760e8e8 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -147,6 +147,12 @@ static const struct of_device_id tegra_soctherm=
_of_match[] =3D {
>>  		.data =3D &tegra124_soctherm,
>>  	},
>>  #endif
>> +#ifdef CONFIG_ARCH_TEGRA_210_SOC
>> +	{
>> +		.compatible =3D "nvidia,tegra210-soctherm",
>> +		.data =3D &tegra210_soctherm,
>> +	},
>> +#endif
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(of, tegra_soctherm_of_match);
>> diff --git a/drivers/thermal/tegra/soctherm.h b/drivers/thermal/tegr=
a/soctherm.h
>> index f80ee1492ddb..69d317269af1 100644
>> --- a/drivers/thermal/tegra/soctherm.h
>> +++ b/drivers/thermal/tegra/soctherm.h
>> @@ -106,5 +106,9 @@ int tegra_calc_tsensor_calib(const struct tegra_=
tsensor *sensor,
>>  extern const struct tegra_soctherm_soc tegra124_soctherm;
>>  #endif
>> =20
>> +#ifdef CONFIG_ARCH_TEGRA_210_SOC
>> +extern const struct tegra_soctherm_soc tegra210_soctherm;
>> +#endif
>=20
> Is CONFIG_ARCH_TEGRA_210_SOC going to be tristate?
>=20
> If only bool, do you need to make the symbol extern?

This config is the bool, it already defined in:
drivers/soc/tegra/Kconfig

>=20
>> --=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
