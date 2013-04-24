From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] ARM: S5pv210: compiling issue, ARM_S3C64XX_CPUFREQ need
 CONFIG_CPU_FREQ_TABLE=y
Date: Wed, 24 Apr 2013 19:02:12 +0800
Message-ID: <5177BBB4.4040600@asianux.com>
References: <5177B562.40400@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5177B562.40400@asianux.com>
Sender: cpufreq-owner@vger.kernel.org
To: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Oh, sorry, the subject and the comment is incorrect: it need use
ARM_S5PV210_CPUFREQ instead of ARM_S3C64XX_CPUFREQ.

I need send patch v2.


On 2013=E5=B9=B404=E6=9C=8824=E6=97=A5 18:35, Chen Gang wrote:
>=20
> For arm S5pv210 with allmodconfig, ARM_S3C64XX_CPUFREQ need=20
> CONFIG_CPU_FREQ_TABLE=3Dy, or will cause compiling issue.
>=20
> The related operation:
> + arm-linux-gnu-ld -EL -p --no-undefined -X --build-id -X -o .tmp_vml=
inux1 -T /root/linux-next/arch/arm/kernel/vmlinux.lds arch/arm/kernel/h=
ead.o init/built-in.o --start-group usr/built-in.o arch/arm/nwfpe/built=
-in.o arch/arm/vfp/built-in.o arch/arm/kernel/built-in.o arch/arm/mm/bu=
ilt-in.o arch/arm/common/built-in.o arch/arm/net/built-in.o arch/arm/cr=
ypto/built-in.o arch/arm/mach-s5pv210/built-in.o arch/arm/plat-samsung/=
built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o=
 security/built-in.o crypto/built-in.o block/built-in.o arch/arm/lib/li=
b.a lib/lib.a arch/arm/lib/built-in.o lib/built-in.o drivers/built-in.o=
 sound/built-in.o firmware/built-in.o net/built-in.o --end-group
>=20
> The related errors:
> drivers/built-in.o: In function `s5pv210_target':
> drivers/cpufreq/s5pv210-cpufreq.c:225: undefined reference to `cpufre=
q_frequency_table_target'
> drivers/cpufreq/s5pv210-cpufreq.c:237: undefined reference to `cpufre=
q_frequency_table_target'
> drivers/built-in.o: In function `s5pv210_verify_speed':
> drivers/cpufreq/s5pv210-cpufreq.c:182: undefined reference to `cpufre=
q_frequency_table_verify'
> drivers/built-in.o: In function `s5pv210_cpu_init':
> drivers/cpufreq/s5pv210-cpufreq.c:556: undefined reference to `cpufre=
q_frequency_table_get_attr'
> drivers/cpufreq/s5pv210-cpufreq.c:560: undefined reference to `cpufre=
q_frequency_table_cpuinfo'
> make: *** [vmlinux] Error 1
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  drivers/cpufreq/Kconfig.arm |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.ar=
m
> index bce2195..bbcd719 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -187,6 +187,7 @@ config ARM_S3C64XX_CPUFREQ
>  config ARM_S5PV210_CPUFREQ
>  	bool "Samsung S5PV210 and S5PC110"
>  	depends on CPU_S5PV210
> +	select CPU_FREQ_TABLE
>  	default y
>  	help
>  	  This adds the CPUFreq driver for Samsung S5PV210 and
>=20


--=20
Chen Gang

Asianux Corporation
