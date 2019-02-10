From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management fixes for v5.0-rc6
Date: Sat, 9 Feb 2019 20:17:23 -0800
Message-ID: <20190210041721.GA2805@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

to receive Thermal-SoC Management fixes for v5.0-rc6 with top-most

bf78f133cd39e0ed41551150909e41513958a738:

  thermal: cpu_cooling: Clarify error message (2019-02-05 15:50:13 -0800)

on top of commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

Specifics:
- Minor fixes on of-thermal and cpu cooling.

BR,
Eduardo

----------------------------------------------------------------
Amit Kucheria (2):
      thermal: of-thermal: Print name of device node with error
      thermal: cpu_cooling: Clarify error message

 drivers/thermal/cpu_cooling.c | 2 +-
 drivers/thermal/of-thermal.c  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
