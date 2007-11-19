From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/8] Suspend: Testing facility (rev. 2)
Date: Mon, 19 Nov 2007 23:41:19 +0100
Message-ID: <200711192341.20857.rjw__28154.0210162804$1195512114$gmane$org@sisk.pl>
References: <200711192332.15078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200711192332.15078.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Adrian Bunk <bunk@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce sysfs attribute /sys/power/pm_test allowing one to test the sus=
pend
core code. =A0Namely, writing one of the strings:

freezer
devices
platform
processors
core

to this file causes the suspend code to work in one of the test modes def=
ined as
follows:

freezer
- test the freezing of processes

devices
- test the freezing of processes and suspending of devices

platform
- test the freezing of processes, suspending of devices and platform glob=
al
=A0 control methods(*)

processors
- test the freezing of processes, suspending of devices, platform global
=A0 control methods and the disabling of nonboot CPUs

core
- test the freezing of processes, suspending of devices, platform global
=A0 control methods, the disabling of nonboot CPUs and suspending of
=A0 platform/system devices

(*) These are ACPI global control methods on ACPI systems

Then, if a suspend is started by normal means, the suspend core will perf=
orm
its normal operations up to the point indicated by given test level. =A0N=
ext, it
will wait for 5 seconds and carry out the resume operations needed to tra=
nsition
the system back to the fully functional state.

Writing "none" to /sys/power/pm_test turns the testing off.

When open for reading, /sys/power/pm_test contains a space-separated list=
 of all
available tests (including "none" that represents the normal functionalit=
y) in
which the current test level is indicated by square brackets.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/main.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++=
++-----
 kernel/power/power.h |   18 ++++++++
 2 files changed, 118 insertions(+), 9 deletions(-)

Index: linux-2.6/kernel/power/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/main.c
+++ linux-2.6/kernel/power/main.c
@@ -28,6 +28,80 @@ BLOCKING_NOTIFIER_HEAD(pm_chain_head);
=20
 DEFINE_MUTEX(pm_mutex);
=20
+#ifdef CONFIG_PM_DEBUG
+int pm_test_level =3D TEST_NONE;
+
+static int suspend_test(int level)
+{
+	if (pm_test_level =3D=3D level) {
+		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		return 1;
+	}
+	return 0;
+}
+
+static const char * const pm_tests[__TEST_AFTER_LAST] =3D {
+	[TEST_NONE] =3D "none",
+	[TEST_CORE] =3D "core",
+	[TEST_CPUS] =3D "processors",
+	[TEST_PLATFORM] =3D "platform",
+	[TEST_DEVICES] =3D "devices",
+	[TEST_FREEZER] =3D "freezer",
+};
+
+static ssize_t pm_test_show(struct kset *kset, char *buf)
+{
+	char *s =3D buf;
+	int level;
+
+	for (level =3D TEST_FIRST; level <=3D TEST_MAX; level++)
+		if (pm_tests[level]) {
+			if (level =3D=3D pm_test_level)
+				s +=3D sprintf(s, "[%s] ", pm_tests[level]);
+			else
+				s +=3D sprintf(s, "%s ", pm_tests[level]);
+		}
+
+	if (s !=3D buf)
+		/* convert the last space to a newline */
+		*(s-1) =3D '\n';
+
+	return (s - buf);
+}
+
+static ssize_t pm_test_store(struct kset *kset, const char *buf, size_t =
n)
+{
+	const char * const *s;
+	int level;
+	char *p;
+	int len;
+	int error =3D -EINVAL;
+
+	p =3D memchr(buf, '\n', n);
+	len =3D p ? p - buf : n;
+
+	mutex_lock(&pm_mutex);
+
+	level =3D TEST_FIRST;
+	for (s =3D &pm_tests[level]; level <=3D TEST_MAX; s++, level++)
+		if (*s && len =3D=3D strlen(*s) && !strncmp(buf, *s, len)) {
+			pm_test_level =3D level;
+			error =3D 0;
+			break;
+		}
+
+	mutex_unlock(&pm_mutex);
+
+	return error ? error : n;
+}
+
+power_attr(pm_test);
+#else /* !CONFIG_PM_DEBUG */
+static inline int suspend_test(int level) { return 0; }
+#endif /* !CONFIG_PM_DEBUG */
+
+
 #ifdef CONFIG_SUSPEND
=20
 /* This is just an arbitrary number */
@@ -133,7 +207,10 @@ static int suspend_enter(suspend_state_t
 		printk(KERN_ERR "Some devices failed to power down\n");
 		goto Done;
 	}
-	error =3D suspend_ops->enter(state);
+
+	if (!suspend_test(TEST_CORE))
+		error =3D suspend_ops->enter(state);
+
 	device_power_up();
  Done:
 	arch_suspend_enable_irqs();
@@ -164,16 +241,25 @@ int suspend_devices_and_enter(suspend_st
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Resume_console;
 	}
+
+	if (suspend_test(TEST_DEVICES))
+		goto Resume_devices;
+
 	if (suspend_ops->prepare) {
 		error =3D suspend_ops->prepare();
 		if (error)
 			goto Resume_devices;
 	}
+
+	if (suspend_test(TEST_PLATFORM))
+		goto Finish;
+
 	error =3D disable_nonboot_cpus();
-	if (!error)
+	if (!error && !suspend_test(TEST_CPUS))
 		suspend_enter(state);
=20
 	enable_nonboot_cpus();
+ Finish:
 	if (suspend_ops->finish)
 		suspend_ops->finish();
  Resume_devices:
@@ -240,12 +326,17 @@ static int enter_state(suspend_state_t s
 	printk("done.\n");
=20
 	pr_debug("PM: Preparing system for %s sleep\n", pm_states[state]);
-	if ((error =3D suspend_prepare()))
+	error =3D suspend_prepare();
+	if (error)
 		goto Unlock;
=20
+	if (suspend_test(TEST_FREEZER))
+		goto Finish;
+
 	pr_debug("PM: Entering %s sleep\n", pm_states[state]);
 	error =3D suspend_devices_and_enter(state);
=20
+ Finish:
 	pr_debug("PM: Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
@@ -363,18 +454,18 @@ pm_trace_store(struct kset *kset, const=20
 }
=20
 power_attr(pm_trace);
+#endif /* CONFIG_PM_TRACE */
=20
 static struct attribute * g[] =3D {
 	&state_attr.attr,
+#ifdef CONFIG_PM_TRACE
 	&pm_trace_attr.attr,
+#endif
+#ifdef CONFIG_PM_DEBUG
+	&pm_test_attr.attr,
+#endif
 	NULL,
 };
-#else
-static struct attribute * g[] =3D {
-	&state_attr.attr,
-	NULL,
-};
-#endif /* CONFIG_PM_TRACE */
=20
 static struct attribute_group attr_group =3D {
 	.attrs =3D g,
Index: linux-2.6/kernel/power/power.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -190,3 +190,21 @@ int restore_highmem(void);
 static inline unsigned int count_highmem_pages(void) { return 0; }
 static inline int restore_highmem(void) { return 0; }
 #endif
+
+/*
+ * Suspend test levels
+ */
+enum {
+	/* keep first */
+	TEST_NONE,
+	TEST_CORE,
+	TEST_CPUS,
+	TEST_PLATFORM,
+	TEST_DEVICES,
+	TEST_FREEZER,
+	/* keep last */
+	__TEST_AFTER_LAST
+};
+
+#define TEST_FIRST	TEST_NONE
+#define TEST_MAX	(__TEST_AFTER_LAST - 1)
