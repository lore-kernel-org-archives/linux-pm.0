From: Bo Yan <byan@nvidia.com>
Subject: [PATCH v2] cpufreq: skip cpufreq resume if it's not suspended
Date: Thu, 25 Jan 2018 11:15:45 -0800
Message-ID: <1516907745-13508-1-git-send-email-byan@nvidia.com>
References: <1744712.rO4QOLozun@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17444 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeAYTPu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jan 2018 14:15:50 -0500
In-Reply-To: <1744712.rO4QOLozun@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Bo Yan <byan@nvidia.com>

cpufreq_resume can be called even without preceding cpufreq_suspend.
This can happen in following scenario:

    suspend_devices_and_enter
       --> dpm_suspend_start
          --> dpm_prepare
              --> device_prepare : this function errors out
          --> dpm_suspend: this is skipped due to dpm_prepare failure
                           this means cpufreq_suspend is skipped over
       --> goto Recover_platform, due to previous error
       --> goto Resume_devices
       --> dpm_resume_end
           --> dpm_resume
               --> cpufreq_resume

In case schedutil is used as frequency governor, cpufreq_resume will
eventually call sugov_start, which does following:

    memset(sg_cpu, 0, sizeof(*sg_cpu));
    ....

This effectively erases function pointer for frequency update, causing
crash later on. The function pointer would have been set correctly if
subsequent cpufreq_add_update_util_hook runs successfully, but that
function returns earlier because cpufreq_suspend was not called:

    if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
		return;

Ideally, suspend should succeed, then things will be fine. But even
in case of suspend failure, system should not crash.

The fix is to check the pm_transition status in dpm_resume. if
pm_transition.event == PMSG_ON, we know for sure dpm_suspend has not
been called, so do not call cpufreq_resume.

Signed-off-by: Bo Yan <byan@nvidia.com>
---
 drivers/base/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 08744b572af6..39829d7a9311 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -921,6 +921,7 @@ static void async_resume(void *data, async_cookie_t cookie)
 void dpm_resume(pm_message_t state)
 {
 	struct device *dev;
+	bool suspended = (pm_transition.event != PM_EVENT_ON);
 	ktime_t starttime = ktime_get();
 
 	trace_suspend_resume(TPS("dpm_resume"), state.event, true);
@@ -964,7 +965,8 @@ void dpm_resume(pm_message_t state)
 	async_synchronize_full();
 	dpm_show_time(starttime, state, 0, NULL);
 
-	cpufreq_resume();
+	if (likely(suspended))
+		cpufreq_resume();
 	trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }
 
-- 
2.7.4
