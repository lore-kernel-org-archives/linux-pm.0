From: Peter Chen <peter.chen@freescale.com>
Subject: [PATCH 1/1] PM / Runtime: Do not send suspend request
	after the device is shutdown
Date: Wed, 9 Nov 2011 17:42:15 +0800
Message-ID: <1320831735-28640-1-git-send-email-peter.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: hzpeterchen@gmail.com
List-Id: linux-pm@vger.kernel.org

There may be an issue when the user issue "reboot" command, then the
device has shut down its hardware, after that, this runtime-pm featured
device's driver will probably be scheduled to do its suspend routine,
and at its suspend routine, it may access hardware, but the device has
already shutdown physically, then the system hang may be occurred.

I ran out this issue with a auto-suspend supported USB devices, like
3G modem, keyboard. The usb runtime suspend routine may be scheduled
after the usb controller has been shut down, and the usb runtime suspend
routine will try to suspend its roothub(controller), it will access
register, then the system hang occurs as the controller is shutdown.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/base/power/runtime.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index acb3f83..a439227 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -150,6 +150,13 @@ static int rpm_check_suspend_allowed(struct device *dev)
 		retval = -EAGAIN;
 	else if (dev->power.runtime_status == RPM_SUSPENDED)
 		retval = 1;
+	/* 
+	 * If the device has already been shut down, DO NOT
+	 * send suspend request.
+	 */
+	else if (list_empty(&dev->kobj.entry)) {
+		retval = -ESHUTDOWN;
+	}
 
 	return retval;
 }
-- 
1.7.1
