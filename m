From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 2/5] intel_pstate: Use C0 time for busy calculations
 (again).
Date: Wed, 6 May 2015 12:20:27 -0700
Message-ID: <20150506122027.568b0522@kcaccard-desk.amr.corp.intel.com>
References: <1428811830-15006-1-git-send-email-dsmythies@telus.net>
	<1428811830-15006-3-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30025 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbbEFTUw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 6 May 2015 15:20:52 -0400
In-Reply-To: <1428811830-15006-3-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: rjw@rjwysocki.net, dsmythies@telus.net, linux-pm@vger.kernel.org

On Sat, 11 Apr 2015 21:10:27 -0700
Doug Smythies <doug.smythies@gmail.com> wrote:

> This patch brings back the inclusion of C0 time
> for the calculation of core_busy.
> scaled_busy ultimatley defines the target pstate
> (CPU frequency) verses load (C0) response curve.
> The target pstate will be held at minimum until the load
> is larger than the c0_floor. Thereafter, the response
> is roughly linear until the maximum target pstate is
> reached at the c0_ceiling.
> A larger co_floor and lesser c0_ceiling tends towards
> minimum energy, at a cost of performance and slower rising
> edge load response times. A lesser c0_floor and larger
> c0_ceiling tends towards more energy consumption, but
> better performance and faster rising edge load response
> times. Note, for falling edge loads, response times are
> dominated by durations, and this driver runs very rarely.
> c0_floor and c0_ceiling are available in the debugfs.
> c0_floor and c0_ceiling are in units of tenths of a percent.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  Documentation/cpu-freq/intel-pstate.txt |  2 +
>  drivers/cpufreq/intel_pstate.c          | 87 +++++++++++++++++++++++----------
>  2 files changed, 63 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/intel-pstate.txt b/Documentation/cpu-freq/intel-pstate.txt
> index 6557507..583a048 100644
> --- a/Documentation/cpu-freq/intel-pstate.txt
> +++ b/Documentation/cpu-freq/intel-pstate.txt
> @@ -56,6 +56,8 @@ For legacy mode debugfs files have also been added to allow tuning of
>  the internal governor algorythm. These files are located at
>  /sys/kernel/debug/pstate_snb/ These files are NOT present in HWP mode.
>  
> +      c0_ceiling
> +      c0_floor
>        deadband
>        d_gain_pct
>        i_gain_pct
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index f181ce5..ddc3602 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -121,6 +121,8 @@ struct pstate_adjust_policy {
>  	int p_gain_pct;
>  	int d_gain_pct;
>  	int i_gain_pct;
> +	int c0_ceiling;
> +	int c0_floor;
>  };
>  
>  struct pstate_funcs {
> @@ -313,6 +315,8 @@ static struct pid_param pid_files[] = {
>  	{"deadband", &pid_params.deadband},
>  	{"setpoint", &pid_params.setpoint},
>  	{"p_gain_pct", &pid_params.p_gain_pct},
> +	{"c0_ceiling", &pid_params.c0_ceiling},
> +	{"c0_floor", &pid_params.c0_floor},
>  	{NULL, NULL}
>  };
>  
> @@ -624,6 +628,8 @@ static struct cpu_defaults core_params = {
>  		.p_gain_pct = 20,
>  		.d_gain_pct = 0,
>  		.i_gain_pct = 0,
> +		.c0_ceiling = 950,
> +		.c0_floor = 450,
>  	},
>  	.funcs = {
>  		.get_max = core_get_max_pstate,
> @@ -642,6 +648,8 @@ static struct cpu_defaults byt_params = {
>  		.p_gain_pct = 14,
>  		.d_gain_pct = 0,
>  		.i_gain_pct = 4,
> +		.c0_ceiling = 950,
> +		.c0_floor = 450,
>  	},
>  	.funcs = {
>  		.get_max = byt_get_max_pstate,
> @@ -720,6 +728,14 @@ static inline void intel_pstate_calc_busy(struct cpudata *cpu)
>  			cpu->pstate.max_pstate * cpu->pstate.scaling / 100),
>  			core_pct));
>  
> +	core_pct = int_tofp(sample->mperf) * int_tofp(1000);
> +	core_pct = div64_u64(core_pct, int_tofp(sample->tsc));

FYI - It's not actually valid to use the contents of mperf without aperf
according the the intel SDM:

"Only the IA32_APERF/IA32_MPERF ratio is architecturally defined;
software should not attach meaning to the content of the individual of IA32_APERF or IA32_MPERF MSRs."

There is no guarantee mperf and tsc are using the same clock.
