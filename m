From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
Date: Tue, 28 Jun 2016 12:13:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1606281157190.24439@knanqh.ubzr>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com> <alpine.LFD.2.20.1606271540000.2550@knanqh.ubzr> <8154264.t0CjdgHDuf@amdc1976>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8154264.t0CjdgHDuf@amdc1976>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Jun 2016, Bartlomiej Zolnierkiewicz wrote:

> 
> Hi,
> 
> On Monday, June 27, 2016 03:49:44 PM Nicolas Pitre wrote:
> > On Mon, 27 Jun 2016, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > Hi,
> > > 
> > > It seems that in mainline kernel big.LITTLE switcher support
> > > may be usable only on ARM Versatile Express TC2 platform
> > > (but even this platform doesn't enable it in its defconfig).
> > 
> > It is also used on some Samsung targets.
> 
> Could you please explain this more?  AFAIK mainline never
> had working IKS solution (big.LITTLE switcher support +
> arm_big_little CPUfreq driver support) on any Samsung SoC.

You might be right about mainline.  Out-of-tree support for some Samsung 
targets certainly exists though.

> > > The following patchset removes big.LITTLE switcher support
> > > (from both ARM core and arm_big_little CPUfreq driver) in
> > > favor of using HMP.
> > > 
> > > Since HMP support at scheduler level is not yet merged this
> > > patchset is probably premature and thus is marked as RFC.
> > 
> > It is premature indeed.
> > 
> > And before this is removed, comparison with power/performance benchmark 
> > numbers will have to be provided as well to justify this removal.  At 
> > the moment there is nothing else in mainline that can achieve what this 
> > code does.
> 
> I agree given that this code has real users and according
> to my research on mainline kernel it seems that the IKS
> functionality (bL switcher core code together with
> arm_bit_little CPUfreq driver support) is usable only on
> TC2 and even this platform doesn't enable it by default.

It is not enabled by default because it used to be experimental. And 
given that it pairs two A15's with two A7's leaving the third A7 
completely unused, some people didn't consider a good default for 
showing the complete platform capacity.  

But if you want predictable scheduler results right now with mainline on 
a b.L system then IKS is the only available solution. It also provides a 
good reference to do performance/power comparison against any solution 
meant to replace it. Enabling it by default on TC2 might not be such a 
bad idea at this point.  I certainly have it enabled in my local config.


Nicolas
