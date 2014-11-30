From: Wang Weidong <wangweidong1@huawei.com>
Subject: [PATCH v2] acpi-cpufreq: make the freq_table store the same freq
 value
Date: Sun, 30 Nov 2014 18:17:24 +0800
Message-ID: <547AEEB4.2020803@huawei.com>
References: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:31985 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbaK3KRh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 30 Nov 2014 05:17:37 -0500
In-Reply-To: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wang Weidong <wangweidong1@huawei.com>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com

ACPI's P-states will report the acpi_processor_px *states to acpi-cpufreq.
When the states likes these:

[index:freq, 0:2400 1:2400 2:2000 3:1600...],

we will initialize the freq_tables to those:

[index:driver_data:freq, 0:0:2400, 1:2:2000 2:3,1600 ... CPUFREQ_TABLE_END]

So when set the freqs to 2000, the data->acpi_data->state is 2
(data->freq_table[1].driver_data), So when call get_cur_freq_on_cpu, we get
the freqs is data->freq_table[2].frequency,the value is 1600.

we can make the freq_table store the same value to fix this case problem.

Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
---
Change note: 

v2: to check weather the freq_table will be changeable and clarify the problem.

The set of available states which come from acpi won't change. Just like
the power would be remove, the acpi driver will do that:

 ->acpi_processor_ppc_has_changed
 ->cpufreq_update_policy
 ->acpi_ppc_notifier_block.notifier_call
   ->acpi_processor_ppc_notifier
   ->cpufreq_verify_within_limits

The progress will change the policy's min_freq and max_freq
while it won't change the set of states(freq_tables).

---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index b0c18ed..93634a4 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -779,7 +779,7 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	/* table init */
 	for (i = 0; i < perf->state_count; i++) {
-		if (i > 0 && perf->states[i].core_frequency >=
+		if (i > 0 && perf->states[i].core_frequency >
 		    data->freq_table[valid_states-1].frequency / 1000)
 			continue;
 
-- 
1.7.12



