From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] ARM: S5pv210: compiling issue, ARM_S5PV210_CPUFREQ
 need CONFIG_CPU_FREQ_TABLE=y
Date: Thu, 25 Apr 2013 09:21:34 +0800
Message-ID: <5178851E.3090204@asianux.com>
References: <5177B562.40400@asianux.com> <5177BC50.6050402@asianux.com> <CAOh2x==g96h5UhvBjtyrBTjxdkno3WBv5JEsqyT3jqv7x69V6A@mail.gmail.com> <1486501.MMr8zrpiDO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1486501.MMr8zrpiDO@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2013=E5=B9=B404=E6=9C=8824=E6=97=A5 20:09, Rafael J. Wysocki wrote:
> On Wednesday, April 24, 2013 04:40:38 PM Viresh Kumar wrote:
>> > On Wed, Apr 24, 2013 at 4:34 PM, Chen Gang <gang.chen@asianux.com>=
 wrote:
>>> > >
>>> > > For arm S5pv210 with allmodconfig, ARM_S5PV210_CPUFREQ need
>>> > > CONFIG_CPU_FREQ_TABLE=3Dy, or will cause compiling issue.
>>> > >
>>> > > The related operation:
>>> > > + arm-linux-gnu-ld -EL -p --no-undefined -X --build-id -X -o .t=
mp_vmlinux1 -T /root/linux-next/arch/arm/kernel/vmlinux.lds arch/arm/ke=
rnel/head.o init/built-in.o --start-group usr/built-in.o arch/arm/nwfpe=
/built-in.o arch/arm/vfp/built-in.o arch/arm/kernel/built-in.o arch/arm=
/mm/built-in.o arch/arm/common/built-in.o arch/arm/net/built-in.o arch/=
arm/crypto/built-in.o arch/arm/mach-s5pv210/built-in.o arch/arm/plat-sa=
msung/built-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/buil=
t-in.o security/built-in.o crypto/built-in.o block/built-in.o arch/arm/=
lib/lib.a lib/lib.a arch/arm/lib/built-in.o lib/built-in.o drivers/buil=
t-in.o sound/built-in.o firmware/built-in.o net/built-in.o --end-group
>>> > >
>>> > > The related errors:
>>> > > drivers/built-in.o: In function `s5pv210_target':
>>> > > drivers/cpufreq/s5pv210-cpufreq.c:225: undefined reference to `=
cpufreq_frequency_table_target'
>>> > > drivers/cpufreq/s5pv210-cpufreq.c:237: undefined reference to `=
cpufreq_frequency_table_target'
>>> > > drivers/built-in.o: In function `s5pv210_verify_speed':
>>> > > drivers/cpufreq/s5pv210-cpufreq.c:182: undefined reference to `=
cpufreq_frequency_table_verify'
>>> > > drivers/built-in.o: In function `s5pv210_cpu_init':
>>> > > drivers/cpufreq/s5pv210-cpufreq.c:556: undefined reference to `=
cpufreq_frequency_table_get_attr'
>>> > > drivers/cpufreq/s5pv210-cpufreq.c:560: undefined reference to `=
cpufreq_frequency_table_cpuinfo'
>>> > > make: *** [vmlinux] Error 1
>>> > >
>>> > > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>>> > > ---
>>> > >  drivers/cpufreq/Kconfig.arm |    1 +
>>> > >  1 files changed, 1 insertions(+), 0 deletions(-)
>>> > >
>>> > > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kcon=
fig.arm
>>> > > index bce2195..bbcd719 100644
>>> > > --- a/drivers/cpufreq/Kconfig.arm
>>> > > +++ b/drivers/cpufreq/Kconfig.arm
>>> > > @@ -187,6 +187,7 @@ config ARM_S3C64XX_CPUFREQ
>>> > >  config ARM_S5PV210_CPUFREQ
>>> > >         bool "Samsung S5PV210 and S5PC110"
>>> > >         depends on CPU_S5PV210
>>> > > +       select CPU_FREQ_TABLE
>> >=20
>> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Applied.
>=20
> Thanks,
> Rafael

Thanks, too.


--=20
Chen Gang

Asianux Corporation
