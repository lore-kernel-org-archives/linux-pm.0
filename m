From: Wang Weidong <wangweidong1@huawei.com>
Subject: [PATCH 1/2] acpi-cpufreq: make the freq_table store the same freq value
Date: Fri, 28 Nov 2014 10:43:38 +0800
Message-ID: <1417142619-14548-2-git-send-email-wangweidong1@huawei.com>
References: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417142619-14548-1-git-send-email-wangweidong1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: wangweidong1@huawei.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-pm@vger.kernel.org

As the initialized freq_tables maybe different from the p-states
values, so the array index is different as well.

Although in this case:
p-states value: [2400 2400 2000 ...], while the freq_tables:
[2400 2000 ... CPUFREQ_TABLE_END]. After setted the freqs 2000,
the perf->state is 3 while the freqs_table's index should be 2.
So when call the get_cur_freq_on_cpu, the freqs value we get
is 2400.

So, make the freq_table store the same value as well.

Signed-off-by: Wang Weidong <wangweidong1@huawei.com>
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
