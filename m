From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] PM / suspend: Prevent might sleep splats
Date: Fri, 25 May 2018 11:46:45 +0200
Message-ID: <20180525094648.15464-2-bigeasy@linutronix.de>
References: <20180525094648.15464-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180525094648.15464-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, bigeasy@linutronix.de, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

timekeeping suspend/resume calls read_persistent_clock() which takes
rtc_lock. That results in might sleep warnings because at that point
we run with interrupts disabled.

We cannot convert rtc_lock to a raw spinlock as that would trigger
other might sleep warnings.

As a workaround we disable the might sleep warnings by setting
system_state to SYSTEM_SUSPEND before calling sysdev_suspend() and
restoring it to SYSTEM_RUNNING afer sysdev_resume().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: cover s2idle]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/kernel.h   | 1 +
 kernel/power/hibernate.c | 7 +++++++
 kernel/power/suspend.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6a1eb0b0aad9..7aed92624531 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -542,6 +542,7 @@ extern enum system_states {
 	SYSTEM_HALT,
 	SYSTEM_POWER_OFF,
 	SYSTEM_RESTART,
+	SYSTEM_SUSPEND,
 } system_state;
=20
 /* This cannot be an enum because some may be used in assembly source. */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 5454cc639a8d..9c85c7822383 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -287,6 +287,8 @@ static int create_image(int platform_mode)
=20
 	local_irq_disable();
=20
+	system_state =3D SYSTEM_SUSPEND;
+
 	error =3D syscore_suspend();
 	if (error) {
 		pr_err("Some system devices failed to power down, aborting hibernation\n=
");
@@ -317,6 +319,7 @@ static int create_image(int platform_mode)
 	syscore_resume();
=20
  Enable_irqs:
+	system_state =3D SYSTEM_RUNNING;
 	local_irq_enable();
=20
  Enable_cpus:
@@ -445,6 +448,7 @@ static int resume_target_kernel(bool platform_mode)
 		goto Enable_cpus;
=20
 	local_irq_disable();
+	system_state =3D SYSTEM_SUSPEND;
=20
 	error =3D syscore_suspend();
 	if (error)
@@ -478,6 +482,7 @@ static int resume_target_kernel(bool platform_mode)
 	syscore_resume();
=20
  Enable_irqs:
+	system_state =3D SYSTEM_RUNNING;
 	local_irq_enable();
=20
  Enable_cpus:
@@ -563,6 +568,7 @@ int hibernation_platform_enter(void)
 		goto Enable_cpus;
=20
 	local_irq_disable();
+	system_state =3D SYSTEM_SUSPEND;
 	syscore_suspend();
 	if (pm_wakeup_pending()) {
 		error =3D -EAGAIN;
@@ -575,6 +581,7 @@ int hibernation_platform_enter(void)
=20
  Power_up:
 	syscore_resume();
+	system_state =3D SYSTEM_RUNNING;
 	local_irq_enable();
=20
  Enable_cpus:
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 4c10be0f4843..9108a99878bf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -110,6 +110,7 @@ static void s2idle_loop(void)
 {
 	pm_pr_dbg("suspend-to-idle\n");
=20
+	system_state =3D SYSTEM_SUSPEND;
 	for (;;) {
 		int error;
=20
@@ -148,6 +149,7 @@ static void s2idle_loop(void)
=20
 		pm_wakeup_clear(false);
 	}
+	system_state =3D SYSTEM_RUNNING;
=20
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
@@ -428,6 +430,8 @@ static int suspend_enter(suspend_state_t state, bool *w=
akeup)
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
=20
+	system_state =3D SYSTEM_SUSPEND;
+
 	error =3D syscore_suspend();
 	if (!error) {
 		*wakeup =3D pm_wakeup_pending();
@@ -443,6 +447,8 @@ static int suspend_enter(suspend_state_t state, bool *w=
akeup)
 		syscore_resume();
 	}
=20
+	system_state =3D SYSTEM_RUNNING;
+
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
=20
--=20
2.17.0
