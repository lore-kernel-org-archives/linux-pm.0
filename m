From: Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH] cpufreq: powernv: Use node ID in init_chip_info
Date: Wed, 19 Oct 2016 15:02:38 -0700
Message-ID: <CAJoAoZmfxs8wwy1XsfN9qzLyf-ifQK-qPE4jeBhnKKzjoHSXmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38033 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbcJSWCx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Oct 2016 18:02:53 -0400
Received: by mail-it0-f41.google.com with SMTP id 66so47061523itl.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Oct 2016 15:02:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org

Fixed assumption that node_id==chip_id in powernv-cpufreq.c:init_chip_info;
explicitly use node ID where necessary.

Tested: All CPUs report in /sys/devices/system/cpu*/cpufreq/throttle_stats

Effort: platforms/arch-powerpc
Google-Bug-Id: 26979978

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I22eb626b32fbb8053b3bbb9c75e677c700d0c2fb
---
 drivers/cpufreq/powernv-cpufreq.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c
b/drivers/cpufreq/powernv-cpufreq.c
index d3ffde8..3750b58 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -911,32 +911,47 @@ static struct cpufreq_driver powernv_cpufreq_driver = {

 static int init_chip_info(void)
 {
-       unsigned int chip[256];
+       int rc = 0;
        unsigned int cpu, i;
        unsigned int prev_chip_id = UINT_MAX;
+       unsigned int *chip, *node;
+
+       chip = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
+       node = kcalloc(num_possible_cpus(), sizeof(unsigned int), GFP_KERNEL);
+       if (!chip || !node) {
+               rc = -ENOMEM;
+               goto out;
+       }

        for_each_possible_cpu(cpu) {
                unsigned int id = cpu_to_chip_id(cpu);

                if (prev_chip_id != id) {
                        prev_chip_id = id;
-                       chip[nr_chips++] = id;
+                       node[nr_chips] = cpu_to_node(cpu);
+                       chip[nr_chips] = id;
+                       nr_chips++;
                }
        }

        chips = kcalloc(nr_chips, sizeof(struct chip), GFP_KERNEL);
-       if (!chips)
-               return -ENOMEM;
+       if (!chips) {
+               rc = -ENOMEM;
+               goto out;
+       }

        for (i = 0; i < nr_chips; i++) {
                chips[i].id = chip[i];
-               cpumask_copy(&chips[i].mask, cpumask_of_node(chip[i]));
+               cpumask_copy(&chips[i].mask, cpumask_of_node(node[i]));
                INIT_WORK(&chips[i].throttle, powernv_cpufreq_work_fn);
                for_each_cpu(cpu, &chips[i].mask)
                        per_cpu(chip_info, cpu) =  &chips[i];
        }

-       return 0;
+out:
+       kfree(node);
+       kfree(chip);
+       return rc;
 }

 static inline void clean_chip_info(void)
-- 
2.8.0.rc3.226.g39d4020
