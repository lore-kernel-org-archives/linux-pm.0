From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 2/7] ACPI: Enable PPTT support on ARM64
Date: Thu, 12 Oct 2017 14:48:51 -0500
Message-ID: <20171012194856.13844-3-jeremy.linton@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171012194856.13844-1-jeremy.linton@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, jhugo@codeaurora.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, ahs3@redhat.com, viresh.kumar@linaro.org, hanjun.guo@linaro.org, sudeep.holla@arm.com, austinwc@codeaurora.org, wangxiongfeng2@huawei.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig         | 1 +
 drivers/acpi/Makefile      | 1 +
 drivers/acpi/arm64/Kconfig | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..68c9d1289735 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,6 +7,7 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 90265ab4437a..c92a0c937551 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index 5a6f80fce0d6..74b855a669ea 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -7,3 +7,6 @@ config ACPI_IORT
 
 config ACPI_GTDT
 	bool
+
+config ACPI_PPTT
+	bool
\ No newline at end of file
-- 
2.13.5
