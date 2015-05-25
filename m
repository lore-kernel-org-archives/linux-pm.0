From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 6/8] mfd: make mfd_remove_devices() iterate in reverse order
Date: Mon, 25 May 2015 19:09:30 +0300
Message-ID: <1432570172-86963-7-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:35279 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbbEYQJo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 May 2015 12:09:44 -0400
In-Reply-To: <1432570172-86963-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The newly introduced device_for_each_child_reverse() would be used when MFD
core removes the device.

After this patch applied the devices will be removed in a reversed order. This
behaviour is useful when devices have implicit dependency on order, i.e.
consider MFD device with serial bus controller, such as SPI, and DMA IP that is
attached to serial bus controller: before remove the DMA driver we have to be
ensured that no DMA transfers is ongoing and the requested channel are unused.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 1aed3b7..79eeaa5 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -300,7 +300,7 @@ void mfd_remove_devices(struct device *parent)
 {
 	atomic_t *cnts = NULL;
 
-	device_for_each_child(parent, &cnts, mfd_remove_devices_fn);
+	device_for_each_child_reverse(parent, &cnts, mfd_remove_devices_fn);
 	kfree(cnts);
 }
 EXPORT_SYMBOL(mfd_remove_devices);
-- 
2.1.4

