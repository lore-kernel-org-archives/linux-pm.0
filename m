From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 8/9] clocksource: atmel-st: use syscon/regmap
Date: Fri, 6 Mar 2015 09:47:27 +0100
Message-ID: <20150306084727.GH3989@piout.net>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425570594-13124-9-git-send-email-alexandre.belloni@free-electrons.com>
 <54F96896.6040204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54F96896.6040204-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06/03/2015 at 09:43:02 +0100, Daniel Lezcano wrote :
> On 03/05/2015 04:49 PM, Alexandre Belloni wrote:
> >The register range from the system timer is also used by the watchdog driver.
> >Use a regmap to handle concurrent accesses.
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >Acked-by: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >---
> >  drivers/clocksource/timer-atmel-st.c | 99 ++++++++++++++----------------------
> >  1 file changed, 37 insertions(+), 62 deletions(-)
> >
> >diff --git a/drivers/clocksource/timer-atmel-st.c b/drivers/clocksource/timer-atmel-st.c
> >index 7d062ab32674..c4a52e32675e 100644
> >--- a/drivers/clocksource/timer-atmel-st.c
> >+++ b/drivers/clocksource/timer-atmel-st.c
> >@@ -24,19 +24,19 @@
> >  #include <linux/irq.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/export.h>
> >-#include <linux/of.h>
> >-#include <linux/of_address.h>
> >+#include <linux/mfd/syscon.h>
> >+#include <linux/mfd/syscon/atmel-st.h>
> >  #include <linux/of_irq.h>
> >+#include <linux/regmap.h>
> >
> >  #include <asm/mach/time.h>
> >
> >-#include <mach/at91_st.h>
> >-#include <mach/hardware.h>
> >-
> >  static unsigned long last_crtr;
> >  static u32 irqmask;
> >  static struct clock_event_device clkevt;
> >+static struct regmap *regmap_st;
> >
> >+#define AT91_SLOW_CLOCK		32768
> >  #define RM9200_TIMER_LATCH	((AT91_SLOW_CLOCK + HZ/2) / HZ)
> >
> >  /*
> >@@ -46,11 +46,11 @@ static struct clock_event_device clkevt;
> >   */
> >  static inline unsigned long read_CRTR(void)
> >  {
> >-	unsigned long x1, x2;
> >+	unsigned int x1, x2;
> >
> >-	x1 = at91_st_read(AT91_ST_CRTR);
> >+	regmap_read(regmap_st, AT91_ST_CRTR, &x1);
> >  	do {
> >-		x2 = at91_st_read(AT91_ST_CRTR);
> >+		regmap_read(regmap_st, AT91_ST_CRTR, &x2);
> >  		if (x1 == x2)
> >  			break;
> >  		x1 = x2;
> >@@ -63,7 +63,10 @@ static inline unsigned long read_CRTR(void)
> >   */
> >  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
> >  {
> >-	u32	sr = at91_st_read(AT91_ST_SR) & irqmask;
> >+	u32 sr;
> >+
> >+	regmap_read(regmap_st, AT91_ST_SR, &sr);
> >+	sr &= irqmask;
> >
> >  	/*
> >  	 * irqs should be disabled here, but as the irq is shared they are only
> >@@ -96,7 +99,7 @@ static struct irqaction at91rm9200_timer_irq = {
> >  	.name		= "at91_tick",
> >  	.flags		= IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> >  	.handler	= at91rm9200_timer_interrupt,
> >-	.irq		= NR_IRQS_LEGACY + AT91_ID_SYS,
> >+	.irq		= 0,
> 
> Is this change related to regmap ?
> 

It is related to the removing of hardware.h. I can do that in a separate
patch if you prefer.

> By the way, perhaps take the opportunity to replace setup_irq by request_irq
> (and check the return value) ?
> 

I tried and it fails, I didn't investigate yet.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
