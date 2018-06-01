From: Colin King <colin.king@canonical.com>
Subject: [PATCH] cpufreq: ACPI: make function acpi_cpufreq_fast_switch static
Date: Fri,  1 Jun 2018 14:05:12 +0100
Message-ID: <20180601130512.30857-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function acpi_cpufreq_fast_switch is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/cpufreq/acpi-cpufreq.c:468:14: warning: symbol
'acpi_cpufreq_fast_switch' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 9449657d72f0..32ba4bc972e7 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -465,8 +465,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
 	return result;
 }
 
-unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
-				      unsigned int target_freq)
+static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
 {
 	struct acpi_cpufreq_data *data = policy->driver_data;
 	struct acpi_processor_performance *perf;
-- 
2.17.0
