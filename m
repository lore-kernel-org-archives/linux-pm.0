From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 08/16] sched: Introduce SD_SHARE_CAP_STATES sched_domain flag
Date: Fri, 23 May 2014 19:16:35 +0100
Message-ID: <1400869003-27769-9-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

cpufreq is currently keeping it a secret which cpus are sharing
clock source. The scheduler needs to know about clock domains as well
to become more energy aware. The SD_SHARE_CAP_STATES domain indicates
whether cpus belonging to the domain share capacity states (P-states).

There is no connection with cpufreq (yet). The flag must be set by
the arch specific topology code.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 arch/arm/kernel/topology.c |    3 ++-
 include/linux/sched.h      |    1 +
 kernel/sched/core.c        |   10 +++++++---
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 0b9c1e0..c78d497 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -383,7 +383,8 @@ static inline const struct sched_energy *cpu_sys_energy=
(int cpu)
=20
 static inline const int cpu_corepower_flags(void)
 {
-=09return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
+=09return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN | \
+=09=09SD_SHARE_CAP_STATES;
 }
=20
 static struct sched_domain_topology_level arm_topology[] =3D {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4eb149b..62d61b5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -877,6 +877,7 @@ enum cpu_idle_type {
 #define SD_PREFER_SIBLING=090x1000=09/* Prefer to place tasks in a sibling=
 domain */
 #define SD_OVERLAP=09=090x2000=09/* sched_domains of this level overlap */
 #define SD_NUMA=09=09=090x4000=09/* cross-node balancing */
+#define SD_SHARE_CAP_STATES=090x8000  /* Domain members share capacity sta=
te */
=20
 #ifdef CONFIG_SCHED_SMT
 static inline const int cpu_smt_flags(void)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 530a348..49b895a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5322,7 +5322,8 @@ static int sd_degenerate(struct sched_domain *sd)
 =09=09=09 SD_BALANCE_EXEC |
 =09=09=09 SD_SHARE_CPUPOWER |
 =09=09=09 SD_SHARE_PKG_RESOURCES |
-=09=09=09 SD_SHARE_POWERDOMAIN)) {
+=09=09=09 SD_SHARE_POWERDOMAIN |
+=09=09=09 SD_SHARE_CAP_STATES)) {
 =09=09if (sd->groups !=3D sd->groups->next)
 =09=09=09return 0;
 =09}
@@ -5354,7 +5355,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct =
sched_domain *parent)
 =09=09=09=09SD_SHARE_CPUPOWER |
 =09=09=09=09SD_SHARE_PKG_RESOURCES |
 =09=09=09=09SD_PREFER_SIBLING |
-=09=09=09=09SD_SHARE_POWERDOMAIN);
+=09=09=09=09SD_SHARE_POWERDOMAIN |
+=09=09=09=09SD_SHARE_CAP_STATES);
 =09=09if (nr_node_ids =3D=3D 1)
 =09=09=09pflags &=3D ~SD_SERIALIZE;
 =09}
@@ -6016,6 +6018,7 @@ static int sched_domains_curr_level;
  * SD_SHARE_PKG_RESOURCES - describes shared caches
  * SD_NUMA                - describes NUMA topologies
  * SD_SHARE_POWERDOMAIN   - describes shared power domain
+ * SD_SHARE_CAP_STATES    - describes shared capacity states
  *
  * Odd one out:
  * SD_ASYM_PACKING        - describes SMT quirks
@@ -6025,7 +6028,8 @@ static int sched_domains_curr_level;
 =09 SD_SHARE_PKG_RESOURCES |=09\
 =09 SD_NUMA |=09=09=09\
 =09 SD_ASYM_PACKING |=09=09\
-=09 SD_SHARE_POWERDOMAIN)
+=09 SD_SHARE_POWERDOMAIN |=09=09\
+=09 SD_SHARE_CAP_STATES)
=20
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl, int cpu)
--=20
1.7.9.5
