From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 1/2] arm: irq: Notify affinity change when migrating IRQs during hotplug
Date: Wed, 20 Aug 2014 10:59:47 -0600
Message-ID: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64889 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaHTRAJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 13:00:09 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so12210122pde.11
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2014 10:00:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, tglx@linutronix.de, linux-pm@vger.kernel.org, daniel.lezcano@linaro.org, ulf.hansson@linaro.org
Cc: Praveen Chidambaram <pchidamb@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>

From: Praveen Chidambaram <pchidamb@codeaurora.org>

Hotplug causes IRQs affine to a core that is being taken down to migrate
to an online core. This is done by directly calling the irq_set_affinity
associated with the irq_chip structure. Instead using the
irq_set_affinity_locked() api lets the notifications bubble through.

Signed-off-by: Praveen Chidambaram <pchidamb@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 arch/arm/kernel/irq.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 2c42576..8835ef2 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -157,7 +157,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
 	const struct cpumask *affinity = d->affinity;
-	struct irq_chip *c;
 	bool ret = false;
 
 	/*
@@ -167,17 +166,12 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
 		ret = true;
-	}
-
-	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
-		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
 
+	affinity = cpu_online_mask;
+	ret = (irq_set_affinity_locked(d, affinity, true) == IRQ_SET_MASK_OK)
+			&& ret;
 	return ret;
 }
 
-- 
1.9.1

