From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 0/9] lib/string: introduce match_string() helper
Date: Thu, 28 Jan 2016 15:14:16 +0200
Message-ID: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3144 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877AbcA1NOe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Jan 2016 08:14:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There are users of a simple string matching in the array. Let's do a common
helper for that.

Several users are updated in the series.

The series is compile tested.

There is still a question what function should return. There are variants:
-1, -EINVAL, -ENODATA, something else?

Since v3:
- rebase on top of latest linux-next
- add Rafael's Ack

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
2.7.0.rc3

