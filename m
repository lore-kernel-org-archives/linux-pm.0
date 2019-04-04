From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Thu, 4 Apr 2019 09:06:23 +0100
Message-ID: <20190404080623.GJ6830@dell>
References: <20190403073152.GM4187@dell>
 <20190403084732.GA3493@localhost.localdomain>
 <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
 <20190404072449.GE3493@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190404072449.GE3493@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "broonie@kernel.org" <broonie@kernel.org>, "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>l
List-Id: linux-pm@vger.kernel.org

> > > ROHM. Also, I am not terribly excited about the option of changing this
> > > back to function-pointer as I already removed the pointer from parent
> > > data and this changed parent data is already adapted to all sub drivers
> > > - so this is all just babbling. Maybe it is just my huge ego shouting
> > > there - 'I was right, I must have the final say'.
> > 
> > No, a call-back function would be a back-step.
> 
> You are probably right.
> 
> > Ego or no ego, you're wrong. =:-D
> 
> I'd rephrase that as "It's not that I am wrong, but you are right." =)

Works for me.

> > > As a side note, I already did submit v12 with other styling fixes but
> > > which left the WDT function in MFD. If you still see the WDT functions
> > > should be exported from WDT - then please ignore the v12. I'll do v13
> > > at the afternoon (my time, which is only a bit after noon your time I
> > > guess) which will export these functions from WDT. (Well, I had to try
> > > once more :D)
> > 
> > Please keep the WDT code in the WDT driver.  Create a little stub for
> > the cases where the WDT driver is not enabled - job done.
> 
> Yes Sir.

=;-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
