From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 36/70] cpufreq: interactive: fix race on timer restart on governor start
Date: Tue, 27 Oct 2015 18:30:24 +0100
Message-ID: <1445967059-6897-36-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

Starting the governor, or restarting on a hotplugged-in CPU, can race
with the timer start in idle, triggering a BUG on timer already pending=
=2E
Start the timer before setting the enable flag, and use enable_sem to
protect the sequence (and ensure correct order of the update to the
enable flag).  Delete any existing timer for safety.

Change-Id: Ife77cf9fe099e8fd8543224cbf148c6722c2ffb0
Reported-by: Francisco Franco <francisco.franco@cloudcar.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 74f5609..d22d162 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -919,17 +919,17 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 				ktime_to_us(ktime_get());
 			pcpu->hispeed_validate_time =3D
 				pcpu->floor_validate_time;
-			pcpu->governor_enabled =3D 1;
-			smp_wmb();
+			down_write(&pcpu->enable_sem);
 			expires =3D jiffies + usecs_to_jiffies(timer_rate);
 			pcpu->cpu_timer.expires =3D expires;
 			add_timer_on(&pcpu->cpu_timer, j);
-
 			if (timer_slack_val >=3D 0) {
 				expires +=3D usecs_to_jiffies(timer_slack_val);
 				pcpu->cpu_slack_timer.expires =3D expires;
 				add_timer_on(&pcpu->cpu_slack_timer, j);
 			}
+			pcpu->governor_enabled =3D 1;
+			up_write(&pcpu->enable_sem);
 		}
=20
 		/*
--=20
1.7.9.5
