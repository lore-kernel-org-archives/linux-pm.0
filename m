From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 08/16] cris idle: delete idle and pm_idle
Date: Mon, 11 Feb 2013 09:42:48 +0100
Message-ID: <20130211084248.GY23529@axis.com>
References: <2b219d07e0f287c2c713f5465fc8646158fa986e.1360475150.git.len.brown@intel.com>
 <128d290dacc38d1a3d09031018adf017eec0b5f2.1360475150.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <128d290dacc38d1a3d09031018adf017eec0b5f2.1360475150.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-cris-kernel <linux-cris-kernel@axis.com>
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 10, 2013 at 06:58:15AM +0100, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> pm_idle() and idle() served no purpose on cris --
> invoke default_idle() directly.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Cc: linux-cris-kernel@axis.com

Looks good!

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/kernel/process.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
> index 7f65be6..104ff4d 100644
> --- a/arch/cris/kernel/process.c
> +++ b/arch/cris/kernel/process.c
> @@ -54,11 +54,6 @@ void enable_hlt(void)
>  
>  EXPORT_SYMBOL(enable_hlt);
>   
> -/*
> - * The following aren't currently used.
> - */
> -void (*pm_idle)(void);
> -
>  extern void default_idle(void);
>  
>  void (*pm_power_off)(void);
> @@ -77,16 +72,12 @@ void cpu_idle (void)
>  	while (1) {
>  		rcu_idle_enter();
>  		while (!need_resched()) {
> -			void (*idle)(void);
>  			/*
>  			 * Mark this as an RCU critical section so that
>  			 * synchronize_kernel() in the unload path waits
>  			 * for our completion.
>  			 */
> -			idle = pm_idle;
> -			if (!idle)
> -				idle = default_idle;
> -			idle();
> +			default_idle();
>  		}
>  		rcu_idle_exit();
>  		schedule_preempt_disabled();
> -- 
> 1.8.1.3.535.ga923c31

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
