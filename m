From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 00/19] PM / devferq: Add generic exynos bus frequency
 driver and new passive governor
Date: Thu, 10 Dec 2015 09:57:45 +0900
Message-ID: <5668CE09.3030503@samsung.com>
References: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1449634091-1842-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, myungjoo.ham@samsung.com, kgene@kernel.org
Cc: kyungmin.park@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, tjakobi@math.uni-bielefeld.de, linux.amoon@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09.12.2015 13:07, Chanwoo Choi wrote:

(...)

>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  383 +++++++

How about adding this file to the MAINTAINERS to devfreq exynos entry?
Unfortunately, in current linux-next, I can find the entry for devfreq
exynos. However I saw patches adding such entries... aren't they merged
to linux-next?

Best regards,
Krzysztof

>  arch/arm/boot/dts/exynos3250-monk.dts              |    6 +
>  arch/arm/boot/dts/exynos3250-rinato.dts            |   47 +
>  arch/arm/boot/dts/exynos3250.dtsi                  |  194 ++++
>  arch/arm/boot/dts/exynos4210.dtsi                  |  172 ++++
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   93 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts            |   47 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |  184 ++++
>  drivers/devfreq/Kconfig                            |   37 +-
>  drivers/devfreq/Makefile                           |    2 +
>  drivers/devfreq/devfreq.c                          |  120 ++-
>  drivers/devfreq/exynos/Makefile                    |    3 +-
>  drivers/devfreq/exynos/exynos-bus.c                |  549 ++++++++++
>  drivers/devfreq/exynos/exynos4_bus.c               | 1055 --------------------
>  drivers/devfreq/exynos/exynos4_bus.h               |  110 --
>  drivers/devfreq/exynos/exynos5_bus.c               |  431 --------
>  drivers/devfreq/exynos/exynos_ppmu.c               |  119 ---
>  drivers/devfreq/exynos/exynos_ppmu.h               |   86 --
>  drivers/devfreq/governor.h                         |    7 +
>  drivers/devfreq/governor_passive.c                 |  109 ++
>  drivers/devfreq/governor_performance.c             |    1 +
>  drivers/devfreq/governor_powersave.c               |    1 +
>  drivers/devfreq/governor_simpleondemand.c          |    1 +
>  drivers/devfreq/governor_userspace.c               |    1 +
>  include/linux/devfreq.h                            |   28 +
>  25 files changed, 1958 insertions(+), 1828 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos4_bus.h
>  delete mode 100644 drivers/devfreq/exynos/exynos5_bus.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.c
>  delete mode 100644 drivers/devfreq/exynos/exynos_ppmu.h
>  create mode 100644 drivers/devfreq/governor_passive.c
> 
