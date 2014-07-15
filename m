From: Thomas Abraham <ta.omasab@gmail.com>
Subject: Re: [PATCH v7 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
Date: Tue, 15 Jul 2014 09:20:34 +0530
Message-ID: <CAJuA9ahWbL8v2nS6wuDosn-bi+pga57KUe5wQN14Mot_-RTc6w@mail.gmail.com>
References: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:44924 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932483AbaGODug (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jul 2014 23:50:36 -0400
In-Reply-To: <1405345118-4269-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "thomas.ab@samsung.com" <thomas.ab@samsung.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>

Hi Tomasz,

On Mon, Jul 14, 2014 at 7:08 PM, Thomas Abraham <thomas.ab@samsung.com> wrote:
> Changes since v6:
> - Fixes suggested by Amit Daniel <amit.daniel@samsung.com>.
>
> This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
> drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
> series also enabled cpufreq support for Exynos5420 using arm_big_little cpufreq
> driver.
>
> Thomas Abraham (6):
>   clk: samsung: add infrastructure to register cpu clocks
>   clk: samsung: register exynos5420 apll/kpll configuration data
>   clk: exynos: use cpu-clock provider type to represent arm clock
>   ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
>   ARM: Exynos: switch to using generic cpufreq driver for exynos4210/5250
>   cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support

In this series, support for Exynos5420 has been included. If there are
any more changes required, could you please let me know.

Thanks,
Thomas.

>
>  arch/arm/boot/dts/exynos4210-origen.dts         |    6 +
>  arch/arm/boot/dts/exynos4210-trats.dts          |    6 +
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +
>  arch/arm/boot/dts/exynos4210.dtsi               |   27 ++
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    6 +
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi   |    6 +
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    6 +
>  arch/arm/boot/dts/exynos5250.dtsi               |   23 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts       |    6 +
>  arch/arm/boot/dts/exynos5420.dtsi               |   32 ++
>  arch/arm/mach-exynos/exynos.c                   |   15 +-
>  drivers/clk/samsung/Makefile                    |    2 +-
>  drivers/clk/samsung/clk-cpu.c                   |  576 +++++++++++++++++++++++
>  drivers/clk/samsung/clk-exynos4.c               |   25 +-
>  drivers/clk/samsung/clk-exynos5250.c            |   16 +-
>  drivers/clk/samsung/clk-exynos5420.c            |   60 ++-
>  drivers/clk/samsung/clk.h                       |    5 +
>  drivers/cpufreq/Kconfig.arm                     |   22 -
>  drivers/cpufreq/Makefile                        |    2 -
>  drivers/cpufreq/exynos4210-cpufreq.c            |  184 --------
>  drivers/cpufreq/exynos5250-cpufreq.c            |  210 ---------
>  include/dt-bindings/clock/exynos5250.h          |    1 +
>  include/dt-bindings/clock/exynos5420.h          |    2 +
>  23 files changed, 802 insertions(+), 442 deletions(-)
>  create mode 100644 drivers/clk/samsung/clk-cpu.c
>  delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
>  delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
>
> --
> 1.7.9.5
>
