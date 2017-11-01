From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] Thermal SoC management updates for v4.15-rc1 #1
Date: Wed, 01 Nov 2017 10:29:46 +0800
Message-ID: <1509503386.3080.72.camel@intel.com>
References: <20171030143003.GA1938@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171030143003.GA1938@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2017-10-30 at 07:30 -0700, Eduardo Valentin wrote:
> Hello Rui,
> 
> Please pull the changes for thermal-soc for the coming v4.15-rc1.
> Changelog:
> - New drivers: Rockchip RV1108 and Broadcom AVS tmon.
> - Major rework on HISI driver plus additional support of hisi3660.
> - Several fixes on diverse drivers and few in core.
> 
> BR,
> 
> The following changes since commit
> 569dbb88e80deb68974ef6fdd6a13edb9d686261:
> 
>   Linux 4.13 (2017-09-03 13:56:17 -0700)
> 
please rebase it on top of v4.14-rc1 to avoid conflict, as we have a
couple of thermal soc changes merged in 4.14-rc1.

thanks,
rui

> are available in the git repository at:
> 
>  
> 
> for you to fetch changes up to
> 877a9aa9dadc7291b0069fb2ccdf2bbc1e3e6a6e:
> 
>   thermal: cpu_cooling: pr_err() strings should end with newlines
> (2017-10-26 11:33:32 -0700)
> 
> ----------------------------------------------------------------
> Allen Wild (1):
>       thermal: enable broadcom menu for arm64 bcm2835
> 
> Arvind Yadav (1):
>       thermal: cpu_cooling: pr_err() strings should end with newlines
> 
> Baruch Siach (1):
>       thermal: armada: fix formula documentation comment
> 
> Brian Norris (2):
>       Documentation: devicetree: add binding for Broadcom STB AVS
> TMON
>       thermal: add brcmstb AVS TMON driver
> 
> Daniel Lezcano (16):
>       thermal/drivers/hisi: Fix missing interrupt enablement
>       thermal/drivers/hisi: Remove the multiple sensors support
>       thermal/drivers/hisi: Fix kernel panic on alarm interrupt
>       thermal/drivers/hisi: Simplify the temperature/step computation
>       thermal/drivers/hisi: Fix multiple alarm interrupts firing
>       thermal/drivers/hisi: Remove pointless lock
>       thermal/drivers/hisi: Encapsulate register writes into helpers
>       thermal/drivers/hisi: Fix configuration register setting
>       thermal/drivers/hisi: Remove costly sensor inspection
>       thermal/drivers/hisi: Rename and remove unused field
>       thermal/drivers/hisi: Convert long to int
>       thermal/drivers/hisi: Remove thermal data back pointer
>       thermal/drivers/hisi: Remove mutex_lock in the code
>       thermal/drivers/step_wise: Fix temperature regulation
> misbehavior
>       thermal/drivers/generic-iio-adc: Switch tz request to devm
> version
>       thermal/drivers/qcom-spmi: Use devm_iio_channel_get
> 
> Kevin Wangtao (6):
>       thermal/drivers/hisi: Move the clk setup in the corresponding
> functions
>       thermal/drivers/hisi: Use round up step value
>       thermal/drivers/hisi: Put platform code together
>       thermal/drivers/hisi: Add platform prefix to function name
>       thermal/drivers/hisi: Prepare to add support for other hisi
> platforms
>       thermal/drivers/hisi: Add support for hi3660 SoC
> 
> Nicolin Chen (1):
>       thermal: tegra: remove null check for dev pointer
> 
> Niklas Söderlund (1):
>       thermal: rcar_gen3_thermal: fix initialization sequence for H3
> ES2.0
> 
> Rocky Hao (2):
>       dt-bindings: rockchip-thermal: Support the RV1108 SoC
> compatible
>       thermal: rockchip: Support the RV1108 SoC in thermal driver
> 
> Tony Lindgren (1):
>       thermal: ti-soc-thermal: Fix ti_thermal_unregister_cpu_cooling
> NULL pointer on unload
> 
>  .../devicetree/bindings/thermal/brcm,avs-tmon.txt  |  20 +
>  .../bindings/thermal/rockchip-thermal.txt          |   1 +
>  MAINTAINERS                                        |   8 +
>  drivers/thermal/Kconfig                            |   2 +-
>  drivers/thermal/armada_thermal.c                   |   2 +-
>  drivers/thermal/broadcom/Kconfig                   |   7 +
>  drivers/thermal/broadcom/Makefile                  |   1 +
>  drivers/thermal/broadcom/brcmstb_thermal.c         | 387
> +++++++++++++
>  drivers/thermal/cpu_cooling.c                      |   2 +-
>  drivers/thermal/hisi_thermal.c                     | 612
> ++++++++++++++-------
>  drivers/thermal/qcom-spmi-temp-alarm.c             |  43 +-
>  drivers/thermal/rcar_gen3_thermal.c                |  34 +-
>  drivers/thermal/rockchip_thermal.c                 |  67 +++
>  drivers/thermal/step_wise.c                        |  11 +-
>  drivers/thermal/tegra/soctherm.c                   |   2 +-
>  drivers/thermal/thermal-generic-adc.c              |  24 +-
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |   3 +-
>  17 files changed, 940 insertions(+), 286 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/thermal/brcm,avs-tmon.txt
>  create mode 100644 drivers/thermal/broadcom/brcmstb_thermal.c
