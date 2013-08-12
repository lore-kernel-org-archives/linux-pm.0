From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL]: CPUFreq: ARM Fixes for 3.12
Date: Mon, 12 Aug 2013 12:03:39 +0530
Message-ID: <CAKohponyLTUn_Sonstw_oOLZ+S+x9e3UH0JaZbkLaQfX-9zmWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, linux-arm-kernel@lists.infradead.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-fixes

for you to fetch changes up to 45e12086263a53f16b489fc7f4f8f6348a688661:

  cpufreq: fix EXYNOS drivers selection (2013-08-12 12:00:21 +0530)

----------------------------------------------------------------
Amit Daniel Kachhap (1):
      cpufreq: exynos5440: Fix to skip when new frequency same as current

Bartlomiej Zolnierkiewicz (1):
      cpufreq: fix EXYNOS drivers selection

 drivers/cpufreq/Kconfig.arm          | 36 ++++++++++++++++++++++++------------
 drivers/cpufreq/exynos-cpufreq.c     |  1 -
 drivers/cpufreq/exynos-cpufreq.h     | 21 +++++++++++++++++++++
 drivers/cpufreq/exynos5440-cpufreq.c |  3 +++
 4 files changed, 48 insertions(+), 13 deletions(-)

--
viresh
