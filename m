From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/5] ACPI / boot: Add number of legacy IRQs to debug output
Date: Mon, 17 Jul 2017 16:29:44 +0300
Message-ID: <20170717132946.20892-4-andriy.shevchenko@linux.intel.com>
References: <20170717132946.20892-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717132946.20892-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Sometimes it's useful to have when mp_config_acpi_legacy_irqs() is called.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 6d5b1346268a..0186d3bae610 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1078,7 +1078,7 @@ static void __init mp_config_acpi_legacy_irqs(void)
 	mp_bus_id_to_type[MP_ISA_BUS] = MP_BUS_ISA;
 #endif
 	set_bit(MP_ISA_BUS, mp_bus_not_pci);
-	pr_debug("Bus #%d is ISA\n", MP_ISA_BUS);
+	pr_debug("Bus #%d is ISA (nIRQs: %d)\n", MP_ISA_BUS, nr_legacy_irqs());
 
 	/*
 	 * Use the default configuration for the IRQs 0-15.  Unless
-- 
2.11.0
