From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 17/23] sched: Likely idle state statistics placeholder
Date: Thu,  3 Jul 2014 17:26:04 +0100
Message-ID: <1404404770-323-18-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:47352 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267AbaGCQ0y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:26:54 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

The scheduler is currently completely unaware of idle-states. To make
informed decisions using the sched_group_energy idle_states list it
is necessary to know which idle-state a cpu (or group of cpus) is most
likely to be in when it is idle.

For example when migrating a task that wakes up periodically, the wakeup
energy expense depends on the idle-state the destination cpu is most
likely to be in when idle.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9720f04..353e2d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4254,6 +4254,19 @@ static inline bool energy_aware(void)
 =09return sched_feat(ENERGY_AWARE);
 }
=20
+/*
+ * Returns the index of the most likely idle-state that the sched_group is=
 in
+ * when idle. The index can be used to identify the idle-state in the
+ * sched_group_energy idle_states list.
+ *
+ * This is currently just a placeholder. The information needs to come fro=
m
+ * cpuidle.
+ */
+static inline int likely_idle_state_idx(struct sched_group *sg)
+{
+=09return 0;
+}
+
 static int wake_wide(struct task_struct *p)
 {
 =09int factor =3D this_cpu_read(sd_llc_size);
--=20
1.7.9.5


