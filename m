From: Len Brown <lenb@kernel.org>
Subject: turbostat.c (version Jan-23, 2010)
Date: Sat, 23 Jan 2010 02:01:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001230152070.11462@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-108051260-1264230097=:11462"
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux Power Management List <linux-pm@lists.osdl.org>, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.or
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-108051260-1264230097=:11462
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Here's a utility that I've been using to examine frequency
and idle residency on Nehalem systems.  If others find it
useful, I can add it to the pmutils package.

See comments at top of source for usage and examples.

$ cc turbostat.c -o turbostat

cheers,
-Len Brown, Intel Open Source Technology Center
---
/*
 * turbostat -- show CPU frequency and C-state residency
 * on modern Intel turbo-capable processors.
 *
 * Copyright (c) 2010, Intel Corporation.
 * Len Brown <len.brown@intel.com>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
 */

/*
 * Works properly on Nehalem and newer processors, since
 * Nehalem features an always-running TSC, plus hardware
 * C-state residency MSRs.
 *
 * Works poorly on systems before Nehalem with
 * a TSC that stops in deep C-states.
 *
 * Works properly on Linux-2.6.30 and later.
 * Works poorly Linux-2.6.29 and earlier, as acpi-cpufreq
 * used to clear APERF/MPERF counters on access.
 *
 * APERF, MPERF count non-halted cycles.
 * Although it is not guaranteed by the architecture, we assume
 * here that they count at TSC rate, which is true for Nehalem.
 *
 * References:
 * "Intel® Turbo Boost Technology
 * in Intel® Core™ Microarchitecture (Nehalem) Based Processors"
 * http://download.intel.com/design/processor/applnots/320354.pdf
 *
 * "Intel® 64 and IA-32 Architectures Software Developer's Manual
 * Volume 3B: System Programming Guide"
 * http://www.intel.com/products/processor/manuals/
 */

