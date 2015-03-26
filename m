From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: mstp: Never disable INTC-SYS
Date: Thu, 26 Mar 2015 10:39:52 +0000
Message-ID: <5513E1F8.9020104@arm.com>
References: <1426706164-28309-1-git-send-email-geert+renesas@glider.be>	<1426706164-28309-2-git-send-email-geert+renesas@glider.be>	<20150324232508.7930.89483@quantum>	<CAMuHMdVRhaZY_y2=1+9sZ-kteiguYGeS62Ka-V1WYnNCq_rgQA@mail.gmail.com>	<55127E2A.1040300@arm.com> <CAMuHMdWY7orzt0ONTzmyG8nSagCM1r1HK=zQHzfttfr6cK7eqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWY7orzt0ONTzmyG8nSagCM1r1HK=zQHzfttfr6cK7eqA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On 25/03/15 21:19, Geert Uytterhoeven wrote:

[...]

>> adverse to it. My only gripe is with the undocumented clock property in
>> the binding, and that leads to two questions:
>> This doesn't touch the GIC code at all, so I don't feel completely
> 
> The reason no GIC code is touched (for now), is that it's non-trivial to
> fix the GIC driver to handle this.

Indeed.  The interrupt controller is basically the first device to be
activated in the life of the system, and I can see a nasty chicken and
egg problem creeping up if you're trying to do clock management in a
generic way at that level.

>> adverse to it. My only gripe is with the undocumented clock property in
>> the binding, and that leads to two questions:
>> - the GIC architecture doesn't mention a clock at all, so that's a
>> Renesas special. Do we want to have a vendor-specific property for this?
>> Or does it belong elsewhere?
> 
> Apart from being implemented using synchronous logic and thus using a
> clock signal internally, the GIC and its driver don't care about this clock.
> 
> When an existing IP module that doesn't care about clocks becomes reused
> on a new SoC, and it now ends up being part of a "PM Domain" (e.g. a Power
> Domain or Clock Domain, or both), this "PM Domain" is a feature of the
> platform, not of the IP module itself (cfr. "(Existing) Device Driver" in [1];
> GIC falls in the same category as the Thermal Module example).
> Hence I don't think it's necessary to mention this in the ARM GIC binding.
> 
>> - alternatively, do we want the core GIC code to deal with this? In
>> which case, how do we express the policy?
> 
> The proper way to handle this automatically is to add Runtime PM support
> to the driver. However, this requires using a platform device.
> 
> I would like to add the clock and GIC dependency on the clock in the DTS now,
> for reasons of DTS stability. But that means I need a temporary workaround
> to avoid the clock from being disabled, until the GIC driver handles this.
> 
> I don't expect a fix for the GIC code to just show up magically. I just wanted
> you to be aware of the problem. GIC is not the only problematic module here,
> there are others, cfr. the last slide of [2].

As long as there is an agreement from the DT people on the presence of
that extra property in the GIC node, I'm happy with that. I'd like it to
be documented though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
