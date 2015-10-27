From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 56/70] cpufreq: interactive: delete timers for GOV_START
Date: Tue, 27 Oct 2015 18:30:44 +0100
Message-ID: <1445967059-6897-56-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Shridhar Rasal <srasal@nvidia.com>, Bharat Nihalani <bnihalani@nvidia.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Shridhar Rasal <srasal@nvidia.com>

Make sure that timers cpu_timer and cpu_slack_timer
deactivated before addition of new.

Change-Id: If31c4049606871df6f00efdc24b1d713c86a6f69
Signed-off-by: Shridhar Rasal <srasal@nvidia.com>
Signed-off-by: Bharat Nihalani <bnihalani@nvidia.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 66c096d..d72e8c4 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -1247,6 +1247,8 @@ static int cpufreq_governor_interactive(struct cp=
ufreq_policy *policy,
 			pcpu->hispeed_validate_time =3D
 				pcpu->floor_validate_time;
 			down_write(&pcpu->enable_sem);
+			del_timer_sync(&pcpu->cpu_timer);
+			del_timer_sync(&pcpu->cpu_slack_timer);
 			cpufreq_interactive_timer_start(tunables, j);
 			pcpu->governor_enabled =3D 1;
 			up_write(&pcpu->enable_sem);
--=20
1.7.9.5
