From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 18/70] cpufreq: interactive: keep freezer happy when not current governor
Date: Tue, 27 Oct 2015 18:30:06 +0100
Message-ID: <1445967059-6897-18-git-send-email-czoborbalint@gmail.com>
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

=46ix a problem where the hung task mechanism was deeming the interacti=
ve
clock boost thread as hung.  This was because the thread is created at
module init but never run/woken up until needed.  If the governor is no=
t
being used this can be forever.  To workaround this explicitly wake up
the thread once all the necessary data structures are initialized.  The
latter required some minor code shuffle.

Signed-off-by: Sam Leffler <sleffler@chromium.org>
Change-Id: Ie2c058dd75dcb6460ea10e7ac997e46baf66b1fe
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 2038991..184140a 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -953,6 +953,10 @@ static int __init cpufreq_interactive_init(void)
 		pcpu->cpu_timer.data =3D i;
 	}
=20
+	spin_lock_init(&up_cpumask_lock);
+	spin_lock_init(&down_cpumask_lock);
+	mutex_init(&set_speed_lock);
+
 	up_task =3D kthread_create(cpufreq_interactive_up_task, NULL,
 				 "kinteractiveup");
 	if (IS_ERR(up_task))
@@ -968,14 +972,12 @@ static int __init cpufreq_interactive_init(void)
 	if (!down_wq)
 		goto err_freeuptask;
=20
-	INIT_WORK(&freq_scale_down_work,
-		  cpufreq_interactive_freq_down);
+	INIT_WORK(&freq_scale_down_work, cpufreq_interactive_freq_down);
+	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
=20
-	spin_lock_init(&up_cpumask_lock);
-	spin_lock_init(&down_cpumask_lock);
-	mutex_init(&set_speed_lock);
+	/* NB: wake up so the thread does not look hung to the freezer */
+	wake_up_process(up_task);
=20
-	INIT_WORK(&inputopen.inputopen_work, cpufreq_interactive_input_open);
 	return cpufreq_register_governor(&cpufreq_gov_interactive);
=20
 err_freeuptask:
--=20
1.7.9.5
