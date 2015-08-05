From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 9/9] ACPI: Allow selection of the ACPI processor driver for ARM64
Date: Wed,  5 Aug 2015 09:40:32 -0400
Message-ID: <fa99d8e78cfa7ec4704d53774907861a100664f2.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

Now that the ACPI processor driver has been decoupled from
the C states and P states functionality, make it selectable on
ARM64 so that it can be used by others e.g. CPPC.

The C states and P states code is selected only on X86 or
IA64 until the relevant support is added on ARM64.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/acpi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c6ec903..9787172 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -213,9 +213,9 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || IA64
-	select ACPI_PROCESSOR_IDLE
-	select ACPI_CPU_FREQ_PSS
+	depends on X86 || IA64 || ARM64
+	select ACPI_PROCESSOR_IDLE if X86 || IA64
+	select ACPI_CPU_FREQ_PSS if X86 || IA64
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
-- 
1.9.1

