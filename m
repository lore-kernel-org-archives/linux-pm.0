From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v9 3/6] ARM: dts: Exynos: add CPU OPP and regulator supply
 property
Date: Sat, 02 Aug 2014 05:49:21 +0200
Message-ID: <53DC5FC1.7060700@collabora.co.uk>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com> <1406707663-16656-4-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406707663-16656-4-git-send-email-thomas.ab@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, mturquette@linaro.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, heiko@sntech.de, cw00.choi@samsung.com, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hello Thomas,

On 07/30/2014 10:07 AM, Thomas Abraham wrote:
> For Exynos 4210/5250/5420 based platforms, add CPU operating points and CPU
> regulator supply properties for migrating from Exynos specific cpufreq driver
> to using generic cpufreq drivers.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         |    4 +++
>  arch/arm/boot/dts/exynos4210-trats.dts          |    4 +++
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +++
>  arch/arm/boot/dts/exynos4210.dtsi               |   14 ++++++++-
>  arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +++
>  arch/arm/boot/dts/exynos5250-snow.dts           |    4 +++
>  arch/arm/boot/dts/exynos5250.dtsi               |   25 ++++++++++++++-
>  arch/arm/boot/dts/exynos5420.dtsi               |   38 +++++++++++++++++++++++
>  9 files changed, 99 insertions(+), 2 deletions(-)
> 

Tested the series on a Exynos5420 based Peach Pit Chromebook by doing the
following for CPU0-3:

1) Verified that the big.LITTLE CPUFreq (arm-big-little) driver was reported as
used in /sys/devices/system/cpu/cpu*/cpufreq/scaling_driver.

2) Set all available governors (conservative, ondemand, userspace, powersave and
performance).

3) Confirmed that cpuinfo_cur_freq and scaling_cur_freq values were fixed or
changing according to the selected governor policy.

4) Verified that the statistics in /sys/devices/system/cpu/cpu*/cpufreq/stats/*
were filled.

Everything is working correctly so please feel free to add for the whole series:

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
