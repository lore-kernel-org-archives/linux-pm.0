From: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: [PATCH] tools/power turbostat: Make interval calculation per thread
 to reduce jitter
Date: Mon, 25 Mar 2019 17:32:42 +0000
Message-ID: <20190325173232.216357-1-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Turbostat currently normalizes TSC and other values by dividing by an
interval. This interval is the delta between the start of one global
(all counters on all CPUs) sampling and the start of another. However,
this introduces a lot of jitter into the data.

In order to reduce jitter, the interval calculation should be based on
timestamps taken per thread and close to the start of the thread's
sampling.

Define a per thread time value to hold the delta between samples taken
on the thread.

Use the timestamp taken at the beginning of sampling to calculate the
delta.

Move the thread's beginning timestamp to after the CPU migration to
avoid jitter due to the migration.

Use the global time delta for the average time delta.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 tools/power/x86/turbostat/turbostat.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbos=
tat/turbostat.c
index c3fad065c89c..6ebcc420021f 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -166,6 +166,7 @@ size_t cpu_present_setsize, cpu_affinity_setsize, cpu_s=
ubset_size;
 struct thread_data {
 	struct timeval tv_begin;
 	struct timeval tv_end;
+	struct timeval tv_delta;
 	unsigned long long tsc;
 	unsigned long long aperf;
 	unsigned long long mperf;
@@ -896,7 +897,7 @@ int format_counters(struct thread_data *t, struct core_=
data *c,
 	if (DO_BIC(BIC_TOD))
 		outp +=3D sprintf(outp, "%10ld.%06ld\t", t->tv_end.tv_sec, t->tv_end.tv_=
usec);
=20
-	interval_float =3D tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
+	interval_float =3D t->tv_delta.tv_sec + t->tv_delta.tv_usec/1000000.0;
=20
 	tsc =3D t->tsc * tsc_tweak;
=20
@@ -1279,6 +1280,7 @@ delta_thread(struct thread_data *new, struct thread_d=
ata *old,
 	 * over-write old w/ new so we can print end of interval values
 	 */
=20
+	timersub(&new->tv_begin, &old->tv_begin, &old->tv_delta);
 	old->tv_begin =3D new->tv_begin;
 	old->tv_end =3D new->tv_end;
=20
@@ -1374,6 +1376,8 @@ void clear_counters(struct thread_data *t, struct cor=
e_data *c, struct pkg_data
 	t->tv_begin.tv_usec =3D 0;
 	t->tv_end.tv_sec =3D 0;
 	t->tv_end.tv_usec =3D 0;
+	t->tv_delta.tv_sec =3D 0;
+	t->tv_delta.tv_usec =3D 0;
=20
 	t->tsc =3D 0;
 	t->aperf =3D 0;
@@ -1540,6 +1544,9 @@ void compute_average(struct thread_data *t, struct co=
re_data *c,
=20
 	for_all_cpus(sum_counters, t, c, p);
=20
+	/* Use the global time delta for the average. */
+	average.threads.tv_delta =3D tv_delta;
+
 	average.threads.tsc /=3D topo.num_cpus;
 	average.threads.aperf /=3D topo.num_cpus;
 	average.threads.mperf /=3D topo.num_cpus;
@@ -1729,13 +1736,13 @@ int get_counters(struct thread_data *t, struct core=
_data *c, struct pkg_data *p)
 	struct msr_counter *mp;
 	int i;
=20
-	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
-
 	if (cpu_migrate(cpu)) {
 		fprintf(outf, "Could not migrate to CPU %d\n", cpu);
 		return -1;
 	}
=20
+	gettimeofday(&t->tv_begin, (struct timezone *)NULL);
+
 	if (first_counter_read)
 		get_apic_id(t);
 retry:
--=20
2.17.1
