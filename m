From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH] devfreq: simple_ondemand: Update devfreq stats when governor started
Date: Tue, 18 Jul 2017 18:02:51 +0800
Message-ID: <1500372171-7194-1-git-send-email-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rui.zhang@intel.com, briannorris@chromium.org, javi.merino@kernel.org, dianders@chromium.org, lukasz.luba@arm.com, Jeffy Chen <jeffy.chen@rock-chips.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If governor suspends soon after started, it may not have the chance to
update devfreq stats, which leaves devfreq stats' current frequence be
zero.

So when the thermal core tries to throttle the power, it would failed
to get the correct static power of current frequence and print these
warnings:
[    2.024735] core: dev_pm_opp_get_voltage: Invalid parameters
[    2.024743] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
-34
...
[    2.026320] core: dev_pm_opp_get_voltage: Invalid parameters
[    2.026327] mali ff9a0000.gpu: Failed to get voltage for frequency 0:
-34

Update devfreq stats when governor started to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/devfreq/governor_simpleondemand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index ae72ba5..26e0e58 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -98,6 +98,7 @@ static int devfreq_simple_ondemand_handler(struct devfreq *devfreq,
 {
 	switch (event) {
 	case DEVFREQ_GOV_START:
+		devfreq_update_stats(devfreq);
 		devfreq_monitor_start(devfreq);
 		break;
 
-- 
2.1.4
