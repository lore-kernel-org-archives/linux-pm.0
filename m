From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/5] ACPI / boot: Add number of legacy IRQs to debug output
Date: Tue, 18 Jul 2017 18:04:18 +0300
Message-ID: <20170718150420.61600-4-andriy.shevchenko@linux.intel.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:9540 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751462AbdGRPF6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 18 Jul 2017 11:05:58 -0400
In-Reply-To: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

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
