From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/9] lib/string: introduce match_string() helper
Date: Fri,  8 Jan 2016 15:09:09 +0200
Message-ID: <1452258558-119552-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

There are users of a simple string matching in the array. Let's do a common
helper for that.

Several users are updated in the series.

The series is compile tested.

Since v2:
- slightly modify implementation of the helper:
  - rename len -> n in prototype (Sergey)
  - move to for-loop (Rasmus)
  - change 0 -> -1 to iterate over NULL-terminated arrays (Rasmus)
- add patch 9 from Heikki
- append tags

Since v1:
- convert few more users to get helper useful

Andy Shevchenko (8):
  lib/string: introduce match_string() helper
  device property: convert to use match_string() helper
  pinctrl: convert to use match_string() helper
  drm/edid: convert to use match_string() helper
  power: charger_manager: convert to use match_string() helper
  power: ab8500: convert to use match_string() helper
  ata: hpt366: convert to use match_string() helper
  ide: hpt366: convert to use match_string() helper

Heikki Krogerus (1):
  usb: common: convert to use match_string() helper

 drivers/ata/pata_hpt366.c       | 13 +++++--------
 drivers/base/property.c         | 10 ++--------
 drivers/gpu/drm/drm_edid_load.c | 17 ++++++-----------
 drivers/ide/hpt366.c            |  9 ++-------
 drivers/pinctrl/pinmux.c        | 13 +++----------
 drivers/power/ab8500_btemp.c    | 15 +++++----------
 drivers/power/ab8500_charger.c  | 16 +++++-----------
 drivers/power/ab8500_fg.c       | 15 +++++----------
 drivers/power/abx500_chargalg.c | 14 +++++---------
 drivers/power/charger-manager.c | 27 ++++-----------------------
 drivers/usb/common/common.c     | 22 ++++++++--------------
 include/linux/string.h          |  2 ++
 lib/string.c                    | 26 ++++++++++++++++++++++++++
 13 files changed, 78 insertions(+), 121 deletions(-)

-- 
2.6.4
