From: Prateek Sood <prsood@codeaurora.org>
Subject: Query related to usage of cpufreq_suspend() & cpufreq_resume
Date: Fri, 2 Feb 2018 17:11:58 +0530
Message-ID: <e9d13871-184b-dee3-c45f-c6d19e671eea@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gkohli@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

One scenario is there where a kernel panic is observed in
cpufreq during suspend/resume.

pm_suspend()
  suspend_devices_and_enter()
    dpm_suspend_start()
      dpm_prepare() 

Failure in dpm_prepare() happend with following dmesg:

[ 3746.316062] PM: Device xyz not prepared for power transition: code -16
[ 3746.316071] PM: Some devices failed to suspend, or early wake event detected


pm_suspend()
  suspend_devices_and_enter()
    dpm_suspend_start()
      dpm_prepare() //failed
    dpm_resume_end()
      dpm_resume()
        cpufreq_resume()
          cpufreq_start_governor()
            sugov_start()
              cpufreq_add_update_util_hook()

After failure in dpm_prepare(), dpm_resume() called
cpufreq_resume(). Corresponding cpufreq_suspend() was not
called due to failure of dpm_prepare(). 

This resulted in WARN_ON(per_cpu(cpufreq_update_util_data, cpu))
in cpufreq_add_update_util_hook() and cpufreq_add_update_util_hook->func
being inconsistent state. It caused crash in scheduler.

Following are some of the ways to mitigate this issue. Could
you please provide feedback on below two approaches or suugest
a better way to fix this problem.

-----------------------8<------------------------------

Co-developed-by: Gaurav Kohli <gkohli@codeaurora.org>
Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org> 
Signed-off-by: Prateek Sood <prsood@codeaurora.org>

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 02a497e..732e5a2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1038,6 +1038,7 @@ void dpm_resume(pm_message_t state)
 {
        struct device *dev;
        ktime_t starttime = ktime_get();
+       bool valid_resume = false;

        trace_suspend_resume(TPS("dpm_resume"), state.event, true);
        might_sleep();
@@ -1055,6 +1056,7 @@ void dpm_resume(pm_message_t state)
        }

        while (!list_empty(&dpm_suspended_list)) {
+               valid_resume = true;
                dev = to_device(dpm_suspended_list.next);
                get_device(dev);
                if (!is_async(dev)) {
@@ -1080,7 +1082,8 @@ void dpm_resume(pm_message_t state)
        async_synchronize_full();
        dpm_show_time(starttime, state, 0, NULL);

-       cpufreq_resume();
+       if (valid_resume)
+               cpufreq_resume();
        trace_suspend_resume(TPS("dpm_resume"), state.event, false);
 }

--------------------8<--------------------------------------

Signed-off-by: Prateek Sood <prsood@codeaurora.org>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 421f318..439eab8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1648,7 +1648,7 @@ void cpufreq_suspend(void)
 {
        struct cpufreq_policy *policy;

-       if (!cpufreq_driver)
+       if (!cpufreq_driver || cpufreq_suspended)
                return;

        if (!has_target() && !cpufreq_driver->suspend)
@@ -1683,7 +1683,7 @@ void cpufreq_resume(void)
        struct cpufreq_policy *policy;
        int ret;

-       if (!cpufreq_driver)
+       if (!cpufreq_driver || !cpufreq_suspended)
                return;

        cpufreq_suspended = false;




Thanks

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
