From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] MIPS: add IRQF_TIMER flag for Timer
	Interrupts
Date: Thu, 8 Oct 2009 22:26:43 +0200
Message-ID: <200910082226.43690.rjw__6896.92577948353$1255033594$gmane$org@sisk.pl>
References: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1255007874-19574-1-git-send-email-wuzhangjin@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Yoichi Yuasa <yuasa@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 08 October 2009, Wu Zhangjin wrote:
> This patch add IRQF_TIMER flag for all Timer interrupts in linux-MIPS,
> which will help to not disable the Timer IRQ when suspending to ensure
> resuming normally(d6c585a4342a2ff627a29f9aea77c5ed4cd76023) and not
> thread them when enabled PREEMPT_RT.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

> ---
>  arch/mips/jazz/irq.c                |    2 +-
>  arch/mips/kernel/cevt-gt641xx.c     |    2 +-
>  arch/mips/kernel/cevt-r4k.c         |    2 +-
>  arch/mips/kernel/i8253.c            |    2 +-
>  arch/mips/nxp/pnx8550/common/time.c |    2 +-
>  arch/mips/sgi-ip27/ip27-timer.c     |    2 +-
>  arch/mips/sni/time.c                |    2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/jazz/irq.c b/arch/mips/jazz/irq.c
> index 7fd170d..7bd32d0 100644
> --- a/arch/mips/jazz/irq.c
> +++ b/arch/mips/jazz/irq.c
> @@ -134,7 +134,7 @@ static irqreturn_t r4030_timer_interrupt(int irq, void *dev_id)
>  
>  static struct irqaction r4030_timer_irqaction = {
>  	.handler	= r4030_timer_interrupt,
> -	.flags		= IRQF_DISABLED,
> +	.flags		= IRQF_DISABLED | IRQF_TIMER,
>  	.name		= "R4030 timer",
>  };
>  
> diff --git a/arch/mips/kernel/cevt-gt641xx.c b/arch/mips/kernel/cevt-gt641xx.c
> index 92351e0..f5d265e 100644
> --- a/arch/mips/kernel/cevt-gt641xx.c
> +++ b/arch/mips/kernel/cevt-gt641xx.c
> @@ -113,7 +113,7 @@ static irqreturn_t gt641xx_timer0_interrupt(int irq, void *dev_id)
>  
>  static struct irqaction gt641xx_timer0_irqaction = {
>  	.handler	= gt641xx_timer0_interrupt,
> -	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
>  	.name		= "gt641xx_timer0",
>  };
>  
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 2652362..b469ad0 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -83,7 +83,7 @@ out:
>  
>  struct irqaction c0_compare_irqaction = {
>  	.handler = c0_compare_interrupt,
> -	.flags = IRQF_DISABLED | IRQF_PERCPU,
> +	.flags = IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
>  	.name = "timer",
>  };
>  
> diff --git a/arch/mips/kernel/i8253.c b/arch/mips/kernel/i8253.c
> index f7d8d5d..ed5c441 100644
> --- a/arch/mips/kernel/i8253.c
> +++ b/arch/mips/kernel/i8253.c
> @@ -98,7 +98,7 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
>  
>  static struct irqaction irq0  = {
>  	.handler = timer_interrupt,
> -	.flags = IRQF_DISABLED | IRQF_NOBALANCING,
> +	.flags = IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TIMER,
>  	.name = "timer"
>  };
>  
> diff --git a/arch/mips/nxp/pnx8550/common/time.c b/arch/mips/nxp/pnx8550/common/time.c
> index 18b1927..d987a89 100644
> --- a/arch/mips/nxp/pnx8550/common/time.c
> +++ b/arch/mips/nxp/pnx8550/common/time.c
> @@ -59,7 +59,7 @@ static irqreturn_t pnx8xxx_timer_interrupt(int irq, void *dev_id)
>  
>  static struct irqaction pnx8xxx_timer_irq = {
>  	.handler	= pnx8xxx_timer_interrupt,
> -	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
>  	.name		= "pnx8xxx_timer",
>  };
>  
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 6d0e59f..d6802d6 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -105,7 +105,7 @@ static irqreturn_t hub_rt_counter_handler(int irq, void *dev_id)
>  
>  struct irqaction hub_rt_irqaction = {
>  	.handler	= hub_rt_counter_handler,
> -	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
>  	.name		= "hub-rt",
>  };
>  
> diff --git a/arch/mips/sni/time.c b/arch/mips/sni/time.c
> index 62df6a5..f3b60e6 100644
> --- a/arch/mips/sni/time.c
> +++ b/arch/mips/sni/time.c
> @@ -67,7 +67,7 @@ static irqreturn_t a20r_interrupt(int irq, void *dev_id)
>  
>  static struct irqaction a20r_irqaction = {
>  	.handler	= a20r_interrupt,
> -	.flags		= IRQF_DISABLED | IRQF_PERCPU,
> +	.flags		= IRQF_DISABLED | IRQF_PERCPU | IRQF_TIMER,
>  	.name		= "a20r-timer",
>  };
>  
> 
