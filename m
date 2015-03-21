From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 0/8] ARM: cpuidle: Unify the ARM64/ARM DT approach
Date: Sat, 21 Mar 2015 20:51:10 +0000
Message-ID: <20150321205110.GF22354@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 20, 2015 at 11:43:53AM +0000, Daniel Lezcano wrote:
> There is a big number of cpuidle drivers for the ARM architecture.
> 
> These drivers have been cleaned up and grouped into the drivers/cpuidle
> directory to keep track of the changes more easily and ensure the code
> is following the same scheme across the drivers.
> 
> That had the benefit of simplifying the code and factor out a lot of common
> parts. Beside that, as the drivers belong to the 'drivers' directory, we had
> to split the arch specific bits and the generic code in order to keep
> everything self contained. The platform driver paradigm was used for this
> purpose.
> 
> Unfortunately, this approach is now no longer accepted and a different solution
> must be provided to reach the same goal: one example is the Qualcomm cpuidle
> driver upstreaming attempt.
> 
> In the meantime, ARM64 developed a generic cpuidle driver based on DT definition.
> 
> The DT definition provides an 'enable-method' to specify one of the cpu
> operations (PSCI, ...).
> 
> This patchset unify this driver with ARM32, using the same DT definition.
> 
> Thanks with this patchset we can use the 'enable-method' to specify a cpu
> operations, hence get rid of the platform driver approach and go further in the
> cpuidle driver flexibility via the DT.

I tested the series on arm64 FVP models, next week I will do it on Juno
to cover arm64, but I do not expect any changes compared to FVP since the
arm64 arch interface is identical (which is the goal BTW).

I will add the tag accordingly.

Lorenzo

> 
> Changelog:
> 
>  V3:
> 	* Fixed unroll loop when failing to register the device
> 	* Removed the per cpu cpuidle_device
> 	* Remove goto statement in the registration path
> 	* Fixed a compilation failure with allyesconfig on arm64
> 
>  V2:
> 	* Used smp_operations style for cpuidle_ops
> 	* Fixed some nits in the comments
> 	* Added a patch to change the name of the functions
> 	* Added per cpu device registration patch
> 
> Daniel Lezcano (8):
>   ARM: cpuidle: Remove duplicate header inclusion
>   ARM: cpuidle: Add a cpuidle ops structure to be used for DT
>   ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function
>   ARM64: cpuidle: Rename cpu_init_idle to a common function name
>   ARM64: cpuidle: Remove arm64 reference
>   ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
>   ARM: cpuidle: Register per cpuidle device
>   ARM: cpuidle: Change function name to be consistent with x86
> 
>  arch/arm/include/asm/cpuidle.h                     | 23 +++++++
>  arch/arm/kernel/cpuidle.c                          | 74 +++++++++++++++++++-
>  arch/arm/mach-davinci/cpuidle.c                    |  1 -
>  arch/arm/mach-imx/cpuidle-imx6q.c                  |  1 -
>  arch/arm/mach-imx/cpuidle-imx6sl.c                 |  1 -
>  arch/arm/mach-imx/cpuidle-imx6sx.c                 |  1 -
>  arch/arm/mach-omap2/cpuidle44xx.c                  |  1 -
>  arch/arm/mach-s3c64xx/cpuidle.c                    |  2 +-
>  arch/arm/mach-tegra/cpuidle-tegra20.c              |  1 -
>  arch/arm/mach-tegra/cpuidle-tegra30.c              |  1 -
>  arch/arm64/include/asm/cpuidle.h                   |  9 ++-
>  arch/arm64/kernel/cpuidle.c                        |  2 +-
>  drivers/cpuidle/Kconfig                            |  7 +-
>  drivers/cpuidle/Kconfig.arm                        | 12 +++-
>  drivers/cpuidle/Kconfig.arm64                      | 13 ----
>  drivers/cpuidle/Makefile                           |  5 +-
>  drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} | 80 ++++++++++++++++------
>  drivers/cpuidle/cpuidle-at91.c                     |  1 -
>  drivers/cpuidle/cpuidle-exynos.c                   |  1 -
>  drivers/cpuidle/cpuidle-kirkwood.c                 |  1 -
>  drivers/cpuidle/cpuidle-ux500.c                    |  1 -
>  drivers/cpuidle/cpuidle-zynq.c                     |  1 -
>  include/asm-generic/vmlinux.lds.h                  |  2 +
>  23 files changed, 178 insertions(+), 63 deletions(-)
>  delete mode 100644 drivers/cpuidle/Kconfig.arm64
>  rename drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} (57%)
> 
> -- 
> 1.9.1
> 
> 
