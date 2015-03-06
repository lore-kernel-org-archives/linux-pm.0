From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 8/9] clocksource: atmel-st: use syscon/regmap
Date: Fri, 06 Mar 2015 09:43:02 +0100
Message-ID: <54F96896.6040204@linaro.org>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com> <1425570594-13124-9-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425570594-13124-9-git-send-email-alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
> The register range from the system timer is also used by the watchdog=
 driver.
> Use a regmap to handle concurrent accesses.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTGGXanvQGlWp@public.gmane.org=
m>
> Acked-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>   drivers/clocksource/timer-atmel-st.c | 99 ++++++++++++++-----------=
-----------
>   1 file changed, 37 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksour=
ce/timer-atmel-st.c
> index 7d062ab32674..c4a52e32675e 100644
> --- a/drivers/clocksource/timer-atmel-st.c
> +++ b/drivers/clocksource/timer-atmel-st.c
> @@ -24,19 +24,19 @@
>   #include <linux/irq.h>
>   #include <linux/clockchips.h>
>   #include <linux/export.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mfd/syscon/atmel-st.h>
>   #include <linux/of_irq.h>
> +#include <linux/regmap.h>
>
>   #include <asm/mach/time.h>
>
> -#include <mach/at91_st.h>
> -#include <mach/hardware.h>
> -
>   static unsigned long last_crtr;
>   static u32 irqmask;
>   static struct clock_event_device clkevt;
> +static struct regmap *regmap_st;
>
> +#define AT91_SLOW_CLOCK		32768
>   #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
>
>   /*
> @@ -46,11 +46,11 @@ static struct clock_event_device clkevt;
>    */
>   static inline unsigned long read_CRTR(void)
>   {
> -	unsigned long x1, x2;
> +	unsigned int x1, x2;
>
> -	x1 =3D at91_st_read(AT91_ST_CRTR);
> +	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
>   	do {
> -		x2 =3D at91_st_read(AT91_ST_CRTR);
> +		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
>   		if (x1 =3D=3D x2)
>   			break;
>   		x1 =3D x2;
> @@ -63,7 +63,10 @@ static inline unsigned long read_CRTR(void)
>    */
>   static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id=
)
>   {
> -	u32	sr =3D at91_st_read(AT91_ST_SR) & irqmask;
> +	u32 sr;
> +
> +	regmap_read(regmap_st, AT91_ST_SR, &sr);
> +	sr &=3D irqmask;
>
>   	/*
>   	 * irqs should be disabled here, but as the irq is shared they are=
 only
> @@ -96,7 +99,7 @@ static struct irqaction at91rm9200_timer_irq =3D {
>   	.name		=3D "at91_tick",
>   	.flags		=3D IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
>   	.handler	=3D at91rm9200_timer_interrupt,
> -	.irq		=3D NR_IRQS_LEGACY + AT91_ID_SYS,
> +	.irq		=3D 0,

Is this change related to regmap ?

By the way, perhaps take the opportunity to replace setup_irq by=20
request_irq (and check the return value) ?

>   };
>
>   static cycle_t read_clk32k(struct clocksource *cs)
> @@ -115,23 +118,25 @@ static struct clocksource clk32k =3D {
>   static void
>   clkevt32k_mode(enum clock_event_mode mode, struct clock_event_devic=
e *dev)
>   {
> +	unsigned int val;
> +
>   	/* Disable and flush pending timer interrupts */
> -	at91_st_write(AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_IDR, AT91_ST_PITS | AT91_ST_ALMS);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
>
>   	last_crtr =3D read_CRTR();
>   	switch (mode) {
>   	case CLOCK_EVT_MODE_PERIODIC:
>   		/* PIT for periodic irqs; fixed rate of 1/HZ */
>   		irqmask =3D AT91_ST_PITS;
> -		at91_st_write(AT91_ST_PIMR, RM9200_TIMER_LATCH);
> +		regmap_write(regmap_st, AT91_ST_PIMR, RM9200_TIMER_LATCH);
>   		break;
>   	case CLOCK_EVT_MODE_ONESHOT:
>   		/* ALM for oneshot irqs, set by next_event()
>   		 * before 32 seconds have passed
>   		 */
>   		irqmask =3D AT91_ST_ALMS;
> -		at91_st_write(AT91_ST_RTAR, last_crtr);
> +		regmap_write(regmap_st, AT91_ST_RTAR, last_crtr);
>   		break;
>   	case CLOCK_EVT_MODE_SHUTDOWN:
>   	case CLOCK_EVT_MODE_UNUSED:
> @@ -139,7 +144,7 @@ clkevt32k_mode(enum clock_event_mode mode, struct=
 clock_event_device *dev)
>   		irqmask =3D 0;
>   		break;
>   	}
> -	at91_st_write(AT91_ST_IER, irqmask);
> +	regmap_write(regmap_st, AT91_ST_IER, irqmask);
>   }
>
>   static int
> @@ -147,6 +152,7 @@ clkevt32k_next_event(unsigned long delta, struct =
clock_event_device *dev)
>   {
>   	u32		alm;
>   	int		status =3D 0;
> +	unsigned int	val;
>
>   	BUG_ON(delta < 2);
>
> @@ -162,12 +168,12 @@ clkevt32k_next_event(unsigned long delta, struc=
t clock_event_device *dev)
>   	alm =3D read_CRTR();
>
>   	/* Cancel any pending alarm; flush any pending IRQ */
> -	at91_st_write(AT91_ST_RTAR, alm);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
>
>   	/* Schedule alarm by writing RTAR. */
>   	alm +=3D delta;
> -	at91_st_write(AT91_ST_RTAR, alm);
> +	regmap_write(regmap_st, AT91_ST_RTAR, alm);
>
>   	return status;
>   }
> @@ -180,57 +186,26 @@ static struct clock_event_device clkevt =3D {
>   	.set_mode	=3D clkevt32k_mode,
>   };
>
> -void __iomem *at91_st_base;
> -EXPORT_SYMBOL_GPL(at91_st_base);
> -
> -static const struct of_device_id at91rm9200_st_timer_ids[] =3D {
> -	{ .compatible =3D "atmel,at91rm9200-st" },
> -	{ /* sentinel */ }
> -};
> -
> -static int __init of_at91rm9200_st_init(void)
> -{
> -	struct device_node *np;
> -	int ret;
> -
> -	np =3D of_find_matching_node(NULL, at91rm9200_st_timer_ids);
> -	if (!np)
> -		goto err;
> -
> -	at91_st_base =3D of_iomap(np, 0);
> -	if (!at91_st_base)
> -		goto node_err;
> -
> -	/* Get the interrupts property */
> -	ret =3D irq_of_parse_and_map(np, 0);
> -	if (!ret)
> -		goto ioremap_err;
> -	at91rm9200_timer_irq.irq =3D ret;
> -
> -	of_node_put(np);
> -
> -	return 0;
> -
> -ioremap_err:
> -	iounmap(at91_st_base);
> -node_err:
> -	of_node_put(np);
> -err:
> -	return -EINVAL;
> -}
> -
>   /*
>    * ST (system timer) module supports both clockevents and clocksour=
ce.
>    */
>   static void __init atmel_st_timer_init(struct device_node *node)
>   {
> -	/* For device tree enabled device: initialize here */
> -	of_at91rm9200_st_init();
> +	unsigned int val;
> +
> +	regmap_st =3D syscon_node_to_regmap(node);
> +	if (IS_ERR(regmap_st))
> +		panic(pr_fmt("Unable to get regmap\n"));
>
>   	/* Disable all timer interrupts, and clear any pending ones */
> -	at91_st_write(AT91_ST_IDR,
> +	regmap_write(regmap_st, AT91_ST_IDR,
>   		AT91_ST_PITS | AT91_ST_WDOVF | AT91_ST_RTTINC | AT91_ST_ALMS);
> -	at91_st_read(AT91_ST_SR);
> +	regmap_read(regmap_st, AT91_ST_SR, &val);
> +
> +	/* Get the interrupts property */
> +	at91rm9200_timer_irq.irq  =3D irq_of_parse_and_map(node, 0);
> +	if (!at91rm9200_timer_irq.irq)
> +		panic(pr_fmt("Unable to get IRQ from DT\n"));
>
>   	/* Make IRQs happen for the system timer */
>   	setup_irq(at91rm9200_timer_irq.irq, &at91rm9200_timer_irq);
> @@ -239,7 +214,7 @@ static void __init atmel_st_timer_init(struct dev=
ice_node *node)
>   	 * directly for the clocksource and all clockevents, after adjusti=
ng
>   	 * its prescaler from the 1 Hz default.
>   	 */
> -	at91_st_write(AT91_ST_RTMR, 1);
> +	regmap_write(regmap_st, AT91_ST_RTMR, 1);
>
>   	/* Setup timer clockevent, with minimum of two ticks (important!!)=
 */
>   	clkevt.cpumask =3D cpumask_of(0);
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
