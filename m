From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [v5 PATCH 4/4] timers: logic to move non pinned
	timers
Date: Mon, 6 Apr 2009 18:48:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904061846140.21577__8334.4042221599$1239036898$gmane$org@localhost.localdomain>
References: <20090406161357.GB15269@linux.vnet.ibm.com>
	<20090406162205.GE15269@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090406162205.GE15269@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, linux-pm@lists.linux-foundation.org, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

Arun,

On Mon, 6 Apr 2009, Arun R Bharadwaj wrote:
> +again:
> +	new_cpu_base = &per_cpu(hrtimer_bases, cpu);
>  	new_base = &new_cpu_base->clock_base[base->index];
>  
>  	if (base != new_base) {
> @@ -219,6 +230,34 @@ switch_hrtimer_base(struct hrtimer *time
>  		timer->base = NULL;
>  		spin_unlock(&base->cpu_base->lock);
>  		spin_lock(&new_base->cpu_base->lock);
> +
> +		if (cpu == preferred_cpu) {
> +			/* Calculate clock monotonic expiry time */
> +			ktime_t expires = ktime_sub(hrtimer_get_expires(timer),
> +							new_base->offset);
> +
> +			/*
> +			 * Get the next event on target cpu from the
> +			 * clock events layer.
> +			 * This covers the highres=off nohz=on case as well.
> +			 */
> +			ktime_t next = clockevents_get_next_event(cpu);
> +
> +			ktime_t delta = ktime_sub(expires, next);
> +
> +			/*
> +			 * We do not migrate the timer when it is expiring
> +			 * before the next event on the target cpu because
> +			 * we cannot reprogram the target cpu hardware and
> +			 * we would cause it to fire late.
> +			 */
> +			if (delta.tv64 < 0) {
> +				cpu = smp_processor_id();
> +				spin_unlock(&new_base->cpu_base->lock);
> +				spin_lock(&base->cpu_base->lock);

Darn, I knew that I missed something when I looked at this before:

      	     	    	   	 timer->base = base;

Thanks,

	tglx
