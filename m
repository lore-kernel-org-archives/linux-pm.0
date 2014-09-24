From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH 0/3] thermal: fix: Various fixes for thermal subsystem
Date: Wed, 24 Sep 2014 10:27:09 +0200
Message-ID: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>
List-Id: linux-pm@vger.kernel.org

This little patch series comprises fixes for step_wise governor and
thermal core.

Lukasz Majewski (3):
  thermal: step_wise: fix: Prevent from binary overflow when trend is
    dropping
  thermal: core: fix: Initialize the max_state variable to 0
  thermal: core: fix: Check return code of the ->get_max_state()
    callback

 drivers/thermal/step_wise.c    | 2 +-
 drivers/thermal/thermal_core.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.0.0.rc2
