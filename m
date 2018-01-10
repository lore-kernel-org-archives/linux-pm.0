From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] platform/x86: surfacepro3: Support for wakeup from suspend-to-idle
Date: Wed, 10 Jan 2018 13:26:35 +0100
Message-ID: <6492549.QWquAG8VGe@aspire.rjw.lan>
References: <4046497.JI7UjL75gC@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4046497.JI7UjL75gC@aspire.rjw.lan>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Valentin Manea <valy@mrs.ro>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify surface_button_notify() to make it wake up the system from
suspend-to-idle (by reporting "hard" wakeup events while suspended)
and add wakeup initialization to surface_button_add() for wakeup
events reported by this driver to work at all.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198389
Reported-by: Valentin Manea <valy@mrs.ro>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/surfacepro3_button.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/platform/x86/surfacepro3_button.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/surfacepro3_button.c
+++ linux-pm/drivers/platform/x86/surfacepro3_button.c
@@ -119,7 +119,7 @@ static void surface_button_notify(struct
 	if (key_code == KEY_RESERVED)
 		return;
 	if (pressed)
-		pm_wakeup_event(&device->dev, 0);
+		pm_wakeup_dev_event(&device->dev, 0, button->suspended);
 	if (button->suspended)
 		return;
 	input_report_key(input, key_code, pressed?1:0);
@@ -185,6 +185,8 @@ static int surface_button_add(struct acp
 	error = input_register_device(input);
 	if (error)
 		goto err_free_input;
+
+	device_init_wakeup(&device->dev, true);
 	dev_info(&device->dev,
 			"%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
