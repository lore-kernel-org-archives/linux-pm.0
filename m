From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: prevent runtime_resume from racing with probe
Date: Fri, 1 Jul 2011 17:13:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1107011132070.1988-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1107011045160.1988-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1107011045160.1988-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1475) adds device_lock() and device_unlock() calls to
the store methods for the power/control and power/autosuspend_delay_ms
sysfs attribute files.  We don't want badly timed writes to these
files to cause runtime_resume callbacks to occur while a driver is
being probed for a device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 drivers/base/power/sysfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: usb-3.0/drivers/base/power/sysfs.c
===================================================================
--- usb-3.0.orig/drivers/base/power/sysfs.c
+++ usb-3.0/drivers/base/power/sysfs.c
@@ -116,12 +116,14 @@ static ssize_t control_store(struct devi
 	cp = memchr(buf, '\n', n);
 	if (cp)
 		len = cp - buf;
+	device_lock(dev);
 	if (len == sizeof ctrl_auto - 1 && strncmp(buf, ctrl_auto, len) == 0)
 		pm_runtime_allow(dev);
 	else if (len == sizeof ctrl_on - 1 && strncmp(buf, ctrl_on, len) == 0)
 		pm_runtime_forbid(dev);
 	else
-		return -EINVAL;
+		n = -EINVAL;
+	device_unlock(dev);
 	return n;
 }
 
@@ -205,7 +207,9 @@ static ssize_t autosuspend_delay_ms_stor
 	if (strict_strtol(buf, 10, &delay) != 0 || delay != (int) delay)
 		return -EINVAL;
 
+	device_lock(dev);
 	pm_runtime_set_autosuspend_delay(dev, delay);
+	device_unlock(dev);
 	return n;
 }
 