/*
 * usage:
 * # turbostat [-v verbosity] [-i interval_sec] [command [arg]...]
 *
 * examples:
 *
 * [root@nehalem lenb]# ./turbostat
 *  CPU   GHz    TSC    %c0    %c1    %c3    %c6   %pc3   %pc6   %pc7 
 *    0   1.60   2.93   0.03   0.10  40.82  59.04   0.00   0.00   0.00
 *    1   1.60   2.93   0.01   0.03  99.96   0.00   0.00   0.00   0.00
 *    2   1.60   2.93   0.06   0.07  26.51  73.36   0.00   0.00   0.00
 *    3   1.60   2.93   0.15   0.06  99.17   0.62   0.00   0.00   0.00
 *    4   1.60   2.93   0.03   0.10  40.82  59.04   0.00   0.00   0.00
 *    5   1.59   2.93   0.01   0.03  99.97   0.00   0.00   0.00   0.00
 *    6   1.60   2.93   0.03   0.10  26.51  73.36   0.00   0.00   0.00
 *    7   1.60   2.93   0.00   0.20  99.17   0.62   0.00   0.00   0.00
 *
 * Without any parameters, turbostat prints out counters ever 5 seconds.
 * (override interval with "-i sec" option).
 *
 * %c0 is the percent of the interval that the core retired instructions.
 *
 * GHz is the average clock rate while the core was in c0 state.
 *
 * TSC is the average GHz that the TSC ran during the entire interval.
 *
 * %c1, %c3, %c6 show the residency in hardware CPU core idle states.
 * Note that these may not equal the software states requested by Linux.
 *
 * pc3%, pc6%, pc7% show package idle C-states, which happen are disabled
 * by the BIOS for the stepping in this example.
 *
 * The "-v" option adds verbosity to the output: eg.
 *
 * CPUID GenuineIntel 11 levels family:model:stepping 6:26:4
 * Nehalem multiplier 22, TSC frequency 2933 MHz
 * Nehalem 4 cores active: 23 mult, max turbo frequency = 3067 MHz
 * Nehalem 3 cores active: 23 mult, max turbo frequency = 3067 MHz
 * Nehalem 2 cores active: 23 mult, max turbo frequency = 3067 MHz
 * Nehalem 1 core active: 24 mult, max turbo frequency = 3200 MHz
 *
 * If a command is handed to turbostat, it will invoke that
 * command and output the statistics gathered while that
 * command was running.  eg. Here a cycle soaker is run
 * on 1 CPU (until ^C) while the others are mostly idle:
 * 
 *[root@nehalem lenb]# ./turbostat cat /dev/zero > /dev/null 
 *^C CPU   GHz    TSC    %c0    %c1    %c3    %c6   %pc3   %pc6   %pc7 
 *   0   3.04   2.93   1.67   5.65   8.54  84.14   0.00   0.00   0.00
 *   1   2.26   2.93   0.03   0.22  99.75   0.00   0.00   0.00   0.00
 *   2   2.86   2.93   0.06  99.91   0.01   0.02   0.00   0.00   0.00
 *   3   3.03   2.93   6.06   5.37  88.55   0.03   0.00   0.00   0.00
 *   4   2.94   2.93   0.67   6.65   8.54  84.14   0.00   0.00   0.00
 *   5   2.59   2.93   0.08   0.17  99.74   0.01   0.00   0.00   0.00
 *   6   3.16   2.93  99.46   0.51   0.00   0.03   0.00   0.00   0.00
 *   7   1.60   2.93   0.01  11.42  88.55   0.03   0.00   0.00   0.00
 *
 * Above the cycles soaker drives 1 CPU up to almost 3.2Ghz
 * while the other processors are generally in various states of idle.
 *
 * Note that turbostat reads hardware counters, but doesn't write them.
 * So it will not interfere with the OS or other programs, including
 * multiple invocations of itself.
 *
 * turbostat depends on the Linux msr driver for /dev/cpu/.../msr
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/time.h>

#define MSR_TSC	0x10
#define MSR_NEHALEM_PLATFORM_INFO	0xCE
#define MSR_NEHALEM_TURBO_RATIO_LIMIT	0x1AD
#define MSR_APERF	0xE8
#define MSR_MPERF	0xE7
#define MSR_PKG_C3_RESIDENCY	0x3F8
#define MSR_PKG_C6_RESIDENCY	0x3F9
#define MSR_PKG_C7_RESIDENCY	0x3FA
#define MSR_CORE_C3_RESIDENCY	0x3FC
#define MSR_CORE_C3_RESIDENCY	0x3FC
#define MSR_CORE_C3_RESIDENCY	0x3FC
#define MSR_CORE_C6_RESIDENCY	0x3FD

unsigned int interval_sec = 5;	/* set with -i interval_sec */
unsigned int verbose;		/* set with -v */
unsigned int debug;		/* set with -d */
unsigned int do_nehalem;
unsigned int do_c0, skip_c0;
unsigned int do_c1, skip_c1;
unsigned int do_c3;
unsigned int do_c6;
unsigned int do_pkg;
unsigned int do_aperf = 1;	/* TBD set with CPUID */
unsigned int iterations;
unsigned int units = 1000000000.0;	/* Ghz etc */

int aperf_mperf_unstable;
int backwards_count;
char *progname;

#define MAX_CPUS 16	/* TBD: make dynamic */
int num_cpus;
int fd_msr[MAX_CPUS];

typedef struct per_core_counters {
	unsigned long long tsc;
	unsigned long long c1;
	unsigned long long c3;
	unsigned long long c6;
	unsigned long long aperf;
	unsigned long long mperf;
	unsigned long long pc3;
	unsigned long long pc6;
	unsigned long long pc7;
} PCC;

PCC pcc_even[MAX_CPUS];
PCC pcc_odd[MAX_CPUS];
PCC pcc_delta[MAX_CPUS];
struct timeval tv_even;
struct timeval tv_odd;
struct timeval tv_delta;

