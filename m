From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: divide by zero on Knights
 Landing (KNL)
Date: Thu, 15 Oct 2015 13:43:54 -0700
Message-ID: <20151015134354.7f2046bf@kcaccard-desk.amr.corp.intel.com>
References: <1444937661-9519-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1444937661-9519-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19036 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbbJOUnz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 16:43:55 -0400
In-Reply-To: <1444937661-9519-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael.j.wysocki@intel.com, len.brown@intel.com, linux-pm@vger.kernel.org

On Thu, 15 Oct 2015 12:34:21 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> This is a workaround for KNL platform, where in some cases MPERF counter
> will not have updated value before next read of MSR_IA32_MPERF. In this
> case divide by zero will occur. This change ignores current sample for
> busy calculation in this case.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 3af9dd7..aa33b92 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -776,6 +776,11 @@ static inline void intel_pstate_sample(struct cpudata *cpu)
>  	local_irq_save(flags);
>  	rdmsrl(MSR_IA32_APERF, aperf);
>  	rdmsrl(MSR_IA32_MPERF, mperf);
> +	if (cpu->prev_mperf == mperf) {
> +		local_irq_restore(flags);
> +		return;
> +	}
> +
>  	tsc = rdtsc();
>  	local_irq_restore(flags);
>  

Acked-by: Kristen Carlson Accardi <kristen@linux.intel.com>
