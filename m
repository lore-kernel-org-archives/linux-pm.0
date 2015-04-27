From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 3/3] x86, irq, SFI: Constify irq_domain_ops
Date: Mon, 27 Apr 2015 21:48:09 +0900
Message-ID: <1430138889-3310-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1430138889-3310-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430138889-3310-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sfi-devel@simplefirmware.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-pm@vger.kernel.org

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/x86/platform/sfi/sfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/sfi/sfi.c b/arch/x86/platform/sfi/sfi.c
index 2a8a74f3bd76..68eba8edc437 100644
--- a/arch/x86/platform/sfi/sfi.c
+++ b/arch/x86/platform/sfi/sfi.c
@@ -71,7 +71,7 @@ static int __init sfi_parse_cpus(struct sfi_table_header *table)
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_IO_APIC
-static struct irq_domain_ops sfi_ioapic_irqdomain_ops = {
+static const struct irq_domain_ops sfi_ioapic_irqdomain_ops = {
 	.map = mp_irqdomain_map,
 };
 
-- 
2.1.0
