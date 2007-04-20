From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Fri, 20 Apr 2007 06:57:31 +0000
Message-ID: <20070420065731.GA5831@kroah.com>
References: <1176980411.6141.83.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 19, 2007 at 01:00:11PM +0200, Johannes Berg wrote:
> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. This patch
> allows architectures to define arch_s2ram_{en,dis}able_irqs in their
> asm/suspend.h to have control over this step.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
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

Can't you just make this a "weak" symbol and override it in your ppc
code if you really need it, and make a "real" function here in this file
for all other arches?

thanks,

greg k-h
