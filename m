From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v8 1/6] cpufreq: powernv: Free 'chips' on module exit
Date: Wed,  3 Feb 2016 01:11:37 +0530
Message-ID: <1454442102-1229-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

This will free the dynamically allocated memory of 'chips' on
module exit.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Changes from v7:
- Minor typo fix in the commit message

 drivers/cpufreq/powernv-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 547890f..53f980b 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -612,6 +612,7 @@ static void __exit powernv_cpufreq_exit(void)
 	unregister_reboot_notifier(&powernv_cpufreq_reboot_nb);
 	opal_message_notifier_unregister(OPAL_MSG_OCC,
 					 &powernv_cpufreq_opal_nb);
+	kfree(chips);
 	cpufreq_unregister_driver(&powernv_cpufreq_driver);
 }
 module_exit(powernv_cpufreq_exit);
-- 
1.9.3
