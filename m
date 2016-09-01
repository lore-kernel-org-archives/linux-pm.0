From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/4] acpi: cppc: Don't return on CPPC probe failure
Date: Thu,  1 Sep 2016 13:37:09 -0700
Message-ID: <1472762231-88923-3-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, alexey.klimov@arm.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

It is still possible to continue even CPPC data is invalid or missing.

Suggested-by: Alexey Klimov <alexey.klimov@arm.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/processor_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index f5c92be..8f8552a 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -246,7 +246,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 
 	result = acpi_cppc_processor_probe(pr);
 	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
-		return -ENODEV;
+		dev_warn(&device->dev, "CPPC data invalid or not present\n");
 
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
 		acpi_processor_power_init(pr);
-- 
2.7.4

