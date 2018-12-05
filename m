From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
Date: Wed, 05 Dec 2018 23:08:06 +0800
Message-ID: <1544022486.2841.42.camel@intel.com>
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
         <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <l.luba@partner.samsung.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com, krzk@kernel.org
List-Id: linux-pm@vger.kernel.org

On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
> Hi all,
> 
> This patch set adds a new flag and mechanism in thermal trip points
> in
> DT.  The old implementation in thermal zone in DT sets the same
> configuration for all internal trip points. It does not work for all
> HW.  There are SoCs which support IRQs for some trip points (i.e.
> Exynos 4 has 4 trip points with IRQs). For additional one defined
> inside the thermal zone there is a need of 'polling'. When developer
> adds polling mode settings inside the thermal zone, all the trip
> points will be registered for polling, even those supporting IRQs,
> which does not make sense.

we have two timers, one for polling, and one for passive cooling.
I think we are talking about passive cooling timer only, right?
And the real problem is that we have multiple passive trip points and
only part of them support irq_mode, and we don't want to start the
passive polling timer for all of the passive trip points.

thanks,
rui

>  Thus, developers create workarounds, which
> are confusing for some other developers.  To workaround, 
> people declare some trip points as 'active' (those with IRQ support).
> It allows to bypass polling mode in thermal framework applied for 
> all thermal zone's trip points.
> 
> Thermal framework defines 4 types of trip points. The 'passive' means
> passive cooling using DVFS, 'active' is designed for fan and other
> devices actively changing the outside conditions. Therefore, a
> workaround
> mentioned earlier is confusing when someone does not know about the
> framework limitations.
> 
> This patch set tries to solve the issue by adding one flag inside the
> trip point: 'irq-mode;'.  The trip point 'passive' declared in DT
> with
> explicit flag 'irq-mode;' will not register itself as polling mode.
> Thermal framework will skip it during scheduling next read out work.
> The old global-polling-mode-configuration-inside-thermal-zone is
> still
> valid.  Patch set does not break existing design for trip points
> which
> do not have 'irq-mode' flag - they will use polling.
> 
> As an example please check patch #10 for Exynos4 SoC family, where
> there
> is 4 HW supported trip points and there is a need of 6. The rest 2
> are
> declared as 'passive' without 'irq-mode;' flag, which means polling
> mode needed for them.
> 
> Patch #1 is a small cleanup in thermal framework.
> 
> Change log:
> v2
> - changed description in cover letter
> - change commit messages according to Krzysztof comments
> - rebase on top of current mainline (v4.20-rc1)
> 
> Regards,
> Lukasz Luba
> 
> Lukasz Luba (11):
>   thermal: remove unused function parameter
>   thermal: add irq-mode configuration for trip point
>   thermal: add new sysfs file for irq-mode
>   Doc: thermal: new irq-mode for trip point
>   Doc: DT: thermal: new irq-mode for trip point
>   arm64: dts: exynos5433: add support for thermal trip irq-mode
>   arm64: dts: exynos7: add support for thermal trip irq-mode
>   arm: dts: exynos4: add support for thermal trip irq-mode
>   arm: dts: exynos5420: add support for thermal trip irq-mode
>   arm: dts: exynos5422: add support for thermal trip irq-mode
>   arm: dts: exynos5410: add support for thermal trip irq-mode
> 
>  .../devicetree/bindings/thermal/thermal.txt        |   7 ++
>  Documentation/thermal/sysfs-api.txt                |   9 ++
>  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105
> ++++++++++++++-------
>  .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
>  drivers/thermal/of-thermal.c                       |  17 ++++
>  drivers/thermal/thermal_core.c                     |  16 ++--
>  drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
>  include/linux/thermal.h                            |   5 +
>  12 files changed, 226 insertions(+), 64 deletions(-)
> 
