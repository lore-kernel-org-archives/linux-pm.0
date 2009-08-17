From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 7/7] PM: Asynchronous suspend and resume of
	i8042
Date: Mon, 17 Aug 2009 02:21:34 +0200
Message-ID: <200908170221.34885.rjw__43143.0654287853$1250469283$gmane$org@sisk.pl>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200908170215.21173.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Set async_suspend for i8042.

---
 drivers/input/serio/i8042.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/input/serio/i8042.c
===================================================================
--- linux-2.6.orig/drivers/input/serio/i8042.c
+++ linux-2.6/drivers/input/serio/i8042.c
@@ -1289,6 +1289,8 @@ static int __init i8042_init(void)
 	if (err)
 		goto err_free_device;
 
+	device_enable_async_suspend(&i8042_platform_device->dev, true);
+
 	panic_blink = i8042_panic_blink;
 
 	return 0;
