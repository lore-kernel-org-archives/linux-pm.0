From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 4/9] power: reset: Add AT91RM9200 reset driver
Date: Thu, 5 Mar 2015 16:09:56 +0100
Message-ID: <20150305150956.GT3989@piout.net>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1425478897-27322-5-git-send-email-alexandre.belloni@free-electrons.com>
 <20150304171758.GA8717@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150304171758.GA8717@earth>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/03/2015 at 18:17:58 +0100, Sebastian Reichel wrote :
> Hi,
> 
> On Wed, Mar 04, 2015 at 03:21:32PM +0100, Alexandre Belloni wrote:
> > AT91RM9200 uses the watchdog from the system timer to reset.
> > [...]
> > +	regmap_write(regmap_st, AT91_ST_WDMR,
> > +		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
> > +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
> > +
> > +	mdelay(2000);
> 
> At pity that you have to write into two registers, otherwise you
> could have used the syscon-reboot driver.
> 

Exactly what I was thinking :)

> > [...]
> > +module_platform_driver(at91rm9200_reset_driver);
> 
> Apart from missing module metadata (MODULE_AUTHOR(),
> MODULE_LICENSE(), ...) the driver looks fine to me.
> 

I'll add those.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
