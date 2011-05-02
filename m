From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] PM: Print a warning if firmware is
	requested when tasks are frozen
Date: Tue, 3 May 2011 00:44:51 +0200
Message-ID: <201105030044.51661.rjw__45637.0397973389$1304376451$gmane$org@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Some drivers erroneously use request_firmware() from their ->resume()
(or ->thaw(), or ->restore()) callbacks, which is not going to work
unless the firmware has been built in.  This causes system resume to
stall until the firmware-loading timeout expires, which makes users
think that the resume has failed and reboot their machines
unnecessarily.  For this reason, make _request_firmware() print a
warning when it has been called when tasks are frozen and it's
impossible to start any new usermode helpers.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/firmware_class.c |    3 +++
 include/linux/kmod.h          |    1 +
 kernel/kmod.c                 |    8 ++++++++
 3 files changed, 12 insertions(+)

Index: linux-2.6/include/linux/kmod.h
===================================================================
--- linux-2.6.orig/include/linux/kmod.h
+++ linux-2.6/include/linux/kmod.h
@@ -113,5 +113,6 @@ extern void usermodehelper_init(void);
 
 extern int usermodehelper_disable(void);
 extern void usermodehelper_enable(void);
+extern bool usermodehelper_is_disabled(void);
 
 #endif /* __LINUX_KMOD_H__ */
Index: linux-2.6/kernel/kmod.c
===================================================================
--- linux-2.6.orig/kernel/kmod.c
+++ linux-2.6/kernel/kmod.c
@@ -301,6 +301,14 @@ void usermodehelper_enable(void)
 	usermodehelper_disabled = 0;
 }
 
+/**
+ * usermodehelper_is_disabled - check if new helpers are allowed to be started
+ */
+bool usermodehelper_is_disabled(void)
+{
+	return usermodehelper_disabled;
+}
+
 static void helper_lock(void)
 {
 	atomic_inc(&running_helpers);
Index: linux-2.6/drivers/base/firmware_class.c
===================================================================
--- linux-2.6.orig/drivers/base/firmware_class.c
+++ linux-2.6/drivers/base/firmware_class.c
@@ -521,6 +521,9 @@ static int _request_firmware(const struc
 	if (!firmware_p)
 		return -EINVAL;
 
+	if (WARN_ON(usermodehelper_is_disabled()))
+		return -EBUSY;
+
 	*firmware_p = firmware = kzalloc(sizeof(*firmware), GFP_KERNEL);
 	if (!firmware) {
 		dev_err(device, "%s: kmalloc(struct firmware) failed\n",
