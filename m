From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH] drivers/base: stop new probing during shutdown
Date: Thu, 19 Jul 2018 13:14:58 +0800
Message-ID: <1531977298-21465-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pingfan Liu <kernelfans@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

There is a race window in device_shutdown(), which may cause
-1. parent device shut down before child or
-2. no shutdown on a new probing device.

For 1st, taking the following scenario:
         device_shutdown                        new plugin device
  list_del_init(parent_dev);
  spin_unlock(list_lock);
                                                  device_add(child)
                                                  probe child
  shutdown parent_dev
       --> now child is on the tail of devices_kset

For 2nd, taking the following scenario:
         device_shutdown                        new plugin device
                                                  device_add(dev)
  device_lock(dev);
  ...
  device_unlock(dev);
                                                  probe dev
       --> now, the new occurred dev has no opportunity to shutdown

To fix this race issue, just prevent the new probing request. With this
logic, device_shutdown() is more similar to dpm_prepare().

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index df3e1a4..3aba4ad 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2809,6 +2809,9 @@ void device_shutdown(void)
 {
 	struct device *dev, *parent;
 
+	wait_for_device_probe();
+	device_block_probing();
+
 	spin_lock(&devices_kset->list_lock);
 	/*
 	 * Walk the devices list backward, shutting down each in turn.
-- 
2.7.4
