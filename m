From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 00/10] i2c: move handling of suspended adapters to the core
Date: Wed, 19 Dec 2018 17:48:16 +0100
Message-ID: <20181219164827.20985-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Finally, here is the implementation Hans and I agreed on. Plus, all potential
users I could spot already converted. Renesas R-Car driver was added on top.
This series was tested on a Renesas Lager board (R-Car H2). I had to hack some
error cases into the code to verify the workings. Thanks for all the tests so
far. Of course, more testing never hurts ;)

Please comment, review, test... a branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/core-pm-helpers

Thanks,

   Wolfram

Changes since RFC:

* don't use bitfields anymore but an unsigned long flags variable which is only
  meant for flags to be changed when the adapter lock is held

* split the genereic accessor into _mark_suspended() and _mark_resumed()

* added kerneldoc and noted that using these helpers is optional

* documented -ESHUTDOWN as the error code when trying to transfer using an
  already suspended adapter

* added acks from last series. Changes were minor enough to keep them. Please let
  me know if you disagree.


Wolfram Sang (10):
  i2c: add suspended flag and accessors for i2c adapters
  i2c: reject new transfers when adapters are suspended
  i2c: synquacer: remove unused is_suspended flag
  i2c: brcmstb: use core helper to mark adapter suspended
  i2c: zx2967: use core helper to mark adapter suspended
  i2c: sprd: don't use pdev as variable name for struct device *
  i2c: sprd: use core helper to mark adapter suspended
  i2c: exynos5: use core helper to mark adapter suspended
  i2c: s3c2410: use core helper to mark adapter suspended
  i2c: rcar: add suspend/resume support

 Documentation/i2c/fault-codes      |  4 ++++
 drivers/i2c/busses/i2c-brcmstb.c   | 13 ++-----------
 drivers/i2c/busses/i2c-exynos5.c   | 11 ++---------
 drivers/i2c/busses/i2c-rcar.c      | 25 +++++++++++++++++++++++++
 drivers/i2c/busses/i2c-s3c2410.c   |  8 ++------
 drivers/i2c/busses/i2c-sprd.c      | 34 ++++++++++++----------------------
 drivers/i2c/busses/i2c-synquacer.c |  5 -----
 drivers/i2c/busses/i2c-zx2967.c    |  8 ++------
 drivers/i2c/i2c-core-base.c        |  3 +++
 include/linux/i2c.h                | 34 ++++++++++++++++++++++++++++++++++
 10 files changed, 86 insertions(+), 59 deletions(-)

-- 
2.11.0
