From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 0/3] Fixes for twl4030 charger
Date: Fri, 14 Apr 2017 20:25:54 +0200
Message-ID: <cover.1492194356.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

Changes V3:
* worked in comments by Sebsatian Reichel
* clarifications of some commit messages
* rebased on v4.11rc-6

It took a while (18 months) until we propose an updated patch for upstream...

2015-11-02 12:27:39: Changes V2:
* worked in comments by Nishanth Menon <nm@ti.com>
* added another patch which solves a probing/boot stall problem (irq allocation vs. -EPROBE_DEFER)

V1:
4.3-rc1 introduced a new charger driver for the twl4030. This patch set fixes some
issues.

While making twl4030 changes from 4.3 operable we have found some issues
during testing on GTA04 and OpenPandora.

H. Nikolaus Schaller (3):
  drivers:power:twl4030-charger: don't check if battery is present
  drivers:power:twl4030-charger: add INPUT_CURRENT_LIMIT property and
    make it writeable
  drivers:power:twl4030-charger: remove nonstandard max_current sysfs
    attribute

 drivers/power/supply/twl4030_charger.c | 158 ++++++++++++---------------------
 1 file changed, 59 insertions(+), 99 deletions(-)

-- 
2.7.3
