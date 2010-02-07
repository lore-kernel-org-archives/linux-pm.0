From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Update][RFC][PATCH 2/3] ACPI: Modify GPE consumers to
	use GPE refcounting
Date: Sun, 7 Feb 2010 12:58:58 +0100
Message-ID: <201002071258.59093.rjw__8222.19265760413$1265544148$gmane$org@sisk.pl>
References: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
	<201002070317.47029.rjw@sisk.pl> <201002071256.35998.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002071256.35998.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add GPE refcounting support to the existing GPE users.  This will
currently do little until the core is changed over to fully
implement the new behaviour.

Based on a patch from Matthew Garrett <mjg@redhat.com>.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/button.c |   10 ++++++++++
 drivers/acpi/ec.c     |    4 +++-
 drivers/acpi/sleep.c  |   15 ++++++++++++---
 drivers/acpi/wakeup.c |    2 ++
 4 files changed, 27 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/acpi/button.c
===================================================================
--- linux-2.6.orig/drivers/acpi/button.c
+++ linux-2.6/drivers/acpi/button.c
@@ -427,6 +427,9 @@ static int acpi_button_add(struct acpi_d
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(device->wakeup.gpe_device,
 				device->wakeup.gpe_number);
+		acpi_get_gpe(device->wakeup.gpe_device,
+				device->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE_RUN);
 		device->wakeup.state.enabled = 1;
 	}
 
@@ -446,6 +449,13 @@ static int acpi_button_remove(struct acp
 {
 	struct acpi_button *button = acpi_driver_data(device);
 
+	if (device->wakeup.flags.valid) {
+		acpi_put_gpe(device->wakeup.gpe_device,
+				device->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE_RUN);
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
@@ -789,7 +789,7 @@ static int ec_install_handlers(struct ac
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 	acpi_set_gpe_type(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
-	acpi_enable_gpe(NULL, ec->gpe);
+	acpi_get_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	status = acpi_install_address_space_handler(ec->handle,
 						    ACPI_ADR_SPACE_EC,
 						    &acpi_ec_space_handler,
@@ -806,6 +806,7 @@ static int ec_install_handlers(struct ac
 		} else {
 			acpi_remove_gpe_handler(NULL, ec->gpe,
 				&acpi_ec_gpe_handler);
+			acpi_put_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 			return -ENODEV;
 		}
 	}
@@ -816,6 +817,7 @@ static int ec_install_handlers(struct ac
 
 static void ec_remove_handlers(struct acpi_ec *ec)
 {
+	acpi_put_gpe(NULL, ec->gpe, ACPI_GPE_TYPE_RUNTIME);
 	if (ACPI_FAILURE(acpi_remove_address_space_handler(ec->handle,
 				ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
 		pr_err(PREFIX "failed to remove space handler\n");
Index: linux-2.6/drivers/acpi/sleep.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep.c
+++ linux-2.6/drivers/acpi/sleep.c
@@ -745,9 +745,18 @@ int acpi_pm_device_sleep_wake(struct dev
 		return -ENODEV;
 	}
 
-	error = enable ?
-		acpi_enable_wakeup_device_power(adev, acpi_target_sleep_state) :
-		acpi_disable_wakeup_device_power(adev);
+	if (enable) {
+		error = acpi_enable_wakeup_device_power(adev,
+						acpi_target_sleep_state);
+		if (!error)
+			acpi_get_gpe(adev->wakeup.gpe_device,
+					adev->wakeup.gpe_number,
+					ACPI_GPE_TYPE_WAKE);
+	} else {
+		acpi_put_gpe(adev->wakeup.gpe_device, adev->wakeup.gpe_number,
+				ACPI_GPE_TYPE_WAKE);
+		error = acpi_disable_wakeup_device_power(adev);
+	}
 	if (!error)
 		dev_info(dev, "wake-up capability %s by ACPI\n",
 				enable ? "enabled" : "disabled");
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -141,6 +141,8 @@ int __init acpi_wakeup_device_init(void)
 				  ACPI_GPE_TYPE_WAKE_RUN);
 		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
+ 		acpi_get_gpe(dev->wakeup.gpe_device, dev->wakeup.gpe_number,
+ 				ACPI_GPE_TYPE_WAKE);
 		dev->wakeup.state.enabled = 1;
 	}
 	mutex_unlock(&acpi_device_lock);
