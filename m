From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH v3 0/3] cpufreq: cpufreq-dt: platform_data based proposal
Date: Sun, 19 Oct 2014 11:30:26 +0200
Message-ID: <1413711029-17419-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Sachin Kamat <spk.linux@gmail.com>, Thomas Abraham <thomas.ab@samsung.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "pramod.gurav@smartplayin.com" <pramod.gurav@smartplayin.com>, Rob Herring <rob.herring@linaro.org>, Mike Turquette <mike.turquette@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
List-Id: linux-pm@vger.kernel.org

Hello Rafael,

As you requested, here is a new version of the cpufreq-dt patches,
rebased on top of the latest Linus tree
(52d589a01d4545ce1dc5c3892bb8c7b55edfe714 as I write this).

Compared to version 2:

 - Rebased on top of latest Linus tree.

 - Removed PATCH 3/4, which is meant to go through the mvebu
   maintainer tree. I'll push it post-rc1.

 - Added Acked-by tags from Viresh, since he ACKed all the patches.

Could you take those patches and push them to 3.18 ?

Thanks a lot,

Thomas

Thomas Petazzoni (3):
  cpufreq: allow driver-specific data
  cpufreq: cpufreq-dt: extend with platform_data
  cpufreq: cpufreq-dt: adjust message related to regulators

 drivers/cpufreq/cpufreq-dt.c | 21 +++++++++++++++++----
 drivers/cpufreq/cpufreq.c    | 15 +++++++++++++++
 include/linux/cpufreq-dt.h   | 22 ++++++++++++++++++++++
 include/linux/cpufreq.h      |  2 ++
 4 files changed, 56 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/cpufreq-dt.h

-- 
2.0.0
