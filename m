From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] cpufreq: intel_pstate: Fix the scaling of _PSS entry[0]
Date: Sat, 14 Nov 2015 01:45:01 +0100
Message-ID: <4014502.HoPW4hkEdy@vostro.rjw.lan>
References: <1447124291-14059-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1447124291-14059-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59716 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752270AbbKNAPh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Nov 2015 19:15:37 -0500
In-Reply-To: <1447124291-14059-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, lenlenb@kernel.org, linux-pm@vger.kernel.org

On Monday, November 09, 2015 06:58:11 PM Srinivas Pandruvada wrote:
> Since even non core platforms like Atom SoC has _PSS table, we can't
> hardcode scaling. Instead we can use cpu->pstate.scaling. We need to
> convert to MHz as the scaling values are in KHz.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 69dc9b5..50d3cff 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -312,7 +312,7 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
>  		 * Also need to convert to MHz as _PSS freq is in MHz.
>  		 */
>  		cpu->acpi_perf_data.states[0].core_frequency =
> -						turbo_pss_ctl * 100;
> +				turbo_pss_ctl * cpu->pstate.scaling / 1000;
>  	}
>  
>  	pr_debug("intel_pstate: Updated limits using _PSS 0x%x 0x%x 0x%x\n",
> 

Applied, thanks!

Rafael

