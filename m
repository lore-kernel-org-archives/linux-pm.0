From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] cpufreq / CPPC: Mark acpi_ids as used
Date: Tue,  2 Oct 2018 15:34:57 -0700
Message-ID: <20181002223457.7564-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: linux-pm@vger.kernel.org

Clang warns:

drivers/cpufreq/cppc_cpufreq.c:431:36: warning: variable 'cppc_acpi_ids'
is not needed and will not be emitted [-Wunneeded-internal-declaration]
static const struct acpi_device_id cppc_acpi_ids[] = {
                                   ^
1 warning generated.

Mark the definition as used so that Clang understands we don't want this
warning while not inhibiting Clang's dead code elimination from removing
the unreferenced internal symbol when moving the data it contains to the
globally available symbol via MODULE_DEVICE_TABLE.

$ nm -S drivers/cpufreq/cppc_cpufreq.o | grep acpi | tail -1
0000000000000000 0000000000000040 R __mod_acpi__cppc_acpi_ids_device_table

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 30f302149730..fd25c21cee72 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -428,7 +428,7 @@ MODULE_LICENSE("GPL");
 
 late_initcall(cppc_cpufreq_init);
 
-static const struct acpi_device_id cppc_acpi_ids[] = {
+static const struct acpi_device_id cppc_acpi_ids[] __used = {
 	{ACPI_PROCESSOR_DEVICE_HID, },
 	{}
 };
-- 
2.19.0
