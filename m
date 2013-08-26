From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [GIT PULL]: CPUFreq: ARM Fixes for 3.12
Date: Mon, 26 Aug 2013 11:48:00 +0530
Message-ID: <CAKohpoksNiGT+r3JTY6KFwnDFA5OYE-vQe8W_9GT-fN21UMrfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joseph Lo <josephl@nvidia.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Stephen Warren <swarren@nvidia.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Hopefully this is the last patch for 3.12 for ARM CPUFreq subsystem.

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-fixes

for you to fetch changes up to b192b910f3832793082c1a18262c4da0efe121ae:

  cpufreq: tegra: fix the wrong clock name (2013-08-23 21:58:28 +0530)

----------------------------------------------------------------
Joseph Lo (1):
      cpufreq: tegra: fix the wrong clock name

 drivers/cpufreq/tegra-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
