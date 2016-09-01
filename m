From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/4] acpi: cppc: Allow build with ACPI_CPU_FREQ_PSS config
Date: Thu,  1 Sep 2016 13:37:08 -0700
Message-ID: <1472762231-88923-2-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472762231-88923-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, tglx@linutronix.de, mingo@redhat.com, bp@suse.de, peterz@infradead.org
Cc: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, tim.c.chen@linux.intel.com, alexey.klimov@arm.com, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Some newer x86 platforms have support for both _CPC and _PSS object. So
kernel config can have both ACPI_CPU_FREQ_PSS and ACPI_CPPC_LIB. So remove
restriction for ACPI_CPPC_LIB to build only when ACPI_CPU_FREQ_PSS is not
defined.
Also for legacy systems with only _PSS, we shouldn't bail out if
acpi_cppc_processor_probe() fails, if ACPI_CPU_FREQ_PSS is also defined.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Kconfig            | 1 -
 drivers/acpi/processor_driver.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 445ce28..c6bb6aa 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -227,7 +227,6 @@ config ACPI_MCFG
 config ACPI_CPPC_LIB
 	bool
 	depends on ACPI_PROCESSOR
-	depends on !ACPI_CPU_FREQ_PSS
 	select MAILBOX
 	select PCC
 	help
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 0553aee..f5c92be 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -245,7 +245,7 @@ static int __acpi_processor_start(struct acpi_device *device)
 		return 0;
 
 	result = acpi_cppc_processor_probe(pr);
-	if (result)
+	if (result && !IS_ENABLED(CONFIG_ACPI_CPU_FREQ_PSS))
 		return -ENODEV;
 
 	if (!cpuidle_get_driver() || cpuidle_get_driver() == &acpi_idle_driver)
-- 
2.7.4
