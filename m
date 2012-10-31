From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] ACPI / x86: Export acpi_[un]register_gsi()
Date: Wed, 31 Oct 2012 10:34:21 +0100
Message-ID: <1371890.suMCXUWu9X@vostro.rjw.lan>
References: <1421417.rIOjExM5Pt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421417.rIOjExM5Pt@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lv Zheng <lv.zheng@intel.com>, Huang Ying <ying.huang@intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, x86 list <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

These functions might be called from modules as well so make sure
they are exported.

In addition, implement empty version of acpi_unregister_gsi() and
remove the one from pci_irq.c.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/acpi/boot.c |    6 ++++++
 drivers/acpi/pci_irq.c      |    5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

Index: linux/arch/x86/kernel/acpi/boot.c
===================================================================
--- linux.orig/arch/x86/kernel/acpi/boot.c
+++ linux/arch/x86/kernel/acpi/boot.c
@@ -574,6 +574,12 @@ int acpi_register_gsi(struct device *dev
 
 	return irq;
 }
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 void __init acpi_set_irq_model_pic(void)
 {
Index: linux/drivers/acpi/pci_irq.c
===================================================================
--- linux.orig/drivers/acpi/pci_irq.c
+++ linux/drivers/acpi/pci_irq.c
@@ -495,11 +495,6 @@ int acpi_pci_irq_enable(struct pci_dev *
 	return 0;
 }
 
-/* FIXME: implement x86/x86_64 version */
-void __attribute__ ((weak)) acpi_unregister_gsi(u32 i)
-{
-}
-
 void acpi_pci_irq_disable(struct pci_dev *dev)
 {
 	struct acpi_prt_entry *entry;
