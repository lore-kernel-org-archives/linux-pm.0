From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 17/70] cpufreq: interactive: take idle notifications only when active
Date: Tue, 27 Oct 2015 18:30:05 +0100
Message-ID: <1445967059-6897-17-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Sam Leffler <sleffler@chromium.org>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Sam Leffler <sleffler@chromium.org>

Register an idle notifier only when the governor is active.  Also
short-circuit work of idle end if the governor is not enabled.

Signed-off-by: Sam Leffler <sleffler@chromium.org>
Change-Id: I4cae36dd2e7389540d337d74745ffbaa0131870f
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   46 ++++++++++++++++++-------=
--------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index a4ed750..2038991 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -364,6 +364,9 @@ static void cpufreq_interactive_idle_end(void)
 	struct cpufreq_interactive_cpuinfo *pcpu =3D
 		&per_cpu(cpuinfo, smp_processor_id());
=20
+	if (!pcpu->governor_enabled)
+		return;
+
 	pcpu->idling =3D 0;
 	smp_wmb();
=20
@@ -816,6 +819,26 @@ static struct attribute_group interactive_attr_gro=
up =3D {
 	.name =3D "interactive",
 };
=20
+static int cpufreq_interactive_idle_notifier(struct notifier_block *nb=
,
+					     unsigned long val,
+					     void *data)
+{
+	switch (val) {
+	case IDLE_START:
+		cpufreq_interactive_idle_start();
+		break;
+	case IDLE_END:
+		cpufreq_interactive_idle_end();
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block cpufreq_interactive_idle_nb =3D {
+	.notifier_call =3D cpufreq_interactive_idle_notifier,
+};
+
 static int cpufreq_governor_interactive(struct cpufreq_policy *policy,
 		unsigned int event)
 {
@@ -869,6 +892,7 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 			pr_warn("%s: failed to register input handler\n",
 				__func__);
=20
+		idle_notifier_register(&cpufreq_interactive_idle_nb);
 		break;
=20
 	case CPUFREQ_GOV_STOP:
@@ -891,6 +915,7 @@ static int cpufreq_governor_interactive(struct cpuf=
req_policy *policy,
 		if (atomic_dec_return(&active_count) > 0)
 			return 0;
=20
+		idle_notifier_unregister(&cpufreq_interactive_idle_nb);
 		input_unregister_handler(&cpufreq_interactive_input_handler);
 		sysfs_remove_group(cpufreq_global_kobject,
 				&interactive_attr_group);
@@ -909,26 +934,6 @@ static int cpufreq_governor_interactive(struct cpu=
freq_policy *policy,
 	return 0;
 }
=20
-static int cpufreq_interactive_idle_notifier(struct notifier_block *nb=
,
-					     unsigned long val,
-					     void *data)
-{
-	switch (val) {
-	case IDLE_START:
-		cpufreq_interactive_idle_start();
-		break;
-	case IDLE_END:
-		cpufreq_interactive_idle_end();
-		break;
-	}
-
-	return 0;
-}
-
-static struct notifier_block cpufreq_interactive_idle_nb =3D {
-	.notifier_call =3D cpufreq_interactive_idle_notifier,
-};
-
 static int __init cpufreq_interactive_init(void)
 {
 	unsigned int i;
@@ -970,7 +975,6 @@ static int __init cpufreq_interactive_init(void)
 	spin_lock_init(&down_cpumask_lock);
 	mutex_init(&set_speed_lock);
=20
-	idle_notifier_register(&cpufreq_interactive_idle_nb);
 	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
 	return cpufreq_register_governor(&cpufreq_gov_interactive);
=20
--=20
1.7.9.5
