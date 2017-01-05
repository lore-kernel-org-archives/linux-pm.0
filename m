From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] ACPI: processor_perflib: Simplify code and stop using CPUFREQ_START
Date: Thu,  5 Jan 2017 11:34:30 +0530
Message-ID: <c62a8f8b1bf699b0c7834c87096d4f144c02bf1d.1483596168.git.viresh.kumar@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_processor_ppc_notifier() can live without using CPUFREQ_START
(which is gonna be removed soon). Simplify it a bit.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Rebased over: https://marc.info/?l=linux-kernel&m=148359167516831&w=2

 drivers/acpi/processor_perflib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index f0b4a981b8d3..1ceea1143a1c 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -75,14 +75,12 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 	struct acpi_processor *pr;
 	unsigned int ppc = 0;
 
-	if (event == CPUFREQ_START && ignore_ppc <= 0) {
-		ignore_ppc = 0;
-		return 0;
-	}
-
 	if (ignore_ppc)
 		return 0;
 
+	if (ignore_ppc < 0)
+		ignore_ppc = 0;
+
 	if (event != CPUFREQ_ADJUST)
 		return 0;
 
-- 
2.7.1.410.g6faf27b

