From: Markus Reichl <m.reichl@fivetechno.de>
Subject: Re: [PATCH v3 0/10] cpufreq: add generic cpufreq driver support for
 Exynos542x/5800 platforms
Date: Mon, 7 Dec 2015 16:36:21 +0100
Message-ID: <5665A775.9040707@fivetechno.de>
References: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449250235-9613-1-git-send-email-b.zolnierkie@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ben Gamari <ben@smart-cactus.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Kevin Hilman <khilman@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Anand Moon <linux.amoon@gmail.com>, linux-pm@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

I have tested this patch set on Odroid-XU4 and get:

[    2.140821] cpu cpu0: Looking up cpu-cluster.1-supply from device tree
[    2.142780] cpu cpu0: bL_cpufreq_init: CPU 0 initialized
[    2.146858] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    2.161574] cpu cpu4: Looking up cpu-cluster.0-supply from device tree
[    2.163277] cpu cpu4: bL_cpufreq_init: CPU 4 initialized
[    2.167263] cpufreq: ondemand governor failed, too long transition latency of HW, fallback to performance governor
[    2.180092] arm_big_little: bL_cpufreq_register: Registered platform driver: dt-bl

cpufreq stays in performance mode and does not change down from highest frequency.

Had the same behaviour with Ben Gamari's patch.

Thanks,
--
Markus


Am 04.12.2015 um 18:30 schrieb Bartlomiej Zolnierkiewicz:
> Hi,
> 
> This patch series adds generic arm_big_little_dt cpufreq driver
> support for Exynos542x/5800 (using the new CPU clock type which
> allows it).  It also:
> - enhances arm_big_little[_dt] driver with CPU cluster regulator
>   support
> - adds CPU clock configuration data and CPU operating points
>   setup for Exynos542x/5800
> - adds CPU cluster regulator supplies for Exynos542x/5800 boards
> 
> This patch series has been tested on Exynos5422 based ODROID-XU3
> Lite board.
> 
> Please note that this is not a final version of the patchset.
> I just wanted to push out current work-in-progress patches that
> integrate changes from Anand, Ben and me.
> 
> TODO:
> - porting the Exynos542x/5800 support over cpufreq-dt
> 
> Depends on:
> - next-20151124 branch of linux-next kernel tree
> 
> Changes since v2:
> - ported over next-20151124 branch
> - integrated missing CLK_RECALC_NEW_RATES flags fix to patch #3
>   (from Anand Moon)
> - added regulator supply properties for ODROID-XU3 Lite and
>   ODROID-XU4 in patch #2
> - ported CPU OPPs to operating-points-v2 (from Ben Gamari)
> - added "ARM: dts: Exynos5422: fix OPP tables" patch (from Ben
>   Gamari)
> - added "cpufreq: arm-big-little: accept operating-points-v2
>   nodes" patch (from Ben Gamari)
> - renamed OPP nodes as opp@<opp-hz>
> 
> Changes since v1:
> - added CPU cluster regulator supply properties to
>   exynos5420-arndale-octa.dts, exynos5420-peach-pit.dts,
>   exynos5420-smdk5420.dts and exynos5800-peach-pi.dts
> 
> Changes over Thomas' original v12 code:
> - split Exynos5420 and Exynos5800 support
> - moved E5420_[EGL,KFC]_DIV0() macros to clk-exynos5420.c
> - disabled cpufreq if big.LITTLE switcher support is enabled
> - enhanced arm_big_little[_dt] driver with CPU cluster regulator
>   support
> - fixed CPU clock configuration data for Exynos5800
> - fixed CPU operating points setup for Exynos5800
> - added CPU cluster regulator supplies for ODROID-XU3 board
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (4):
>   cpufreq: arm_big_little: add cluster regulator support
>   ARM: dts: Exynos5420/5800: add cluster regulator supply properties
>   clk: samsung: exynos5800: fix cpu clock configuration data
>   ARM: dts: Exynos5800: fix CPU OPP
> 
> Ben Gamari (2):
>   ARM: dts: Exynos5422: fix OPP tables
>   cpufreq: arm-big-little: accept operating-points-v2 nodes
> 
> Thomas Abraham (4):
>   clk: samsung: exynos5420: add cpu clock configuration data and
>     instantiate cpu clock
>   ARM: dts: Exynos5420: add CPU OPP and regulator supply property
>   ARM: Exynos: use generic cpufreq driver for Exynos5420
>   ARM: Exynos: use generic cpufreq driver for Exynos5800
> 
>  .../bindings/cpufreq/arm_big_little_dt.txt         |   4 +
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   8 +
>  arch/arm/boot/dts/exynos5420-peach-pit.dts         |   8 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |   8 +
>  arch/arm/boot/dts/exynos5420.dtsi                  | 122 ++++++++++++++
>  arch/arm/boot/dts/exynos5422-cpus.dtsi             |  10 ++
>  arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    |   8 +
>  arch/arm/boot/dts/exynos5422-odroidxu3.dts         |   8 +
>  arch/arm/boot/dts/exynos5422-odroidxu4.dts         |   8 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts          |   8 +
>  arch/arm/boot/dts/exynos5800.dtsi                  | 165 +++++++++++++++++++
>  arch/arm/mach-exynos/exynos.c                      |   8 +
>  drivers/clk/samsung/clk-exynos5420.c               |  88 ++++++++++-
>  drivers/cpufreq/arm_big_little.c                   | 175 +++++++++++++++++----
>  drivers/cpufreq/arm_big_little_dt.c                |  12 +-
>  include/dt-bindings/clock/exynos5420.h             |   2 +
>  16 files changed, 608 insertions(+), 34 deletions(-)
> 
