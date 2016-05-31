From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 00/15] thermal: sysfs: add locking
Date: Mon, 30 May 2016 23:31:21 -0700
Message-ID: <1464676296-5610-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Several thermal sysfs entries are currently being called
from userspace without locking. Data and calls to ops
are accessed deliberated without any care for locking.

This patch series attempts to fix this.

Now that sysfs handlers are on the same place it is easier
to visualize this issue and fix it. The strategy is essentially
to lock any access. Also, functions in thermal core and thermal
helpers are assumed to do the proper locking already.

This patch series is based on the thermal core reorganization.

There is no change in the ABI to userspace. The difference
is that now serialization to data will be done.

For your consideration, I am also adding this to this branch:
  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal sysfs_locking

Comments are welcome.

BR,

Eduardo Valentin (15):
  thermal: sysfs: lock tz in type_show
  thermal: sysfs: lock tz while on access to mode properties
  thermal: sysfs: lock tz while on trip_point_type properties
  thermal: sysfs: lock tz while on trip_point_temp properties
  thermal: sysfs: lock tz while on trip_point_hyst properties
  thermal: sysfs: lock tz while on passive properties
  thermal: sysfs: lock tz while on policy properties
  thermal: sysfs: improve locking of emul_temp_store()
  thermal: sysfs: lock tz when access sustainable power properties
  thermal: sysfs: lock tz when access tzp properties
  thermal: sysfs: lock cdev while accessing type
  thermal: sysfs: lock cdev while accessing max_state
  thermal: sysfs: lock cdev while accessing cur_state
  thermal: sysfs: serialize access to instances
  thermal: sysfs: add comments describing locking strategy

 drivers/thermal/thermal_sysfs.c | 133 ++++++++++++++++++++++++++++++++++------
 include/linux/thermal.h         |   2 +-
 2 files changed, 115 insertions(+), 20 deletions(-)

-- 
2.1.4
