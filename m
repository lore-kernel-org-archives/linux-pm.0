From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle: Invert CPUIDLE_FLAG_TIME_VALID logic
Date: Thu, 13 Nov 2014 16:14:33 +0100
Message-ID: <5464CAD9.1070905@linaro.org>
References: <1415804630-5055-1-git-send-email-daniel.lezcano@linaro.org> <20141113145609.GA9726@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141113145609.GA9726@red-moon>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "nsekhar@ti.com" <nsekhar@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "tony@atomide.com" <tony@atomide.com>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/13/2014 03:56 PM, Lorenzo Pieralisi wrote:
> On Wed, Nov 12, 2014 at 03:03:50PM +0000, Daniel Lezcano wrote:
>> The only place where the time is invalid is when the ACPI_CSTATE_FFH=
 entry
>> method is not set. Otherwise for all the drivers, the time can be co=
rrectly
>> measured.
>>
>> Instead of duplicating the CPUIDLE_FLAG_TIME_VALID flag in all the d=
rivers
>> for all the states, just invert the logic by replacing it by the fla=
g
>> CPUIDLE_FLAG_TIME_INVALID, hence we can set this flag only for the a=
cpi idle
>> driver, remove the former flag from all the drivers and invert the l=
ogic with
>> this flag in the different governor.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> Are we sure that ACPI C1 invalid residency time is *still* an issue a=
fter
> we moved the residency accounting to the idle core ?

Ah good point !

> I have a feeling you can remove this flag entirely, but I will let x8=
6
> guys speak for themselves.

If this flag can be removed, that will help to do a lot more cleanups.=20
That will be great.

> Other than that, it makes sense to me:
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks Lorenzo for the review.

   -- Daniel

