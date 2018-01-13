From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v6 06/12] ACPI: Enable PPTT support on ARM64
Date: Fri, 12 Jan 2018 18:59:14 -0600
Message-ID: <20180113005920.28658-7-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180113005920.28658-1-jeremy.linton@arm.com>
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
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, austinwc@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, morten.rasmussen@arm.com, vkilari@codeaurora.org, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

Now that we have a PPTT parser, in preparation for its use
on arm64, lets build it.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig    | 1 +
 drivers/acpi/Kconfig  | 3 +++
 drivers/acpi/Makefile | 1 +
 3 files changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c9a7e9e1414f..23bf30319d31 100644
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
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 46505396869e..df7aebf0af0e 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -545,6 +545,9 @@ config ACPI_CONFIGFS
 
 if ARM64
 source "drivers/acpi/arm64/Kconfig"
+
+config ACPI_PPTT
+	bool
 endif
 
 config TPS68470_PMIC_OPREGION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 41954a601989..b6056b566df4 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -87,6 +87,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
 obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
 obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
+obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
 
 # processor has its own "processor." module_param namespace
 processor-y			:= processor_driver.o
-- 
2.13.5
