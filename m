From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 58/70] cpufreq: interactive: fix NULL pointer dereference at sysfs ops
Date: Tue, 27 Oct 2015 18:30:46 +0100
Message-ID: <1445967059-6897-58-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38882 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965618AbbJ0Rdp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:33:45 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Minsung Kim <ms925.kim@samsung.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Minsung Kim <ms925.kim@samsung.com>

sysfs ops for target_loads and above_hispeed_delay can be called before
initializing tunables at CPUFREQ_GOV_POLICY_INIT. Create sysfs entries =
after
initialization.

Change-Id: I50356198d7629731c0d32a3066d61fe8354e0001
Signed-off-by: Minsung Kim <ms925.kim@samsung.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 9f63bd1..8297ac6 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1178,13 +1178,6 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 			return -ENOMEM;
 		}
=20
-		rc =3D sysfs_create_group(get_governor_parent_kobj(policy),
-				get_sysfs_attr());
-		if (rc) {
-			kfree(tunables);
-			return rc;
-		}
-
 		tunables->usage_count =3D 1;
 		tunables->above_hispeed_delay =3D default_above_hispeed_delay;
 		tunables->nabove_hispeed_delay =3D
@@ -1200,16 +1193,26 @@ static int cpufreq_governor_interactive(struct =
cpufreq_policy *policy,
 		spin_lock_init(&tunables->target_loads_lock);
 		spin_lock_init(&tunables->above_hispeed_delay_lock);
=20
+		policy->governor_data =3D tunables;
+		if (!have_governor_per_policy())
+			common_tunables =3D tunables;
+
+		rc =3D sysfs_create_group(get_governor_parent_kobj(policy),
+				get_sysfs_attr());
+		if (rc) {
+			kfree(tunables);
+			policy->governor_data =3D NULL;
+			if (!have_governor_per_policy())
+				common_tunables =3D NULL;
+			return rc;
+		}
+
 		if (!policy->governor->initialized) {
 			idle_notifier_register(&cpufreq_interactive_idle_nb);
 			cpufreq_register_notifier(&cpufreq_notifier_block,
 					CPUFREQ_TRANSITION_NOTIFIER);
 		}
=20
-		policy->governor_data =3D tunables;
-		if (!have_governor_per_policy())
-			common_tunables =3D tunables;
-
 		break;
=20
 	case CPUFREQ_GOV_POLICY_EXIT:
--=20
1.7.9.5

