From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date: Wed, 17 Apr 2019 19:57:43 +0530
Message-ID: <20190417142629.uckz42ufxywcbeez@vireshk-mac-ubuntu>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
 <20190417083116.xgwglxogy2zqdghh@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417083116.xgwglxogy2zqdghh@flea>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Yangtao Li <tiny.windzz@gmail.com>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17-04-19, 10:31, Maxime Ripard wrote:
> On Wed, Apr 17, 2019 at 07:38:30AM +0530, Viresh Kumar wrote:
> > On 16-04-19, 11:52, Yangtao Li wrote:
> > > Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> > >
> > > Yangtao Li (2):
> > >   cpufreq: Add sunxi nvmem based CPU scaling driver
> > >   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> > >
> > >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/cpufreq/Kconfig.arm                   |  12 +
> > >  drivers/cpufreq/Makefile                      |   1 +
> > >  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
> > >  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
> > >  6 files changed, 415 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> > >  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> > >
> > > ---
> > > v4:
> > > -I removed this sunxi_cpufreq_soc_data structure for now.
> >
> > Why this change ?
> 
> It's used on a single SoC for now, so it's impossible to know at this
> point what to put in that structure in the first place.
> 
> Of course, that would need to be brought back if we ever have two SoCs
> to support and that we know which differences there is.

Okay, I was surprised that you dropped that in v4, which was quite late :)

-- 
viresh
