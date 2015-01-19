From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 0/9] devfreq: Add generic exynos memory-bus frequency
 driver
Date: Mon, 19 Jan 2015 09:50:58 +0900
Message-ID: <54BC54F2.8090001@samsung.com>
References: <1421286657-4720-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1421286657-4720-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kgene@kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo and Kukjin,

Could you please review this patchset?

Best Regards,
Chanwoo Choi

On 01/15/2015 10:50 AM, Chanwoo Choi wrote:
> This patch-set adds the generic exynos bus frequency driver for memory bus
> with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
> for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
> support the memory bus frequency driver for Exynos SoCs.
> 
> Each memory bus block has a clock for memory bus speed and frequency
> table which is changed according to the utilization of memory bus on runtime.
> And then each memory bus group has the one more memory bus blocks and
> OPP table (including frequency and voltage), regulator, devfreq-event
> devices.
> 
> There are a little difference about the number of memory bus because each Exynos
> SoC have the different sub-IP and different memory bus speed. In spite of this
> difference among Exynos SoCs, we can support almost Exynos SoC by adding
> unique data of memory bus to devicetree file.
> 
> Depend on:
> - [PATCHv8 0/9] devfreq: Add devfreq-event class to provide raw data for devfreq device
>   : https://lkml.org/lkml/2015/1/7/795
> 
> Changelog:
> 
> Changes from v3:
> (https://lkml.org/lkml/2015/1/7/872)
> - Change the driver name and path by comment
>   : drivers/devfreq/exynos-busfreq.c -> drivers/devfreq/exynos/exynos-bus.c
> - Disable regulator when entering suspend state in exynos-bus.c
>   and enable it after wake-up from suspend state.
> - Add 'exynos,saturation-ratio' property to calibrate the performance count
>   against cycle count.
> - Add new patch to remove unused old driver
>   : drivers/devfreq/exynos/exynos4_bus.{c|h}
> - Clean-up code for minor issue
> - Add acked tag by Myungjoo Ham (DEVFREQ maintainer)
> 
> Changes from v2:
> (https://lkml.org/lkml/2014/12/31/2)
> - Support the memory bus frequency feature for Exynos3250-based Monk board
> - Fix build warning about variable uninitialized
> 
> Changes from v1:
> (https://lkml.org/lkml/2014/12/23/178)
> - This patchset is rebased on v3.19-rc2.
> - Fix bug after wake-up from suspend state. If devfreq device fail to get event,
>   exynos-busfreq retry to set the event for starting.
> - Add memory bus group of Exynos4x12/Exynos4210
> - Add divider clock id for Exynos4 memory bus frequency
> - Support memory bus frequency driver on Exynos4412-based TRATS2 board
> - This patch-set has the dependency on following patch-set[1]:
>   [1] [PATCHv6 0/9] devfreq: Add devfreq-event class to provide raw data for devfreq device
>   : https://lkml.org/lkml/2014/12/28/139
> 
> Chanwoo Choi (9):
>   devfreq: exynos: Add generic exynos memory bus frequency driver
>   devfreq: exynos: Add documentation for generic exynos memory bus frequency driver
>   ARM: dts: Add memory bus node for Exynos3250
>   clk: samsung: exynos4: Add divider clock id for memory bus frequency
>   ARM: dts: Add memory bus node for Exynos4x12
>   ARM: dts: Add memory bus node for Exynos4210
>   ARM: dts: Add the support for exynos busfreq on Exynos3250-based Rinato/Monk board
>   ARM: dts: Add the support for exynos busfreq on Exynos4412-based TRATS2 board
>   devfreq: exynos: Remove unused exynos4 memory busfreq driver
> 
>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  188 ++++
>  arch/arm/boot/dts/exynos3250-monk.dts              |   12 +
>  arch/arm/boot/dts/exynos3250-rinato.dts            |   12 +
>  arch/arm/boot/dts/exynos3250.dtsi                  |  125 +++
>  arch/arm/boot/dts/exynos4210.dtsi                  |   93 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts            |   12 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  121 +++
>  drivers/clk/samsung/clk-exynos4.c                  |   10 +-
>  drivers/devfreq/Kconfig                            |   17 +-
>  drivers/devfreq/Makefile                           |    1 +
>  drivers/devfreq/exynos/Makefile                    |    2 +-
>  drivers/devfreq/exynos/exynos-bus.c                |  598 +++++++++++
>  drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------------------
>  drivers/devfreq/exynos/exynos4_bus.h               |  110 --
>  include/dt-bindings/clock/exynos4.h                |    7 +-
>  15 files changed, 1184 insertions(+), 1179 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
> 
