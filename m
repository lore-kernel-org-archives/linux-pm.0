From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/6] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Thu, 12 Mar 2015 15:25:34 +0100
Message-ID: <5501A1DE.9020804@linaro.org>
References: <1425385777-14766-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425385777-14766-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin.Marinas-5wv7dgnIgG8@public.gmane.org, robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org


Catalin, Rob,

do you agree with this patchset ?

Thanks
   -- Daniel

On 03/03/2015 01:29 PM, Daniel Lezcano wrote:
> There is a big number of cpuidle drivers for the ARM architecture.
>
> These drivers have been cleaned up and grouped into the drivers/cpuid=
le
> directory to keep track of the changes more easily and ensure the cod=
e
> is following the same scheme across the drivers.
>
> That had the benefit of simplifying the code and factor out a lot of =
common
> parts. Beside that, as the drivers belong to the 'drivers' directory,=
 we had
> to split the arch specific bits and the generic code in order to keep
> everything self contained. The platform driver paradigm was used for =
this
> purpose.
>
> Unfortunately, this approach is now no longer accepted and a differen=
t solution
> must be provided to reach the same goal: one example is the Qualcomm =
cpuidle
> driver upstreaming attempt [1].
>
> In the meantime, ARM64 developed a generic cpuidle driver based on DT=
 definition.
>
> The DT definition provides an 'enable-method' to specify one of the c=
pu
> operations (PSCI, ...).
>
> This patchset unify this driver with ARM32, using the same DT definit=
ion.
>
> Thanks with this patchset we can use the 'enable-method' to specify a=
 cpu
> operations, hence get rid of the platform driver approach and go furt=
her in the
> cpuidle driver flexibility via the DT.
>
> Daniel Lezcano (6):
>    ARM: cpuidle: Remove duplicate header inclusion
>    ARM: cpuidle: Add a cpuidle ops structure to be used for DT
>    ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 functi=
on
>    ARM64: cpuidle: Rename cpu_init_idle to a common function name
>    ARM64: cpuidle: Remove arm64 reference
>    ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
>
>   arch/arm/include/asm/cpuidle.h                     | 12 +++
>   arch/arm/include/asm/cpuidle_ops.h                 |  3 +
>   arch/arm/kernel/cpuidle.c                          | 87 +++++++++++=
++++++++++-
>   arch/arm/mach-davinci/cpuidle.c                    |  1 -
>   arch/arm/mach-imx/cpuidle-imx6q.c                  |  1 -
>   arch/arm/mach-imx/cpuidle-imx6sl.c                 |  1 -
>   arch/arm/mach-imx/cpuidle-imx6sx.c                 |  1 -
>   arch/arm/mach-omap2/cpuidle44xx.c                  |  1 -
>   arch/arm/mach-tegra/cpuidle-tegra20.c              |  1 -
>   arch/arm/mach-tegra/cpuidle-tegra30.c              |  1 -
>   arch/arm64/include/asm/cpuidle.h                   |  9 ++-
>   arch/arm64/kernel/cpuidle.c                        |  2 +-
>   drivers/cpuidle/Kconfig                            |  7 +-
>   drivers/cpuidle/Kconfig.arm                        | 10 +++
>   drivers/cpuidle/Kconfig.arm64                      | 13 ----
>   drivers/cpuidle/Makefile                           |  5 +-
>   drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} | 38 +++++----=
-
>   drivers/cpuidle/cpuidle-at91.c                     |  1 -
>   drivers/cpuidle/cpuidle-exynos.c                   |  1 -
>   drivers/cpuidle/cpuidle-kirkwood.c                 |  1 -
>   drivers/cpuidle/cpuidle-ux500.c                    |  1 -
>   drivers/cpuidle/cpuidle-zynq.c                     |  1 -
>   22 files changed, 139 insertions(+), 59 deletions(-)
>   create mode 100644 arch/arm/include/asm/cpuidle_ops.h
>   delete mode 100644 drivers/cpuidle/Kconfig.arm64
>   rename drivers/cpuidle/{cpuidle-arm64.c =3D> cpuidle-arm.c} (72%)
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
