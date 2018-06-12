From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.18-rc1 #1
Date: Wed, 13 Jun 2018 00:14:58 +0800
Message-ID: <1528820098.2661.28.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.18-rc1 with
top-most commit e9ed3ee61aa62ce280aadeeea1ec959f0c66a290:

  Merge branches 'thermal-core' and 'thermal-intel' into next (2018-05-30 14:54:20 +0800)

on top of commit 771c577c23bac90597c685971d7297ea00f99d11:

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

Specifics:

- convert thermal sysfs attributes to use DEVICE_ATTR_{RO|RW|WO}() variants (Viresh Kumar).

- update license to SPDX format (Lina Iyer).

- add GeminiLake support for int340x processor_thermal driver (Sumeet Pawnikar).

- Prevent error in reading trip hysteresis attribute for int340x thermal driver (Srinivas Pandruvada).

I merged the thermal-soc changes from Eduardo some days ago, but without any merge message in the changelog. And I realize this is wrong after reading the discussion for the libnvdimm pull request. So, to avoid a pretty new merge commit in my pull request, I decided to send the pull requests separately this time, one for thermal core and intel thermal driver changes, and another for the other thermal soc driver changes.

BTW, for the top-most merge commit in this pull request, thermal-core and thermal-intel are not strictly topic branches, they are just collections of small patches, for thermal core framework and for Intel platform specific thermal drivers. Are you suggesting I should append the detailed specifics (like above) into the merge message as well?

thanks,
rui

----------------------------------------------------------------
Lina Iyer (1):
      drivers: thermal: Update license to SPDX format

Srinivas Pandruvada (1):
      thermal: int340x: Prevent error in reading trip hysteresis
attribute

Sumeet Pawnikar (1):
      thermal: int340x: processor_thermal: Add GeminiLake support

Viresh Kumar (2):
      thermal: Shorten name of sysfs callbacks
      thermal: Use DEVICE_ATTR_{RO|RW|WO}() variants

Zhang Rui (1):
      Merge branches 'thermal-core' and 'thermal-intel' into next

 .../thermal/int340x_thermal/int340x_thermal_zone.c |  6 +-
 .../int340x_thermal/processor_thermal_device.c     |  4 ++
 drivers/thermal/of-thermal.c                       | 19 +----
 drivers/thermal/thermal_core.c                     | 11 ++-
 drivers/thermal/thermal_core.h                     | 30 ++------
 drivers/thermal/thermal_helpers.c                  |  5 +-
 drivers/thermal/thermal_hwmon.c                    | 17 +----
 drivers/thermal/thermal_hwmon.h                    | 17 +----
 drivers/thermal/thermal_sysfs.c                    | 81 ++++++++----
----------
 include/linux/thermal.h                            | 17 +----
 10 files changed, 50 insertions(+), 157 deletions(-)
