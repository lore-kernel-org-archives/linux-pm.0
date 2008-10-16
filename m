From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/2] cpuidle: use last_state which can
 reflect the actual state entered
Date: Thu, 16 Oct 2008 17:55:53 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0810161755390.3026@localhost.localdomain>
References: <20080929222426.914988000@intel.com>
	<20080929222752.648696000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20080929222752.648696000@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

1,2 applied.

thanks,
-len

On Mon, 29 Sep 2008, Venkatesh Pallipadi wrote:

> cpuidle accounts the idle time for the C-state it was trying to enter and
> not to the actual state that the driver eventually entered. The driver may
> select a different state than the one chosen by cpuidle due to
> constraints like bus-mastering, etc.
> 
> Change the time acounting code to look at the dev->last_state after
> returning from target_state->enter(). Driver can modify dev->last_state
> internally, inside the enter routine to reflect the actual C-state
> entered.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  drivers/cpuidle/cpuidle.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Index: tip/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- tip.orig/drivers/cpuidle/cpuidle.c	2008-09-23 13:52:59.000000000 -0700
> +++ tip/drivers/cpuidle/cpuidle.c	2008-09-23 14:22:43.000000000 -0700
> @@ -71,8 +71,11 @@ static void cpuidle_idle_call(void)
>  	target_state = &dev->states[next_state];
>  
>  	/* enter the state and update stats */
> -	dev->last_residency = target_state->enter(dev, target_state);
>  	dev->last_state = target_state;
> +	dev->last_residency = target_state->enter(dev, target_state);
> +	if (dev->last_state)
> +		target_state = dev->last_state;
> +
>  	target_state->time += (unsigned long long)dev->last_residency;
>  	target_state->usage++;
>  
> 
> -- 
> 
