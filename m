From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 6/7] xen/acpi/sleep: Enable ACPI sleep via the
	__acpi_override_sleep
Date: Wed, 31 Aug 2011 14:31:23 -0400
Message-ID: <1314815484-4668-7-git-send-email-konrad.wilk__44664.7701239728$1314917504$gmane$org@oracle.com>
References: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314815484-4668-1-git-send-email-konrad.wilk@oracle.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: x86@kernel.org, tglx@linutronix.de, tboot-devel@lists.sourceforge.net, shane.wang@intel.com, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@in
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: linux-pm@vger.kernel.org

Provide the registration callback to call in the Xen's
ACPI sleep functionality. This means that during S3/S5
we make a hypercall XENPF_enter_acpi_sleep with the
proper PM1A/PM1B registers.

Based of Ke Yu's <ke.yu@intel.com> initial idea.
[ From http://xenbits.xensource.com/linux-2.6.18-xen.hg
change c68699484a65 ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/include/asm/xen/hypercall.h |    8 ++++++++
 arch/x86/xen/enlighten.c             |    3 +++
 drivers/xen/Makefile                 |    2 +-
 drivers/xen/acpi.c                   |   25 +++++++++++++++++++++++++
 include/xen/acpi.h                   |   26 ++++++++++++++++++++++++++
 5 files changed, 63 insertions(+), 1 deletions(-)
 create mode 100644 drivers/xen/acpi.c
 create mode 100644 include/xen/acpi.h

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index d240ea9..0c9894e 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -45,6 +45,7 @@
 #include <xen/interface/xen.h>
 #include <xen/interface/sched.h>
 #include <xen/interface/physdev.h>
+#include <xen/interface/platform.h>
 
 /*
  * The hypercall asms have to meet several constraints:
@@ -299,6 +300,13 @@ HYPERVISOR_set_timer_op(u64 timeout)
 }
 
 static inline int
+HYPERVISOR_dom0_op(struct xen_platform_op *platform_op)
+{
+	platform_op->interface_version = XENPF_INTERFACE_VERSION;
+	return _hypercall1(int, dom0_op, platform_op);
+}
+
+static inline int
 HYPERVISOR_set_debugreg(int reg, unsigned long value)
 {
 	return _hypercall2(int, set_debugreg, reg, value);
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 5525163..6962653 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -42,6 +42,7 @@
 #include <xen/page.h>
 #include <xen/hvm.h>
 #include <xen/hvc-console.h>
+#include <xen/acpi.h>
 
 #include <asm/paravirt.h>
 #include <asm/apic.h>
@@ -1250,6 +1251,8 @@ asmlinkage void __init xen_start_kernel(void)
 	} else {
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
+
+		xen_acpi_sleep_register();
 	}
 		
 
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index bbc1825..370552d 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_XENFS)			+= xenfs/
 obj-$(CONFIG_XEN_SYS_HYPERVISOR)	+= sys-hypervisor.o
 obj-$(CONFIG_XEN_PLATFORM_PCI)		+= xen-platform-pci.o
 obj-$(CONFIG_SWIOTLB_XEN)		+= swiotlb-xen.o
-obj-$(CONFIG_XEN_DOM0)			+= pci.o
+obj-$(CONFIG_XEN_DOM0)			+= pci.o acpi.o
 
 xen-evtchn-y				:= evtchn.o
 xen-gntdev-y				:= gntdev.o
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
new file mode 100644
index 0000000..c0f829f
--- /dev/null
+++ b/drivers/xen/acpi.c
@@ -0,0 +1,25 @@
+#include <xen/acpi.h>
+#include <xen/interface/platform.h>
+#include <asm/xen/hypercall.h>
+#include <asm/xen/hypervisor.h>
+
+int xen_acpi_notify_hypervisor_state(u8 sleep_state,
+				     u32 pm1a_cnt, u32 pm1b_cnt,
+				     bool *skip_rest)
+{
+	struct xen_platform_op op = {
+		.cmd = XENPF_enter_acpi_sleep,
+		.interface_version = XENPF_INTERFACE_VERSION,
+		.u = {
+			.enter_acpi_sleep = {
+				.pm1a_cnt_val = (u16)pm1a_cnt,
+				.pm1b_cnt_val = (u16)pm1b_cnt,
+				.sleep_state = sleep_state,
+			},
+		},
+	};
+	if (skip_rest)
+		*skip_rest = true;
+
+	return HYPERVISOR_dom0_op(&op);
+}
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
new file mode 100644
index 0000000..e414f14
--- /dev/null
+++ b/include/xen/acpi.h
@@ -0,0 +1,26 @@
+#ifndef _XEN_ACPI_H
+#define _XEN_ACPI_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_XEN_DOM0
+#include <asm/xen/hypervisor.h>
+#include <xen/xen.h>
+#include <linux/acpi.h>
+
+int xen_acpi_notify_hypervisor_state(u8 sleep_state,
+				     u32 pm1a_cnt, u32 pm1b_cnd,
+				     bool *skip_rest);
+
+static inline void xen_acpi_sleep_register(void)
+{
+	if (xen_initial_domain())
+		__acpi_override_sleep = xen_acpi_notify_hypervisor_state;
+}
+#else
+static inline void xen_acpi_sleep_register(void)
+{
+}
+#endif
+
+#endif	/* _XEN_ACPI_H */
-- 
1.7.4.1
