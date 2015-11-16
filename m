From: "Zhang, Lin-Bao (Linux Kernel R&D)" <linbao.zhang@hpe.com>
Subject: [PATCH v1 1/2] enforce max/min time between commands
Date: Mon, 16 Nov 2015 10:37:16 +0000
Message-ID: <92645B27BF79D04FBD2B0F8494FFD0F9199B5FB9@G2W2527.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:39155 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbbKPKhg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:37:36 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


In Processor Clocking Control specification v1.0 ,there are 2 definitions:
2.1.8 Minimum Time Between Commands
2.1.9 Maximum Time Between Commands
that means 2 commands' interval should be located between Minimum Time Between Commands and Maximum Time Between Commands.

3.1 Get Average Frequency
The Get Average Frequency command is used by the Operating System to query the running frequency of the processor since the last time this command was last completed.

This patch implements this feature, while old pcc-cpufreq.c didn't follow the rule.
Especially ,at boot time there will be no "last time" and BIOS can return out bounds frequencies including the value zero. 
In booting kernel case, we would run querying again as PCC spec.
In normal case, we also need to make sure these 2 commands interval is larger than Minimum Time Between Commands, and also smaller than the max time, although perhaps that is more rare.


Signed-off-by: Pearson, Greg <greg.pearson@hpe.com>
Signed-off-by: Zhang, Lin-Bao <linbao.zhang@hpe.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 2a0d589..c8f1616 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -29,6 +29,8 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <linux/cpufreq.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
 #include <linux/compiler.h>
 #include <linux/slab.h>

@@ -105,8 +107,12 @@ static u8 OSC_UUID[16] = {0x9F, 0x2C, 0x9B, 0x63, 0x91, 0x70, 0x1f, 0x49,
 struct pcc_cpu {
        u32 input_offset;
        u32 output_offset;
+       u64 prev_time;
 };

+static u32 max_time_between_cmds = 0;
+static u32 min_time_between_cmds = 0;
+
 static struct pcc_cpu __percpu *pcc_cpu_info;

 static int pcc_cpufreq_verify(struct cpufreq_policy *policy)
@@ -137,7 +143,7 @@ static inline void pcc_clear_mapping(void)
        pcch_virt_addr = NULL;
 }

-static unsigned int pcc_get_freq(unsigned int cpu)
+static unsigned int real_pcc_get_freq(unsigned int cpu)
 {
        struct pcc_cpu *pcc_cpu_data;
        unsigned int curr_freq;
@@ -185,6 +191,8 @@ static unsigned int pcc_get_freq(unsigned int cpu)
                        " capped at %d\n", cpu, curr_freq);
        }

+       pcc_cpu_data->prev_time = get_jiffies_64();
+
        spin_unlock(&pcc_lock);
        return curr_freq;

@@ -194,6 +202,32 @@ cmd_incomplete:
        return 0;
 }

+static unsigned int pcc_get_freq(unsigned int cpu)
+{
+       struct pcc_cpu *pcc_cpu_data;
+       unsigned int curr_freq;
+       u64 cur_time;
+       u32 diff_time;
+
+       pcc_cpu_data = per_cpu_ptr(pcc_cpu_info, cpu);
+       cur_time = get_jiffies_64();
+       diff_time = jiffies_to_usecs(cur_time - pcc_cpu_data->prev_time);
+
+       if (diff_time > max_time_between_cmds) {
+               curr_freq = real_pcc_get_freq(cpu);
+               cur_time = get_jiffies_64();
+               diff_time =
+                       jiffies_to_usecs(cur_time - pcc_cpu_data->prev_time);
+       }
+
+       if (diff_time < min_time_between_cmds)
+               msleep((min_time_between_cmds - diff_time) / 1000);
+
+       curr_freq = real_pcc_get_freq(cpu);
+
+       return curr_freq;
+}
+
 static int pcc_cpufreq_target(struct cpufreq_policy *policy,
                              unsigned int target_freq,
                              unsigned int relation)
@@ -521,6 +555,9 @@ static int __init pcc_cpufreq_probe(void)
                goto pcch_free;
        }

+       max_time_between_cmds = ioread32(&pcch_hdr->maximum_time);
+       min_time_between_cmds = ioread32(&pcch_hdr->minimum_time);
+
        printk(KERN_DEBUG "pcc-cpufreq: (v%s) driver loaded with frequency"
               " limits: %d MHz, %d MHz\n", PCC_VERSION,
               ioread32(&pcch_hdr->minimum_frequency),
--
1.8.5.2

