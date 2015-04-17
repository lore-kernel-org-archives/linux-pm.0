From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFC/PATCH v2 0/5] Add cpuidle support for r8a7791
Date: Fri, 17 Apr 2015 17:19:37 +0900
Message-ID: <20150417081937.GB28811@verge.net.au>
References: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429180540-5692-1-git-send-email-keita.kobayashi.ym@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Kobayashi-san,

from my point of view this looks reasonable.
Is it marked as an RFC because you see some problems with it.
If not perhaps it would be best to proceed to a more formal
stage of the review process by dropping the RFC designation?

On Thu, Apr 16, 2015 at 07:35:35PM +0900, Keita Kobayashi wrote:
> Hello
> 
> These patches add cpuidle support for Renesas r8a7791 SoC.
> The r8a7791 cpuidle supports WFI and the cpu power state(Core-Standby)
> using Generic ARM CPU idle driver(cpuidle-arm).
> Generic ARM CPU idle driver have been merged in linux-pm.git / pm+acpi-4.1-rc1 tag.
> 
> Based on : renesas.git / renesas-devel-20150413-v4.0 tag
> Tested on : koelsch board
> 
> Changes from v1:
>  - Change "select" to "depend on"
>  - Document a new enable method of Renesas cpuidle
> 
> Keita Kobayashi (5):
>   ARM: cpuidle: Add cpuidle support for R-Car Gen2 series
>   ARM: shmobile: Add cpuidle_ops for R-Car cpuidle
>   devicetree: bindings: Add new cpuidle enable method for Renesas R-car
>     SoCs
>   ARM: shmobile: dtsi: Add cpuidle parameters into each cpu for r8a7791
>   ARM: shmobile: Enable Renesas R-Car cpuidle for shmobile_defconfig
> 
>  Documentation/devicetree/bindings/arm/cpus.txt |  1 +
>  arch/arm/boot/dts/r8a7791.dtsi                 | 13 +++++++++++++
>  arch/arm/configs/shmobile_defconfig            |  3 +++
>  arch/arm/mach-shmobile/platsmp-apmu.c          | 14 +++++++++++---
>  arch/arm/mach-shmobile/platsmp-apmu.h          |  1 +
>  arch/arm/mach-shmobile/pm-rcar-gen2.c          | 17 +++++++++++++++++
>  drivers/cpuidle/Kconfig.arm                    |  8 ++++++++
>  7 files changed, 54 insertions(+), 3 deletions(-)
> 
> -- 
> 1.9.1
> 
