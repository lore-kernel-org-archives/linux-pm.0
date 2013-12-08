From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v4 2/4] mvebu: Dove: Instantiate cpufreq driver.
Date: Sat, 7 Dec 2013 19:50:49 -0500
Message-ID: <20131208005049.GE11251@titan.lakedaemon.net>
References: <1386166641-7567-1-git-send-email-andrew@lunn.ch>
 <1386166641-7567-3-git-send-email-andrew@lunn.ch>
 <20131204143628.GB29200@e106331-lin.cambridge.arm.com>
 <20131204150228.GB8062@lunn.ch>
 <20131205175434.GQ29200@e106331-lin.cambridge.arm.com>
 <20131205182939.GB19067@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23210 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab3LHAvF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 7 Dec 2013 19:51:05 -0500
Content-Disposition: inline
In-Reply-To: <20131205182939.GB19067@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Thu, Dec 05, 2013 at 07:29:39PM +0100, Andrew Lunn wrote:
> > I'm not arguing for describing a pseudo-device. The power management
> > unit is a real device. If we used that to register a cpufreq driver, it
> > doesn't mean that we've registered a pseudo-device, but rather that we
> > made a decision to register the cpufreq portions based on the necessary
> > real devices being present.
> 
> Hi Mark
> 
> I need a more concrete explanation to understand what you mean.
> 
> Are you suggesting that i add a drivers/pmu/dove.c, which gets
> instantiated by DT? This driver would then instantiate the cpufreq
> driver? If so, it should also instantiate the gated clocks in
> drivers/clk/mvebu/dove.c, since they are also part of the PMU,
> according to the data sheet.  The RTC and the thermal management unit
> are also part of the PMU. Should these drivers also be instantiated by
> the PMU somehow?

No, I don't think that is where Mark is heading.  Separate the DT from
Linux.  Describe the PMU in DT.  It's then up to Linux to figure out how
to use (or not) that device.

I don't know if we've encountered this scenario yet, but is it possible
for Linux to have two drivers (cpufreq and cpuidle) answer to the same
compatible string?  Not that I'm advocating for that solution here...

The only problem I see with that is locking on any resources both
drivers use.  I think we had a similar issue with watchdog/rtc.

> > Perhaps this was the problem with the proposed kirkwood binding?
> 
> Kirkwood does not have a PMU, at least not according to the data
> sheet. There are registers to control cpuidle, cpufreq, gating some
> clocks, the exact same RTC and a somewhat similar thermal
> sensor. However the data sheet makes no reference as to calling the
> collection the "PMU".

If it quacks like a duck... :)

thx,

Jason.
