From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 2/2] arm64: irq: Notify affinity change when migrating IRQs during hotplug
Date: Wed, 20 Aug 2014 10:59:48 -0600
Message-ID: <1408553988-63924-2-git-send-email-lina.iyer@linaro.org>
References: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51774 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbaHTRAK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Aug 2014 13:00:10 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so12685980pab.40
        for <linux-pm@vger.kernel.org>; Wed, 20 Aug 2014 10:00:07 -0700 (PDT)
In-Reply-To: <1408553988-63924-1-git-send-email-lina.iyer@linaro.org>
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
 arch/arm64/kernel/irq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 0f08dfd..c623032 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -87,7 +87,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
 	const struct cpumask *affinity = d->affinity;
-	struct irq_chip *c;
 	bool ret = false;
 
 	/*
@@ -106,12 +105,8 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	 * selected as the target CPU otherwise
 	 */
 	affinity = cpu_online_mask;
-	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
-		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
-
+	ret = (irq_set_affinity_locked(d, affinity, true) == IRQ_SET_MASK_OK)
+			&& ret;
 	return ret;
 }
 
-- 
1.9.1

