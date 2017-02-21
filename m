From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] PM / runtime: Fix some typo
Date: Tue, 21 Feb 2017 21:41:53 +0100
Message-ID: <20170221204153.4803-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:45420 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752577AbdBUUrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Feb 2017 15:47:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 Documentation/power/runtime_pm.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/runtime_pm.txt
index 4870980e967e..64546eb9a16a 100644
--- a/Documentation/power/runtime_pm.txt
+++ b/Documentation/power/runtime_pm.txt
@@ -100,7 +100,7 @@ knows what to do to handle the device).
   * If the suspend callback returns an error code different from -EBUSY and
     -EAGAIN, the PM core regards this as a fatal error and will refuse to run
     the helper functions described in Section 4 for the device until its status
-    is directly set to  either'active', or 'suspended' (the PM core provides
+    is directly set to  either 'active', or 'suspended' (the PM core provides
     special helper functions for this purpose).
 
 In particular, if the driver requires remote wakeup capability (i.e. hardware
@@ -217,7 +217,7 @@ defined in include/linux/pm.h:
       one to complete
 
   spinlock_t lock;
-    - lock used for synchronisation
+    - lock used for synchronization
 
   atomic_t usage_count;
     - the usage counter of the device
@@ -565,7 +565,7 @@ appropriate to ensure that the device is not put back to sleep during the
 probe. This can happen with systems such as the network device layer.
 
 It may be desirable to suspend the device once ->probe() has finished.
-Therefore the driver core uses the asyncronous pm_request_idle() to submit a
+Therefore the driver core uses the asynchronous pm_request_idle() to submit a
 request to execute the subsystem-level idle callback for the device at that
 time.  A driver that makes use of the runtime autosuspend feature, may want to
 update the last busy mark before returning from ->probe().
-- 
2.9.3
