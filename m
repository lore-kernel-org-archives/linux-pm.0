From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeup: Use pm_pr_dbg() instead of pr_debug()
Date: Tue, 02 Apr 2019 10:41:19 +0200
Message-ID: <4534427.J6G7dtiVmp@aspire.rjw.lan>
References: <20190325172456.227190-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325172456.227190-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <swboyd@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wenkai Du <wenkai.du@intel.com>, Justin TerAvest <teravest@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Monday, March 25, 2019 6:24:56 PM CEST Stephen Boyd wrote:
> These prints are useful if we're doing PM suspend debugging. Having them
> at pr_debug() level means that we need to either enable DEBUG in this
> file, or compile the kernel with dynamic debug capabilities. Both of
> these options have drawbacks like custom compilation or opting into all
> debug statements being included into the kernel image. Given that we
> already have infrastructure to collect PM debugging information with
> CONFIG_PM_DEBUG and friends, let's change the pr_debug usage here to be
> pm_pr_dbg() instead so we can collect the wakeup information in the
> kernel logs.
> 
> Cc: Wenkai Du <wenkai.du@intel.com>
> Cc: Justin TerAvest <teravest@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index bb1ae175fae1..23c243a4c675 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -804,7 +804,7 @@ void pm_print_active_wakeup_sources(void)
>  	srcuidx = srcu_read_lock(&wakeup_srcu);
>  	list_for_each_entry_rcu(ws, &wakeup_sources, entry) {
>  		if (ws->active) {
> -			pr_debug("active wakeup source: %s\n", ws->name);
> +			pm_pr_dbg("active wakeup source: %s\n", ws->name);
>  			active = 1;
>  		} else if (!active &&
>  			   (!last_activity_ws ||
> @@ -815,7 +815,7 @@ void pm_print_active_wakeup_sources(void)
>  	}
>  
>  	if (!active && last_activity_ws)
> -		pr_debug("last active wakeup source: %s\n",
> +		pm_pr_dbg("last active wakeup source: %s\n",
>  			last_activity_ws->name);
>  	srcu_read_unlock(&wakeup_srcu, srcuidx);
>  }
> @@ -845,7 +845,7 @@ bool pm_wakeup_pending(void)
>  	raw_spin_unlock_irqrestore(&events_lock, flags);
>  
>  	if (ret) {
> -		pr_debug("Wakeup pending, aborting suspend\n");
> +		pm_pr_dbg("Wakeup pending, aborting suspend\n");
>  		pm_print_active_wakeup_sources();
>  	}
>  
> 

Applied, thanks!
