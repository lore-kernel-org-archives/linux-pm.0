From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Mon, 8 Jan 2018 09:46:43 +0530
Message-ID: <20180108041643.GC4003@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
 <20171229045854.GE8652@vireshk-i7>
 <20180105221954.GC21040@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33947 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754987AbeAHEQq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jan 2018 23:16:46 -0500
Received: by mail-pf0-f195.google.com with SMTP id e76so354957pfk.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Jan 2018 20:16:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180105221954.GC21040@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05-01-18, 14:19, Stephen Boyd wrote:
> On 12/29, Viresh Kumar wrote:

> Could you please point to Kevin's comments and also include the

https://lkml.kernel.org/r/m2r30i4w35.fsf@baylibre.com

> reasoning behind magic values in the commit text for the patch?
> It would be very helpful to know why something is done a certain
> way. The two to three line commit text in this patch is not
> helpful right now.

Sure.

> > https://github.com/rrnayak/linux/commits/genpd-performance-state
> 
> Thanks for the pointer. That whole matching devices with
> of_match_device() is not looking good.

Yeah, I agree, but that was done because we didn't had these bindings
then. Once these bindings are in place, we wouldn't require the
of_match_device() thingy.

> I don't see how we're going to convince each driver to move to
> using the OPP framework to set a performance state + clk
> frequency when they're going to want/need to have certain clks
> and regulators in hand to do something besides set the frequency
> or voltage. Probably we're going to have a hybrid approach, where
> some drivers can just set rate and voltage through OPP because
> it's fairly well fixed (think CPU or GPU frequency scaling),
> while other drivers are going to set frequency and
> voltage/performance state based on some calculation of their
> required frequency (think of display panels or even the uart baud
> rate or i2c bus frequency requirements).

The OPP framework doesn't (and shouldn't) force drivers to move to the
dev_pm_opp_set_rate() API. That is optional and is provided to make
user code simpler.

So, if a driver wants to handle everything by itself, it will just use
the OPP core as "provider" for the data it needs and do everything by
itself.

> For these other drivers, I don't really want to see the OPP
> framework proxy all the clk and regulator calls into the
> appropriate framework by wrapping clk_round_rate(),
> regulator_set_load(), etc. with opp_*() APIs. This becomes
> especially annoying if OPP framework is grabbing and holding
> these clk and regulator references in the core, instead of
> letting the driver figure that out and tell the OPP framework
> what resources it should operate on.

Sure.

> So really, I'm hoping that OPP framework "stays away" and acts as
> a data hole, sometimes, where we can look up the performance
> state for a particular frequency, but also have it do everything
> to set some particular performance state and frequency, etc. if
> the user wants that.

That's how I see it as well.

> And also OPP framework hopefully doesn't
> force a rigid set of frequencies that a particular clk can be set
> to, so that we can calculate frequencies for things like display
> panels based on height and width of the panel, or uart baud rate
> which is entirely use-case driven, and then ask OPP framework to
> tell us what the performance state of a particular domain would
> be if we are within some frequency range. Because sometimes we
> really can't determine every possible frequency that a clk can be
> running at, but we can figure out the maximum frequency that a
> clk can be running at for a particular voltage/performance state
> to support it.

That makes sense to me. We can do that once we have someone who wants
to use OPP core for such devices.

> I'm not asking for test code. A git tree pointer in cover letter
> is sufficient, with the full and complete solution to the
> problem. Then only a few patches out of the tree sent to the list
> is fine if you want to chunk it up into sub-topics. That way the
> list and reviewers aren't overloaded, but if someone wants to
> review the full picture they can do that easily.

That's fine.

> >         	mmc_opp_table: mmc-opp-table {
> >         		compatible = "operating-points-v2";
> >         		opp-shared;
> >         
> >         		opp00 {
> >         			opp-hz = /bits/ 64 <208000000>;
> >         			required-opp = <&domain_opp_1>;
> 
> It can have multiple phandles though, right? Makes me think it
> should have been called 'required-opps' instead.

Okay.

> > static unsigned int foo_get_performance(struct generic_pm_domain *genpd,
> > 			                struct dev_pm_opp *opp)
> > {
> >         /*
> >          * Simply return freq value as we passed the state in opp-hz.
> >          *
> >          * If we choose to use platform-specific bindings instead of opp-hz,
> >          * then only this routine requires to change to read the DT and provide
> >          * the value from platform specific binding.
> 
> If we wanted to change this function to do a platform specific
> thing, will we somehow get a way to access the DT node of the opp
> passed into this function?

Yes, we can do that. The OPP core already stores pointer to the node
in the OPP structure, we will just need another API to expose that.

> Also, I don't see how the foo_get_performance function will use
> the genpd pointer passed here. Maybe that's never used?

It depends actually and I think its better to pass it anyway. What if
a single driver is handling multiple genpds and wants to do things
differently for them? It should know which genpd it is called for,
looks like  basic requirement to me.

> Finally, I would think that a "getter" like this function would
> be informing the framework about what the current performance
> state is, not translating an OPP into a performance state. So the
> whole thing looks like a misnomer, and probably should be called
> something like xlate_opp_performance.

Sure, I can name it anything.

So the question still stands, are we all okay for using magic values
or we want platform specific properties ?

-- 
viresh
