From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Tue, 12 Feb 2019 11:37:59 +0200
Message-ID: <20190212093759.GA12247@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
 <20190207162807.GB1920@localhost.localdomain>
 <20190208105743.GI20638@dell>
 <20190208124111.GB3012@localhost.localdomain>
 <20190212091723.GZ20638@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190212091723.GZ20638@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Guenter Roeck <linux@roeck-us.net>, heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com, robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, wim@linux-watchdog.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Thanks Again Lee,

On Tue, Feb 12, 2019 at 09:17:23AM +0000, Lee Jones wrote:
> On Fri, 08 Feb 2019, Matti Vaittinen wrote:
> 
> > > I think an exported function with comments would be better.
> > So do you mean you would prefer exported function over the pointer from
> Yes please.  Call-back pointers for non-subsystem level actions are a
> bit messy IMHO.

That's fine. I'll go with exported function then =)

> > case it just hides the meaning of values we are passing as arguments.
> > With raw assignment we at least have some idea what the 0x40 or 0x20 are
> > referring to =)
> 
> Well I do agree with your last comment.
> 
> Maybe doing the following would help with the ugliness (i.e. the shear
> number of chars):
> 
>  unsigned int type_reg_offset_inc = 0;
>  for (i = BD70528_INT_GPIO0; i <=  BD70528_INT_GPIO3; i++) {
>         <blar> *t = irqs[i].type;
>         t->type_reg_offset     = type_reg_offset_inc;
>  	t->type_rising_val     = 0x20;
>  	t->type_falling_val    = 0x10;
>  	t->type_level_high_val = 0x40;
>  	t->type_level_low_val  = 0x50;
>  	t->types_supported =
>  		(IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
>  	type_reg_offset_inc += 2;
>  }

I'll go with this for next version.

> > > > > > +	/* wdt_set must be called rtc_timer_lock held */
> > > > > 
> > > > > This doesn't make sense.
> > > > 
> > > > Umm.. The comment does not make sense? Maybe I can explain it further.
> > > 
> > > "wdt_set must be called when the rtc_timer_lock is held"
> > 
> > Yes. I wanted to say that who-ever is calling the wdt_set function
> > below, should have locked the rtc_timer_lock mutex (last in this
> > struct). The function does not do locking inside because we want the RTC
> > to be able to perform:
> > 
> > lock
> > disable wdt (store original state)
> > set RTC
> > return wdt original state
> > unlock
> > 
> > Locking is needed so that we can exclude the watchdog enabling or
> > disabling the WDT timer between moments when RTC is getting the original
> > WDT state and re-turning back the old state. Without the lock we have a
> > risk that WDT-driver enables or disables the timer when RTC is being
> > set, and RTC overwrites the watchdog driver changes when writing back
> > the old state. I hope this makes sense now... Any suggestions how to
> > explain this nicely in english?
> 
> I think I did already:
> 
>  "wdt_set must be called when the rtc_timer_lock is held"
> 
> Actually, this is a little ambiguous.  A better sentence could read:
> 
>  "rtc_timer_lock must be taken before calling wdt_set()"

Sure. I'll ruthlessy plagiarize that sentence. (And as I am not at all
sure if "ruthlessy plagiarize" actually means what I think it does -
I tried to say that I'll take your suggestion and use it :] )

Once again, thanks for the help =)

Br,
	Matti

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
