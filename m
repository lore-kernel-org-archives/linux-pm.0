From: Len Brown <lenb@kernel.org>
Subject: [PATCH v4] tools: create power/x86/turbostat
Date: Tue, 07 Dec 2010 01:00:45 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012070053470.5514__14498.5992847525$1291701765$gmane$org@x980>
References: <alpine.LFD.2.00.1010230116590.29399@localhost.localdomain>
	<alpine.LFD.2.00.1010240004180.23060@localhost.localdomain>
	<alpine.LFD.2.00.1010262312090.3209@localhost.localdomain>
	<alpine.LFD.2.00.1011151056380.2939@x980>
	<alpine.LFD.2.00.1011232353440.20657@x980>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1458846773-1291701647=:5514"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <alpine.LFD.2.00.1011232353440.20657@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1458846773-1291701647=:5514
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id oB761CSk009338

From: Len Brown <len.brown@intel.com>

turbostat is a tool to help verify proper operation
of processor power management states on modern x86.

Signed-off-by: Len Brown <len.brown@intel.com>
---
v4: fix open file descriptor leak, reported by David C. Wong

 tools/power/x86/turbostat/Makefile    |    8 +
 tools/power/x86/turbostat/turbostat.8 |  172 ++++++
 tools/power/x86/turbostat/turbostat.c | 1048 +++++++++++++++++++++++++++=
++++++
 3 files changed, 1228 insertions(+), 0 deletions(-)

diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbost=
at/Makefile
new file mode 100644
index 0000000..fd8e1f1
--- /dev/null
+++ b/tools/power/x86/turbostat/Makefile
@@ -0,0 +1,8 @@
+turbostat : turbostat.c
+
+clean :
+	rm -f turbostat
+
+install :
+	install turbostat /usr/bin/turbostat
+	install turbostat.8 /usr/share/man/man8
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turb=
ostat/turbostat.8
new file mode 100644
index 0000000..ff75125
--- /dev/null
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -0,0 +1,172 @@
+.TH TURBOSTAT 8
+.SH NAME
+turbostat \- Report processor frequency and idle statistics
+.SH SYNOPSIS
+.ft B
+.B turbostat
+.RB [ "\-v" ]
+.RB [ "\-M MSR#" ]
+.RB command
+.br
+.B turbostat
+.RB [ "\-v" ]
+.RB [ "\-M MSR#" ]
+.RB [ "\-i interval_sec" ]
+.SH DESCRIPTION
+\fBturbostat \fP reports processor topology, frequency
+and idle power state statistics on modern X86 processors.
+Either \fBcommand\fP is forked and statistics are printed
+upon its completion, or statistics are printed periodically.
+
+\fBturbostat \fP
+requires that the processor
+supports an "invariant" TSC, plus the APERF and MPERF MSRs.
+\fBturbostat \fP will report idle cpu power state residency
+on processors that additionally support C-state residency counters.
+
+.SS Options
+The \fB-v\fP option increases verbosity.
+.PP
+The \fB-M MSR#\fP option dumps the specified MSR,
+in addition to the usual frequency and idle statistics.
+.PP
+The \fB-i interval_sec\fP option prints statistics every \fiinterval_sec=
\fP seconds.
+The default is 5 seconds.
+.PP
+The \fBcommand\fP parameter forks \fBcommand\fP and upon its exit,
+displays the statistics gathered since it was forked.
+.PP
+.SH FIELD DESCRIPTIONS
+.nf
+\fBpkg\fP processor package number.
+\fBcore\fP processor core number.
+\fBCPU\fP Linux CPU (logical processor) number.
+\fB%c0\fP percent of the interval that the CPU retired instructions.
+\fBGHz\fP average clock rate while the CPU was in c0 state.
+\fBTSC\fP average GHz that the TSC ran during the entire interval.
+\fB%c1, %c3, %c6\fP show the percentage residency in hardware core idle =
states.
+\fB%pc3, %pc6\fP percentage residency in hardware package idle states.
+.fi
+.PP
+.SH EXAMPLE
+Without any parameters, turbostat prints out counters ever 5 seconds.
+(override interval with "-i sec" option, or specify a command
+for turbostat to fork).
+
+The first row of statistics reflect the average for the entire system.
+Subsequent rows show per-CPU statistics.
+
+.nf
+[root@x980]# ./turbostat
+core CPU   %c0   GHz  TSC   %c1    %c3    %c6   %pc3   %pc6
+          0.04 1.62 3.38   0.11   0.00  99.85   0.00  95.07
+  0   0   0.04 1.62 3.38   0.06   0.00  99.90   0.00  95.07
+  0   6   0.02 1.62 3.38   0.08   0.00  99.90   0.00  95.07
+  1   2   0.10 1.62 3.38   0.29   0.00  99.61   0.00  95.07
+  1   8   0.11 1.62 3.38   0.28   0.00  99.61   0.00  95.07
+  2   4   0.01 1.62 3.38   0.01   0.00  99.98   0.00  95.07
+  2  10   0.01 1.61 3.38   0.02   0.00  99.98   0.00  95.07
+  8   1   0.07 1.62 3.38   0.15   0.00  99.78   0.00  95.07
+  8   7   0.03 1.62 3.38   0.19   0.00  99.78   0.00  95.07
+  9   3   0.01 1.62 3.38   0.02   0.00  99.98   0.00  95.07
+  9   9   0.01 1.62 3.38   0.02   0.00  99.98   0.00  95.07
+ 10   5   0.01 1.62 3.38   0.13   0.00  99.86   0.00  95.07
+ 10  11   0.08 1.62 3.38   0.05   0.00  99.86   0.00  95.07
+.fi
+.SH VERBOSE EXAMPLE
+The "-v" option adds verbosity to the output:
+
+.nf
+GenuineIntel 11 CPUID levels; family:model:stepping 0x6:2c:2 (6:44:2)
+12 * 133 =3D 1600 MHz max efficiency
+25 * 133 =3D 3333 MHz TSC frequency
+26 * 133 =3D 3467 MHz max turbo 4 active cores
+26 * 133 =3D 3467 MHz max turbo 3 active cores
+27 * 133 =3D 3600 MHz max turbo 2 active cores
+27 * 133 =3D 3600 MHz max turbo 1 active cores
+
+.fi
+The \fBmax efficiency\fP frequency, a.k.a. Low Frequency Mode, is the fr=
equency
+available at the minimum package voltage.  The \fBTSC frequency\fP is th=
e nominal
+maximum frequency of the processor if turbo-mode were not available.  Th=
is frequency
+should be sustainable on all CPUs indefinitely, given nominal power and =
cooling.
+The remaining rows show what maximum turbo frequency is possible
+depending on the number of idle cores.  Note that this information is
+not available on all processors.
+.SH FORK EXAMPLE
+If turbostat is invoked with a command, it will fork that command
+and output the statistics gathered when the command exits.
+eg. Here a cycle soaker is run on 1 CPU (see %c0) for a few seconds
+until ^C while the other CPUs are mostly idle:
+
+.nf
+[root@x980 lenb]# ./turbostat cat /dev/zero > /dev/null
+
+^Ccore CPU   %c0   GHz  TSC   %c1    %c3    %c6   %pc3   %pc6
+           8.49 3.63 3.38  16.23   0.66  74.63   0.00   0.00
+   0   0   1.22 3.62 3.38  32.18   0.00  66.60   0.00   0.00
+   0   6   0.40 3.61 3.38  33.00   0.00  66.60   0.00   0.00
+   1   2   0.11 3.14 3.38   0.19   3.95  95.75   0.00   0.00
+   1   8   0.05 2.88 3.38   0.25   3.95  95.75   0.00   0.00
+   2   4   0.00 3.13 3.38   0.02   0.00  99.98   0.00   0.00
+   2  10   0.00 3.09 3.38   0.02   0.00  99.98   0.00   0.00
+   8   1   0.04 3.50 3.38  14.43   0.00  85.54   0.00   0.00
+   8   7   0.03 2.98 3.38  14.43   0.00  85.54   0.00   0.00
+   9   3   0.00 3.16 3.38 100.00   0.00   0.00   0.00   0.00
+   9   9  99.93 3.63 3.38   0.06   0.00   0.00   0.00   0.00
+  10   5   0.01 2.82 3.38   0.08   0.00  99.91   0.00   0.00
+  10  11   0.02 3.36 3.38   0.06   0.00  99.91   0.00   0.00
+6.950866 sec
+
+.fi
+Above the cycle soaker drives cpu9 up 3.6 Ghz turbo limit
+while the other processors are generally in various states of idle.
+
+Note that cpu3 is an HT sibling sharing core9
+with cpu9, and thus it is unable to get to an idle state
+deeper than c1 while cpu9 is busy.
+
+Note that turbostat reports average GHz of 3.61, while
+the arithmetic average of the GHz column above is 3.24.
+This is a weighted average, where the weight is %c0.  ie. it is the tota=
l number of
+un-halted cycles elapsed per time divided by the number of CPUs.
+.SH NOTES
+
+.B "turbostat "
+must be run as root.
+
+.B "turbostat "
+reads hardware counters, but doesn't write them.
+So it will not interfere with the OS or other programs, including
+multiple invocations of itself.
+
+\fBturbostat \fP
+may work poorly on Linux-2.6.20 through 2.6.29,
+as \fBacpi-cpufreq \fPperiodically cleared the APERF and MPERF
+in those kernels.
+
+The APERF, MPERF MSRs are defined to count non-halted cycles.
+Although it is not guaranteed by the architecture, turbostat assumes
+that they count at TSC rate, which is true on all processors tested to d=
ate.
+
+.SH REFERENCES
+"Intel=C2=AE Turbo Boost Technology
+in Intel=C2=AE Core=E2=84=A2 Microarchitecture (Nehalem) Based Processor=
s"
+http://download.intel.com/design/processor/applnots/320354.pdf
+
+"Intel=C2=AE 64 and IA-32 Architectures Software Developer's Manual
+Volume 3B: System Programming Guide"
+http://www.intel.com/products/processor/manuals/
+
+.SH FILES
+.ta
+.nf
+/dev/cpu/*/msr
+.fi
+
+.SH "SEE ALSO"
+msr(4), vmstat(8)
+.PP
+.SH AUTHORS
+.nf
+Written by Len Brown <len.brown@intel.com>
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
new file mode 100644
index 0000000..4c6983d
--- /dev/null
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -0,0 +1,1048 @@
+/*
+ * turbostat -- show CPU frequency and C-state residency
+ * on modern Intel turbo-capable processors.
+ *
+ * Copyright (c) 2010, Intel Corporation.
+ * Len Brown <len.brown@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify =
it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOU=
T
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License=
 for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License alo=
ng with
+ * this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <sys/resource.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <sys/time.h>
+#include <stdlib.h>
+#include <dirent.h>
+#include <string.h>
+#include <ctype.h>
+
+#define MSR_TSC	0x10
+#define MSR_NEHALEM_PLATFORM_INFO	0xCE
+#define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1AD
+#define MSR_APERF	0xE8
+#define MSR_MPERF	0xE7
+#define MSR_PKG_C2_RESIDENCY	0x60D	/* SNB only */
+#define MSR_PKG_C3_RESIDENCY	0x3F8
+#define MSR_PKG_C6_RESIDENCY	0x3F9
+#define MSR_PKG_C7_RESIDENCY	0x3FA	/* SNB only */
+#define MSR_CORE_C3_RESIDENCY	0x3FC
+#define MSR_CORE_C6_RESIDENCY	0x3FD
+#define MSR_CORE_C7_RESIDENCY	0x3FE	/* SNB only */
+
+char *proc_stat =3D "/proc/stat";
+unsigned int interval_sec =3D 5;	/* set with -i interval_sec */
+unsigned int verbose;		/* set with -v */
+unsigned int skip_c0;
+unsigned int skip_c1;
+unsigned int do_nhm_cstates;
+unsigned int do_snb_cstates;
+unsigned int has_aperf;
+unsigned int units =3D 1000000000;	/* Ghz etc */
+unsigned int genuine_intel;
+unsigned int has_invariant_tsc;
+unsigned int do_nehalem_platform_info;
+unsigned int do_nehalem_turbo_ratio_limit;
+unsigned int extra_msr_offset;
+double bclk;
+unsigned int show_pkg;
+unsigned int show_core;
+unsigned int show_cpu;
+
+int aperf_mperf_unstable;
+int backwards_count;
+char *progname;
+int need_reinitialize;
+
+int num_cpus;
+
+typedef struct per_cpu_counters {
+	unsigned long long tsc;		/* per thread */
+	unsigned long long aperf;	/* per thread */
+	unsigned long long mperf;	/* per thread */
+	unsigned long long c1;	/* per thread (calculated) */
+	unsigned long long c3;	/* per core */
+	unsigned long long c6;	/* per core */
+	unsigned long long c7;	/* per core */
+	unsigned long long pc2;	/* per package */
+	unsigned long long pc3;	/* per package */
+	unsigned long long pc6;	/* per package */
+	unsigned long long pc7;	/* per package */
+	unsigned long long extra_msr;	/* per thread */
+	int pkg;
+	int core;
+	int cpu;
+	struct per_cpu_counters *next;
+} PCC;
+
+PCC *pcc_even;
+PCC *pcc_odd;
+PCC *pcc_delta;
+PCC *pcc_average;
+struct timeval tv_even;
+struct timeval tv_odd;
+struct timeval tv_delta;
+
+unsigned long long get_msr(int cpu, off_t offset)
+{
+	ssize_t retval;
+	unsigned long long msr;
+	char pathname[32];
+	int fd;
+
+	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	fd =3D open(pathname, O_RDONLY);
+	if (fd < 0) {
+		perror(pathname);
+		need_reinitialize =3D 1;
+		return 0;
+	}
+
+	retval =3D pread(fd, &msr, sizeof msr, offset);
+	if (retval !=3D sizeof msr) {
+		fprintf(stderr, "cpu%d pread(..., 0x%zx) =3D %jd\n",
+			cpu, offset, retval);
+		exit(-2);
+	}
+
+	close(fd);
+	return msr;
+}
+
+void print_header()
+{
+	if (show_pkg)
+		fprintf(stderr, "pkg ");
+	if (show_core)
+		fprintf(stderr, "core");
+	if (show_cpu)
+		fprintf(stderr, " CPU");
+	if (do_nhm_cstates)
+		fprintf(stderr, "   %%c0 ");
+	if (has_aperf)
+		fprintf(stderr, "  GHz");
+	fprintf(stderr, "  TSC");
+	if (do_nhm_cstates)
+		fprintf(stderr, "   %%c1 ");
+	if (do_nhm_cstates)
+		fprintf(stderr, "   %%c3 ");
+	if (do_nhm_cstates)
+		fprintf(stderr, "   %%c6 ");
+	if (do_snb_cstates)
+		fprintf(stderr, "   %%c7 ");
+	if (do_snb_cstates)
+		fprintf(stderr, "  %%pc2 ");
+	if (do_nhm_cstates)
+		fprintf(stderr, "  %%pc3 ");
+	if (do_nhm_cstates)
+		fprintf(stderr, "  %%pc6 ");
+	if (do_snb_cstates)
+		fprintf(stderr, "  %%pc7 ");
+	if (extra_msr_offset)
+		fprintf(stderr, "       MSR 0x%x ", extra_msr_offset);
+
+	putc('\n', stderr);
+}
+
+void dump_pcc(PCC *pcc)
+{
+	fprintf(stderr, "package: %d ", pcc->pkg);
+	fprintf(stderr, "core:: %d ", pcc->core);
+	fprintf(stderr, "CPU: %d ", pcc->cpu);
+	fprintf(stderr, "TSC: %016llX\n", pcc->tsc);
+	fprintf(stderr, "c3: %016llX\n", pcc->c3);
+	fprintf(stderr, "c6: %016llX\n", pcc->c6);
+	fprintf(stderr, "c7: %016llX\n", pcc->c7);
+	fprintf(stderr, "aperf: %016llX\n", pcc->aperf);
+	fprintf(stderr, "pc2: %016llX\n", pcc->pc2);
+	fprintf(stderr, "pc3: %016llX\n", pcc->pc3);
+	fprintf(stderr, "pc6: %016llX\n", pcc->pc6);
+	fprintf(stderr, "pc7: %016llX\n", pcc->pc7);
+	fprintf(stderr, "msr0x%x: %016llX\n", extra_msr_offset, pcc->extra_msr)=
;
+}
+
+void dump_list(PCC *pcc)
+{
+	printf("dump_list 0x%p\n", pcc);
+
+	for (; pcc; pcc =3D pcc->next)
+		dump_pcc(pcc);
+}
+
+void print_pcc(PCC *p)
+{
+	double interval_float;
+
+	interval_float =3D tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;
+
+	/* topology columns, print blanks on 1st (average) line */
+	if (p =3D=3D pcc_average) {
+		if (show_pkg)
+			fprintf(stderr, "    ");
+		if (show_core)
+			fprintf(stderr, "    ");
+		if (show_cpu)
+			fprintf(stderr, "    ");
+	} else {
+		if (show_pkg)
+			fprintf(stderr, "%4d", p->pkg);
+		if (show_core)
+			fprintf(stderr, "%4d", p->core);
+		if (show_cpu)
+			fprintf(stderr, "%4d", p->cpu);
+	}
+
+	/* %c0 */
+	if (do_nhm_cstates) {
+		if (!skip_c0)
+			fprintf(stderr, "%7.2f", 100.0 * p->mperf/p->tsc);
+		else
+			fprintf(stderr, "   ****");
+	}
+
+	/* GHz */
+	if (has_aperf) {
+		if (!aperf_mperf_unstable) {
+			fprintf(stderr, "%5.2f",
+				1.0 * p->tsc / units * p->aperf /
+				p->mperf / interval_float);
+		} else {
+			if (p->aperf > p->tsc || p->mperf > p->tsc) {
+				fprintf(stderr, " ****");
+			} else {
+				fprintf(stderr, "%4.1f*",
+					1.0 * p->tsc /
+					units * p->aperf /
+					p->mperf / interval_float);
+			}
+		}
+	}
+
+	/* TSC */
+	fprintf(stderr, "%5.2f", 1.0 * p->tsc/units/interval_float);
+
+	if (do_nhm_cstates) {
+		if (!skip_c1)
+			fprintf(stderr, "%7.2f", 100.0 * p->c1/p->tsc);
+		else
+			fprintf(stderr, "   ****");
+	}
+	if (do_nhm_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->c3/p->tsc);
+	if (do_nhm_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->c6/p->tsc);
+	if (do_snb_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->c7/p->tsc);
+	if (do_snb_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->pc2/p->tsc);
+	if (do_nhm_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->pc3/p->tsc);
+	if (do_nhm_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->pc6/p->tsc);
+	if (do_snb_cstates)
+		fprintf(stderr, "%7.2f", 100.0 * p->pc7/p->tsc);
+	if (extra_msr_offset)
+		fprintf(stderr, "  0x%016llx", p->extra_msr);
+	putc('\n', stderr);
+}
+
+void print_counters(PCC *cnt)
+{
+	PCC *pcc;
+
+	print_header();
+
+	if (num_cpus > 1)
+		print_pcc(pcc_average);
+
+	for (pcc =3D cnt; pcc !=3D NULL; pcc =3D pcc->next)
+		print_pcc(pcc);
+
+}
+
+#define SUBTRACT_COUNTER(after, before, delta) (delta =3D (after - befor=
e), (before > after))
+
+
+int compute_delta(PCC *after, PCC *before, PCC *delta)
+{
+	int errors =3D 0;
+	int perf_err =3D 0;
+
+	skip_c0 =3D skip_c1 =3D 0;
+
+	for ( ; after && before && delta;
+		after =3D after->next, before =3D before->next, delta =3D delta->next)=
 {
+		if (before->cpu !=3D after->cpu) {
+			printf("cpu configuration changed: %d !=3D %d\n",
+				before->cpu, after->cpu);
+			return -1;
+		}
+
+		if (SUBTRACT_COUNTER(after->tsc, before->tsc, delta->tsc)) {
+			fprintf(stderr, "cpu%d TSC went backwards %llX to %llX\n",
+				before->cpu, before->tsc, after->tsc);
+			errors++;
+		}
+		/* check for TSC < 1 Mcycles over interval */
+		if (delta->tsc < (1000 * 1000)) {
+			fprintf(stderr, "Insanely slow TSC rate,"
+				" TSC stops in idle?\n");
+			fprintf(stderr, "You can disable all c-states"
+				" by booting with \"idle=3Dpoll\"\n");
+			fprintf(stderr, "or just the deep ones with"
+				" \"processor.max_cstate=3D1\"\n");
+			exit(-3);
+		}
+		if (SUBTRACT_COUNTER(after->c3, before->c3, delta->c3)) {
+			fprintf(stderr, "cpu%d c3 counter went backwards %llX to %llX\n",
+				before->cpu, before->c3, after->c3);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->c6, before->c6, delta->c6)) {
+			fprintf(stderr, "cpu%d c6 counter went backwards %llX to %llX\n",
+				before->cpu, before->c6, after->c6);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->c7, before->c7, delta->c7)) {
+			fprintf(stderr, "cpu%d c7 counter went backwards %llX to %llX\n",
+				before->cpu, before->c7, after->c7);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->pc2, before->pc2, delta->pc2)) {
+			fprintf(stderr, "cpu%d pc2 counter went backwards %llX to %llX\n",
+				before->cpu, before->pc2, after->pc2);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->pc3, before->pc3, delta->pc3)) {
+			fprintf(stderr, "cpu%d pc3 counter went backwards %llX to %llX\n",
+				before->cpu, before->pc3, after->pc3);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->pc6, before->pc6, delta->pc6)) {
+			fprintf(stderr, "cpu%d pc6 counter went backwards %llX to %llX\n",
+				before->cpu, before->pc6, after->pc6);
+			errors++;
+		}
+		if (SUBTRACT_COUNTER(after->pc7, before->pc7, delta->pc7)) {
+			fprintf(stderr, "cpu%d pc7 counter went backwards %llX to %llX\n",
+				before->cpu, before->pc7, after->pc7);
+			errors++;
+		}
+
+		perf_err =3D SUBTRACT_COUNTER(after->aperf, before->aperf, delta->aper=
f);
+		if (perf_err) {
+			fprintf(stderr, "cpu%d aperf counter went backwards %llX to %llX\n",
+				before->cpu, before->aperf, after->aperf);
+		}
+		perf_err |=3D SUBTRACT_COUNTER(after->mperf, before->mperf, delta->mpe=
rf);
+		if (perf_err) {
+			fprintf(stderr, "cpu%d mperf counter went backwards %llX to %llX\n",
+				before->cpu, before->mperf, after->mperf);
+		}
+		if (perf_err) {
+			if (!aperf_mperf_unstable) {
+				fprintf(stderr, "%s: APERF or MPERF went backwards *\n", progname);
+				fprintf(stderr, "* Frequency results do not cover entire interval *\=
n");
+				fprintf(stderr, "* fix this by running Linux-2.6.30 or later *\n");
+
+				aperf_mperf_unstable =3D 1;
+			}
+			/*
+			 * mperf delta is likely a huge "positive" number
+			 * can not use it for calculating c0 time
+			 */
+			skip_c0 =3D 1;
+			skip_c1 =3D 1;
+		}
+
+		/*
+		 * As mperf and tsc collection are not atomic,
+		 * it is possible for mperf's non-halted cycles
+		 * to exceed TSC's all cycles: show c1 =3D 0% in that case.
+		 */
+		if (delta->mperf > delta->tsc)
+			delta->c1 =3D 0;
+		else /* normal case, derive c1 */
+			delta->c1 =3D delta->tsc - delta->mperf
+				- delta->c3 - delta->c6 - delta->c7;
+
+		if (delta->mperf =3D=3D 0)
+			delta->mperf =3D 1;	/* divide by 0 protection */
+
+		/*
+		 * for "extra msr", just copy the latest w/o subtracting
+		 */
+		delta->extra_msr =3D after->extra_msr;
+		if (errors) {
+			fprintf(stderr, "ERROR cpu%d before:\n", before->cpu);
+			dump_pcc(before);
+			fprintf(stderr, "ERROR cpu%d after:\n", before->cpu);
+			dump_pcc(after);
+			errors =3D 0;
+		}
+	}
+	return 0;
+}
+
+void compute_average(PCC *delta, PCC *avg)
+{
+	PCC *sum;
+
+	sum =3D calloc(1, sizeof(PCC));
+	if (sum =3D=3D NULL) {
+		perror("calloc sum");
+		exit(1);
+	}
+
+	for (; delta; delta =3D delta->next) {
+		sum->tsc +=3D delta->tsc;
+		sum->c1 +=3D delta->c1;
+		sum->c3 +=3D delta->c3;
+		sum->c6 +=3D delta->c6;
+		sum->c7 +=3D delta->c7;
+		sum->aperf +=3D delta->aperf;
+		sum->mperf +=3D delta->mperf;
+		sum->pc2 +=3D delta->pc2;
+		sum->pc3 +=3D delta->pc3;
+		sum->pc6 +=3D delta->pc6;
+		sum->pc7 +=3D delta->pc7;
+	}
+	avg->tsc =3D sum->tsc/num_cpus;
+	avg->c1 =3D sum->c1/num_cpus;
+	avg->c3 =3D sum->c3/num_cpus;
+	avg->c6 =3D sum->c6/num_cpus;
+	avg->c7 =3D sum->c7/num_cpus;
+	avg->aperf =3D sum->aperf/num_cpus;
+	avg->mperf =3D sum->mperf/num_cpus;
+	avg->pc2 =3D sum->pc2/num_cpus;
+	avg->pc3 =3D sum->pc3/num_cpus;
+	avg->pc6 =3D sum->pc6/num_cpus;
+	avg->pc7 =3D sum->pc7/num_cpus;
+
+	free(sum);
+}
+
+void get_counters(PCC *pcc)
+{
+	for ( ; pcc; pcc =3D pcc->next) {
+		pcc->tsc =3D get_msr(pcc->cpu, MSR_TSC);
+		if (do_nhm_cstates)
+			pcc->c3 =3D get_msr(pcc->cpu, MSR_CORE_C3_RESIDENCY);
+		if (do_nhm_cstates)
+			pcc->c6 =3D get_msr(pcc->cpu, MSR_CORE_C6_RESIDENCY);
+		if (do_snb_cstates)
+			pcc->c7 =3D get_msr(pcc->cpu, MSR_CORE_C7_RESIDENCY);
+		if (has_aperf)
+			pcc->aperf =3D get_msr(pcc->cpu, MSR_APERF);
+		if (has_aperf)
+			pcc->mperf =3D get_msr(pcc->cpu, MSR_MPERF);
+		if (do_snb_cstates)
+			pcc->pc2 =3D get_msr(pcc->cpu, MSR_PKG_C2_RESIDENCY);
+		if (do_nhm_cstates)
+			pcc->pc3 =3D get_msr(pcc->cpu, MSR_PKG_C3_RESIDENCY);
+		if (do_nhm_cstates)
+			pcc->pc6 =3D get_msr(pcc->cpu, MSR_PKG_C6_RESIDENCY);
+		if (do_snb_cstates)
+			pcc->pc7 =3D get_msr(pcc->cpu, MSR_PKG_C7_RESIDENCY);
+		if (extra_msr_offset)
+			pcc->extra_msr =3D get_msr(pcc->cpu, extra_msr_offset);
+	}
+}
+
+
+void print_nehalem_info()
+{
+	unsigned long long msr;
+	unsigned int ratio;
+
+	if (!do_nehalem_platform_info)
+		return;
+
+	msr =3D get_msr(0, MSR_NEHALEM_PLATFORM_INFO);
+
+	ratio =3D (msr >> 40) & 0xFF;
+	fprintf(stderr, "%d * %.0f =3D %.0f MHz max efficiency\n",
+		ratio, bclk, ratio * bclk);
+
+	ratio =3D (msr >> 8) & 0xFF;
+	fprintf(stderr, "%d * %.0f =3D %.0f MHz TSC frequency\n",
+		ratio, bclk, ratio * bclk);
+
+	if (verbose > 1)
+		fprintf(stderr, "MSR_NEHALEM_PLATFORM_INFO: 0x%llx\n", msr);
+
+	if (!do_nehalem_turbo_ratio_limit)
+		return;
+
+	msr =3D get_msr(0, MSR_NEHALEM_TURBO_RATIO_LIMIT);
+
+	ratio =3D (msr >> 24) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f =3D %.0f MHz max turbo 4 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio =3D (msr >> 16) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f =3D %.0f MHz max turbo 3 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio =3D (msr >> 8) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f =3D %.0f MHz max turbo 2 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+	ratio =3D (msr >> 0) & 0xFF;
+	if (ratio)
+		fprintf(stderr, "%d * %.0f =3D %.0f MHz max turbo 1 active cores\n",
+			ratio, bclk, ratio * bclk);
+
+}
+
+void free_counter_list(PCC *list)
+{
+	PCC *p;
+
+	for (p =3D list; p; ) {
+		PCC *free_me;
+
+		free_me =3D p;
+		p =3D p->next;
+		free(free_me);
+	}
+	return;
+}
+
+void free_all_counters(void)
+{
+	free_counter_list(pcc_even);
+	pcc_even =3D NULL;
+
+	free_counter_list(pcc_odd);
+	pcc_odd =3D NULL;
+
+	free_counter_list(pcc_delta);
+	pcc_delta =3D NULL;
+
+	free_counter_list(pcc_average);
+	pcc_average =3D NULL;
+}
+
+void insert_cpu_counters(PCC **list, PCC *new)
+{
+	PCC *prev;
+
+	/*
+	 * list was empty
+	 */
+	if (*list =3D=3D NULL) {
+		new->next =3D *list;
+		*list =3D new;
+		return;
+	}
+
+	show_cpu =3D 1;	/* there is more than one CPU */
+
+	/*
+	 * insert on front of list.
+	 * It is sorted by ascending package#, core#, cpu#
+	 */
+	if (((*list)->pkg > new->pkg) ||
+	    (((*list)->pkg =3D=3D new->pkg) && ((*list)->core > new->core)) ||
+	    (((*list)->pkg =3D=3D new->pkg) && ((*list)->core =3D=3D new->core)=
 && ((*list)->cpu > new->cpu))) {
+		new->next =3D *list;
+		*list =3D new;
+		return;
+	}
+
+	prev =3D *list;
+
+	while (prev->next && (prev->next->pkg < new->pkg)) {
+		prev =3D prev->next;
+		show_pkg =3D 1;	/* there is more than 1 package */
+	}
+
+	while (prev->next && (prev->next->pkg =3D=3D new->pkg)
+		&& (prev->next->core < new->core)) {
+		prev =3D prev->next;
+		show_core =3D 1;	/* there is more than 1 core */
+	}
+
+	while (prev->next && (prev->next->pkg =3D=3D new->pkg)
+		&& (prev->next->core =3D=3D new->core)
+		&& (prev->next->cpu < new->cpu)) {
+		prev =3D prev->next;
+	}
+
+	/*
+	 * insert after "prev"
+	 */
+	new->next =3D prev->next;
+	prev->next =3D new;
+
+	return;
+}
+
+void alloc_new_cpu_counters(int pkg, int core, int cpu)
+{
+	PCC *new;
+
+	if (verbose > 1)
+		printf("pkg%d core%d, cpu%d\n", pkg, core, cpu);
+
+	new =3D (PCC *)calloc(1, sizeof(PCC));
+	if (new =3D=3D NULL) {
+		perror("calloc");
+		exit(1);
+	}
+	new->pkg =3D pkg;
+	new->core =3D core;
+	new->cpu =3D cpu;
+	insert_cpu_counters(&pcc_odd, new);
+
+	new =3D (PCC *)calloc(1, sizeof(PCC));
+	if (new =3D=3D NULL) {
+		perror("calloc");
+		exit(1);
+	}
+	new->pkg =3D pkg;
+	new->core =3D core;
+	new->cpu =3D cpu;
+	insert_cpu_counters(&pcc_even, new);
+
+	new =3D (PCC *)calloc(1, sizeof(PCC));
+	if (new =3D=3D NULL) {
+		perror("calloc");
+		exit(1);
+	}
+	new->pkg =3D pkg;
+	new->core =3D core;
+	new->cpu =3D cpu;
+	insert_cpu_counters(&pcc_delta, new);
+
+	new =3D (PCC *)calloc(1, sizeof(PCC));
+	if (new =3D=3D NULL) {
+		perror("calloc");
+		exit(1);
+	}
+	new->pkg =3D pkg;
+	new->core =3D core;
+	new->cpu =3D cpu;
+	pcc_average =3D new;
+}
+
+int get_physical_package_id(int cpu)
+{
+	char path[64];
+	FILE *filep;
+	int pkg;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology/physical_package_=
id", cpu);
+	filep =3D fopen(path, "r");
+	if (filep =3D=3D NULL) {
+		perror(path);
+		exit(1);
+	}
+	fscanf(filep, "%d", &pkg);
+	fclose(filep);
+	return pkg;
+}
+
+int get_core_id(int cpu)
+{
+	char path[64];
+	FILE *filep;
+	int core;
+
+	sprintf(path, "/sys/devices/system/cpu/cpu%d/topology/core_id", cpu);
+	filep =3D fopen(path, "r");
+	if (filep =3D=3D NULL) {
+		perror(path);
+		exit(1);
+	}
+	fscanf(filep, "%d", &core);
+	fclose(filep);
+	return core;
+}
+
+/*
+ * run func(index, cpu) on every cpu in /proc/stat
+ */
+
+int for_all_cpus(void (func)(int, int, int))
+{
+	FILE *fp;
+	int cpu_count;
+	int retval;
+
+	fp =3D fopen(proc_stat, "r");
+	if (fp =3D=3D NULL) {
+		perror(proc_stat);
+		exit(1);
+	}
+
+	retval =3D fscanf(fp, "cpu %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d\n");
+	if (retval !=3D 0) {
+		perror("/proc/stat format");
+		exit(1);
+	}
+
+	for (cpu_count =3D 0; ; cpu_count++) {
+		int cpu;
+
+		retval =3D fscanf(fp, "cpu%u %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d\n=
", &cpu);
+		if (retval !=3D 1)
+			break;
+
+		func(get_physical_package_id(cpu), get_core_id(cpu), cpu);
+	}
+	fclose(fp);
+	return cpu_count;
+}
+
+void re_initialize(void)
+{
+	printf("turbostat: topology changed, re-initializing.\n");
+	free_all_counters();
+	num_cpus =3D for_all_cpus(alloc_new_cpu_counters);
+	need_reinitialize =3D 0;
+	printf("num_cpus is now %d\n", num_cpus);
+}
+
+void dummy(int pkg, int core, int cpu) { return; }
+/*
+ * check to see if a cpu came on-line
+ */
+void verify_num_cpus()
+{
+	int new_num_cpus;
+
+	new_num_cpus =3D for_all_cpus(dummy);
+
+	if (new_num_cpus !=3D num_cpus) {
+		if (verbose)
+			printf("num_cpus was %d, is now  %d\n",
+				num_cpus, new_num_cpus);
+		need_reinitialize =3D 1;
+	}
+
+	return;
+}
+
+void turbostat_loop()
+{
+restart:
+	get_counters(pcc_even);
+	gettimeofday(&tv_even, (struct timezone *)NULL);
+
+	while (1) {
+		verify_num_cpus();
+		if (need_reinitialize) {
+			re_initialize();
+			goto restart;
+		}
+		sleep(interval_sec);
+		get_counters(pcc_odd);
+		gettimeofday(&tv_odd, (struct timezone *)NULL);
+
+		compute_delta(pcc_odd, pcc_even, pcc_delta);
+		timersub(&tv_odd, &tv_even, &tv_delta);
+		compute_average(pcc_delta, pcc_average);
+		print_counters(pcc_delta);
+		if (need_reinitialize) {
+			re_initialize();
+			goto restart;
+		}
+		sleep(interval_sec);
+		get_counters(pcc_even);
+		gettimeofday(&tv_even, (struct timezone *)NULL);
+		compute_delta(pcc_even, pcc_odd, pcc_delta);
+		timersub(&tv_even, &tv_odd, &tv_delta);
+		compute_average(pcc_delta, pcc_average);
+		print_counters(pcc_delta);
+	}
+}
+
+void check_dev_msr()
+{
+	struct stat sb;
+
+	if (stat("/dev/cpu/0/msr", &sb)) {
+		fprintf(stderr, "no /dev/cpu/0/msr\n");
+		fprintf(stderr, "Try \"# modprobe msr\"\n");
+		exit(-5);
+	}
+}
+
+void check_super_user()
+{
+	if (getuid() !=3D 0) {
+		fprintf(stderr, "must be root\n");
+		exit(-6);
+	}
+}
+
+int has_nehalem_turbo_ratio_limit(unsigned int family, unsigned int mode=
l)
+{
+	if (!genuine_intel)
+		return 0;
+
+	if (family !=3D 6)
+		return 0;
+
+	switch (model) {
+	case 0x1A:	/* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP =
*/
+	case 0x1E:	/* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper=
 Forest */
+	case 0x1F:	/* Core i7 and i5 Processor - Nehalem */
+	case 0x25:	/* Westmere Client - Clarkdale, Arrandale */
+	case 0x2C:	/* Westmere EP - Gulftown */
+	case 0x2A:	/* SNB */
+	case 0x2D:	/* SNB Xeon */
+		return 1;
+	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
+	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
+	default:
+		return 0;
+	}
+}
+
+int is_snb(unsigned int family, unsigned int model)
+{
+	if (!genuine_intel)
+		return 0;
+
+	switch (model) {
+	case 0x2A:
+	case 0x2D:
+		return 1;
+	}
+	return 0;
+}
+
+double discover_bclk(unsigned int family, unsigned int model)
+{
+	if (is_snb(family, model))
+		return 100.00;
+	else
+		return 133.33;
+}
+
+void check_cpuid()
+{
+	unsigned int eax, ebx, ecx, edx, max_level;
+	unsigned int fms, family, model, stepping;
+
+	eax =3D ebx =3D ecx =3D edx =3D 0;
+
+	asm("cpuid" : "=3Da" (max_level), "=3Db" (ebx), "=3Dc" (ecx), "=3Dd" (e=
dx) : "a" (0));
+
+	if (ebx =3D=3D 0x756e6547 && edx =3D=3D 0x49656e69 && ecx =3D=3D 0x6c65=
746e)
+		genuine_intel =3D 1;
+
+	if (verbose)
+		fprintf(stderr, "%.4s%.4s%.4s ",
+			(char *)&ebx, (char *)&edx, (char *)&ecx);
+
+	asm("cpuid" : "=3Da" (fms), "=3Dc" (ecx), "=3Dd" (edx) : "a" (1) : "ebx=
");
+	family =3D (fms >> 8) & 0xf;
+	model =3D (fms >> 4) & 0xf;
+	stepping =3D fms & 0xf;
+	if (family =3D=3D 6 || family =3D=3D 0xf)
+		model +=3D ((fms >> 16) & 0xf) << 4;
+
+	if (verbose)
+		fprintf(stderr, "%d CPUID levels; family:model:stepping 0x%x:%x:%x (%d=
:%d:%d)\n",
+			max_level, family, model, stepping, family, model, stepping);
+
+	if (!(edx & (1 << 5))) {
+		fprintf(stderr, "CPUID: no MSR\n");
+		exit(1);
+	}
+
+	/*
+	 * check max extended function levels of CPUID.
+	 * This is needed to check for invariant TSC.
+	 * This check is valid for both Intel and AMD.
+	 */
+	ebx =3D ecx =3D edx =3D 0;
+	asm("cpuid" : "=3Da" (max_level), "=3Db" (ebx), "=3Dc" (ecx), "=3Dd" (e=
dx) : "a" (0x80000000));
+
+	if (max_level < 0x80000007) {
+		fprintf(stderr, "CPUID: no invariant TSC (max_level 0x%x)\n", max_leve=
l);
+		exit(1);
+	}
+
+	/*
+	 * Non-Stop TSC is advertised by CPUID.EAX=3D0x80000007: EDX.bit8
+	 * this check is valid for both Intel and AMD
+	 */
+	asm("cpuid" : "=3Da" (eax), "=3Db" (ebx), "=3Dc" (ecx), "=3Dd" (edx) : =
"a" (0x80000007));
+	has_invariant_tsc =3D edx && (1 << 8);
+
+	if (!has_invariant_tsc) {
+		fprintf(stderr, "No invariant TSC\n");
+		exit(1);
+	}
+
+	/*
+	 * APERF/MPERF is advertised by CPUID.EAX=3D0x6: ECX.bit0
+	 * this check is valid for both Intel and AMD
+	 */
+
+	asm("cpuid" : "=3Da" (eax), "=3Db" (ebx), "=3Dc" (ecx), "=3Dd" (edx) : =
"a" (0x6));
+	has_aperf =3D ecx && (1 << 0);
+	if (!has_aperf) {
+		fprintf(stderr, "No APERF MSR\n");
+		exit(1);
+	}
+
+	do_nehalem_platform_info =3D genuine_intel && has_invariant_tsc;
+	do_nhm_cstates =3D genuine_intel;	/* all Intel w/ non-stop TSC have NHM=
 counters */
+	do_snb_cstates =3D is_snb(family, model);
+	bclk =3D discover_bclk(family, model);
+
+	do_nehalem_turbo_ratio_limit =3D has_nehalem_turbo_ratio_limit(family, =
model);
+}
+
+
+void usage()
+{
+	fprintf(stderr, "%s: [-v] [-M MSR#] [-i interval_sec | command ...]\n",
+		progname);
+	exit(1);
+}
+
+
+/*
+ * in /dev/cpu/ return success for names that are numbers
+ * ie. filter out ".", "..", "microcode".
+ */
+int dir_filter(const struct dirent *dirp)
+{
+	if (isdigit(dirp->d_name[0]))
+		return 1;
+	else
+		return 0;
+}
+
+int open_dev_cpu_msr(int dummy1)
+{
+	return 0;
+}
+
+void turbostat_init()
+{
+	check_cpuid();
+
+	check_dev_msr();
+	check_super_user();
+
+	num_cpus =3D for_all_cpus(alloc_new_cpu_counters);
+
+	if (verbose)
+		print_nehalem_info();
+}
+
+int fork_it(char **argv)
+{
+	int retval;
+	pid_t child_pid;
+	get_counters(pcc_even);
+	gettimeofday(&tv_even, (struct timezone *)NULL);
+
+	child_pid =3D fork();
+	if (!child_pid) {
+		/* child */
+		execvp(argv[0], argv);
+	} else {
+		int status;
+
+		/* parent */
+		if (child_pid =3D=3D -1) {
+			perror("fork");
+			exit(1);
+		}
+
+		signal(SIGINT, SIG_IGN);
+		signal(SIGQUIT, SIG_IGN);
+		if (waitpid(child_pid, &status, 0) =3D=3D -1) {
+			perror("wait");
+			exit(1);
+		}
+	}
+	get_counters(pcc_odd);
+	gettimeofday(&tv_odd, (struct timezone *)NULL);
+	retval =3D compute_delta(pcc_odd, pcc_even, pcc_delta);
+
+	timersub(&tv_odd, &tv_even, &tv_delta);
+	compute_average(pcc_delta, pcc_average);
+	if (!retval)
+		print_counters(pcc_delta);
+
+	fprintf(stderr, "%.6f sec\n", tv_delta.tv_sec + tv_delta.tv_usec/100000=
0.0);;
+
+	return 0;
+}
+
+void cmdline(int argc, char **argv)
+{
+	int opt;
+
+	progname =3D argv[0];
+
+	while ((opt =3D getopt(argc, argv, "+vi:M:")) !=3D -1) {
+		switch (opt) {
+		case 'v':
+			verbose++;
+			break;
+		case 'i':
+			interval_sec =3D atoi(optarg);
+			break;
+		case 'M':
+			sscanf(optarg, "%x", &extra_msr_offset);
+			if (verbose > 1)
+				fprintf(stderr, "MSR 0x%X\n", extra_msr_offset);
+			break;
+		default:
+			usage();
+		}
+	}
+}
+
+int main(int argc, char **argv)
+{
+	cmdline(argc, argv);
+
+	if (verbose > 1)
+		fprintf(stderr, "turbostat Dec 6, 2010"
+			" - Len Brown <lenb@kernel.org>\n");
+	if (verbose > 1)
+		fprintf(stderr, "http://userweb.kernel.org/~lenb/acpi/utils/pmtools/tu=
rbostat/\n");
+
+	turbostat_init();
+
+	/*
+	 * if any params left, it must be a command to fork
+	 */
+	if (argc - optind)
+		return fork_it(argv + optind);
+	else
+		turbostat_loop();
+
+	return 0;
+}

--8323328-1458846773-1291701647=:5514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--8323328-1458846773-1291701647=:5514--
