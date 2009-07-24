From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH V2 4/4] i8042: support async suspend and shutdown
Date: Fri, 24 Jul 2009 11:02:12 +0800
Message-ID: <1248404532.2670.112.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: dtor@mail.ru, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org


i8042 controller support device async actions.

If boot option "dev_async_action" is added,
i8042 controller and its child devices can be
suspended/shutdown asynchronously.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/input/serio/i8042.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/i8042.c
+++ linux-2.6/drivers/input/serio/i8042.c
@@ -1285,14 +1285,21 @@ static int __init i8042_init(void)
 		goto err_unregister_driver;
 	}
 
-	err = platform_device_add(i8042_platform_device);
+	err = dev_async_register(&i8042_platform_device->dev,
+			DEV_ASYNC_SUSPEND | DEV_ASYNC_SHUTDOWN);
 	if (err)
 		goto err_free_device;
 
+	err = platform_device_add(i8042_platform_device);
+	if (err)
+		goto err_dev_async_unregister;
+
 	panic_blink = i8042_panic_blink;
 
 	return 0;
 
+ err_dev_async_unregister:
+	dev_async_unregister(&i8042_platform_device->dev);
  err_free_device:
 	platform_device_put(i8042_platform_device);
  err_unregister_driver:
@@ -1305,6 +1312,7 @@ static int __init i8042_init(void)
 
 static void __exit i8042_exit(void)
 {
+	dev_async_unregister(&i8042_platform_device->dev);
 	platform_device_unregister(i8042_platform_device);
 	platform_driver_unregister(&i8042_driver);
 	i8042_platform_exit();
