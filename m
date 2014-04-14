From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 02/20] cpufreq: acpi-cpufreq: Use cpufreq_for_each_entry macro
 for iteration
Date: Tue, 15 Apr 2014 00:08:06 +0300
Message-ID: <534C4E36.9060208@semaphore.gr>
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
 drivers/cpufreq/acpi-cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 000e4e0..12a5750 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -213,7 +213,7 @@ static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
 
 static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
 {
-	int i;
+	struct cpufreq_frequency_table *pos;
 	struct acpi_processor_performance *perf;
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
@@ -223,11 +223,11 @@ static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
 
 	perf = data->acpi_data;
 
-	for (i = 0; data->freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
-		if (msr == perf->states[data->freq_table[i].driver_data].status)
-			return data->freq_table[i].frequency;
+	cpufreq_for_each_entry(pos, data->freq_table) {
+		if (msr == perf->states[pos->driver_data].status)
+			return pos->frequency;
 	}
-	return data->freq_table[0].frequency;
+	return data->freq_table->frequency;
 }
 
 static unsigned extract_freq(u32 val, struct acpi_cpufreq_data *data)
-- 
1.9.0
