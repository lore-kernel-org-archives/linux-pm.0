From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv2 0/4] cpufreq-dt, platform_data based proposal
Date: Wed, 10 Sep 2014 14:08:24 +0200
Message-ID: <1410350908-11316-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=GiQHJ5eg=TkYAkzvsn=hTNTjSwmH20vitG2Z42zsoDA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Here is the v2 of the platform_data based proposal to make cpufreq-dt
understand when it has a shared clock by all CPUs vs. independent
clock for each CPU.

Changes since v1:

 - Use a 'void *driver_data' in cpufreq_driver instead of extending
   the existing flags field. Suggested by Viresh.

 - Keep the regulator related warning in cpufreq-dt, but reword it,
   and move it to the dev_dbg() level instead of dev_warn().

Thanks,

Thomas

Thomas Petazzoni (4):
  cpufreq: allow driver-specific data
  cpufreq: cpufreq-dt: extend with platform_data
  ARM: mvebu: use the cpufreq-dt platform_data for independent clocks
  cpufreq: cpufreq-dt: adjust message related to regulators

 arch/arm/mach-mvebu/pmsu.c   |  8 +++++++-
 drivers/cpufreq/cpufreq-dt.c | 21 +++++++++++++++++----
 drivers/cpufreq/cpufreq.c    | 15 +++++++++++++++
 include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
 include/linux/cpufreq.h      |  2 ++
 5 files changed, 63 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/cpufreq-dt.h

-- 
2.0.0
