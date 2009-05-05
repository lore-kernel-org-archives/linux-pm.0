From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Mon, 4 May 2009 23:54:05 -0700
Message-ID: <20090504235405.647772ed.akpm__403.793695341115$1241506642$gmane$org@linux-foundation.org>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon,  4 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deeprootsystems.com> wrote:

> Interrupts that are flagged as wakeup sources via set_irq_wake()
> should not be disabled for suspend.
> 

Why not?

> 
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index 638d8be..99113bd 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -28,6 +28,9 @@ void suspend_device_irqs(void)
>  	for_each_irq_desc(irq, desc) {
>  		unsigned long flags;
>  
> +		if (desc->status & IRQ_WAKEUP)
> +			continue;
> +
>  		spin_lock_irqsave(&desc->lock, flags);
>  		__disable_irq(desc, irq, true);
>  		spin_unlock_irqrestore(&desc->lock, flags);

If this fixes some bug then please provide a description of that bug?
