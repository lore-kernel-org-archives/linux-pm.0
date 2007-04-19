From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Thu, 19 Apr 2007 14:55:08 -0700
Message-ID: <20070419145508.4a6d2055.akpm@linux-foundation.org>
References: <1176980411.6141.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176980411.6141.83.camel@johannes.berg>
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

On Thu, 19 Apr 2007 13:00:11 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. This patch
> allows architectures to define arch_s2ram_{en,dis}able_irqs in their
> asm/suspend.h to have control over this step.
> 

what on earth is a decrementer?

> 
> ---
>  kernel/power/main.c |   14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> --- wireless-dev.orig/kernel/power/main.c	2007-04-17 18:52:24.536830941 +0200
> +++ wireless-dev/kernel/power/main.c	2007-04-17 19:09:40.966830941 +0200
> @@ -128,13 +128,22 @@ static int suspend_prepare(suspend_state
>  	return error;
>  }
>  
> +#ifndef arch_s2ram_disable_irqs
> +#define arch_s2ram_disable_irqs(flags) local_irq_save(*flags)
> +#endif
> +
> +#ifndef arch_s2ram_enable_irqs
> +#define arch_s2ram_enable_irqs(flags) local_irq_restore(*flags)
> +#endif
> +
>  
>  int suspend_enter(suspend_state_t state)
>  {
>  	int error = 0;
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	arch_s2ram_disable_irqs(&flags);

hm, ugly.  We could use attribute(weak) here, so we don't force
architectures to implement this with a macro.  But whatever.


It might be nice to identify which arch header is supposed to define
arch_s2ram_disable_irqs, perhaps via an explicit inclusion of that header.
