From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: [RFC PATCH V2] power: supply: Use system freezable queue for power
 supply change event
Date: Fri, 29 Sep 2017 10:36:44 +0200
Message-ID: <20170929083642.GA20189@panicking>
References: <1506583986-4527-1-git-send-email-michael@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:43710 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbdI2Igs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Sep 2017 04:36:48 -0400
Received: by mail-wm0-f44.google.com with SMTP id m72so4340744wmc.0
        for <linux-pm@vger.kernel.org>; Fri, 29 Sep 2017 01:36:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1506583986-4527-1-git-send-email-michael@amarulasolutions.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org

Just before suspend we can get the situation that a user process
is trying to access the sysfs attribute of power supply. During resume
we can hit the situation to have an invalid access to i2c bus that
is still suspended. Make more sense to freeze the workqueue too

<4>[13502.656095] [<c0419264>] (sbs_read_word_data+0x0/0x70) from
[<c04192f8>] (sbs_set_battery_mode+0x24/0x6c)
<4>[13502.656095]  r6:d79b0800 r5:d7123408 r4:00000001 r3:c04194ac
<4>[13502.656125] [<c04192d4>] (sbs_set_battery_mode+0x0/0x6c) from
[<c041962c>] (sbs_get_property+0x180/0x6e4)
<4>[13502.656125]  r6:0000001b r5:d7123408 r4:d79b0800 r3:c04194ac
<4>[13502.656156] [<c04194ac>] (sbs_get_property+0x0/0x6e4) from
[<c0417e2c>] (power_supply_show_property+0x4c/0x1c8)
<4>[13502.656186] [<c0417de0>] (power_supply_show_property+0x0/0x1c8)
from [<c0418098>] (power_supply_uevent+0xa8/0x1d4)
<4>[13502.656186]  r8:ca4b1000 r7:0000001b r6:d7123408 r5:0000000e r4:c068d3dc
<4>[13502.656217] [<c0417ff0>] (power_supply_uevent+0x0/0x1d4) from
[<c0324f58>] (dev_uevent+0xc8/0x18c)
<4>[13502.656247] [<c0324e90>] (dev_uevent+0x0/0x18c) from
[<c025ce18>] (kobject_uevent_env+0x1d4/0x4c4)
<4>[13502.656247]  r7:d7882880 r6:00000000 r5:c069cda4 r4:00000002
<4>[13502.656278] [<c025cc44>] (kobject_uevent_env+0x0/0x4c4) from
[<c025d11c>] (kobject_uevent+0x14/0x18)
<4>[13502.656308] [<c025d108>] (kobject_uevent+0x0/0x18) from
[<c04178d0>] (power_supply_changed_work+0x94/0xb8)
<4>[13502.656308] [<c041783c>] (power_supply_changed_work+0x0/0xb8)
from [<c00603e8>] (process_one_work+0x158/0x474)
<4>[13502.656339]  r7:c1ae9e00 r6:c1ae4880 r5:cc480000 r4:ce655e00
<4>[13502.656369] [<c0060290>] (process_one_work+0x0/0x474) from
[<c0060a50>] (worker_thread+0x144/0x324)
<4>[13502.656369] [<c006090c>] (worker_thread+0x0/0x324) from
[<c00655c4>] (kthread+0x98/0xa4)
<4>[13502.656400] [<c006552c>] (kthread+0x0/0xa4) from [<c0047b6c>]
(do_exit+0x0/0x7c4)

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
Changes V1:
- fix typo in the code
- Add more information in the description

---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 1e0960b..aa70853 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -119,7 +119,7 @@ void power_supply_changed(struct power_supply *psy)
 	psy->changed = true;
 	pm_stay_awake(&psy->dev);
 	spin_unlock_irqrestore(&psy->changed_lock, flags);
-	schedule_work(&psy->changed_work);
+	queue_work(system_freezable_wq, &psy->changed_work);
 }
 EXPORT_SYMBOL_GPL(power_supply_changed);
 
-- 
2.7.4
