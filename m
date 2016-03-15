From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V7 01/12] thermal: tegra: move tegra thermal files into
 tegra directory
Date: Tue, 15 Mar 2016 14:17:34 +0800
Message-ID: <56E7A8FE.7000706@nvidia.com>
References: <1457665763-29781-1-git-send-email-wni@nvidia.com> <1457665763-29781-2-git-send-email-wni@nvidia.com> <20160314183736.GA5378@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160314183736.GA5378-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mikko.perttunen-/1wQRMveznE@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 02:37, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 11, 2016 at 11:09:12AM +0800, Wei Ni wrote:
>> Move Tegra soctherm driver to tegra directory, it's easy to maintain
>> and add more new function support for Tegra platforms.
>> This will also help to split soctherm driver into common parts and
>> chip specific data related parts.
>>
>> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/thermal/Kconfig                                     | 12 ++=
----------
>>  drivers/thermal/Makefile                                    |  2 +-
>>  drivers/thermal/tegra/Kconfig                               | 13 ++=
+++++++++++
>>  drivers/thermal/tegra/Makefile                              |  1 +
>>  .../thermal/{tegra_soctherm.c =3D> tegra/tegra-soctherm.c}    |  0
>>  5 files changed, 17 insertions(+), 11 deletions(-)
>>  create mode 100644 drivers/thermal/tegra/Kconfig
>>  create mode 100644 drivers/thermal/tegra/Makefile
>>  rename drivers/thermal/{tegra_soctherm.c =3D> tegra/tegra-soctherm.=
c} (100%)
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index 8cc4ac64a91c..1802629f5051 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -254,16 +254,6 @@ config ARMADA_THERMAL
>>  	  Enable this option if you want to have support for thermal manag=
ement
>>  	  controller present in Armada 370 and Armada XP SoC.
>> =20
>> -config TEGRA_SOCTHERM
>> -	tristate "Tegra SOCTHERM thermal management"
>> -	depends on ARCH_TEGRA
>> -	help
>> -	  Enable this option for integrated thermal management support on =
NVIDIA
>> -	  Tegra124 systems-on-chip. The driver supports four thermal zones
>> -	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the therm=
al
>> -	  zones to manage temperatures. This option is also required for t=
he
>> -	  emergency thermal reset (thermtrip) feature to function.
>> -
>>  config DB8500_CPUFREQ_COOLING
>>  	tristate "DB8500 cpufreq cooling"
>>  	depends on ARCH_U8500
>> @@ -380,6 +370,8 @@ depends on ARCH_STI && OF
>>  source "drivers/thermal/st/Kconfig"
>>  endmenu
>> =20
>> +source "drivers/thermal/tegra/Kconfig"
>> +
>>  config QCOM_SPMI_TEMP_ALARM
>>  	tristate "Qualcomm SPMI PMIC Temperature Alarm"
>>  	depends on OF && SPMI && IIO
>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index cfae6a654793..119e25cdcc66 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -46,5 +46,5 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+=3D ti-soc-thermal/
>>  obj-$(CONFIG_INT340X_THERMAL)  +=3D int340x_thermal/
>>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+=3D intel_pch_thermal.o
>>  obj-$(CONFIG_ST_THERMAL)	+=3D st/
>> -obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra_soctherm.o
>> +obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra/
>>  obj-$(CONFIG_HISI_THERMAL)     +=3D hisi_thermal.o
>> diff --git a/drivers/thermal/tegra/Kconfig b/drivers/thermal/tegra/K=
config
>> new file mode 100644
>> index 000000000000..0b719d8b629b
>> --- /dev/null
>> +++ b/drivers/thermal/tegra/Kconfig
>> @@ -0,0 +1,13 @@
>> +menu "NVIDIA Tegra thermal drivers"
>> +
>> +config TEGRA_SOCTHERM
>> +	tristate "Tegra SOCTHERM thermal management"
>> +	depends on ARCH_TEGRA
>=20
> You probably want to move the depends part to the menu section, so th=
e
> menu wont appear where it shouldnt.

Yes, will fix it.

>=20
>> +	help
>> +	  Enable this option for integrated thermal management support on =
NVIDIA
>> +	  Tegra124 systems-on-chip. The driver supports four thermal zones
>> +	  (CPU, GPU, MEM, PLLX). Cooling devices can be bound to the therm=
al
>> +	  zones to manage temperatures. This option is also required for t=
he
>> +	  emergency thermal reset (thermtrip) feature to function.
>> +
>> +endmenu
>> diff --git a/drivers/thermal/tegra/Makefile b/drivers/thermal/tegra/=
Makefile
>> new file mode 100644
>> index 000000000000..d4dc4e7f279e
>> --- /dev/null
>> +++ b/drivers/thermal/tegra/Makefile
>> @@ -0,0 +1 @@
>> +obj-$(CONFIG_TEGRA_SOCTHERM)	+=3D tegra-soctherm.o
>> diff --git a/drivers/thermal/tegra_soctherm.c b/drivers/thermal/tegr=
a/tegra-soctherm.c
>> similarity index 100%
>> rename from drivers/thermal/tegra_soctherm.c
>> rename to drivers/thermal/tegra/tegra-soctherm.c
>> --=20
>> 1.9.1
>>
>=20
> * Unknown Key
> * 0x7DA4E256
>=20