unsigned long long get_msr(int cpu, off_t offset)
{
	ssize_t retval;
	unsigned long long msr;

	retval = pread(fd_msr[cpu], &msr, sizeof msr, offset);
	if (retval != sizeof msr) {
		fprintf(stderr, "pread cpu%d 0x%x = %d\n", cpu, offset, retval);
		_exit(-2);
	}
	return msr;
}
void print_header()
{
	fprintf(stderr, " CPU");
	fprintf(stderr, "   GHz ");
	fprintf(stderr, "   TSC ");
	if (do_c0) fprintf(stderr, "   %%c0 ");
	if (do_c1) fprintf(stderr, "   %%c1 ");
	if (do_c3) fprintf(stderr, "   %%c3 ");
	if (do_c6) fprintf(stderr, "   %%c6 ");
	if (do_pkg) fprintf(stderr, "  %%pc3 ");
	if (do_pkg) fprintf(stderr, "  %%pc6 ");
	if (do_pkg) fprintf(stderr, "  %%pc7 ");

	putc('\n', stderr);
}
void dump_counters(PCC *c)
{
	int i;

	fprintf(stderr, "TSC: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].tsc);
	}
	putc('\n', stderr);

	fprintf(stderr, "c3: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].c3);
	}
	putc('\n', stderr);

	fprintf(stderr, "c6: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].c6);
	}
	putc('\n', stderr);

	fprintf(stderr, "aperf: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].aperf);
	}
	putc('\n', stderr);

	fprintf(stderr, "mperf: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].mperf);
	}
	putc('\n', stderr);

	fprintf(stderr, "pc3: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].pc3);
	}
	putc('\n', stderr);

	fprintf(stderr, "pc6: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].pc6);
	}
	putc('\n', stderr);

	fprintf(stderr, "pc7: ");
	for (i = 0; i < num_cpus; ++i) {
		fprintf(stderr, "%llX ", c[i].pc7);
	}
	putc('\n', stderr);
}
void print_counters(PCC *c) 
{
	int i;
	double interval_float;

	interval_float = tv_delta.tv_sec + tv_delta.tv_usec/1000000.0;

	if (debug)
		fprintf(stderr, "%.6f sec\n", interval_float);

	print_header();

	for (i = 0; i < num_cpus; ++i) {

		fprintf(stderr, "%4d", i);

		if (do_aperf) {
			if (!aperf_mperf_unstable) {
				fprintf(stderr, "%7.2f",
					1.0 * c[i].tsc / units * c[i].aperf /
					c[i].mperf / interval_float);
			} else {
				if (c[i].aperf > c[i].tsc || c[i].mperf > c[i].tsc) {
					fprintf(stderr, "   ****");
				} else {
					fprintf(stderr, "%6.1f*",
						1.0 * c[i].tsc / units * c[i].aperf /
						c[i].mperf / interval_float);
				}
			}
		}

		fprintf(stderr, "%7.2f", 1.0 * c[i].tsc/units/interval_float);

		if (do_c0) {
			if (!skip_c0)
				fprintf(stderr, "%7.2f", 100.0 * c[i].mperf/c[i].tsc);
			else
				fprintf(stderr, "   ****");
		}
		if (do_c1) {
			if (!skip_c1)
				fprintf(stderr, "%7.2f", 100.0 * c[i].c1/c[i].tsc);
			else
				fprintf(stderr, "   ****");
		}
		if (do_c3)
			fprintf(stderr, "%7.2f", 100.0 * c[i].c3/c[i].tsc);
		if (do_c6)
			fprintf(stderr, "%7.2f", 100.0 * c[i].c6/c[i].tsc);
		if (do_pkg)
			fprintf(stderr, "%7.2f", 100.0 * c[i].pc3/c[i].tsc);
		if (do_pkg)
			fprintf(stderr, "%7.2f", 100.0 * c[i].pc6/c[i].tsc);
		if (do_pkg)
			fprintf(stderr, "%7.2f", 100.0 * c[i].pc7/c[i].tsc);
		putc('\n', stderr);
	}
}


