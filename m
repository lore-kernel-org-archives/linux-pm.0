From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 05/12] power management: no valid states w/o
	pm_ops + docs
Date: Wed, 07 Feb 2007 13:45:41 +0100
Message-ID: <20070207124612.176570000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=no-pm_ops-no-valid-states.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, Pavel Macheck <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch changes /sys/power/state to not advertise any valid states
(except for disk if SOFTWARE_SUSPEND is enabled) when no pm_ops have been
set so userspace can easily discover what states should be available.

Also, because the pm ops in powermac are obviously not using them as
intended, I added documentation for it in kernel-doc format.

Reordering the fields in struct pm_ops not only makes the output of
kernel-doc make more sense but also removes a hole from the structure on
64-bit platforms.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm@lists.osdl.org
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Macheck <pavel@ucw.cz>

--- linux-2.6-git.orig/kernel/power/main.c	2007-02-07 02:55:01.676884289 +0=
100
+++ linux-2.6-git/kernel/power/main.c	2007-02-07 02:55:31.182884289 +0100
@@ -161,7 +161,10 @@ static inline int valid_state(suspend_st
 	if (state =3D=3D PM_SUSPEND_DISK)
 		return 1;
 =

-	if (pm_ops && pm_ops->valid && !pm_ops->valid(state))
+	/* all other states need lowlevel support and need to be
+	 * valid to the lowlevel implementation, no valid callback
+	 * implies that all are valid. */
+	if (!pm_ops || (pm_ops->valid && !pm_ops->valid(state)))
 		return 0;
 	return 1;
 }
--- linux-2.6-git.orig/include/linux/pm.h	2007-02-07 02:55:02.028884289 +01=
00
+++ linux-2.6-git/include/linux/pm.h	2007-02-07 02:55:31.208884289 +0100
@@ -120,15 +120,47 @@ typedef int __bitwise suspend_disk_metho
 #define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
 #define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
 =

+/**
+ * struct pm_ops
+ *
+ * Callbacks for managing platform dependent suspend states.
+ *
+ * @valid: Callback to determine whether the given state can be entered.
+ *         If %CONFIG_SOFTWARE_SUSPEND is set then %PM_SUSPEND_DISK is
+ *         always valid and never passed to this call.
+ *         If not assigned, all suspend states are advertised as valid
+ *         in /sys/power/state (but can still be rejected by prepare or en=
ter.)
+ * @prepare: Prepare the platform for the given suspend state. Can return a
+ *           negative error code if necessary.
+ * @enter: Enter the given suspend state, must be assigned. Can return a
+ *         negative error code if necessary.
+ * @finish: Called when the system has left the given state and all devices
+ *          are resumed. The return value is ignored.
+ * @pm_disk_mode: Set to the disk method that the user should be able to
+ *                configure for suspend-to-disk. Since %PM_DISK_SHUTDOWN,
+ *                %PM_DISK_REBOOT, %PM_DISK_TEST and %PM_DISK_TESTPROC
+ *                are always allowed, currently only %PM_DISK_PLATFORM
+ *                makes sense. If the user then choses %PM_DISK_PLATFORM,
+ *                the @prepare call will be called before suspending to di=
sk
+ *                (if present), the @enter call should be present and will
+ *                be called after all state has been saved and the machine
+ *                is ready to be shut down/suspended/..., and the @finish
+ *                callback is called after state has been restored. All
+ *                these calls are called with %PM_SUSPEND_DISK as the stat=
e.
+ */
 struct pm_ops {
-	suspend_disk_method_t pm_disk_mode;
 	int (*valid)(suspend_state_t state);
 	int (*prepare)(suspend_state_t state);
 	int (*enter)(suspend_state_t state);
 	int (*finish)(suspend_state_t state);
+	suspend_disk_method_t pm_disk_mode;
 };
 =

-extern void pm_set_ops(struct pm_ops *);
+/**
+ * pm_set_ops - set platform dependent power management ops
+ * @pm_ops: The new power management operations to set.
+ */
+extern void pm_set_ops(struct pm_ops *pm_ops);
 extern struct pm_ops *pm_ops;
 extern int pm_suspend(suspend_state_t state);
 =


--
