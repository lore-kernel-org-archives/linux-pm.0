From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/6] of-thermal hardware trip points + Tegra124 SOCTHERM
 driver
Date: Mon, 21 Jul 2014 15:42:29 +0800
Message-ID: <1405928549.2455.2.camel@rzhang1-toshiba>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1097 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752685AbaGUHmf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 21 Jul 2014 03:42:35 -0400
In-Reply-To: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: edubezval@gmail.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, pdeschrijver@nvidia.com, mlongnecker@nvidia.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi, Eduardo,

what do you think of this patch set?

thanks,
rui

On Fri, 2014-06-27 at 11:11 +0300, Mikko Perttunen wrote:
> Hi everyone,
> 
> this series adds support for hardware-tracked thermal trip points
> for the device tree thermal framework and introduces a new Tegra124 thermal
> driver that uses them.
> 
> Hardware-tracked trip points are trip points that do not need to be polled;
> the hardware gives an interrupt when the trip point is reached. The device
> tree thermal framework has not previously given the sensor driver any
> information about set trip points, so using these has been impossible.
> This series adds a new callback from of-thermal to the driver to allow telling
> the driver about trip points. The driver only needs to track two trip points,
> the framework ensures that the current temperature lies between those two.
> Behavior for drivers that do not include this callback is unchanged.
> 
> The Tegra124 SOCTHERM thermal driver that is included exposes four thermal zones
> (the thermctl thermal zones) with hardware-tracked trip point support. While the
> hardware supports four tracked trip points, only one is used.
> 
> Mikko Perttunen (6):
>   thermal: of: Add support for hardware-tracked trip points
>   of: Add bindings for nvidia,tegra124-soctherm
>   ARM: tegra: Add thermal trip points for Jetson TK1
>   ARM: tegra: Add soctherm and thermal zones to Tegra124 device tree
>   clk: tegra: Add soctherm and tsensor clocks to Tegra124 init table
>   thermal: Add Tegra SOCTHERM thermal management driver
> 
>  .../devicetree/bindings/thermal/tegra-soctherm.txt |  32 ++
>  arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  32 ++
>  arch/arm/boot/dts/tegra124.dtsi                    |  48 ++
>  drivers/clk/tegra/clk-tegra124.c                   |   2 +
>  drivers/thermal/Kconfig                            |   7 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/of-thermal.c                       |  97 +++-
>  drivers/thermal/tegra_soctherm.c                   | 553 +++++++++++++++++++++
>  include/dt-bindings/thermal/tegra124-soctherm.h    |  15 +
>  include/linux/thermal.h                            |   3 +-
>  10 files changed, 785 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
>  create mode 100644 drivers/thermal/tegra_soctherm.c
>  create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h
> 