#define SUBTRACT_COUNTER(after, before, delta) (delta = (after - before), (before > after))


compute_delta(PCC *after, PCC *before)
{
	int i;
	int error, error1, error2;

	skip_c0 = skip_c1 = 0;

	for (i = 0; i < num_cpus; ++i) {
		error = SUBTRACT_COUNTER(after[i].tsc, before[i].tsc, pcc_delta[i].tsc);
		if (error) {
			fprintf(stderr, "TSC went backwards %llX to %llX\n",
				after[i].tsc, before[i].tsc);
		}
		if (pcc_delta[i].tsc < (1000 * 1000) ) { /* check for TSC < 1 Mcycles over interval */
			fprintf(stderr, "Insanely slow TSC rate, TSC stops in idle?\n");
			fprintf(stderr, "You can disable all c-states by booting with \"idle=poll\"\n");
			fprintf(stderr, "or just the deep ones with \"processor.max_cstate=1\"\n");
			_exit(-3);
		}
		error1 = SUBTRACT_COUNTER(after[i].c3, before[i].c3, pcc_delta[i].c3);
		error2 = SUBTRACT_COUNTER(after[i].c6, before[i].c6, pcc_delta[i].c6);
		if (error1 || error2) {
			fprintf(stderr, "c3 or c6 residency counter went backwards\n");
			_exit(-1);
		}
		error = SUBTRACT_COUNTER(after[i].pc3, before[i].pc3, pcc_delta[i].pc3);
		error1 = SUBTRACT_COUNTER(after[i].pc6, before[i].pc6, pcc_delta[i].pc6);
		error2 = SUBTRACT_COUNTER(after[i].pc7, before[i].pc7, pcc_delta[i].pc7);
		if (error || error1 || error2) {
			fprintf(stderr, "package residency counter went backwards\n");
			_exit(-1);
		}

		error1 = SUBTRACT_COUNTER(after[i].aperf, before[i].aperf, pcc_delta[i].aperf);
		error2 = SUBTRACT_COUNTER(after[i].mperf, before[i].mperf, pcc_delta[i].mperf);
		if (error1 || error2) {
			if (!aperf_mperf_unstable) {
				fprintf(stderr, "%s: APERF or MPERF went backwards *\n", progname);
				fprintf(stderr, "* Frequency results do not cover entire interval *\n");
				fprintf(stderr, "* fix this by running Linux-2.6.30 or later *\n");

				aperf_mperf_unstable = 1;
			}
			/*
			 * mperf delta is likely a huge "positive" number
			 * can not use it for calculating c0 time
			 */
			skip_c0 = 1;
			skip_c1 = 1;
		}

		/*
 		 * As mperf and tsc collection are not atomic,
 		 * it is possible for mperf's non-halted cycles
 		 * to exceed TSC's all cycles: show c1l = 0% in that case.
 		 */
		if (pcc_delta[i].mperf > pcc_delta[i].tsc)
			pcc_delta[i].c1 = 0;
		else /* normal case, derive c1 */
			pcc_delta[i].c1 = pcc_delta[i].tsc - pcc_delta[i].mperf - pcc_delta[i].c3 - pcc_delta[i].c6;

		if (pcc_delta[i].mperf == 0)
			pcc_delta[i].mperf = 1;	/* divide by 0 protection */
	}
}


