From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 0/2] cpufreq: exynos: Fixes for v3.12
Date: Wed, 25 Sep 2013 13:22:16 +0200
Message-ID: <1380108138-30402-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Attached commits provide cpufreq regression fixes for Trats and Trats2
Exynos4 boards.
Since v3.12 Exynos4 uses common clock framework for clock manipulation.
Those patches restore correct output for cpuinfo_cur_freq [1] sysfs
attribute.
Without them, the [1] provides default frequency (800 MHz) set at driver
initialization.

Lukasz Majewski (2):
  cpufreq: exynos4x12: Use the common clock framework to set APLL clock
    rate
  cpufreq: exynos4210: Use the common clock framework to set APLL clock
    rate

 drivers/cpufreq/exynos4210-cpufreq.c |   20 ++++----------------
 drivers/cpufreq/exynos4x12-cpufreq.c |   23 ++++-------------------
 2 files changed, 8 insertions(+), 35 deletions(-)

-- 
1.7.10.4
