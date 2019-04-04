From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Date: Thu, 4 Apr 2019 09:21:53 +0100
Message-ID: <20190404082153.GP6830@dell>
References: <20190403093015.GJ11301@dell>
 <20190403101003.GC3493@localhost.localdomain>
 <20190403112559.GP11301@dell>
 <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
 <20190404025234.GB6830@dell>
 <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
 <20190404065452.GD6830@dell>
 <20190404072449.GE3493@localhost.localdomain>
 <20190404075640.GV22216@piout.net>
 <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "sre@kernel.org" <sre@kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "sboyd@kernel.org" <sboyd@kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>, "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>, "a.zummo@towertech.it" <a.zummo@towertech.it>, "mark.rutland@arm.com" <mark.rutland@arm.com>linux
List-Id: linux-pm@vger.kernel.org

On Thu, 04 Apr 2019, Vaittinen, Matti wrote:

> Hello Alexandre,
> 
> On Thu, 2019-04-04 at 09:56 +0200, Alexandre Belloni wrote:
> > On 04/04/2019 10:24:49+0300, Matti Vaittinen wrote:
> > > On Thu, Apr 04, 2019 at 07:54:52AM +0100, Lee Jones wrote:
> > > > On Thu, 04 Apr 2019, Vaittinen, Matti wrote:
> > > > 
> > > > > Actually, now that I thik of it the right way to do this would
> > > > > have
> > > > > been the function pointer in parent data as was done in
> > > > > original patch
> > > > > set. HW-colleagues tend to re-use HW blocks, and we like to re-
> > > > > use our
> > > > > drivers. If the next PMIC from ROHM uses same RTC block but
> > > > > does not
> > > > > provide watchdog - then it is cleanest solution to fall back to
> > > > > function pointer and leave it to NULL when there is no WDT or
> > > > > when WDT
> > > > > is unused. Another option is to export dummy function - which
> > > > > is not so
> > > > > nice.
> > > > 
> > > > I think the converse is true.
> > > > 
> > > > Pointers to functions outside of a subsystem API context are
> > > > generally
> > > > horrible.  It's much nicer to call a function which can be easily
> > > > stubbed out in a header file based on a Kconfig option.  It's how
> > > > most
> > > > kernel APIs work.
> > > 
> > > I hate to admit but I see your point. This nicely solves any issues
> > > in
> > > syncronizing the startup for driver providing function pointer and
> > > for
> > > driver using it.
> > > 
> > 
> > Wouldn't it be easier to register the watchdog driver as part of the
> > RTC
> > driver?
> > 
> > As I see it, the wdt is just a glorified RTC alarm.
> 
> Do you suggest me to put all the stuff now placed in
> drivers/watchdog/bd70528_wdt.c into rtc driver? It would be doable -
> but I'd rather kept the WDT independent module so that it can be left
> out of config if WDT needs not to be used. And same with RTC. Also, re-
> use of RTC driver in HW which does not include WDT is easier when WDT
> is a separate module. To me it looks much cleaner to have the WDT as
> own module than polluting the RTC driver with config ifdefs.

I haven't looked at the code, but I agree with this in principle.

I'm a firm believer of having functionality in the most appropriate
subsystem.  IMHO, if a device can be neatly split 9/10 it should be.

> But from HW perspective you are correct. The WDT in BD70528 seems to be
> kind of RTC alarm which shuts of the PMIC if triggered.
> 
> Br,
> 	Matti Vaittinen

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
