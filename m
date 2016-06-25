From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] cpufreq: Avoid warning during resume by return EAGAIN if cpufreq is unavailable
Date: Sun, 26 Jun 2016 00:28:48 +0800
Message-ID: <1466872128-14566-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

Previously we saw warning during resume on some platforms,
which use acpi-cpufreq:

smpboot: Booting Node 0 Processor 3 APIC 0x5
cache: parent cpu3 should not be sleeping
CPU3 is up
ACPI: Waking up from system sleep state S3
WARNING: CPU: 0 PID: 12546 at drivers/cpufreq/cpufreq.c:2173
Call Trace:
[<ffffffff81311d95>] dump_stack+0x5c/0x77
[<ffffffff8107aef4>] __warn+0xc4/0xe0
[<ffffffff8148c13e>] cpufreq_update_policy+0xfe/0x150
[<ffffffff8148c190>] cpufreq_update_policy+0x150/0x150
[<ffffffffc03e42ef>] acpi_processor_notify+0x51/0xdc [processor]
[<ffffffff813b0d24>] acpi_ev_notify_dispatch+0x3c/0x55
[<ffffffff81399613>] acpi_os_execute_deferred+0x10/0x1a
[<ffffffff81093ffb>] process_one_work+0x14b/0x400
[<ffffffff81094aa5>] worker_thread+0x65/0x4a0
[<ffffffff81094a40>] rescuer_thread+0x340/0x340
[<ffffffff81099dbf>] kthread+0xdf/0x100
[<ffffffff815c7ee2>] ret_from_fork+0x22/0x40
[<ffffffff81099ce0>] kthread_park+0x50/0x50

This is because this platforms tries to notify
the processor to reevaluate the _PPC object in _WAK,
however at that time the cpufreq driver's resume has
not been invoked yet, thus cpufreq_update_current_freq
returns zero because of cpufreq_suspended = true, which
caused the warning.

Actually it should be unnecessary to care the update request
at that moment, so remove the warning and change the return
value to -EAGAIN for invokers.

Reported-and-tested-by: BzukTuk <darlor@seznam.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9009295..67a3aa1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2262,8 +2262,11 @@ int cpufreq_update_policy(unsigned int cpu)
 	 */
 	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
 		new_policy.cur = cpufreq_update_current_freq(policy);
-		if (WARN_ON(!new_policy.cur)) {
-			ret = -EIO;
+		if (!new_policy.cur) {
+			if (WARN_ON(!cpufreq_suspended))
+				ret = -EIO;
+			else
+				ret = -EAGAIN;
 			goto unlock;
 		}
 	}
-- 
2.7.4

