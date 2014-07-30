From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3] gpio-keys / PM: use enable/disable_device_irq_wake()
Date: Wed, 30 Jul 2014 23:52:26 +0200
Message-ID: <4990705.YeFNUfB5d5@vostro.rjw.lan>
References: <20140724212620.GO3935@laptop> <3042738.6Ohp3GcNCj@vostro.rjw.lan> <8151374.tpuvaHv3nd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59329 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751463AbaG3Vgd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jul 2014 17:36:33 -0400
In-Reply-To: <8151374.tpuvaHv3nd@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Dmitry Torokhov <dtor@google.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use enable/disable_device_irq_wake() instead of enable/disable_irq_wake(),
respectively, to prepare the gpio-keys interrupt for waking up the
system from sleep states.

That is safe with respect to shared interrupts and allows the IRQ
subsystem to take care of IRQ configuration at the right time
instead of going all the way to the hardware and reconfiguring it
right away.  It also allows gpio-keys to wake up the system from
the "freeze" sleep state (suspend-to-idle).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/input/keyboard/gpio_keys.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/input/keyboard/gpio_keys.c
===================================================================
--- linux-pm.orig/drivers/input/keyboard/gpio_keys.c
+++ linux-pm/drivers/input/keyboard/gpio_keys.c
@@ -788,7 +788,7 @@ static int gpio_keys_suspend(struct devi
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
-				enable_irq_wake(bdata->irq);
+				enable_device_irq_wake(bdata->irq, bdata);
 		}
 	} else {
 		mutex_lock(&input->mutex);
@@ -811,7 +811,7 @@ static int gpio_keys_resume(struct devic
 		for (i = 0; i < ddata->pdata->nbuttons; i++) {
 			struct gpio_button_data *bdata = &ddata->data[i];
 			if (bdata->button->wakeup)
-				disable_irq_wake(bdata->irq);
+				disable_device_irq_wake(bdata->irq, bdata);
 		}
 	} else {
 		mutex_lock(&input->mutex);

