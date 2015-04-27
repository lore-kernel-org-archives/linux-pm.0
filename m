From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 2/3] x86, mpparse: Constify irq_domain_ops
Date: Mon, 27 Apr 2015 21:48:08 +0900
Message-ID: <1430138889-3310-2-git-send-email-k.kozlowski.k@gmail.com>
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
 arch/x86/kernel/mpparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 2d2a237f2c73..35f05c3b4e4e 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -113,7 +113,7 @@ static void __init MP_bus_info(struct mpc_bus *m)
 		pr_warn("Unknown bustype %s - ignoring\n", str);
 }
 
-static struct irq_domain_ops mp_ioapic_irqdomain_ops = {
+static const struct irq_domain_ops mp_ioapic_irqdomain_ops = {
 	.map = mp_irqdomain_map,
 	.unmap = mp_irqdomain_unmap,
 };
-- 
2.1.0
