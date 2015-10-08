From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 1/2] PM / sleep: ensure deferred probe workqueue is finished in wait_for_device_probe
Date: Thu, 8 Oct 2015 11:57:06 -0500
Message-ID: <1444323427-6822-2-git-send-email-grygorii.strashko@ti.com>
References: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444323427-6822-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alan Stern <stern@rowland.harvard.edu>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pm@vger.kernel.org

Now wait_for_device_probe() waits for currently executing probes to finish,
but it doesn't take into account deferred probing mechanism. As result,
nothing prevents deferred probe workqueue to continue probing devices right
after wait_for_device_probe() is finished.

Hence, lest ensure deferred probe workqueue is finished in
wait_for_device_probe() before proceeding.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/base/dd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index be0eb46..98de1a5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -391,6 +391,10 @@ int driver_probe_done(void)
  */
 void wait_for_device_probe(void)
 {
+	/* wait for the deferred probe workqueue to finish */
+	if (driver_deferred_probe_enable)
+		flush_workqueue(deferred_wq);
+
 	/* wait for the known devices to complete their probing */
 	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
 	async_synchronize_full();
-- 
2.5.1
