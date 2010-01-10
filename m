From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 5/9] ACPI: Add support for new refcounted GPE API
	to drivers
Date: Sun, 10 Jan 2010 14:39:13 +0100
Message-ID: <201001101439.13616.rjw__23035.1374754266$1263132735$gmane$org@sisk.pl>
References: <201001101431.38630.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001101431.38630.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

Add GPE refcounting support to ACPI drivers that need it. This will
currently do little until the core is changed over to use the new
behaviour.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by; Rafael J. Wysocki <rjw@sisk.pl>
---
drivers/acpi/button.c |   12 ++++++++++++
 drivers/acpi/button.c |   12 ++++++++++++
 drivers/acpi/ec.c     |    4 +++-
 drivers/acpi/wakeup.c |    6 ++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -427,6 +427,10 @@ static int acpi_button_add(struct acpi_d
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
+		acpi_ref_runtime_gpe(device->wakeup.gpe_device,
+				     device->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(device->wakeup.gpe_device,
+				    device->wakeup.gpe_number);
 		device->wakeup.state.enabled = 1;
 	}
 
@@ -446,6 +450,14 @@ static int acpi_button_remove(struct acp
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (device->wakeup.flags.valid) {
+		acpi_unref_runtime_gpe(device->wakeup.gpe_device,
+			     device->wakeup.gpe_number);
+		acpi_unref_wakeup_gpe(device->wakeup.gpe_device,
+				      device->wakeup.gpe_number);
+		device->wakeup.state.enabled = 0;
+	}
+
 	acpi_button_remove_fs(device);
 	input_unregister_device(button->input);
 	kfree(button);
Index: linux-2.6/drivers/acpi/ec.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ec.c
+++ linux-2.6/drivers/acpi/ec.c
@@ -755,7 +755,7 @@ static int ec_install_handlers(struct ac
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe);
+	acpi_ref_runtime_gpe(NULL, ec->gpe);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -772,6 +772,7 @@ static int ec_install_handlers(struct ac
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
+                        acpi_unref_runtime_gpe(NULL, ec->gpe);
 			return -ENODEV;
 		}
 	}
@@ -782,6 +783,7 @@ static int ec_install_handlers(struct ac
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	acpi_unref_runtime_gpe(NULL, ec->gpe);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -81,6 +81,8 @@ void acpi_enable_wakeup_device(u8 sleep_
 		if (!dev->wakeup.flags.run_wake)
 			acpi_enable_gpe(dev->wakeup.gpe_device,
 					dev->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 	}
 }
 
@@ -121,6 +123,8 @@ void acpi_disable_wakeup_device(u8 sleep
 			acpi_clear_gpe(dev->wakeup.gpe_device,
 				       dev->wakeup.gpe_number, ACPI_NOT_ISR);
 		}
+		acpi_unref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 	}
 }
 
@@ -141,6 +145,8 @@ int __init acpi_wakeup_device_init(void)
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);
 		dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);
