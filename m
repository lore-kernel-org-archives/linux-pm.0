From: shaohua.li@intel.com
Subject: [RFC 1/5] devcore introduce wakeup_event callback
Date: Mon, 08 Sep 2008 17:19:27 +0800
Message-ID: <20080908092305.221009807__24950.2939325341$1220865983$gmane$org@sli10-desk.sh.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=devcore-introduce-wakeup_event.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: dbrownell@users.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Introduce .wakeup_event(). When a device gets a wakeup event,
the callback is called. The callback usually should disable wakeup event.

---
 include/linux/pm.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux/include/linux/pm.h
===================================================================
--- linux.orig/include/linux/pm.h	2008-09-08 13:55:57.000000000 +0800
+++ linux/include/linux/pm.h	2008-09-08 13:56:51.000000000 +0800
@@ -125,6 +125,8 @@ typedef struct pm_message {
  *	make ANY assumptions about the hardware state right prior to @restore().
  *	On most platforms, there are no restrictions on availability of
  *	resources like clocks during @restore().
+ * @wakeup_event: Checks if a wakeup event occurs. If yes, wakeup event should
+ *      be disabled.
  *
  * All of the above callbacks, except for @complete(), return error codes.
  * However, the error codes returned by the resume operations, @resume(),
@@ -151,6 +153,7 @@ struct pm_ops {
 	int (*thaw)(struct device *dev);
 	int (*poweroff)(struct device *dev);
 	int (*restore)(struct device *dev);
+	int (*wakeup_event)(struct device *dev);
 };
 
 /**

-- 
