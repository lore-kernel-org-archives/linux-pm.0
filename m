From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFCv2 PATCH 02/23] sched: Make energy awareness a sched feature
Date: Thu,  3 Jul 2014 17:25:49 +0100
Message-ID: <1404404770-323-3-git-send-email-morten.rasmussen@arm.com>
References: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:44876 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758298AbaGCQ0J (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jul 2014 12:26:09 -0400
In-Reply-To: <1404404770-323-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, Dietmar.Eggemann@arm.com, pjt@google.com

This patch introduces the ENERGY_AWARE sched feature, which is
implemented using jump labels when SCHED_DEBUG is defined. It is
statically set false when SCHED_DEBUG is not defined. Hence this doesn't
allow energy awareness to be enabled without SCHED_DEBUG. This
sched_feature knob will be replaced later with a more appropriate
control knob when things have matured a bit.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/fair.c     |    5 +++++
 kernel/sched/features.h |    6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3c73122..981406e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4215,6 +4215,11 @@ static long effective_load(struct task_group *tg, in=
t cpu, long wl, long wg)
=20
 #endif
=20
+static inline bool energy_aware(void)
+{
+=09return sched_feat(ENERGY_AWARE);
+}
+
 static int wake_wide(struct task_struct *p)
 {
 =09int factor =3D this_cpu_read(sd_llc_size);
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 90284d1..199ee3a 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -83,3 +83,9 @@ SCHED_FEAT(NUMA_FAVOUR_HIGHER, true)
  */
 SCHED_FEAT(NUMA_RESIST_LOWER, false)
 #endif
+
+/*
+ * Energy aware scheduling. Use platform energy model to guide scheduling
+ * decisions optimizing for energy efficiency.
+ */
+SCHED_FEAT(ENERGY_AWARE, false)
--=20
1.7.9.5


