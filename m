From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v4 3/9] arm64/acpi: Create arch specific cpu to acpi id helper
Date: Thu,  9 Nov 2017 15:03:05 -0600
Message-ID: <20171109210311.25655-4-jeremy.linton@arm.com>
References: <20171109210311.25655-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171109210311.25655-1-jeremy.linton@arm.com>
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
Cc: mark.rutland@arm.com, Jonathan.Zhang@cavium.com, austinwc@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, lv.zheng@intel.com, wangxiongfeng2@huawei.com, Jayachandran.Nair@cavium.com, lorenzo.pieralisi@arm.com, jhugo@codeaurora.org, robert.moore@intel.com, viresh.kumar@linaro.org, lenb@kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com, linux-arm-kernel@lists.infradead.org, devel@acpica.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>, hanjun.guo@linaro.org, sudeep.holla@arm.com
List-Id: linux-pm@vger.kernel.org

Its helpful to be able to lookup the acpi_processor_id
associated with a logical cpu. Provide an arm64
helper to do this.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/include/asm/acpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 59cca1d6ec54..408e7989d3a2 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -86,6 +86,10 @@ static inline bool acpi_has_cpu_in_madt(void)
 }
 
 struct acpi_madt_generic_interrupt *acpi_cpu_get_madt_gicc(int cpu);
+static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
+{
+	return	acpi_cpu_get_madt_gicc(cpu)->uid;
+}
 
 static inline void arch_fix_phys_package_id(int num, u32 slot) { }
 void __init acpi_init_cpus(void);
-- 
2.13.5
