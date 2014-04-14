From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 06/20] cpufreq: elanfreq: Use cpufreq_for_each_entry macro
 for iteration
Date: Tue, 15 Apr 2014 00:08:57 +0300
Message-ID: <534C4E69.1000907@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core supports the cpufreq_for_each_entry macro helper
for iteration over the cpufreq_frequency_table, so use it.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/elanfreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 7f5d2a6..a3f6f26 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -147,7 +147,7 @@ static int elanfreq_target(struct cpufreq_policy *policy,
 static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cpuinfo_x86 *c = &cpu_data(0);
-	unsigned int i;
+	struct cpufreq_frequency_table *pos;
 
 	/* capability check */
 	if ((c->x86_vendor != X86_VENDOR_AMD) ||
@@ -159,9 +159,9 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
 		max_freq = elanfreq_get_cpu_frequency(0);
 
 	/* table init */
-	for (i = 0; (elanfreq_table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if (elanfreq_table[i].frequency > max_freq)
-			elanfreq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+	cpufreq_for_each_entry(pos, elanfreq_table) {
+		if (pos->frequency > max_freq)
+			pos->frequency = CPUFREQ_ENTRY_INVALID;
 	}
 
 	/* cpuinfo and default policy values */
-- 
1.9.0
