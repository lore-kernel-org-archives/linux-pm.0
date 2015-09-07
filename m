From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 0/4] cpufreq-dt: add suspend frequency support
Date: Mon, 07 Sep 2015 17:41:37 +0200
Message-ID: <1441640501-13613-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, Michael Turquette <mturquette@baylibre.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

Hi,

This patch series adds suspend frequency support (using opp-v2
bindings and suspend-opp functionality) to cpufreq-dt driver and
then adds suspend opp for Exynos4412 based boards.

This patch series fixes suspend/resume support on Exynos4412
based Trats2 board and reboot hang on Exynos4412 based Odroid
U3 board.

Changes since v3:
- fixed dev_pm_opp_get_suspend_opp() locking
- shortened variable name in dev_pm_opp_get_suspend_opp()
- adjusted cpufreq_generic_suspend() to work with cpufreq-dt
- removed no longer needed cpufreq_dt_suspend()
- added Acked-by tag from Viresh to patch #4

Changes since v2:
- rewrote to use suspend-opp functionality

Changes since v1:
- removed superfluous ";"

Depends on:
- next-20150902 branch of linux-next kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (4):
  PM / OPP: add dev_pm_opp_get_suspend_opp() helper
  cpufreq: allow cpufreq_generic_suspend() to work without suspend
    frequency
  cpufreq-dt: add suspend frequency support
  ARM: dts: add suspend opp to exynos4412

 arch/arm/boot/dts/exynos4412.dtsi |  1 +
 drivers/base/power/opp.c          | 30 ++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c      | 11 +++++++++++
 drivers/cpufreq/cpufreq.c         |  4 ++--
 include/linux/pm_opp.h            |  6 ++++++
 5 files changed, 50 insertions(+), 2 deletions(-)

-- 
1.9.1

