From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RFC PATCH 0/4] ARM: remove big.LITTLE switcher support
Date: Tue, 28 Jun 2016 10:18:17 +0200
Message-ID: <8154264.t0CjdgHDuf@amdc1976>
References: <1467026770-5699-1-git-send-email-b.zolnierkie@samsung.com>
 <alpine.LFD.2.20.1606271540000.2550@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <alpine.LFD.2.20.1606271540000.2550@knanqh.ubzr>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Dave Martin <dave.martin@linaro.org>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

On Monday, June 27, 2016 03:49:44 PM Nicolas Pitre wrote:
> On Mon, 27 Jun 2016, Bartlomiej Zolnierkiewicz wrote:
> 
> > Hi,
> > 
> > It seems that in mainline kernel big.LITTLE switcher support
> > may be usable only on ARM Versatile Express TC2 platform
> > (but even this platform doesn't enable it in its defconfig).
> 
> It is also used on some Samsung targets.

Could you please explain this more?  AFAIK mainline never
had working IKS solution (big.LITTLE switcher support +
arm_big_little CPUfreq driver support) on any Samsung SoC.

> > The following patchset removes big.LITTLE switcher support
> > (from both ARM core and arm_big_little CPUfreq driver) in
> > favor of using HMP.
> > 
> > Since HMP support at scheduler level is not yet merged this
> > patchset is probably premature and thus is marked as RFC.
> 
> It is premature indeed.
> 
> And before this is removed, comparison with power/performance benchmark 
> numbers will have to be provided as well to justify this removal.  At 
> the moment there is nothing else in mainline that can achieve what this 
> code does.

I agree given that this code has real users and according
to my research on mainline kernel it seems that the IKS
functionality (bL switcher core code together with
arm_bit_little CPUfreq driver support) is usable only on
TC2 and even this platform doesn't enable it by default.

IOW I would really like to get the confirmation that there
are platforms that are making use of IKS functionality
currently with the mainline  kernel.  Otherwise we should
either consider its removal or enable it on platforms that
are supposed to use it.

> We all agree that the scheduler based solution is the best way to do it. 
> But this has been a couple years already and this is still work in 
> progress.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
