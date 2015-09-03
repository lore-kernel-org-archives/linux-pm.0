From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3 0/3] cpufreq-dt: add suspend frequency support
Date: Thu, 03 Sep 2015 20:11:29 +0200
Message-ID: <1441303892-32004-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
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

Changes since v2:
- rewrited to use suspend-opp functionality

Changes since v1:
- removed superfluous ";"

Depends on:
- next-20150902 branch of linux-next kernel tree

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  PM / OPP: add dev_pm_opp_get_suspend_opp() helper
  cpufreq-dt: add suspend frequency support
  ARM: dts: add suspend opp to exynos4412

 arch/arm/boot/dts/exynos4412.dtsi |  1 +
 drivers/base/power/opp.c          | 28 ++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c      | 32 ++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h            |  6 ++++++
 4 files changed, 67 insertions(+)

-- 
1.9.1
