From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 48/52] tools/power: turbostat: fix large c1%
	issue
Date: Wed, 25 Jul 2012 09:03:14 -0400
Message-ID: <20120725130314.GB4783@phenom.dumpdata.com>
References: <6af1c4fc5227af65092ebc848989693562bfa3e8.1343187617.git.len.brown@intel.com>
	<c3ae331d1c2fe25edfbece73fda0bb312445b636.1343187618.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <c3ae331d1c2fe25edfbece73fda0bb312445b636.1343187618.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 24, 2012 at 11:41:44PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Under some conditions, c1% was displayed as very large number,
> much higher than 100%.
> 
> c1% is not measured, it is derived as "that, which is left over"
> from other counters.  However, the other counters are not collected
> atomically, and so it is possible for c1% to be calaculagted as

calculated.

> a small negative number -- displayed as very large positive.
> 
> There was a check for mperf vs tsc for this already,
> but it needed to also include the other counters
> that are used to calculate c1.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index b815a12..861d771 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -444,6 +444,9 @@ delta_core(struct core_data *new, struct core_data *old)
>  	old->c7 = new->c7 - old->c7;
>  }
>  
> +/*
> + * old = new - old
> + */
>  void
>  delta_thread(struct thread_data *new, struct thread_data *old,
>  	struct core_data *core_delta)
> @@ -482,19 +485,20 @@ delta_thread(struct thread_data *new, struct thread_data *old,
>  
>  
>  	/*
> -	 * As mperf and tsc collection are not atomic,
> -	 * it is possible for mperf's non-halted cycles
> +	 * As counter collection is not atomic,
> +	 * it is possible for mperf's non-halted cycles + idle states
>  	 * to exceed TSC's all cycles: show c1 = 0% in that case.
>  	 */
> -	if (old->mperf > old->tsc)
> +	if ((old->mperf + core_delta->c3 + core_delta->c6 + core_delta->c7) > old->tsc)
>  		old->c1 = 0;
>  	else {
>  		/* normal case, derive c1 */
>  		old->c1 = old->tsc - old->mperf - core_delta->c3
>  				- core_delta->c6 - core_delta->c7;
>  	}
> +
>  	if (old->mperf == 0) {
> -		if (verbose) fprintf(stderr, "cpu%d MPERF 0!\n", old->cpu_id);
> +		if (verbose > 1) fprintf(stderr, "cpu%d MPERF 0!\n", old->cpu_id);
>  		old->mperf = 1;	/* divide by 0 protection */
>  	}
>  
> -- 
> 1.7.12.rc0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