void get_counters(PCC *c)
{
	int i;

	for (i = 0; i < num_cpus; ++i)
	{
		c[i].tsc = get_msr(i, MSR_TSC);
		if (do_c3) c[i].c3 = get_msr(i, MSR_CORE_C3_RESIDENCY);
		if (do_c6) c[i].c6 = get_msr(i, MSR_CORE_C6_RESIDENCY);
		if (do_aperf) c[i].aperf = get_msr(i, MSR_APERF);
		if (do_aperf) c[i].mperf = get_msr(i, MSR_MPERF);
		if (do_pkg) c[i].pc3 = get_msr(i, MSR_PKG_C3_RESIDENCY);
		if (do_pkg) c[i].pc6 = get_msr(i, MSR_PKG_C6_RESIDENCY);
		if (do_pkg) c[i].pc7 = get_msr(i, MSR_PKG_C7_RESIDENCY);
	}

}
print_nehalem_info()
{
	unsigned long long msr;
	unsigned int ratio;

	if (!do_nehalem)
		return;

	msr = get_msr(0, MSR_NEHALEM_PLATFORM_INFO);

	ratio = (msr >> 8) & 0xFF;
	fprintf(stderr, "Nehalem multiplier %d, TSC frequency %.0f MHz\n", ratio, ratio * 133.33);

	msr = get_msr(0, MSR_NEHALEM_TURBO_RATIO_LIMIT);

	ratio = (msr >> 24) & 0xFF;
	fprintf(stderr, "Nehalem 4 cores active: %d mult, max turbo frequency = %.0f MHz\n", ratio, ratio * 133.33);

	ratio = (msr >> 16) & 0xFF;
	fprintf(stderr, "Nehalem 3 cores active: %d mult, max turbo frequency = %.0f MHz\n", ratio, ratio * 133.33);

	ratio = (msr >> 8) & 0xFF;
	fprintf(stderr, "Nehalem 2 cores active: %d mult, max turbo frequency = %.0f MHz\n", ratio, ratio * 133.33);

	ratio = (msr >> 0) & 0xFF;
	fprintf(stderr, "Nehalem 1 core active: %d mult, max turbo frequency = %.0f MHz\n", ratio, ratio * 133.33);

}
void turbostat_loop()
{
	get_counters(pcc_even);
	gettimeofday(&tv_even, (struct timezone *)NULL);

	for (iterations = 1; ; iterations++) {
		sleep(interval_sec);
		get_counters(pcc_odd);
		gettimeofday(&tv_odd, (struct timezone *)NULL);
		compute_delta(pcc_odd, pcc_even);
		timersub(&tv_odd, &tv_even, &tv_delta);
		print_counters(pcc_delta);

		sleep(interval_sec);
		get_counters(pcc_even);
		gettimeofday(&tv_even, (struct timezone *)NULL);
		compute_delta(pcc_even, pcc_odd);
		timersub(&tv_even, &tv_odd, &tv_delta);
		print_counters(pcc_delta);
	}
}

check_dev_msr() {
	struct stat sb;

	if (stat("/dev/cpu/0/msr", &sb)) {
		fprintf(stderr, "no /dev/cpu/0/msr\n");
		fprintf(stderr, "Please load the msr driver\n");
		_exit(-5);
	}
}

int is_nehalem(unsigned int family, unsigned int model)
{
	if (family != 6)
		return 0;

	switch(model) {
	case 0x1A:	/* Core i7, Xeon 5500 series */
	case 0x1E:	/* Core i7 and i5 Processor */
	case 0x1F:	/* Core i7 and i5 Processor */
	case 0x2E:	/* Nehalem Xeon */
	case 0x25:	/* Westmere */
	case 0x2C:	/* Westmere */
		return 1;
	default:
		return 0;
	}
}

