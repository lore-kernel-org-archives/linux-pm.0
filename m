From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] PM / suspend: measure the time of filesystem syncing
Date: Tue, 19 Feb 2019 11:24:36 +0100
Message-ID: <2819109.DzhZvocLkm@aspire.rjw.lan>
References: <20190206154214.576-1-harry.pan@intel.com> <20190214111543.22137-1-harry.pan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214111543.22137-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Pan <harry.pan@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com, pavel@ucw.cz, len.brown@intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, February 14, 2019 12:15:43 PM CET Harry Pan wrote:
> This patch gives the reader an intuitive metric of the time cost by
> the kernel issuing a filesystem sync during suspend; although developer
> can guess by the timestamp of next log or enable the ftrace power event
> for manual calculation, this manner is easier to read and benefits the
> automatic script.
> 
> v2: simplify the variables, apply the simplest form of ktime API.
> v3: reduce conditional compilation, rectify profiling in better syntax
> 
> Signed-off-by: Harry Pan <harry.pan@intel.com>
> ---
>  kernel/power/suspend.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 0bd595a0b610..4844fc6a796d 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -568,13 +568,20 @@ static int enter_state(suspend_state_t state)
>  	if (state == PM_SUSPEND_TO_IDLE)
>  		s2idle_begin();
>  
> -#ifndef CONFIG_SUSPEND_SKIP_SYNC
> -	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> -	pr_info("Syncing filesystems ... ");
> -	ksys_sync();
> -	pr_cont("done.\n");
> -	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> -#endif
> +	if (!IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC)) {
> +		ktime_t start;
> +		unsigned int elapsed_msecs;
> +
> +		trace_suspend_resume(TPS("sync_filesystems"), 0, true);
> +		pr_info("Syncing filesystems ... ");
> +		start = ktime_get();
> +		ksys_sync();
> +		elapsed_msecs = ktime_to_ms(ktime_sub(ktime_get(), start));
> +		pr_cont("(elapsed %d.%03d seconds) done.\n",
> +			elapsed_msecs / MSEC_PER_SEC,
> +			elapsed_msecs % MSEC_PER_SEC);

One more nit.

Since you are printing the sync time anyway, there is a little sense to
split the message using pr_cont() that may be messed up with by any
intervening messages, so why don't you just print a one-line
pr_info("Filesystems sync: %d.%03d seconds\n", ...) message?

Also, if you change it here, I guess it would be consistent to make an
analogous change for hibernation.

> +		trace_suspend_resume(TPS("sync_filesystems"), 0, false);
> +	}
>  
>  	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
>  	pm_suspend_clear_flags();
> 
