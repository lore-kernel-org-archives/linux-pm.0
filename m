From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH v4 6/8] thermal: cpu_cooling: Use cpufreq_for_each_valid_entry
 macro for iteration
Date: Tue, 22 Apr 2014 02:02:03 +0300
Message-ID: <5355A36B.8030601@semaphore.gr>
References: <534DB21F.4070005@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <534DB21F.4070005@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core now supports the cpufreq_for_each_valid_entry macro
helper for iteration over the cpufreq_frequency_table, so use it.

Also remove the redundant !! operator.

It should have no functional changes.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/thermal/cpu_cooling.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4246262..84a75f8 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -144,11 +144,11 @@ static int get_property(unsigned int cpu, unsigned long input,
 			unsigned int *output,
 			enum cpufreq_cooling_property property)
 {
-	int i, j;
+	int i;
 	unsigned long max_level = 0, level = 0;
 	unsigned int freq = CPUFREQ_ENTRY_INVALID;
 	int descend = -1;
-	struct cpufreq_frequency_table *table =
+	struct cpufreq_frequency_table *pos, *table =
 					cpufreq_frequency_get_table(cpu);
 
 	if (!output)
@@ -157,20 +157,16 @@ static int get_property(unsigned int cpu, unsigned long input,
 	if (!table)
 		return -EINVAL;
 
-	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		/* ignore invalid entries */
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-
+	cpufreq_for_each_valid_entry(pos, table) {
 		/* ignore duplicate entry */
-		if (freq == table[i].frequency)
+		if (freq == pos->frequency)
 			continue;
 
 		/* get the frequency order */
 		if (freq != CPUFREQ_ENTRY_INVALID && descend == -1)
-			descend = !!(freq > table[i].frequency);
+			descend = freq > pos->frequency;
 
-		freq = table[i].frequency;
+		freq = pos->frequency;
 		max_level++;
 	}
 
@@ -190,29 +186,26 @@ static int get_property(unsigned int cpu, unsigned long input,
 	if (property == GET_FREQ)
 		level = descend ? input : (max_level - input);
 
-	for (i = 0, j = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		/* ignore invalid entry */
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-
+	i = 0;
+	cpufreq_for_each_valid_entry(pos, table) {
 		/* ignore duplicate entry */
-		if (freq == table[i].frequency)
+		if (freq == pos->frequency)
 			continue;
 
 		/* now we have a valid frequency entry */
-		freq = table[i].frequency;
+		freq = pos->frequency;
 
 		if (property == GET_LEVEL && (unsigned int)input == freq) {
 			/* get level by frequency */
-			*output = descend ? j : (max_level - j);
+			*output = descend ? i : (max_level - i);
 			return 0;
 		}
-		if (property == GET_FREQ && level == j) {
+		if (property == GET_FREQ && level == i) {
 			/* get frequency by level */
 			*output = freq;
 			return 0;
 		}
-		j++;
+		i++;
 	}
 
 	return -EINVAL;
-- 
1.9.0
