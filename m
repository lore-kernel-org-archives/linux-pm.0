From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 12:44:48 -0700
Message-ID: <20070420124448.4eaa159c.akpm@linux-foundation.org>
References: <1176980411.6141.83.camel@johannes.berg>
	<20070420065731.GA5831@kroah.com>
	<1177083093.5902.3.camel@johannes.berg>
	<20070420173951.GB14778@kroah.com>
	<1177097838.5902.10.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177097838.5902.10.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 20 Apr 2007 21:37:18 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

>  int suspend_enter(suspend_state_t state)
>  {
>  	int error = 0;
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	arch_s2ram_disable_irqs(&flags);
> +	BUG_ON(!irqs_disabled());
>  
>  	if ((error = device_power_down(PMSG_SUSPEND))) {
>  		printk(KERN_ERR "Some devices failed to power down\n");
> @@ -143,7 +165,8 @@ int suspend_enter(suspend_state_t state)
>  	error = pm_ops->enter(state);
>  	device_power_up();
>   Done:
> -	local_irq_restore(flags);
> +	arch_s2ram_enable_irqs(&flags);
> +	BUG_ON(irqs_disabled());
>  	return error;
>  }

The second BUG_ON() looks a bit fishy to me.  If someone calls
suspend_enter() with local interrupts disabled, it will trigger.
