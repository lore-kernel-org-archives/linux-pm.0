From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 08:41:17 -0700
Message-ID: <200704210841.18581.david-b@pacbell.net>
References: <1176980411.6141.83.camel@johannes.berg>
	<1177163853.5941.21.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177163853.5941.21.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm <linux-pm@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Saturday 21 April 2007, Johannes Berg wrote:

>  int suspend_enter(suspend_state_t state)
>  {
>  	int error = 0;
> -	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	arch_s2ram_disable_irqs();

Sorry for not highlighting this before, but these are badly misnamed.
They apply for every system suspend state except PM_SUSPEND_DISK ...
NOT just suspend-to-ram, as specified by the function name.


> +	BUG_ON(!irqs_disabled());
>  
>  	if ((error = device_power_down(PMSG_SUSPEND))) {
>  		printk(KERN_ERR "Some devices failed to power down\n");
> @@ -143,7 +164,8 @@ int suspend_enter(suspend_state_t state)
>  	error = pm_ops->enter(state);
>  	device_power_up();
>   Done:
> -	local_irq_restore(flags);
> +	arch_s2ram_enable_irqs();

Same here.

> +	BUG_ON(irqs_disabled());
>  	return error;
>  }
>  
> 
