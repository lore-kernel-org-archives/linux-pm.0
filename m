From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v6 0/9] samsung: pmu: split up SoC specific PMU data
Date: Thu, 17 Dec 2015 14:31:02 +0900
Message-ID: <56724896.1080009@samsung.com>
References: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1447740351-14246-1-git-send-email-pankaj.dubey@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Pankaj Dubey <pankaj.dubey@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de
List-Id: linux-pm@vger.kernel.org

On 17.11.2015 15:05, Pankaj Dubey wrote:
> In this series I am splitting up SoC specific PMU configuration data into
> mach-exynos folder itself, before moving all of them under
> drivers/soc/samsung/. Also instead of making all changes in single patch it
> has been broken into SoC specific patches to avoid large size of patch.
> With this approach there will not be unwanted big churns just after
> adding exynos-pmu under drivers/soc/samsung.
> 
> All these patches are just refactoring to keep minimal changes while moving
> exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can
> be added on top of it, in such a manner that for ARM64 build, ARM related
> SoC's PMU will not get compiled and thus unnecessary increasing kernel image size.
> 
> These patches have been prepared on top of Kukjin Kim's for-next merged with
> driver-samsung and on top of
> cherry-picked change from [1].
> 
> 1: ARM: EXYNOS: Constify local exynos_pmu_data structure
>    https://lkml.org/lkml/2015/10/28/917
> 
> For testing entire patchset on Peach-Pi (Exynos5880) based chromebook for boot
> and S2R functionality.
> 
> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> For testing entire patchset on on Trats2 (Exynos4412, S2R, reboot, poweroff)
> and Odroid XU3 (Exynos5422, reboot, poweroff).
> 
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Changes since v5:
>  - Removed extra blank line from patch 5/9 and 6/9.
>  - Modified soc/samsung/Kconfig for config EXNOS_PMU. Added depends on ARM.
> 
> Changes since v4:
>  - In v3 I missed to give -M flag to detect rename, which made patches hard
>    to review, so resubmitting patches with rename detector flag.
>  - Addressed review comments from Krzysztof.
> 
> Changes since v3:
>  - Keeping intact copyright dates in existing header files.
>  - Addressed review comments from Krzysztof for v3.
>  - Removing static inline function from exynos-pmu.h and
>    keeping them in PMU driver.
>  - Added new patch (2/9) for fixing potential null pointer reference in
>    exynos_sys_powerdown_conf.
>  - Added new patch (8/9) for rearranging static and non-static function for
>    better readability.
> 
> Changes since v2:
>  - Removed Amit's Samsung id as it's no more valid.
>  - Rebased on latest kgene tree.
>  - Removed redundant code from regs-pmu.h
> 
> Pankaj Dubey (9):
>   ARM: EXYNOS: removing redundant code from regs-pmu.h
>   ARM: EXYNOS: Fix potential NULL pointer access in
>     exynos_sys_powerdown_conf
>   ARM: EXYNOS: Move pmu specific headers under "linux/soc/samsung"
>   ARM: EXYNOS: split up exynos3250 SoC specific PMU data
>   ARM: EXYNOS: split up exynos4 SoC specific PMU data
>   ARM: EXYNOS: split up exynos5250 SoC specific PMU data
>   ARM: EXYNOS: split up exynos5420 SoC specific PMU data
>   ARM: EXYNOS: rearrange static and non-static functions of PMU driver
>   drivers: soc: Add support for Exynos PMU driver
> 

I tried to apply this to my branch:
next/stuff-late-not-split-per-branch
https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/stuff-late-not-split-per-branch

Unfortunately it fails on:
error: patch failed: arch/arm/mach-exynos/pmu.c:17
error: arch/arm/mach-exynos/pmu.c: patch does not apply
Patch failed at 0001 ARM: EXYNOS: Move pmu specific headers under
"linux/soc/samsung"

because of syscon-reboot handlers (Alim's work).

I think I have all the dependencies already in my
"next/stuff-late-not-split-per-branch".
If you want to proceed now, can you rebase on top of it? Otherwise we
could wait and rebase later (after v4.5-rc1).


P.S. Please note that "next/stuff-late-not-split-per-branch" is not
included in linux-next because I am not sure if I will be able to push
it out soon.


Best regards,
Krzysztof
