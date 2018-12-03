From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 4/5] drivers: power: suspend: call devfreq suspend/resume
Date: Mon,  3 Dec 2018 15:31:14 +0100
Message-ID: <1543847475-7600-5-git-send-email-l.luba@partner.samsung.com>
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143134eucas1p1edd70b0f4dca115f6f154555d8829427@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org, anton@enomsg.org, ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org, krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Devfreq framework supports suspend of its devices.
Call the the devfreq interface and allow devfreq devices preserve/restore
their states during suspend/resume.

The patch is based on earlier work by Tobias Jakobi.

Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 drivers/base/power/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index a690fd4..0992e67 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -32,6 +32,7 @@
 #include <trace/events/power.h>
 #include <linux/cpufreq.h>
 #include <linux/cpuidle.h>
+#include <linux/devfreq.h>
 #include <linux/timer.h>
 
 #include "../base.h"
@@ -1078,6 +1079,7 @@ void dpm_resume(pm_message_t state)
 	dpm_show_time(starttime, state, 0, NULL);
 
 	cpufreq_resume();
+	devfreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
@@ -1852,6 +1854,7 @@ int dpm_suspend(pm_message_t state)
 	trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
 	might_sleep();
 
+	devfreq_suspend();
 	cpufreq_suspend();
 
 	mutex_lock(&dpm_list_mtx);
-- 
2.7.4