void do_cpuid()
{
	unsigned int eax, ebx, ecx, edx, max_level;
	char brand[16];
	unsigned int fms, family, model, stepping, ht_capable;

	eax = ebx = ecx = edx = 0;

	asm("cpuid" : "=a" (max_level), "=b" (ebx), "=c" (ecx), "=d" (edx) : "a" (0));

	sprintf(brand, "%.4s%.4s%.4s", &ebx, &edx, &ecx);

	if (strncmp(brand, "GenuineIntel", 12)) {
		fprintf(stderr, "CPUID: %s GenuineIntel\n", brand);
		_exit(-1);
	}

	asm("cpuid" : "=a" (fms), "=c" (ecx), "=d" (edx) : "a" (1) : "ebx");
	family = (fms >> 8) & 0xf;
	model = (fms >> 4) & 0xf;
	stepping = fms & 0xf;
	if (family == 6 || family == 0xf)
		model += ((fms >> 16) & 0xf) << 4;

	if (!(edx & (1 << 5))) {
		fprintf(stderr, "CPUID: no MSR\n");
		_exit(-1);
	}

	ht_capable = edx & (1 << 28);

	if (verbose)
		fprintf(stderr, "CPUID %s %d levels family:model:stepping %d:%d:%d\n",
			brand, max_level, family, model, stepping);

	do_nehalem = is_nehalem(family, model);
}


usage() {
	fprintf(stderr, "%s: [-v verbosity] [-i interval_sec] [command [arg]...]\n",
		progname);
}

void turbostat_init()
{
	int i;

	num_cpus = sysconf(_SC_NPROCESSORS_ONLN);

	if (num_cpus > MAX_CPUS) {
		fprintf(stderr, "%s: limited to %d CPUs, rebuild with MAX_CPUS %d\n",
			progname, MAX_CPUS, num_cpus);
		num_cpus = MAX_CPUS;
	}

	do_cpuid();

	do_c0 = do_c1 = do_c3 = do_c6 = do_pkg = do_nehalem;

	check_dev_msr();

	for (i = 0; i < num_cpus; ++i) {
		char msr_path[32];

		sprintf(msr_path, "/dev/cpu/%d/msr", i);
		fd_msr[i] = open(msr_path, O_RDONLY);
		if (fd_msr[i] < 0) {
			perror(msr_path);
			break;
		}
	}
	num_cpus = i;
	if (num_cpus == 0)
		_exit(-1);

	if (debug)
		fprintf(stderr, "num_cpus %d\n", num_cpus);

	if (verbose)
		print_nehalem_info();
}

int fork_it(char **argv) {
	pid_t child_pid;
	get_counters(pcc_even);
	gettimeofday(&tv_even, (struct timezone *)NULL);

	child_pid = fork();
	if (!child_pid) {
		/* child */
		execvp(argv[0], argv);
	} else  {
		int status;

		/* parent */
		if (child_pid == -1) {
			perror("fork");
			_exit(-1);
		}
	
		signal(SIGINT, SIG_IGN);
		signal(SIGQUIT, SIG_IGN);
		if (waitpid(child_pid, &status, 0) == -1) {
			perror("wait");
			_exit(-1);
		}
	}
	get_counters(pcc_odd);
	gettimeofday(&tv_odd, (struct timezone *)NULL);
	compute_delta(pcc_odd, pcc_even);
	timersub(&tv_odd, &tv_even, &tv_delta);
	print_counters(pcc_delta);

	return 0;
}

cmdline(int argc, char **argv) {
	int opt;

	progname = argv[0];

	while((opt = getopt(argc, argv, "+vdi:")) != -1) {
		switch (opt) {
		case 'v':
			verbose = 1;
			break;
		case 'i':
			interval_sec = atoi(optarg);
			break;
		case 'd':
			debug = 1;
			fprintf(stderr, "turbostat Jan-23, 2010 - Len Brown <lenb@kernel.org>\n");
			break;
		default:
			usage();
			_exit(-1);
		}
	}
}
int main(int argc, char **argv)
{
	cmdline(argc, argv);

	turbostat_init();

	/*
 	 * if any params left, it must be a command to fork
 	 */
	if (argc - optind)
		return fork_it(argv + optind);
	else
		turbostat_loop();

	return 0;
}
--8323328-108051260-1264230097=:11462--