>> ---
>>   arch/arm/include/asm/cpuidle.h         |   1 -
>>   arch/arm/mach-davinci/cpuidle.c        |   1 -
>>   arch/arm/mach-imx/cpuidle-imx5.c       |   1 -
>>   arch/arm/mach-imx/cpuidle-imx6q.c      |   3 +-
>>   arch/arm/mach-imx/cpuidle-imx6sl.c     |   3 +-
>>   arch/arm/mach-omap2/cpuidle34xx.c      |   7 ---
>>   arch/arm/mach-omap2/cpuidle44xx.c      |   5 +-
>>   arch/arm/mach-s3c64xx/cpuidle.c        |   1 -
>>   arch/arm/mach-shmobile/pm-sh7372.c     |   4 --
>>   arch/arm/mach-tegra/cpuidle-tegra114.c |   1 -
>>   arch/arm/mach-tegra/cpuidle-tegra20.c  |   3 +-
>>   arch/arm/mach-tegra/cpuidle-tegra30.c  |   1 -
>>   arch/mips/include/asm/idle.h           |   1 -
>>   arch/sh/kernel/cpu/shmobile/cpuidle.c  |   3 -
>>   arch/x86/kernel/apm_32.c               |   1 -
>>   drivers/acpi/processor_idle.c          |   6 +-
>>   drivers/cpuidle/cpuidle-arm64.c        |   1 -
>>   drivers/cpuidle/cpuidle-at91.c         |   1 -
>>   drivers/cpuidle/cpuidle-big_little.c   |   6 +-
>>   drivers/cpuidle/cpuidle-calxeda.c      |   1 -
>>   drivers/cpuidle/cpuidle-cps.c          |   7 +--
>>   drivers/cpuidle/cpuidle-exynos.c       |   1 -
>>   drivers/cpuidle/cpuidle-kirkwood.c     |   1 -
>>   drivers/cpuidle/cpuidle-mvebu-v7.c     |   8 +--
>>   drivers/cpuidle/cpuidle-powernv.c      |   6 +-
>>   drivers/cpuidle/cpuidle-pseries.c      |   3 -
>>   drivers/cpuidle/cpuidle-ux500.c        |   3 +-
>>   drivers/cpuidle/cpuidle-zynq.c         |   1 -
>>   drivers/cpuidle/driver.c               |   1 -
>>   drivers/cpuidle/dt_idle_states.c       |   2 +-
>>   drivers/cpuidle/governors/ladder.c     |   2 +-
>>   drivers/cpuidle/governors/menu.c       |   2 +-
>>   drivers/idle/intel_idle.c              | 108 ++++++++++++++++-----=
------------
>>   include/linux/cpuidle.h                |   4 +-
>>   34 files changed, 75 insertions(+), 125 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/c=
puidle.h
>> index 2fca60a..af319ac 100644
>> --- a/arch/arm/include/asm/cpuidle.h
>> +++ b/arch/arm/include/asm/cpuidle.h
>> @@ -15,7 +15,6 @@ static inline int arm_cpuidle_simple_enter(struct =
cpuidle_device *dev,
>>          .exit_latency           =3D 1,\
>>          .target_residency       =3D 1,\
>>          .power_usage            =3D p,\
>> -       .flags                  =3D CPUIDLE_FLAG_TIME_VALID,\
>>          .name                   =3D "WFI",\
>>          .desc                   =3D "ARM WFI",\
>>   }
>> diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci=
/cpuidle.c
>> index f1ac1c9..b4675fc 100644
>> --- a/arch/arm/mach-davinci/cpuidle.c
>> +++ b/arch/arm/mach-davinci/cpuidle.c
>> @@ -66,7 +66,6 @@ static struct cpuidle_driver davinci_idle_driver =3D=
 {
>>                  .enter                  =3D davinci_enter_idle,
>>                  .exit_latency           =3D 10,
>>                  .target_residency       =3D 10000,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "DDR SR",
>>                  .desc                   =3D "WFI and DDR Self Refre=
sh",
>>          },
>> diff --git a/arch/arm/mach-imx/cpuidle-imx5.c b/arch/arm/mach-imx/cp=
uidle-imx5.c
>> index 5a47e3c..3feca52 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx5.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx5.c
>> @@ -24,7 +24,6 @@ static struct cpuidle_driver imx5_cpuidle_driver =3D=
 {
>>                  .enter            =3D imx5_cpuidle_enter,
>>                  .exit_latency     =3D 2,
>>                  .target_residency =3D 1,
>> -               .flags            =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name             =3D "IMX5 SRPG",
>>                  .desc             =3D "CPU state retained,powered o=
ff",
>>          },
>> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/c=
puidle-imx6q.c
>> index aa93578..d76d086 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
>> @@ -53,8 +53,7 @@ static struct cpuidle_driver imx6q_cpuidle_driver =
=3D {
>>                  {
>>                          .exit_latency =3D 50,
>>                          .target_residency =3D 75,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID |
>> -                                CPUIDLE_FLAG_TIMER_STOP,
>> +                       .flags =3D CPUIDLE_FLAG_TIMER_STOP,
>>                          .enter =3D imx6q_enter_wait,
>>                          .name =3D "WAIT",
>>                          .desc =3D "Clock off",
>> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/=
cpuidle-imx6sl.c
>> index d4b6b81..7d92e65 100644
>> --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
>> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
>> @@ -40,8 +40,7 @@ static struct cpuidle_driver imx6sl_cpuidle_driver=
 =3D {
>>                  {
>>                          .exit_latency =3D 50,
>>                          .target_residency =3D 75,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID |
>> -                               CPUIDLE_FLAG_TIMER_STOP,
>> +                       .flags =3D CPUIDLE_FLAG_TIMER_STOP,
>>                          .enter =3D imx6sl_enter_wait,
>>                          .name =3D "WAIT",
>>                          .desc =3D "Clock off",
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index e18709d..aa7b379 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -265,7 +265,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 2 + 2,
>>                          .target_residency =3D 5,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C1",
>>                          .desc             =3D "MPU ON + CORE ON",
>>                  },
>> @@ -273,7 +272,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 10 + 10,
>>                          .target_residency =3D 30,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C2",
>>                          .desc             =3D "MPU ON + CORE ON",
>>                  },
>> @@ -281,7 +279,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 50 + 50,
>>                          .target_residency =3D 300,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C3",
>>                          .desc             =3D "MPU RET + CORE ON",
>>                  },
>> @@ -289,7 +286,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 1500 + 1800,
>>                          .target_residency =3D 4000,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C4",
>>                          .desc             =3D "MPU OFF + CORE ON",
>>                  },
>> @@ -297,7 +293,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 2500 + 7500,
>>                          .target_residency =3D 12000,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C5",
>>                          .desc             =3D "MPU RET + CORE RET",
>>                  },
>> @@ -305,7 +300,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 3000 + 8500,
>>                          .target_residency =3D 15000,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C6",
>>                          .desc             =3D "MPU OFF + CORE RET",
>>                  },
>> @@ -313,7 +307,6 @@ static struct cpuidle_driver omap3_idle_driver =3D=
 {
>>                          .enter            =3D omap3_enter_idle_bm,
>>                          .exit_latency     =3D 10000 + 30000,
>>                          .target_residency =3D 30000,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "C7",
>>                          .desc             =3D "MPU OFF + CORE OFF",
>>                  },
>> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2=
/cpuidle44xx.c
>> index 2498ab0..01e398a 100644
>> --- a/arch/arm/mach-omap2/cpuidle44xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
>> @@ -196,7 +196,6 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>>                          /* C1 - CPU0 ON + CPU1 ON + MPU ON */
>>                          .exit_latency =3D 2 + 2,
>>                          .target_residency =3D 5,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .enter =3D omap_enter_idle_simple,
>>                          .name =3D "C1",
>>                          .desc =3D "CPUx ON, MPUSS ON"
>> @@ -205,7 +204,7 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>>                          /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
>>                          .exit_latency =3D 328 + 440,
>>                          .target_residency =3D 960,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE=
_FLAG_COUPLED,
>> +                       .flags =3D CPUIDLE_FLAG_COUPLED,
>>                          .enter =3D omap_enter_idle_coupled,
>>                          .name =3D "C2",
>>                          .desc =3D "CPUx OFF, MPUSS CSWR",
>> @@ -214,7 +213,7 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>>                          /* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>>                          .exit_latency =3D 460 + 518,
>>                          .target_residency =3D 1100,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE=
_FLAG_COUPLED,
>> +                       .flags =3D CPUIDLE_FLAG_COUPLED,
>>                          .enter =3D omap_enter_idle_coupled,
>>                          .name =3D "C3",
>>                          .desc =3D "CPUx OFF, MPUSS OSWR",
>> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx=
/cpuidle.c
>> index 3c8ab07..2eb0724 100644
>> --- a/arch/arm/mach-s3c64xx/cpuidle.c
>> +++ b/arch/arm/mach-s3c64xx/cpuidle.c
>> @@ -48,7 +48,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_drive=
r =3D {
>>                          .enter            =3D s3c64xx_enter_idle,
>>                          .exit_latency     =3D 1,
>>                          .target_residency =3D 1,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D,
>>                          .name             =3D "IDLE",
>>                          .desc             =3D "System active, ARM g=
ated",
>>                  },
>> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmo=
bile/pm-sh7372.c
>> index 7e5c267..0e37da6 100644
>> --- a/arch/arm/mach-shmobile/pm-sh7372.c
>> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
>> @@ -423,7 +423,6 @@ static struct cpuidle_driver sh7372_cpuidle_driv=
er =3D {
>>                  .desc =3D "Core Standby Mode",
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20 + 10,
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .enter =3D sh7372_enter_core_standby,
>>          },
>>          .states[2] =3D {
>> @@ -431,7 +430,6 @@ static struct cpuidle_driver sh7372_cpuidle_driv=
er =3D {
>>                  .desc =3D "A3SM PLL ON",
>>                  .exit_latency =3D 20,
>>                  .target_residency =3D 30 + 20,
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .enter =3D sh7372_enter_a3sm_pll_on,
>>          },
>>          .states[3] =3D {
>> @@ -439,7 +437,6 @@ static struct cpuidle_driver sh7372_cpuidle_driv=
er =3D {
>>                  .desc =3D "A3SM PLL OFF",
>>                  .exit_latency =3D 120,
>>                  .target_residency =3D 30 + 120,
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .enter =3D sh7372_enter_a3sm_pll_off,
>>          },
>>          .states[4] =3D {
>> @@ -447,7 +444,6 @@ static struct cpuidle_driver sh7372_cpuidle_driv=
er =3D {
>>                  .desc =3D "A4S PLL OFF",
>>                  .exit_latency =3D 240,
>>                  .target_residency =3D 30 + 240,
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .enter =3D sh7372_enter_a4s,
>>                  .disabled =3D true,
>>          },
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-=
tegra/cpuidle-tegra114.c
>> index e3ebdce..b309082 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra114.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
>> @@ -75,7 +75,6 @@ static struct cpuidle_driver tegra_idle_driver =3D=
 {
>>                          .exit_latency           =3D 500,
>>                          .target_residency       =3D 1000,
>>                          .power_usage            =3D 0,
>> -                       .flags                  =3D CPUIDLE_FLAG_TIM=
E_VALID,
>>                          .name                   =3D "powered-down",
>>                          .desc                   =3D "CPU power gate=
d",
>>                  },
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-t=
egra/cpuidle-tegra20.c
>> index b30bf5c..4f25a7c 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
>> @@ -59,8 +59,7 @@ static struct cpuidle_driver tegra_idle_driver =3D=
 {
>>                          .exit_latency     =3D 5000,
>>                          .target_residency =3D 10000,
>>                          .power_usage      =3D 0,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D |
>> -                       CPUIDLE_FLAG_COUPLED,
>> +                       .flags            =3D CPUIDLE_FLAG_COUPLED,
>>                          .name             =3D "powered-down",
>>                          .desc             =3D "CPU power gated",
>>                  },
>> diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-t=
egra/cpuidle-tegra30.c
>> index 3556127..f8815ed 100644
>> --- a/arch/arm/mach-tegra/cpuidle-tegra30.c
>> +++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
>> @@ -56,7 +56,6 @@ static struct cpuidle_driver tegra_idle_driver =3D=
 {
>>                          .exit_latency           =3D 2000,
>>                          .target_residency       =3D 2200,
>>                          .power_usage            =3D 0,
>> -                       .flags                  =3D CPUIDLE_FLAG_TIM=
E_VALID,
>>                          .name                   =3D "powered-down",
>>                          .desc                   =3D "CPU power gate=
d",
>>                  },
>> diff --git a/arch/mips/include/asm/idle.h b/arch/mips/include/asm/id=
le.h
>> index 1c967ab..a2d18ab 100644
>> --- a/arch/mips/include/asm/idle.h
>> +++ b/arch/mips/include/asm/idle.h
>> @@ -22,7 +22,6 @@ extern int mips_cpuidle_wait_enter(struct cpuidle_=
device *dev,
>>          .exit_latency           =3D 1,\
>>          .target_residency       =3D 1,\
>>          .power_usage            =3D UINT_MAX,\
>> -       .flags                  =3D CPUIDLE_FLAG_TIME_VALID,\
>>          .name                   =3D "wait",\
>>          .desc                   =3D "MIPS wait",\
>>   }
>> diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/=
cpu/shmobile/cpuidle.c
>> index e3abfd4..53b8eeb 100644
>> --- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
>> +++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
>> @@ -59,7 +59,6 @@ static struct cpuidle_driver cpuidle_driver =3D {
>>                          .exit_latency =3D 1,
>>                          .target_residency =3D 1 * 2,
>>                          .power_usage =3D 3,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .enter =3D cpuidle_sleep_enter,
>>                          .name =3D "C1",
>>                          .desc =3D "SuperH Sleep Mode",
>> @@ -68,7 +67,6 @@ static struct cpuidle_driver cpuidle_driver =3D {
>>                          .exit_latency =3D 100,
>>                          .target_residency =3D 1 * 2,
>>                          .power_usage =3D 1,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .enter =3D cpuidle_sleep_enter,
>>                          .name =3D "C2",
>>                          .desc =3D "SuperH Sleep Mode [SF]",
>> @@ -78,7 +76,6 @@ static struct cpuidle_driver cpuidle_driver =3D {
>>                          .exit_latency =3D 2300,
>>                          .target_residency =3D 1 * 2,
>>                          .power_usage =3D 1,
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .enter =3D cpuidle_sleep_enter,
>>                          .name =3D "C3",
>>                          .desc =3D "SuperH Mobile Standby Mode [SF]"=
,
>> diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
>> index 5848744..927ec92 100644
>> --- a/arch/x86/kernel/apm_32.c
>> +++ b/arch/x86/kernel/apm_32.c
>> @@ -378,7 +378,6 @@ static struct cpuidle_driver apm_idle_driver =3D=
 {
>>                  { /* entry 1 is for APM idle */
>>                          .name =3D "APM",
>>                          .desc =3D "APM idle",
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .exit_latency =3D 250,    /* WAG */
>>                          .target_residency =3D 500,        /* WAG */
>>                          .enter =3D &apm_cpu_idle
>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_=
idle.c
>> index 17f9ec5..380b4b4 100644
>> --- a/drivers/acpi/processor_idle.c
>> +++ b/drivers/acpi/processor_idle.c
>> @@ -985,8 +985,8 @@ static int acpi_processor_setup_cpuidle_states(s=
truct acpi_processor *pr)
>>                  state->flags =3D 0;
>>                  switch (cx->type) {
>>                          case ACPI_STATE_C1:
>> -                       if (cx->entry_method =3D=3D ACPI_CSTATE_FFH)
>> -                               state->flags |=3D CPUIDLE_FLAG_TIME_=
VALID;
>> +                       if (cx->entry_method !=3D ACPI_CSTATE_FFH)
>> +                               state->flags |=3D CPUIDLE_FLAG_TIME_=
INVALID;
>>
>>                          state->enter =3D acpi_idle_enter_c1;
>>                          state->enter_dead =3D acpi_idle_play_dead;
>> @@ -994,14 +994,12 @@ static int acpi_processor_setup_cpuidle_states=
(struct acpi_processor *pr)
>>                          break;
>>
>>                          case ACPI_STATE_C2:
>> -                       state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
>>                          state->enter =3D acpi_idle_enter_simple;
>>                          state->enter_dead =3D acpi_idle_play_dead;
>>                          drv->safe_state_index =3D count;
>>                          break;
>>
>>                          case ACPI_STATE_C3:
>> -                       state->flags |=3D CPUIDLE_FLAG_TIME_VALID;
>>                          state->enter =3D pr->flags.bm_check ?
>>                                          acpi_idle_enter_bm :
>>                                          acpi_idle_enter_simple;
>> diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuid=
le-arm64.c
>> index 50997ea..87320e6 100644
>> --- a/drivers/cpuidle/cpuidle-arm64.c
>> +++ b/drivers/cpuidle/cpuidle-arm64.c
>> @@ -73,7 +73,6 @@ static struct cpuidle_driver arm64_idle_driver =3D=
 {
>>                  .exit_latency           =3D 1,
>>                  .target_residency       =3D 1,
>>                  .power_usage            =3D UINT_MAX,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "WFI",
>>                  .desc                   =3D "ARM64 WFI",
>>          }
>> diff --git a/drivers/cpuidle/cpuidle-at91.c b/drivers/cpuidle/cpuidl=
e-at91.c
>> index a077437..1964ff0 100644
>> --- a/drivers/cpuidle/cpuidle-at91.c
>> +++ b/drivers/cpuidle/cpuidle-at91.c
>> @@ -43,7 +43,6 @@ static struct cpuidle_driver at91_idle_driver =3D =
{
>>                  .enter                  =3D at91_enter_idle,
>>                  .exit_latency           =3D 10,
>>                  .target_residency       =3D 10000,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "RAM_SR",
>>                  .desc                   =3D "WFI and DDR Self Refre=
sh",
>>          },
>> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/=
cpuidle-big_little.c
>> index fbc00a1..e3e225f 100644
>> --- a/drivers/cpuidle/cpuidle-big_little.c
>> +++ b/drivers/cpuidle/cpuidle-big_little.c
>> @@ -67,8 +67,7 @@ static struct cpuidle_driver bl_idle_little_driver=
 =3D {
>>                  .enter                  =3D bl_enter_powerdown,
>>                  .exit_latency           =3D 700,
>>                  .target_residency       =3D 2500,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID =
|
>> -                                         CPUIDLE_FLAG_TIMER_STOP,
>> +               .flags                  =3D CPUIDLE_FLAG_TIMER_STOP,
>>                  .name                   =3D "C1",
>>                  .desc                   =3D "ARM little-cluster pow=
er down",
>>          },
>> @@ -89,8 +88,7 @@ static struct cpuidle_driver bl_idle_big_driver =3D=
 {
>>                  .enter                  =3D bl_enter_powerdown,
>>                  .exit_latency           =3D 500,
>>                  .target_residency       =3D 2000,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID =
|
>> -                                         CPUIDLE_FLAG_TIMER_STOP,
>> +               .flags                  =3D CPUIDLE_FLAG_TIMER_STOP,
>>                  .name                   =3D "C1",
>>                  .desc                   =3D "ARM big-cluster power =
down",
>>          },
>> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpu=
idle-calxeda.c
>> index 6e51114..6541b0b 100644
>> --- a/drivers/cpuidle/cpuidle-calxeda.c
>> +++ b/drivers/cpuidle/cpuidle-calxeda.c
>> @@ -55,7 +55,6 @@ static struct cpuidle_driver calxeda_idle_driver =3D=
 {
>>                  {
>>                          .name =3D "PG",
>>                          .desc =3D "Power Gate",
>> -                       .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .exit_latency =3D 30,
>>                          .power_usage =3D 50,
>>                          .target_residency =3D 200,
>> diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle=
-cps.c
>> index fc7b627..1adb698 100644
>> --- a/drivers/cpuidle/cpuidle-cps.c
>> +++ b/drivers/cpuidle/cpuidle-cps.c
>> @@ -79,7 +79,6 @@ static struct cpuidle_driver cps_driver =3D {
>>                          .enter  =3D cps_nc_enter,
>>                          .exit_latency           =3D 200,
>>                          .target_residency       =3D 450,
>> -                       .flags  =3D CPUIDLE_FLAG_TIME_VALID,
>>                          .name   =3D "nc-wait",
>>                          .desc   =3D "non-coherent MIPS wait",
>>                  },
>> @@ -87,8 +86,7 @@ static struct cpuidle_driver cps_driver =3D {
>>                          .enter  =3D cps_nc_enter,
>>                          .exit_latency           =3D 300,
>>                          .target_residency       =3D 700,
>> -                       .flags  =3D CPUIDLE_FLAG_TIME_VALID |
>> -                                 CPUIDLE_FLAG_TIMER_STOP,
>> +                       .flags  =3D CPUIDLE_FLAG_TIMER_STOP,
>>                          .name   =3D "clock-gated",
>>                          .desc   =3D "core clock gated",
>>                  },
>> @@ -96,8 +94,7 @@ static struct cpuidle_driver cps_driver =3D {
>>                          .enter  =3D cps_nc_enter,
>>                          .exit_latency           =3D 600,
>>                          .target_residency       =3D 1000,
>> -                       .flags  =3D CPUIDLE_FLAG_TIME_VALID |
>> -                                 CPUIDLE_FLAG_TIMER_STOP,
>> +                       .flags  =3D CPUIDLE_FLAG_TIMER_STOP,
>>                          .name   =3D "power-gated",
>>                          .desc   =3D "core power gated",
>>                  },
>> diff --git a/drivers/cpuidle/cpuidle-exynos.c b/drivers/cpuidle/cpui=
dle-exynos.c
>> index ba9b34b..64d12a8 100644
>> --- a/drivers/cpuidle/cpuidle-exynos.c
>> +++ b/drivers/cpuidle/cpuidle-exynos.c
>> @@ -47,7 +47,6 @@ static struct cpuidle_driver exynos_idle_driver =3D=
 {
>>                          .enter                  =3D exynos_enter_lo=
wpower,
>>                          .exit_latency           =3D 300,
>>                          .target_residency       =3D 100000,
>> -                       .flags                  =3D CPUIDLE_FLAG_TIM=
E_VALID,
>>                          .name                   =3D "C1",
>>                          .desc                   =3D "ARM power down=
",
>>                  },
>> diff --git a/drivers/cpuidle/cpuidle-kirkwood.c b/drivers/cpuidle/cp=
uidle-kirkwood.c
>> index 41ba843..d88f8d7 100644
>> --- a/drivers/cpuidle/cpuidle-kirkwood.c
>> +++ b/drivers/cpuidle/cpuidle-kirkwood.c
>> @@ -47,7 +47,6 @@ static struct cpuidle_driver kirkwood_idle_driver =
=3D {
>>                  .enter                  =3D kirkwood_enter_idle,
>>                  .exit_latency           =3D 10,
>>                  .target_residency       =3D 100000,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "DDR SR",
>>                  .desc                   =3D "WFI and DDR Self Refre=
sh",
>>          },
>> diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cp=
uidle-mvebu-v7.c
>> index 45371bb..dd4c176 100644
>> --- a/drivers/cpuidle/cpuidle-mvebu-v7.c
>> +++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
>> @@ -53,7 +53,6 @@ static struct cpuidle_driver armadaxp_idle_driver =
=3D {
>>                  .exit_latency           =3D 10,
>>                  .power_usage            =3D 50,
>>                  .target_residency       =3D 100,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "MV CPU IDLE",
>>                  .desc                   =3D "CPU power down",
>>          },
>> @@ -62,8 +61,7 @@ static struct cpuidle_driver armadaxp_idle_driver =
=3D {
>>                  .exit_latency           =3D 100,
>>                  .power_usage            =3D 5,
>>                  .target_residency       =3D 1000,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID =
|
>> -                                               MVEBU_V7_FLAG_DEEP_I=
DLE,
>> +               .flags                  =3D MVEBU_V7_FLAG_DEEP_IDLE,
>>                  .name                   =3D "MV CPU DEEP IDLE",
>>                  .desc                   =3D "CPU and L2 Fabric powe=
r down",
>>          },
>> @@ -78,8 +76,7 @@ static struct cpuidle_driver armada370_idle_driver=
 =3D {
>>                  .exit_latency           =3D 100,
>>                  .power_usage            =3D 5,
>>                  .target_residency       =3D 1000,
>> -               .flags                  =3D (CPUIDLE_FLAG_TIME_VALID=
 |
>> -                                          MVEBU_V7_FLAG_DEEP_IDLE),
>> +               .flags                  =3D MVEBU_V7_FLAG_DEEP_IDLE,
>>                  .name                   =3D "Deep Idle",
>>                  .desc                   =3D "CPU and L2 Fabric powe=
r down",
>>          },
>> @@ -94,7 +91,6 @@ static struct cpuidle_driver armada38x_idle_driver=
 =3D {
>>                  .exit_latency           =3D 10,
>>                  .power_usage            =3D 5,
>>                  .target_residency       =3D 100,
>> -               .flags                  =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .name                   =3D "Idle",
>>                  .desc                   =3D "CPU and SCU power down=
",
>>          },
>> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpu=
idle-powernv.c
>> index 7d3a349..e9248bb 100644
>> --- a/drivers/cpuidle/cpuidle-powernv.c
>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>> @@ -93,7 +93,6 @@ static struct cpuidle_state powernv_states[MAX_POW=
ERNV_IDLE_STATES] =3D {
>>          { /* Snooze */
>>                  .name =3D "snooze",
>>                  .desc =3D "snooze",
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .exit_latency =3D 0,
>>                  .target_residency =3D 0,
>>                  .enter =3D &snooze_loop },
>> @@ -202,7 +201,7 @@ static int powernv_add_idle_states(void)
>>                          /* Add NAP state */
>>                          strcpy(powernv_states[nr_idle_states].name,=
 "Nap");
>>                          strcpy(powernv_states[nr_idle_states].desc,=
 "Nap");
>> -                       powernv_states[nr_idle_states].flags =3D CPU=
IDLE_FLAG_TIME_VALID;
>> +                       powernv_states[nr_idle_states].flags =3D 0;
>>                          powernv_states[nr_idle_states].exit_latency=
 =3D
>>                                          ((unsigned int)latency_ns) =
/ 1000;
>>                          powernv_states[nr_idle_states].target_resid=
ency =3D
>> @@ -215,8 +214,7 @@ static int powernv_add_idle_states(void)
>>                          /* Add FASTSLEEP state */
>>                          strcpy(powernv_states[nr_idle_states].name,=
 "FastSleep");
>>                          strcpy(powernv_states[nr_idle_states].desc,=
 "FastSleep");
>> -                       powernv_states[nr_idle_states].flags =3D
>> -                               CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FL=
AG_TIMER_STOP;
>> +                       powernv_states[nr_idle_states].flags =3D CPU=
IDLE_FLAG_TIMER_STOP;
>>                          powernv_states[nr_idle_states].exit_latency=
 =3D
>>                                          ((unsigned int)latency_ns) =
/ 1000;
>>                          powernv_states[nr_idle_states].target_resid=
ency =3D
>> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpu=
idle-pseries.c
>> index 6f7b019..bb9e2b6 100644
>> --- a/drivers/cpuidle/cpuidle-pseries.c
>> +++ b/drivers/cpuidle/cpuidle-pseries.c
>> @@ -142,14 +142,12 @@ static struct cpuidle_state dedicated_states[]=
 =3D {
>>          { /* Snooze */
>>                  .name =3D "snooze",
>>                  .desc =3D "snooze",
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .exit_latency =3D 0,
>>                  .target_residency =3D 0,
>>                  .enter =3D &snooze_loop },
>>          { /* CEDE */
>>                  .name =3D "CEDE",
>>                  .desc =3D "CEDE",
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 100,
>>                  .enter =3D &dedicated_cede_loop },
>> @@ -162,7 +160,6 @@ static struct cpuidle_state shared_states[] =3D =
{
>>          { /* Shared Cede */
>>                  .name =3D "Shared Cede",
>>                  .desc =3D "Shared Cede",
>> -               .flags =3D CPUIDLE_FLAG_TIME_VALID,
>>                  .exit_latency =3D 0,
>>                  .target_residency =3D 0,
>>                  .enter =3D &shared_cede_loop },
>> diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuid=
le-ux500.c
>> index 5e35804..292e65a 100644
>> --- a/drivers/cpuidle/cpuidle-ux500.c
>> +++ b/drivers/cpuidle/cpuidle-ux500.c
>> @@ -101,8 +101,7 @@ static struct cpuidle_driver ux500_idle_driver =3D=
 {
>>                          .enter            =3D ux500_enter_idle,
>>                          .exit_latency     =3D 70,
>>                          .target_residency =3D 260,
>> -                       .flags            =3D CPUIDLE_FLAG_TIME_VALI=
D |
>> -                                           CPUIDLE_FLAG_TIMER_STOP,
>> +                       .flags            =3D CPUIDLE_FLAG_TIMER_STO=
P,
>>                          .name             =3D "ApIdle",
>>                          .desc             =3D "ARM Retention",
>>                  },
>> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuidl=
e-zynq.c
>> index c61b8b2..022dec8 100644
>> --- a/drivers/cpuidle/cpuidle-zynq.c
>> +++ b/drivers/cpuidle/cpuidle-zynq.c
>> @@ -52,7 +52,6 @@ static struct cpuidle_driver zynq_idle_driver =3D =
{
>>                          .enter                  =3D zynq_enter_idle=
,
>>                          .exit_latency           =3D 10,
>>                          .target_residency       =3D 10000,
>> -                       .flags                  =3D CPUIDLE_FLAG_TIM=
E_VALID,
>>                          .name                   =3D "RAM_SR",
>>                          .desc                   =3D "WFI and RAM Se=
lf Refresh",
>>                  },
>> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
>> index e431d11..2697e87 100644
>> --- a/drivers/cpuidle/driver.c
>> +++ b/drivers/cpuidle/driver.c
>> @@ -201,7 +201,6 @@ static void poll_idle_init(struct cpuidle_driver=
 *drv)
>>          state->exit_latency =3D 0;
>>          state->target_residency =3D 0;
>>          state->power_usage =3D -1;
>> -       state->flags =3D CPUIDLE_FLAG_TIME_VALID;
>>          state->enter =3D poll_idle;
>>          state->disabled =3D false;
>>   }
>> diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_i=
dle_states.c
>> index 52f4d11..6e6f0b2 100644
>> --- a/drivers/cpuidle/dt_idle_states.c
>> +++ b/drivers/cpuidle/dt_idle_states.c
>> @@ -73,7 +73,7 @@ static int init_state_node(struct cpuidle_state *i=
dle_state,
>>                  return -EINVAL;
>>          }
>>
>> -       idle_state->flags =3D CPUIDLE_FLAG_TIME_VALID;
>> +       idle_state->flags =3D 0;
>>          if (of_property_read_bool(state_node, "local-timer-stop"))
>>                  idle_state->flags |=3D CPUIDLE_FLAG_TIMER_STOP;
>>          /*
>> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/go=
vernors/ladder.c
>> index 06b57c4..37263d9 100644
>> --- a/drivers/cpuidle/governors/ladder.c
>> +++ b/drivers/cpuidle/governors/ladder.c
>> @@ -79,7 +79,7 @@ static int ladder_select_state(struct cpuidle_driv=
er *drv,
>>
>>          last_state =3D &ldev->states[last_idx];
>>
>> -       if (drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_VALID) {
>> +       if (!(drv->states[last_idx].flags & CPUIDLE_FLAG_TIME_INVALI=
D)) {
>>                  last_residency =3D cpuidle_get_last_residency(dev) =
- \
>>                                           drv->states[last_idx].exit=
_latency;
>>          }
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gove=
rnors/menu.c
>> index 710a233..659d7b0 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -405,7 +405,7 @@ static void menu_update(struct cpuidle_driver *d=
rv, struct cpuidle_device *dev)
>>           * the measured amount of time is less than the exit latenc=
y,
>>           * assume the state was never reached and the exit latency =
is 0.
>>           */
>> -       if (unlikely(!(target->flags & CPUIDLE_FLAG_TIME_VALID))) {
>> +       if (unlikely(target->flags & CPUIDLE_FLAG_TIME_INVALID)) {
>>                  /* Use timer value as is */
>>                  measured_us =3D data->next_timer_us;
>>
>> diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
>> index 9b7ee7e..9cceacb 100644
>> --- a/drivers/idle/intel_idle.c
>> +++ b/drivers/idle/intel_idle.c
>> @@ -128,28 +128,28 @@ static struct cpuidle_state nehalem_cstates[] =
=3D {
>>          {
>>                  .name =3D "C1-NHM",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 3,
>>                  .target_residency =3D 6,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-NHM",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-NHM",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 20,
>>                  .target_residency =3D 80,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-NHM",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 200,
>>                  .target_residency =3D 800,
>>                  .enter =3D &intel_idle },
>> @@ -161,35 +161,35 @@ static struct cpuidle_state snb_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-SNB",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 2,
>>                  .target_residency =3D 2,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-SNB",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-SNB",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 80,
>>                  .target_residency =3D 211,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-SNB",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 104,
>>                  .target_residency =3D 345,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7-SNB",
>>                  .desc =3D "MWAIT 0x30",
>> -               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 109,
>>                  .target_residency =3D 345,
>>                  .enter =3D &intel_idle },
>> @@ -201,42 +201,42 @@ static struct cpuidle_state byt_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-BYT",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 1,
>>                  .target_residency =3D 1,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-BYT",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 15,
>>                  .target_residency =3D 30,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6N-BYT",
>>                  .desc =3D "MWAIT 0x58",
>> -               .flags =3D MWAIT2flg(0x58) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x58) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 40,
>>                  .target_residency =3D 275,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6S-BYT",
>>                  .desc =3D "MWAIT 0x52",
>> -               .flags =3D MWAIT2flg(0x52) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 140,
>>                  .target_residency =3D 560,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7-BYT",
>>                  .desc =3D "MWAIT 0x60",
>> -               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 1200,
>>                  .target_residency =3D 1500,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7S-BYT",
>>                  .desc =3D "MWAIT 0x64",
>> -               .flags =3D MWAIT2flg(0x64) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x64) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 10000,
>>                  .target_residency =3D 20000,
>>                  .enter =3D &intel_idle },
>> @@ -248,35 +248,35 @@ static struct cpuidle_state ivb_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-IVB",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 1,
>>                  .target_residency =3D 1,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-IVB",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-IVB",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 59,
>>                  .target_residency =3D 156,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-IVB",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 80,
>>                  .target_residency =3D 300,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7-IVB",
>>                  .desc =3D "MWAIT 0x30",
>> -               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 87,
>>                  .target_residency =3D 300,
>>                  .enter =3D &intel_idle },
>> @@ -288,28 +288,28 @@ static struct cpuidle_state ivt_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-IVT",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 1,
>>                  .target_residency =3D 1,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-IVT",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 80,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-IVT",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 59,
>>                  .target_residency =3D 156,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-IVT",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 82,
>>                  .target_residency =3D 300,
>>                  .enter =3D &intel_idle },
>> @@ -321,28 +321,28 @@ static struct cpuidle_state ivt_cstates_4s[] =3D=
 {
>>          {
>>                  .name =3D "C1-IVT-4S",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 1,
>>                  .target_residency =3D 1,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-IVT-4S",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 250,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-IVT-4S",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 59,
>>                  .target_residency =3D 300,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-IVT-4S",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 84,
>>                  .target_residency =3D 400,
>>                  .enter =3D &intel_idle },
>> @@ -354,28 +354,28 @@ static struct cpuidle_state ivt_cstates_8s[] =3D=
 {
>>          {
>>                  .name =3D "C1-IVT-8S",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 1,
>>                  .target_residency =3D 1,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-IVT-8S",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 500,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-IVT-8S",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 59,
>>                  .target_residency =3D 600,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-IVT-8S",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 88,
>>                  .target_residency =3D 700,
>>                  .enter =3D &intel_idle },
>> @@ -387,56 +387,56 @@ static struct cpuidle_state hsw_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-HSW",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 2,
>>                  .target_residency =3D 2,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-HSW",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-HSW",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 33,
>>                  .target_residency =3D 100,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-HSW",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 133,
>>                  .target_residency =3D 400,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7s-HSW",
>>                  .desc =3D "MWAIT 0x32",
>> -               .flags =3D MWAIT2flg(0x32) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 166,
>>                  .target_residency =3D 500,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C8-HSW",
>>                  .desc =3D "MWAIT 0x40",
>> -               .flags =3D MWAIT2flg(0x40) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 300,
>>                  .target_residency =3D 900,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C9-HSW",
>>                  .desc =3D "MWAIT 0x50",
>> -               .flags =3D MWAIT2flg(0x50) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 600,
>>                  .target_residency =3D 1800,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C10-HSW",
>>                  .desc =3D "MWAIT 0x60",
>> -               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 2600,
>>                  .target_residency =3D 7700,
>>                  .enter =3D &intel_idle },
>> @@ -447,56 +447,56 @@ static struct cpuidle_state bdw_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-BDW",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 2,
>>                  .target_residency =3D 2,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C1E-BDW",
>>                  .desc =3D "MWAIT 0x01",
>> -               .flags =3D MWAIT2flg(0x01) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x01),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C3-BDW",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 40,
>>                  .target_residency =3D 100,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-BDW",
>>                  .desc =3D "MWAIT 0x20",
>> -               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x20) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 133,
>>                  .target_residency =3D 400,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C7s-BDW",
>>                  .desc =3D "MWAIT 0x32",
>> -               .flags =3D MWAIT2flg(0x32) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x32) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 166,
>>                  .target_residency =3D 500,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C8-BDW",
>>                  .desc =3D "MWAIT 0x40",
>> -               .flags =3D MWAIT2flg(0x40) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x40) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 300,
>>                  .target_residency =3D 900,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C9-BDW",
>>                  .desc =3D "MWAIT 0x50",
>> -               .flags =3D MWAIT2flg(0x50) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x50) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 600,
>>                  .target_residency =3D 1800,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C10-BDW",
>>                  .desc =3D "MWAIT 0x60",
>> -               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x60) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 2600,
>>                  .target_residency =3D 7700,
>>                  .enter =3D &intel_idle },
>> @@ -508,28 +508,28 @@ static struct cpuidle_state atom_cstates[] =3D=
 {
>>          {
>>                  .name =3D "C1E-ATM",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 10,
>>                  .target_residency =3D 20,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C2-ATM",
>>                  .desc =3D "MWAIT 0x10",
>> -               .flags =3D MWAIT2flg(0x10) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x10),
>>                  .exit_latency =3D 20,
>>                  .target_residency =3D 80,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C4-ATM",
>>                  .desc =3D "MWAIT 0x30",
>> -               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x30) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 100,
>>                  .target_residency =3D 400,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-ATM",
>>                  .desc =3D "MWAIT 0x52",
>> -               .flags =3D MWAIT2flg(0x52) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x52) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 140,
>>                  .target_residency =3D 560,
>>                  .enter =3D &intel_idle },
>> @@ -540,14 +540,14 @@ static struct cpuidle_state avn_cstates[] =3D =
{
>>          {
>>                  .name =3D "C1-AVN",
>>                  .desc =3D "MWAIT 0x00",
>> -               .flags =3D MWAIT2flg(0x00) | CPUIDLE_FLAG_TIME_VALID=
,
>> +               .flags =3D MWAIT2flg(0x00),
>>                  .exit_latency =3D 2,
>>                  .target_residency =3D 2,
>>                  .enter =3D &intel_idle },
>>          {
>>                  .name =3D "C6-AVN",
>>                  .desc =3D "MWAIT 0x51",
>> -               .flags =3D MWAIT2flg(0x51) | CPUIDLE_FLAG_TIME_VALID=
 | CPUIDLE_FLAG_TLB_FLUSHED,
>> +               .flags =3D MWAIT2flg(0x51) | CPUIDLE_FLAG_TLB_FLUSHE=
D,
>>                  .exit_latency =3D 15,
>>                  .target_residency =3D 45,
>>                  .enter =3D &intel_idle },
>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>> index 25e0df6..a07e087 100644
>> --- a/include/linux/cpuidle.h
>> +++ b/include/linux/cpuidle.h
>> @@ -53,7 +53,7 @@ struct cpuidle_state {
>>   };
>>
>>   /* Idle State Flags */
>> -#define CPUIDLE_FLAG_TIME_VALID        (0x01) /* is residency time =
measurable? */
>> +#define CPUIDLE_FLAG_TIME_INVALID      (0x01) /* is residency time =
measurable? */
>>   #define CPUIDLE_FLAG_COUPLED   (0x02) /* state applies to multiple=
 cpus */
>>   #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on thi=
s state */
>>
>> @@ -90,7 +90,7 @@ DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev=
);
>>    * cpuidle_get_last_residency - retrieves the last state's residen=
cy time
>>    * @dev: the target CPU
>>    *
>> - * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_VALID isn't set
>> + * NOTE: this value is invalid if CPUIDLE_FLAG_TIME_INVALID is set
>>    */
>>   static inline int cpuidle_get_last_residency(struct cpuidle_device=
 *dev)
>>   {
>> --
>> 1.9.1
>>
>>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
