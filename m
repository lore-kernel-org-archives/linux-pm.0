From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 2/9] irq_work: add irq_work_queue_on for !CONFIG_SMP
Date: Wed, 29 Mar 2017 23:20:48 +0200
Message-ID: <2627152.ptA2OSn8Sr@aspire.rjw.lan>
References: <cover.1489058244.git.viresh.kumar@linaro.org> <85403db254e26655d608137d7df49ebf3aade0c3.1489058244.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <85403db254e26655d608137d7df49ebf3aade0c3.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 09, 2017 05:15:12 PM Viresh Kumar wrote:
> From: Steve Muckle <smuckle.linux@gmail.com>
> 
> Having irq_work_queue_on() available for !CONFIG_SMP can make some
> call sites cleaner.
> 
> Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/irq_work.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> index 47b9ebd4a74f..0195c3502d6b 100644
> --- a/include/linux/irq_work.h
> +++ b/include/linux/irq_work.h
> @@ -1,6 +1,7 @@
>  #ifndef _LINUX_IRQ_WORK_H
>  #define _LINUX_IRQ_WORK_H
>  
> +#include <linux/bug.h>
>  #include <linux/llist.h>
>  
>  /*
> @@ -36,6 +37,12 @@ bool irq_work_queue(struct irq_work *work);
>  
>  #ifdef CONFIG_SMP
>  bool irq_work_queue_on(struct irq_work *work, int cpu);
> +#else
> +static inline bool irq_work_queue_on(struct irq_work *work, int cpu)
> +{
> +	BUG_ON(cpu != 0);

Would WARN_ON(), or WARN_ON_ONCE() even, be insufficient?

> +	return irq_work_queue(work);
> +}
>  #endif
>  
>  void irq_work_tick(void);
> 

Thanks,
Rafael
