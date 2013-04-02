From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 0/9] thermal: exynos: Add thermal driver for exynos5440
Date: Tue, 02 Apr 2013 19:26:44 +0900
Message-ID: <237c01ce2f8c$92eb8ac0$b8c2a040$%kim@samsung.com>
References: <1364297642-2746-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52232 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761981Ab3DBK0q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Apr 2013 06:26:46 -0400
In-reply-to: <1364297642-2746-1-git-send-email-amit.daniel@samsung.com>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Amit Daniel Kachhap' <amit.daniel@samsung.com>, linux-pm@vger.kernel.org
Cc: 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Zhang Rui' <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.kachhap@gmail.com

Amit Daniel Kachhap wrote:
> 
> This patchset adds TMU(Thermal management Unit) driver support for
> exynos5440 platform. There are 3 instances of the TMU controllers so
> necessary cleanup is done to handle multiple thermal zone.
> 
> Patch 1 [thermal: exynos: Adapt to temperature emulation core thermal]
> is a re-post of the earlier posted patch,
> https://patchwork.kernel.org/patch/2123131/.
> 

Looks OK to me on whole series, there is my ack only on 1st patch though.

So if you want to add my ack, feel free:

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

- Kukjin

> All these patches are based on thermal maintainers git tree,
> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next.
> 
> Amit Daniel Kachhap (9):
>   thermal: exynos: Adapt to temperature emulation core thermal
>     framework
>   thermal: exynos: Add support for instance based register/unregister
>   thermal: exynos: Moving into samsung directory for easy maintenance.
>   thermal: exynos: Bifurcate exynos thermal common and tmu controller
>     code
>   thermal: exynos: Make the zone handling dependent on trip count
>   thermal: exynos: small cleanups to prepare for adding exynos5440
>     driver
>   thermal: exynos: Add support for exynos5440 TMU sensor.
>   thermal: exynos: Parse the platform data from the device tree.
>   ARM: dts: Add device tree node for exynos5440 TMU controller
> 
>  .../bindings/thermal/exynos5440-thermal.txt        |   93 ++
>  Documentation/thermal/exynos_thermal_emulation     |    8 +-
>  arch/arm/boot/dts/exynos5440.dtsi                  |   43 +
>  drivers/thermal/Kconfig                            |   22 +-
>  drivers/thermal/Makefile                           |    2 +-
>  drivers/thermal/exynos_thermal.c                   | 1112
--------------------
>  drivers/thermal/samsung/Kconfig                    |   32 +
>  drivers/thermal/samsung/Makefile                   |    6 +
>  drivers/thermal/samsung/exynos4210_thermal.c       |  658 ++++++++++++
>  drivers/thermal/samsung/exynos5440_thermal.c       |  712 +++++++++++++
>  drivers/thermal/samsung/exynos_common.c            |  515 +++++++++
>  drivers/thermal/samsung/exynos_common.h            |   74 ++
>  include/linux/platform_data/exynos_thermal.h       |   37 +-
>  13 files changed, 2163 insertions(+), 1151 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/exynos5440-
> thermal.txt
>  delete mode 100644 drivers/thermal/exynos_thermal.c
>  create mode 100644 drivers/thermal/samsung/Kconfig
>  create mode 100644 drivers/thermal/samsung/Makefile
>  create mode 100644 drivers/thermal/samsung/exynos4210_thermal.c
>  create mode 100644 drivers/thermal/samsung/exynos5440_thermal.c
>  create mode 100644 drivers/thermal/samsung/exynos_common.c
>  create mode 100644 drivers/thermal/samsung/exynos_common.h

