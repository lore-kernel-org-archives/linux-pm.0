From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v4] cpufreq: add imx6q-cpufreq driver
Date: Thu, 31 Jan 2013 14:21:59 +0100
Message-ID: <4348376.DH7xx2jCYa@vostro.rjw.lan>
References: <1359214303-3319-1-git-send-email-shawn.guo@linaro.org> <20130129025652.GB11546@S2101-09.ap.freescale.net> <20130131034148.GB17607@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <20130131034148.GB17607@S2101-09.ap.freescale.net>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Nelson <eric.nelson@boundarydevices.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, January 31, 2013 11:41:50 AM Shawn Guo wrote:
> On Tue, Jan 29, 2013 at 10:56:54AM +0800, Shawn Guo wrote:
> > On Sat, Jan 26, 2013 at 11:31:43PM +0800, Shawn Guo wrote:
> > > Add an imx6q-cpufreq driver for Freescale i.MX6Q SoC to handle the
> > > hardware specific frequency and voltage scaling requirements.
> > > 
> > > The driver supports module build and is instantiated by the platform
> > > device/driver mechanism, so that it will not be instantiated on other
> > > platforms, as IMX is built with multiplatform support.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Rafael,
> > 
> > I think the patch needs to go via cpufreq tree, as it has dependency
> > on Nishanth's "PM / OPP : export symbol consolidation" series.
> 
> Rafael,
> 
> Please hold off this one.  I plan to send v5 to handle regulator
> latency through regulator API, since my colleague is pushing patches
> to take care of voltage ramping time in anatop regulator driver.

OK

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
