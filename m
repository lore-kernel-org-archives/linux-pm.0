From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Subject: [PATCH 0/8] Remove deprecated workqueue interface users
Date: Sat, 13 Aug 2016 21:41:21 +0530
Message-ID: <cover.1471104124.git.bhaktipriya96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch set removes the instances of deprecated
create_singlethread_workqueues in drivers/power by making the appropriate
conversions.

Bhaktipriya Shridhar (8):
  power: abx500_chargalg: Remove deprecated create_singlethread_workqueue
  power: ab8500_btemp: Remove deprecated create_singlethread_workqueue
  power: pm2301_charger: Remove deprecated create_singlethread_workqueue
  power: intel_mid_battery: Remove deprecated create_singlethread_workqueue
  power: ab8500_charger: Remove deprecated create_singlethread_workqueue
  power: ipaq_micro_battery: Remove deprecated create_singlethread_workqueue
  power: ab8500_fg: Remove deprecated create_singlethread_workqueue
  power: ds2760_battery: Remove deprecated create_singlethread_workqueue

 drivers/power/ab8500_btemp.c       | 2 +-
 drivers/power/ab8500_charger.c     | 4 ++--
 drivers/power/ab8500_fg.c          | 2 +-
 drivers/power/abx500_chargalg.c    | 4 ++--
 drivers/power/ds2760_battery.c     | 3 ++-
 drivers/power/intel_mid_battery.c  | 3 +--
 drivers/power/ipaq_micro_battery.c | 2 +-
 drivers/power/pm2301_charger.c     | 3 ++-
 8 files changed, 12 insertions(+), 11 deletions(-)

--
2.1.4
