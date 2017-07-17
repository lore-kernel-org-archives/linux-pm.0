From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RESEND] tools/power/cpupower: allow running without cpu0
Date: Mon, 17 Jul 2017 11:23:19 -0400
Message-ID: <ca8bce98-611a-27df-6bd8-330c593f76d0@redhat.com>
References: <1478871719-30660-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdGQPXU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jul 2017 11:23:20 -0400
In-Reply-To: <1478871719-30660-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

ping?  Thomas?  Rafael?

... patch still applies.

P.

On 11/11/2016 08:41 AM, Prarit Bhargava wrote:
> Linux-3.7 added CONFIG_BOOTPARAM_HOTPLUG_CPU0,
> allowing systems to offline cpu0.
> 
> But when cpu0 is offline, cpupower monitor will not display all
> processor and Mperf information:
> 
> [root@intel-skylake-dh-03 cpupower]# ./cpupower monitor
> WARNING: at least one cpu is offline
>     |Idle_Stats
> CPU | POLL | C1-S | C1E- | C3-S | C6-S | C7s- | C8-S
>    4|  0.00|  0.00|  0.00|  0.00|  0.90|  0.00| 96.13
>    1|  0.00|  0.00|  5.49|  0.00|  0.01|  0.00| 92.26
>    5|  0.00|  0.00|  0.00|  0.00|  0.46|  0.00| 99.50
>    2| 45.42|  0.00|  0.00|  0.00| 22.94|  0.00| 28.84
>    6|  0.00| 37.54|  0.00|  0.00|  0.00|  0.00|  0.00
>    3|  0.00|  0.00|  0.00|  0.00|  0.30|  0.00| 91.99
>    7|  0.00|  0.00|  0.00|  0.00|  4.70|  0.00|  0.70
> 
> This patch replaces the hard-coded use of cpu0 in cpupower with the
> current cpu, allowing it to run without a cpu0.
> 
> After the patch is applied,
> 
> [root@intel-skylake-dh-03 cpupower]# ./cpupower monitor
> WARNING: at least one cpu is offline
>     |Nehalem                    || Mperf              || Idle_Stats
> CPU | C3   | C6   | PC3  | PC6  || C0   | Cx   | Freq || POLL | C1-S | C1E- | C3-S | C6-S | C7s- | C8-S
>    4|  0.01|  1.27|  0.00|  0.00||  0.04| 99.96|  3957||  0.00|  0.00|  0.00|  0.00|  1.43|  0.00| 98.52
>    1|  0.00| 98.82|  0.00|  0.00||  0.05| 99.95|  3361||  0.00|  0.00|  0.01|  0.00|  0.03|  0.00| 99.88
>    5|  0.00| 98.82|  0.00|  0.00||  0.09| 99.91|  3917||  0.00|  0.00|  0.00|  0.00| 99.38|  0.00|  0.50
>    2|  0.33|  0.00|  0.00|  0.00||  0.00|100.00|  3890||  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|100.00
>    6|  0.33|  0.00|  0.00|  0.00||  0.01| 99.99|  3903||  0.00|  0.00|  0.00|  0.00|  0.00|  0.00| 99.99
>    3|  0.01|  0.71|  0.00|  0.00||  0.06| 99.94|  3678||  0.00|  0.00|  0.00|  0.00|  0.80|  0.00| 99.13
>    7|  0.01|  0.71|  0.00|  0.00||  0.03| 99.97|  3538||  0.00|  0.69| 11.70|  0.00|  0.00|  0.00| 87.57
> 
> There are some minor cleanups included in this patch.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Thomas Renninger <trenn@suse.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> ---
>  tools/power/cpupower/utils/cpupower.c              |   15 ++++++++++++---
>  tools/power/cpupower/utils/helpers/cpuid.c         |    4 ++--
>  tools/power/cpupower/utils/helpers/helpers.h       |    5 +++--
>  tools/power/cpupower/utils/helpers/misc.c          |    2 +-
>  .../cpupower/utils/idle_monitor/hsw_ext_idle.c     |    4 ++--
>  .../cpupower/utils/idle_monitor/mperf_monitor.c    |    3 ++-
>  tools/power/cpupower/utils/idle_monitor/nhm_idle.c |    8 ++++----
>  tools/power/cpupower/utils/idle_monitor/snb_idle.c |    4 ++--
>  8 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower.c b/tools/power/cpupower/utils/cpupower.c
> index 9ea914378985..2dccf4998599 100644
> --- a/tools/power/cpupower/utils/cpupower.c
> +++ b/tools/power/cpupower/utils/cpupower.c
> @@ -12,6 +12,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <sched.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/utsname.h>
> @@ -31,6 +32,7 @@
>   */
>  struct cpupower_cpu_info cpupower_cpu_info;
>  int run_as_root;
> +int base_cpu;
>  /* Affected cpus chosen by -c/--cpu param */
>  struct bitmask *cpus_chosen;
>  
> @@ -174,6 +176,7 @@ int main(int argc, const char *argv[])
>  	unsigned int i, ret;
>  	struct stat statbuf;
>  	struct utsname uts;
> +	char pathname[32];
>  
>  	cpus_chosen = bitmask_alloc(sysconf(_SC_NPROCESSORS_CONF));
>  
> @@ -198,17 +201,23 @@ int main(int argc, const char *argv[])
>  		argv[0] = cmd = "help";
>  	}
>  
> -	get_cpu_info(0, &cpupower_cpu_info);
> +	base_cpu = sched_getcpu();
> +	if (base_cpu < 0) {
> +		fprintf(stderr, _("No valid cpus found.\n"));
> +		return EXIT_FAILURE;
> +	}
> +
> +	get_cpu_info(&cpupower_cpu_info);
>  	run_as_root = !geteuid();
>  	if (run_as_root) {
>  		ret = uname(&uts);
> +		sprintf(pathname, "/dev/cpu/%d/msr", base_cpu);
>  		if (!ret && !strcmp(uts.machine, "x86_64") &&
> -		    stat("/dev/cpu/0/msr", &statbuf) != 0) {
> +		    stat(pathname, &statbuf) != 0) {
>  			if (system("modprobe msr") == -1)
>  	fprintf(stderr, _("MSR access not available.\n"));
>  		}
>  	}
> -		
>  
>  	for (i = 0; i < ARRAY_SIZE(commands); i++) {
>  		struct cmd_struct *p = commands + i;
> diff --git a/tools/power/cpupower/utils/helpers/cpuid.c b/tools/power/cpupower/utils/helpers/cpuid.c
> index 93b0aa74ca03..fa3a765d87da 100644
> --- a/tools/power/cpupower/utils/helpers/cpuid.c
> +++ b/tools/power/cpupower/utils/helpers/cpuid.c
> @@ -42,7 +42,7 @@
>   *
>   * TBD: Should there be a cpuid alternative for this if /proc is not mounted?
>   */
> -int get_cpu_info(unsigned int cpu, struct cpupower_cpu_info *cpu_info)
> +int get_cpu_info(struct cpupower_cpu_info *cpu_info)
>  {
>  	FILE *fp;
>  	char value[64];
> @@ -70,7 +70,7 @@ int get_cpu_info(unsigned int cpu, struct cpupower_cpu_info *cpu_info)
>  		if (!strncmp(value, "processor\t: ", 12))
>  			sscanf(value, "processor\t: %u", &proc);
>  
> -		if (proc != cpu)
> +		if (proc != (unsigned int)base_cpu)
>  			continue;
>  
>  		/* Get CPU vendor */
> diff --git a/tools/power/cpupower/utils/helpers/helpers.h b/tools/power/cpupower/utils/helpers/helpers.h
> index afb66f80554e..2bc62f3ca4b8 100644
> --- a/tools/power/cpupower/utils/helpers/helpers.h
> +++ b/tools/power/cpupower/utils/helpers/helpers.h
> @@ -34,6 +34,7 @@
>  /* Internationalization ****************************/
>  
>  extern int run_as_root;
> +extern int base_cpu;
>  extern struct bitmask *cpus_chosen;
>  
>  /* Global verbose (-d) stuff *********************************/
> @@ -85,11 +86,11 @@ struct cpupower_cpu_info {
>   *
>   * Extract CPU vendor, family, model, stepping info from /proc/cpuinfo
>   *
> - * Returns 0 on success or a negativ error code
> + * Returns 0 on success or a negative error code
>   * Only used on x86, below global's struct values are zero/unknown on
>   * other archs
>   */
> -extern int get_cpu_info(unsigned int cpu, struct cpupower_cpu_info *cpu_info);
> +extern int get_cpu_info(struct cpupower_cpu_info *cpu_info);
>  extern struct cpupower_cpu_info cpupower_cpu_info;
>  /* cpuid and cpuinfo helpers  **************************/
>  
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index 1609243f5c64..fa5e5a942838 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -10,7 +10,7 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>  
>  	*support = *active = *states = 0;
>  
> -	ret = get_cpu_info(0, &cpu_info);
> +	ret = get_cpu_info(&cpu_info);
>  	if (ret)
>  		return ret;
>  
> diff --git a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> index ebeaba6571a3..f794d6bbb7e9 100644
> --- a/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/hsw_ext_idle.c
> @@ -123,7 +123,7 @@ static int hsw_ext_start(void)
>  			previous_count[num][cpu] = val;
>  		}
>  	}
> -	hsw_ext_get_count(TSC, &tsc_at_measure_start, 0);
> +	hsw_ext_get_count(TSC, &tsc_at_measure_start, base_cpu);
>  	return 0;
>  }
>  
> @@ -132,7 +132,7 @@ static int hsw_ext_stop(void)
>  	unsigned long long val;
>  	int num, cpu;
>  
> -	hsw_ext_get_count(TSC, &tsc_at_measure_end, 0);
> +	hsw_ext_get_count(TSC, &tsc_at_measure_end, base_cpu);
>  
>  	for (num = 0; num < HSW_EXT_CSTATE_COUNT; num++) {
>  		for (cpu = 0; cpu < cpu_count; cpu++) {
> diff --git a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> index c83f1606970b..d7c2a6d13dea 100644
> --- a/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/mperf_monitor.c
> @@ -80,7 +80,8 @@ static int mperf_get_count_freq(unsigned int id, unsigned long long *count,
>  static int mperf_get_tsc(unsigned long long *tsc)
>  {
>  	int ret;
> -	ret = read_msr(0, MSR_TSC, tsc);
> +
> +	ret = read_msr(base_cpu, MSR_TSC, tsc);
>  	if (ret)
>  		dprint("Reading TSC MSR failed, returning %llu\n", *tsc);
>  	return ret;
> diff --git a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
> index d2a91dd0d563..abf8cb5f7349 100644
> --- a/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/nhm_idle.c
> @@ -129,7 +129,7 @@ static int nhm_start(void)
>  	int num, cpu;
>  	unsigned long long dbg, val;
>  
> -	nhm_get_count(TSC, &tsc_at_measure_start, 0);
> +	nhm_get_count(TSC, &tsc_at_measure_start, base_cpu);
>  
>  	for (num = 0; num < NHM_CSTATE_COUNT; num++) {
>  		for (cpu = 0; cpu < cpu_count; cpu++) {
> @@ -137,7 +137,7 @@ static int nhm_start(void)
>  			previous_count[num][cpu] = val;
>  		}
>  	}
> -	nhm_get_count(TSC, &dbg, 0);
> +	nhm_get_count(TSC, &dbg, base_cpu);
>  	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_start);
>  	return 0;
>  }
> @@ -148,7 +148,7 @@ static int nhm_stop(void)
>  	unsigned long long dbg;
>  	int num, cpu;
>  
> -	nhm_get_count(TSC, &tsc_at_measure_end, 0);
> +	nhm_get_count(TSC, &tsc_at_measure_end, base_cpu);
>  
>  	for (num = 0; num < NHM_CSTATE_COUNT; num++) {
>  		for (cpu = 0; cpu < cpu_count; cpu++) {
> @@ -156,7 +156,7 @@ static int nhm_stop(void)
>  			current_count[num][cpu] = val;
>  		}
>  	}
> -	nhm_get_count(TSC, &dbg, 0);
> +	nhm_get_count(TSC, &dbg, base_cpu);
>  	dprint("TSC diff: %llu\n", dbg - tsc_at_measure_end);
>  
>  	return 0;
> diff --git a/tools/power/cpupower/utils/idle_monitor/snb_idle.c b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
> index efc8a69c9aba..a2b45219648d 100644
> --- a/tools/power/cpupower/utils/idle_monitor/snb_idle.c
> +++ b/tools/power/cpupower/utils/idle_monitor/snb_idle.c
> @@ -120,7 +120,7 @@ static int snb_start(void)
>  			previous_count[num][cpu] = val;
>  		}
>  	}
> -	snb_get_count(TSC, &tsc_at_measure_start, 0);
> +	snb_get_count(TSC, &tsc_at_measure_start, base_cpu);
>  	return 0;
>  }
>  
> @@ -129,7 +129,7 @@ static int snb_stop(void)
>  	unsigned long long val;
>  	int num, cpu;
>  
> -	snb_get_count(TSC, &tsc_at_measure_end, 0);
> +	snb_get_count(TSC, &tsc_at_measure_end, base_cpu);
>  
>  	for (num = 0; num < SNB_CSTATE_COUNT; num++) {
>  		for (cpu = 0; cpu < cpu_count; cpu++) {
> 
