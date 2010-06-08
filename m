From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH ver. 2] PM: describe kernel policy regarding
	wakeup defaults
Date: Tue, 8 Jun 2010 15:12:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006081508490.1372-100000@iolanthe.rowland.org>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1381b) updates a comment describing the kernel's policy
toward enabling wakeup by default.

It also makes device_set_wakeup_capable() actually do something when
CONFIG_PM isn't enabled.  It's not clear this is necessary; however if
it isn't then device_init_wakeup() and device_can_wakeup() should also
be do-nothing routines.  Furthermore, I don't expect this change to
have any noticeable effect -- but if it does then clearly the old
behavior was wrong.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Rafael, I don't know if you got the earlier version of this patch.  
This one applies against 2.6.35-rc1.



Index: usb-2.6/include/linux/pm_wakeup.h
===================================================================
--- usb-2.6.orig/include/linux/pm_wakeup.h
+++ usb-2.6/include/linux/pm_wakeup.h
@@ -29,8 +29,11 @@
 
 #ifdef CONFIG_PM
 
-/* changes to device_may_wakeup take effect on the next pm state change.
- * by default, devices should wakeup if they can.
+/* Changes to device_may_wakeup take effect on the next pm state change.
+ *
+ * By default, most devices should leave wakeup disabled.  The exceptions
+ * are devices that everyone expects to be wakeup sources: keyboards,
+ * power buttons, possibly network interfaces, etc.
  */
 static inline void device_init_wakeup(struct device *dev, bool val)
 {
@@ -59,7 +62,7 @@ static inline bool device_may_wakeup(str
 
 #else /* !CONFIG_PM */
 
-/* For some reason the next two routines work even without CONFIG_PM */
+/* For some reason the following routines work even without CONFIG_PM */
 static inline void device_init_wakeup(struct device *dev, bool val)
 {
 	dev->power.can_wakeup = val;
@@ -67,6 +70,7 @@ static inline void device_init_wakeup(st
 
 static inline void device_set_wakeup_capable(struct device *dev, bool capable)
 {
+	dev->power.can_wakeup = capable;
 }
 
 static inline bool device_can_wakeup(struct device *dev)
