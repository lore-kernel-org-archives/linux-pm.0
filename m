From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 1/2] ACPI: processor_perflib: Simplify code and stop using CPUFREQ_START
Date: Mon, 30 Jan 2017 09:59:57 +0530
Message-ID: <e608c76ea40e4f0d50bfe821174dfebef924e35b.1485750547.git.viresh.kumar@linaro.org>
References: <1547465.PvRbYVlVrB@aspire.rjw.lan>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1547465.PvRbYVlVrB@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

acpi_processor_ppc_notifier() can live without using CPUFREQ_START
(which is gonna be removed soon), as it is only used while setting
ignore_ppc to 0. This can be done with the help of "ignore_ppc < 0"
check alone. The notifier function anyway ignores all events except
CPUFREQ_ADJUST and dropping CPUFREQ_START wouldn't harm at all.

Once CPUFREQ_START event is removed from the cpufreq core,
acpi_processor_ppc_notifier() will get called only for CPUFREQ_NOTIFY or
CPUFREQ_ADJUST event. Drop the return statement from the first if block
to make sure we don't ignore any such events.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V1->V2:
- Improved changelog
- Don't move the first if block to a later point, as it becomes useless
  then.
---
 drivers/acpi/processor_perflib.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index f0b4a981b8d3..18b72eec3507 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -75,10 +75,8 @@ static int acpi_processor_ppc_notifier(struct notifier_block *nb,
 	struct acpi_processor *pr;
 	unsigned int ppc = 0;
 
-	if (event == CPUFREQ_START && ignore_ppc <= 0) {
+	if (ignore_ppc < 0)
 		ignore_ppc = 0;
-		return 0;
-	}
 
 	if (ignore_ppc)
 		return 0;
-- 
2.7.1.410.g6faf27b

