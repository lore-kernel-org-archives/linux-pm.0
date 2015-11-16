From: "Zhang, Lin-Bao (Linux Kernel R&D)" <linbao.zhang@hpe.com>
Subject: [PATCH v1 2/2] retry 2 times when getting cpu frequency is zero
Date: Mon, 16 Nov 2015 10:42:52 +0000
Message-ID: <92645B27BF79D04FBD2B0F8494FFD0F9199B5FCA@G2W2527.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55]:47236 "EHLO
	g1t5425.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbbKPKnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 05:43:25 -0500
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


when getting cpu frequency failures, it will retry 2 times at most.

Signed-off-by: Pearson, Greg <greg.pearson@hpe.com>
Signed-off-by: Zhang, Lin-Bao <linbao.zhang@hpe.com>
---
 drivers/cpufreq/pcc-cpufreq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index c8f1616..159dede 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -108,6 +108,7 @@ struct pcc_cpu {
        u32 input_offset;
        u32 output_offset;
        u64 prev_time;
+       u32 get_freq_retry;
 };

 static u32 max_time_between_cmds = 0;
@@ -225,6 +226,17 @@ static unsigned int pcc_get_freq(unsigned int cpu)

        curr_freq = real_pcc_get_freq(cpu);

+       spin_lock(&pcc_lock);
+       if (curr_freq == 0 && pcc_cpu_data->get_freq_retry < 2) {
+               pcc_cpu_data->get_freq_retry++;
+               spin_unlock(&pcc_lock);
+               curr_freq = pcc_get_freq(cpu);
+               return curr_freq;
+       }
+
+       pcc_cpu_data->get_freq_retry = 0;
+       spin_unlock(&pcc_lock);
+
        return curr_freq;
 }

--
1.8.5.2
