From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 02/27] gpiolib-acpi: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:50 +0800
Message-ID: <1378168335-22556-3-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:46140 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab3ICAbE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:04 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in drivers/gpio/gpiolib-acpi.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Mathias Nyman <mathias.nyman@linux.intel.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>
CC: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpiolib-acpi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 5c1ef2b..f2beb72 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -73,15 +73,8 @@ static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 static irqreturn_t acpi_gpio_irq_handler_evt(int irq, void *data)
 {
 	struct acpi_gpio_evt_pin *evt_pin = data;
-	struct acpi_object_list args;
-	union acpi_object arg;
 
-	arg.type = ACPI_TYPE_INTEGER;
-	arg.integer.value = evt_pin->pin;
-	args.count = 1;
-	args.pointer = &arg;
-
-	acpi_evaluate_object(evt_pin->evt_handle, NULL, &args, NULL);
+	acpi_execute_simple_method(evt_pin->evt_handle, NULL, evt_pin->pin);
 
 	return IRQ_HANDLED;
 }
-- 
1.8.1.2

