From: sriram@marirs.net.in
Subject: Re: [PATCH 1/1] Moving error logs under stderr like most of unix tools
 like ls & rm
Date: Fri, 06 Nov 2015 12:01:26 +0530
Message-ID: <1446791486.3675655.430755377.0CF29AA3@webmail.messagingengine.com>
References: <1445621366-13341-1-git-send-email-sriram@marirs.net.in>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39846 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757238AbbKFGb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2015 01:31:27 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B06C520365
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2015 01:31:26 -0500 (EST)
In-Reply-To: <1445621366-13341-1-git-send-email-sriram@marirs.net.in>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sriram Raghunathan <sriram@marirs.net.in>, trenn@suse.com, rafael.j.wysocki@intel.com, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, ego@linux.vnet.ibm.com
Cc: linux-pm@vger.kernel.org

Typo in email-id. Changed. 


On Fri, Oct 23, 2015, at 10:59 PM, Sriram Raghunathan wrote:
> The patch below, aligns cpupower tool with that of most 
> unix tools like ls, rm in redireting errors to 'STDERR'. 
> 
> Previously within the below committed files, there were difference
> in redirecting the errors to stdout & to stderr. Created a common
> error log redirection to stderr always. This when followed in future 
> would be really helpful to users of the tool. 
> 
> Signed-off-by: Sriram Raghunathan <sriram@marirs.net.in>
> ---
>  tools/power/cpupower/utils/cpufreq-info.c  |  6 +++---
>  tools/power/cpupower/utils/cpufreq-set.c   | 10 +++++-----
>  tools/power/cpupower/utils/cpuidle-info.c  |  2 +-
>  tools/power/cpupower/utils/cpuidle-set.c   |  6 +++---
>  tools/power/cpupower/utils/cpupower-info.c |  6 +++---
>  tools/power/cpupower/utils/cpupower-set.c  |  4 ++--
>  6 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpufreq-info.c
> b/tools/power/cpupower/utils/cpufreq-info.c
> index 0e67643..12672dc 100644
> --- a/tools/power/cpupower/utils/cpufreq-info.c
> +++ b/tools/power/cpupower/utils/cpufreq-info.c
> @@ -28,7 +28,7 @@ static unsigned int count_cpus(void)
>  
>  	fp = fopen("/proc/stat", "r");
>  	if (!fp) {
> -               printf(_("Couldn't count the number of CPUs (%s: %s),
> assuming 1\n"), "/proc/stat", strerror(errno));
> +               fprintf(stderr,_("Couldn't count the number of CPUs (%s:
> %s), assuming 1\n"), "/proc/stat", strerror(errno));
>  		return 1;
>  	}
>  
> @@ -175,7 +175,7 @@ static int get_boost_mode(unsigned int cpu)
>  
>  	ret = cpufreq_has_boost_support(cpu, &support, &active, &b_states);
>  	if (ret) {
> -               printf(_("Error while evaluating Boost Capabilities"
> +               fprintf(stderr,_("Error while evaluating Boost
> Capabilities"
>  				" on CPU %d -- are you root?\n"), cpu);
>  		return ret;
>  	}
> @@ -264,7 +264,7 @@ static void debug_output_one(unsigned int cpu)
>  
>  	driver = cpufreq_get_driver(cpu);
>  	if (!driver) {
> -               printf(_("  no or unknown cpufreq driver is active on
> this CPU\n"));
> +              fprintf(stderr,_("  no or unknown cpufreq driver is active
> on this CPU\n"));
>  	} else {
>  		printf(_("  driver: %s\n"), driver);
>  		cpufreq_put_driver(driver);
> diff --git a/tools/power/cpupower/utils/cpufreq-set.c
> b/tools/power/cpupower/utils/cpufreq-set.c
> index 276919d..bcf74cc 100644
> --- a/tools/power/cpupower/utils/cpufreq-set.c
> +++ b/tools/power/cpupower/utils/cpufreq-set.c
> @@ -57,7 +57,7 @@ const struct freq_units def_units[] = {
>  
>  static void print_unknown_arg(void)
>  {
> -       printf(_("invalid or unknown argument\n"));
> +        fprintf(stderr,_("invalid or unknown argument\n"));
>  }
>  
>  static unsigned long string_to_frequency(const char *str)
> @@ -144,7 +144,7 @@ static int do_new_policy(unsigned int cpu, struct
> cpufreq_policy *new_pol)
>  	int ret;
>  
>  	if (!cur_pol) {
> -               printf(_("wrong, unknown or unhandled CPU?\n"));
> +               fprintf(stderr,_("wrong, unknown or unhandled CPU?\n"));
>  		return -EINVAL;
>  	}
>  
> @@ -269,18 +269,18 @@ int cmd_freq_set(int argc, char **argv)
>  
>  	/* parameter checking */
>  	if (double_parm) {
> -               printf("the same parameter was passed more than once\n");
> +               fprintf(stderr,"the same parameter was passed more than
> once\n");
>  		return -EINVAL;
>  	}
>  
>  	if (freq && policychange) {
> -               printf(_("the -f/--freq parameter cannot be combined with
> -d/--min, -u/--max or\n"
> +               fprintf(stderr,_("the -f/--freq parameter cannot be
> combined with -d/--min, -u/--max or\n"
>  				"-g/--governor parameters\n"));
>  		return -EINVAL;
>  	}
>  
>  	if (!freq && !policychange) {
> -               printf(_("At least one parameter out of -f/--freq,
> -d/--min, -u/--max, and\n"
> +               fprintf(stderr,_("At least one parameter out of
> -f/--freq, -d/--min, -u/--max, and\n"
>  				"-g/--governor must be passed\n"));
>  		return -EINVAL;
>  	}
> diff --git a/tools/power/cpupower/utils/cpuidle-info.c
> b/tools/power/cpupower/utils/cpuidle-info.c
> index 750c1d8..47716ff 100644
> --- a/tools/power/cpupower/utils/cpuidle-info.c
> +++ b/tools/power/cpupower/utils/cpuidle-info.c
> @@ -175,7 +175,7 @@ int cmd_idle_info(int argc, char **argv)
>  			 "output-specific argument\n"));
>  		cpuidle_exit(EXIT_FAILURE);
>  	case '?':
> -               printf(_("invalid or unknown argument\n"));
> +               fprintf(stderr,_("invalid or unknown argument\n"));
>  		cpuidle_exit(EXIT_FAILURE);
>  	}
>  
> diff --git a/tools/power/cpupower/utils/cpuidle-set.c
> b/tools/power/cpupower/utils/cpuidle-set.c
> index 5c44d5b..2057609 100644
> --- a/tools/power/cpupower/utils/cpuidle-set.c
> +++ b/tools/power/cpupower/utils/cpuidle-set.c
> @@ -66,7 +66,7 @@ int cmd_idle_set(int argc, char **argv)
>  			param = ret;
>  			latency = strtoull(optarg, &endptr, 10);
>  			if (*endptr != '\0') {
> -                               printf(_("Bad latency value: %s\n"),
> optarg);
> +                               fprintf(stderr,_("Bad latency value:
> %s\n"), optarg);
>  				exit(EXIT_FAILURE);
>  			}
>  			break;
> @@ -86,11 +86,11 @@ int cmd_idle_set(int argc, char **argv)
>  
>  	switch (param) {
>  	case -1:
> -               printf(_("You can't specify more than one "
> +               fprintf(stderr,_("You can't specify more than one "
>  			 "output-specific argument\n"));
>  		exit(EXIT_FAILURE);
>  	case '?':
> -               printf(_("invalid or unknown argument\n"));
> +               fprintf(stderr,_("invalid or unknown argument\n"));
>  		exit(EXIT_FAILURE);
>  	}
>  
> diff --git a/tools/power/cpupower/utils/cpupower-info.c
> b/tools/power/cpupower/utils/cpupower-info.c
> index 10299f2..1c0c594 100644
> --- a/tools/power/cpupower/utils/cpupower-info.c
> +++ b/tools/power/cpupower/utils/cpupower-info.c
> @@ -23,7 +23,7 @@ static struct option set_opts[] = {
>  
>  static void print_wrong_arg_exit(void)
>  {
> -       printf(_("invalid or unknown argument\n"));
> +        fprintf(stderr,_("invalid or unknown argument\n"));
>  	exit(EXIT_FAILURE);
>  }
>  
> @@ -71,9 +71,9 @@ int cmd_info(int argc, char **argv)
>  	if (params.perf_bias) {
>  		if (!run_as_root) {
>  			params.perf_bias = 0;
> -                       printf(_("Intel's performance bias setting needs
> root privileges\n"));
> +                       fprintf(stderr,_("Intel's performance bias
> setting needs root privileges\n"));
>  		} else if (!(cpupower_cpu_info.caps & CPUPOWER_CAP_PERF_BIAS)) {
> -                       printf(_("System does not support Intel's
> performance"
> +                       fprintf(stderr,_("System does not support Intel's
> performance"
>  				 " bias setting\n"));
>  			params.perf_bias = 0;
>  		}
> diff --git a/tools/power/cpupower/utils/cpupower-set.c
> b/tools/power/cpupower/utils/cpupower-set.c
> index 3e6f374..7bdaa08 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -24,7 +24,7 @@ static struct option set_opts[] = {
>  
>  static void print_wrong_arg_exit(void)
>  {
> -       printf(_("invalid or unknown argument\n"));
> +        fprintf(stderr,_("invalid or unknown argument\n"));
>  	exit(EXIT_FAILURE);
>  }
>  
> @@ -56,7 +56,7 @@ int cmd_set(int argc, char **argv)
>  				print_wrong_arg_exit();
>  			perf_bias = atoi(optarg);
>  			if (perf_bias < 0 || perf_bias > 15) {
> -                               printf(_("--perf-bias param out "
> +                               fprintf(stderr,_("--perf-bias param out "
>  					 "of range [0-%d]\n"), 15);
>  				print_wrong_arg_exit();
>  			}
> -- 
> 2.6.1
> 
