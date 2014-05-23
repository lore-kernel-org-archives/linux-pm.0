From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 16/16] sched: Disable wake_affine to broaden the scope of wakeup target cpus
Date: Fri, 23 May 2014 19:16:43 +0100
Message-ID: <1400869003-27769-17-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

SD_WAKE_AFFINE is currently set by default on all levels which means
that wakeups are always handled inside the lowest level sched_domain.
That means a tiny periodic task is very likely to stay on the cpu it was
forked on forever. To save energy we need to revisit the task placement
decision every now and again to ensure that we don't keep waking the
same cpu if there are cheaper alternatives.

One way is to simply disable wake_affine and rely on the fork/exec
balancing mechanism (find_idlest_{group, cpu}). This is what this patch
does.

An alternative is to let the platform remove the SD_WAKE_AFFINE flag
from lower levels to increase the search space for
select_idle_sibling().

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 kernel/sched/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 49b895a..eeb0508 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6069,8 +6069,13 @@ sd_init(struct sched_domain_topology_level *tl, int =
cpu)
 =09=09=09=09=09| 1*SD_BALANCE_NEWIDLE
 =09=09=09=09=09| 1*SD_BALANCE_EXEC
 =09=09=09=09=09| 1*SD_BALANCE_FORK
+#ifdef CONFIG_SCHED_ENERGY
+=09=09=09=09=09| 1*SD_BALANCE_WAKE
+=09=09=09=09=09| 0*SD_WAKE_AFFINE
+#else
 =09=09=09=09=09| 0*SD_BALANCE_WAKE
 =09=09=09=09=09| 1*SD_WAKE_AFFINE
+#endif
 =09=09=09=09=09| 0*SD_SHARE_CPUPOWER
 =09=09=09=09=09| 0*SD_SHARE_PKG_RESOURCES
 =09=09=09=09=09| 0*SD_SERIALIZE
--=20
1.7.9.5
