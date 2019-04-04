From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Thu, 4 Apr 2019 10:24:49 +0300
Message-ID: <20190404072449.GE3493@localhost.localdomain>
References: <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
 <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404065452.GD6830@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "broonie@kernel.org" <broonie@kernel.org>, "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>l
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 04, 2019 at 07:54:52AM +0100, Lee Jones wrote:
> On Thu, 04 Apr 2019, Vaittinen, Matti wrote:
> 
> > Actually, now that I thik of it the right way to do this would have
> > been the function pointer in parent data as was done in original patch
> > set. HW-colleagues tend to re-use HW blocks, and we like to re-use our
> > drivers. If the next PMIC from ROHM uses same RTC block but does not
> > provide watchdog - then it is cleanest solution to fall back to
> > function pointer and leave it to NULL when there is no WDT or when WDT
> > is unused. Another option is to export dummy function - which is not so
> > nice.
> 
> I think the converse is true.
> 
> Pointers to functions outside of a subsystem API context are generally
> horrible.  It's much nicer to call a function which can be easily
> stubbed out in a header file based on a Kconfig option.  It's how most
> kernel APIs work.

I hate to admit but I see your point. This nicely solves any issues in
syncronizing the startup for driver providing function pointer and for
driver using it.

> > Additional benefit from function pointer would have been that the
> > function pointer can be only used by drivers which have acces to it.
> > This exported function is globally visible. The WDT disable/enable is
> > very specific procedure and it actually would be nicer design to not
> > have it visible globally. It is not intended to be used by anything
> > else besides the WDT and RTC here.
> 
> Why would anything else try to use it?
> 
> There are 1000's of exported functions in the kernel.  If it's
> properly namespaced a consumer would have to purposely call it, which
> if they really wanted to, they could do anyway.  I don't really see
> your point.

I could still argue on this. It _is_ less obvous that an exported function
is not meant to be publicly used than it is for function pointers. But
as you say, this is not a strong enough point to see the trouble in
synchronizing the WDT/RTC startup.

> > But I can't say there will be PMIC with same RTC and no WDT coming from
> > ROHM. Also, I am not terribly excited about the option of changing this
> > back to function-pointer as I already removed the pointer from parent
> > data and this changed parent data is already adapted to all sub drivers
> > - so this is all just babbling. Maybe it is just my huge ego shouting
> > there - 'I was right, I must have the final say'.
> 
> No, a call-back function would be a back-step.

You are probably right.

> Ego or no ego, you're wrong. =:-D

I'd rephrase that as "It's not that I am wrong, but you are right." =)

> > As a side note, I already did submit v12 with other styling fixes but
> > which left the WDT function in MFD. If you still see the WDT functions
> > should be exported from WDT - then please ignore the v12. I'll do v13
> > at the afternoon (my time, which is only a bit after noon your time I
> > guess) which will export these functions from WDT. (Well, I had to try
> > once more :D)
> 
> Please keep the WDT code in the WDT driver.  Create a little stub for
> the cases where the WDT driver is not enabled - job done.

Yes Sir.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
