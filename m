From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Subject: [RFC/PATCH v2 0/6] Add CPUIdle support for Renesas SoCs
Date: Thu, 5 Mar 2015 17:58:57 +0900
Message-ID: <1425545943-1440-1-git-send-email-keita.kobayashi.ym@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, badarkhe.manish@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hello

These patches add CPUIdle support for Renesas SoCs. 
These patches have been tested on Renesas Gen2 series with
following cases on renesas-devel-20150301-v4.0-rc1 tag.

[Test case]
   a. Lager board(CA15 * 4)
   b. Lager board(CA7 * 4)
   c. Lager board(CA15 * 4 + CA7 *4)
   d. Koelsch board(CA15 * 2)

These cases work fine.

Changes since v1
- use 'IS_ENABLED' instead of '#ifdef'

Keita Kobayashi (6):
  cpuidle: renesas: Add CPUIdle Driver for Renesas SoCs
  ARM: shmobile: Change CPUIdle InterFace
  ARM: shmobile: APMU: Add Core-Standby function for CPUIdle
  ARM: shmobile: r8a7791: Add Core-Standby CPUIdle support for r8a7791
  ARM: shmobile: r8a7790: Add Core-Standby CPUIdle support for r8a7790
  ARM: shmobile: Enable Renesas CPUIdle for shmobile_defconfig

 arch/arm/configs/shmobile_defconfig           |   2 +
 arch/arm/mach-shmobile/common.h               |  12 ++-
 arch/arm/mach-shmobile/cpuidle.c              |  31 ++++---
 arch/arm/mach-shmobile/platsmp-apmu.c         |  20 ++++-
 arch/arm/mach-shmobile/pm-r8a7790.c           |  47 ++++++++++
 arch/arm/mach-shmobile/pm-r8a7791.c           |  34 ++++++++
 drivers/cpuidle/Kconfig.arm                   |   8 ++
 drivers/cpuidle/Makefile                      |   1 +
 drivers/cpuidle/cpuidle-renesas.c             | 118 ++++++++++++++++++++++++++
 include/linux/platform_data/renesas-cpuidle.h |  24 ++++++
 10 files changed, 283 insertions(+), 14 deletions(-)
 create mode 100644 drivers/cpuidle/cpuidle-renesas.c
 create mode 100644 include/linux/platform_data/renesas-cpuidle.h

-- 
1.9.1

