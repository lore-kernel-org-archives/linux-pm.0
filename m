From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 60/70] cpufreq: interactive: hold reference on global cpufreq kobject if needed
Date: Tue, 27 Oct 2015 18:30:48 +0100
Message-ID: <1445967059-6897-60-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Greg Hackmann <ghackmann@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Greg Hackmann <ghackmann@google.com>

2361be23666232dbb4851a527f466c4cbf5340fc changed cpufreq to add the
global cpufreq kobject to sysfs on demand.

To ensure this happens, cpufreq_interactive must hold a reference on
this object on devices where it intends to use it (i.e., devices where
have_governor_per_policy() returns false).  Otherwise a parentless
kobject will be passed to sysfs_create_group() which will subsequently
BUG().

Change-Id: I7dd03956e1d3c6c3c0cc17c799882c235804ae09
Signed-off-by: Greg Hackmann <ghackmann@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index ff77b30..786fd01 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1154,8 +1154,10 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
 		spin_lock_init(&tunables->above_hispeed_delay_lock);
=20
 		policy->governor_data =3D tunables;
-		if (!have_governor_per_policy())
+		if (!have_governor_per_policy()) {
 			common_tunables =3D tunables;
+			WARN_ON(cpufreq_get_global_kobject());
+		}
=20
 		rc =3D sysfs_create_group(get_governor_parent_kobj(policy),
 				get_sysfs_attr());
@@ -1185,6 +1187,10 @@ static int cpufreq_governor_interactive(struct c=
pufreq_policy *policy,
=20
 			sysfs_remove_group(get_governor_parent_kobj(policy),
 					get_sysfs_attr());
+
+			if (!have_governor_per_policy())
+				cpufreq_put_global_kobject();
+
 			kfree(tunables);
 			common_tunables =3D NULL;
 		}
--=20
1.7.9.5
