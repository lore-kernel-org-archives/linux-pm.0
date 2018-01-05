From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Fri, 5 Jan 2018 14:19:54 -0800
Message-ID: <20180105221954.GC21040@codeaurora.org>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
 <20171227085645.GF8312@vireshk-i7>
 <CAL_JsqJzMfNhHK=6Wt4dzBRS9BVGMZ-f7uk3OnUupudTfwuyUA@mail.gmail.com>
 <20171228043725.GB8652@vireshk-i7>
 <20171229003253.GD7997@codeaurora.org>
 <20171229045854.GE8652@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeAEWT5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jan 2018 17:19:57 -0500
Content-Disposition: inline
In-Reply-To: <20171229045854.GE8652@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12/29, Viresh Kumar wrote:
> On 28-12-17, 16:32, Stephen Boyd wrote:
> > On 12/28, Viresh Kumar wrote:
> 
> > > So what we need now is:
> > > 
> > > - Stephen to start responding and clarify all the doubts he had as being silent
> > >   isn't helping.
> > 
> > What can I reply to specifically?
> 
> I explained in detail how this stuff is going to get used last time you replied.
> Did you get a chance to look at that ? What am I supposed to do when you don't
> reply back to the clarifications I provide ?
> 
> https://marc.info/?l=linux-kernel&m=151202516128980&w=2
> 
> > From what I can tell, the
> > patches have changed to this 'opp-required' thing in the past
> > week and the position of 'generic OPP layer interprets magic
> > values' doesn't look to have changed. Is that the summary? I can
> > look deeply at the patches tomorrow.
> 
> Kind of yeah, because you didn't reply to my explanation on how the magic values
> are going to get used and so they never changed. Again, I don't have problems
> adding new property for performance-state thing or leave it for the platform,
> but I was sticking around the magic values because Kevin was strongly in favor
> of that earlier.

Could you please point to Kevin's comments and also include the
reasoning behind magic values in the commit text for the patch?
It would be very helpful to know why something is done a certain
way. The two to three line commit text in this patch is not
helpful right now.

> 
> > > - Or Rajendra to post patches which can prove that this is usable. The last time
> > >   I had a chat with him, he confirmed that he will post patches after 4.15-rc1
> > >   and he should have posted them by now, but he didn't :(
> > > 
> > 
> > I'd prefer either that, or some tree here that we can look at.
> 
> I am quite sure Rajendra can help here, he had been testing this stuff on *real*
> hardware for ages now with me. This is what he shared with me earlier, based on
> what we have merged in the kernel today..
> 
> https://github.com/rrnayak/linux/commits/genpd-performance-state

Thanks for the pointer. That whole matching devices with
of_match_device() is not looking good.

I don't see how we're going to convince each driver to move to
using the OPP framework to set a performance state + clk
frequency when they're going to want/need to have certain clks
and regulators in hand to do something besides set the frequency
or voltage. Probably we're going to have a hybrid approach, where
some drivers can just set rate and voltage through OPP because
it's fairly well fixed (think CPU or GPU frequency scaling),
while other drivers are going to set frequency and
voltage/performance state based on some calculation of their
required frequency (think of display panels or even the uart baud
rate or i2c bus frequency requirements).

For these other drivers, I don't really want to see the OPP
framework proxy all the clk and regulator calls into the
appropriate framework by wrapping clk_round_rate(),
regulator_set_load(), etc. with opp_*() APIs. This becomes
especially annoying if OPP framework is grabbing and holding
these clk and regulator references in the core, instead of
letting the driver figure that out and tell the OPP framework
what resources it should operate on.

So really, I'm hoping that OPP framework "stays away" and acts as
a data hole, sometimes, where we can look up the performance
state for a particular frequency, but also have it do everything
to set some particular performance state and frequency, etc. if
the user wants that. And also OPP framework hopefully doesn't
force a rigid set of frequencies that a particular clk can be set
to, so that we can calculate frequencies for things like display
panels based on height and width of the panel, or uart baud rate
which is entirely use-case driven, and then ask OPP framework to
tell us what the performance state of a particular domain would
be if we are within some frequency range. Because sometimes we
really can't determine every possible frequency that a clk can be
running at, but we can figure out the maximum frequency that a
clk can be running at for a particular voltage/performance state
to support it.

> 
> > I said this last time, I'm having a really hard time seeing how
> > everything is going to work. The little drip of code, then DT
> > binding, then maybe a small change in dts files, then maybe some
> > code that uses the new APIs, etc. is pretty annoying. From my
> > perspective you've chopped the problem up into pieces that don't
> > stand on their own and then started sending patches for some
> > parts without showing the overall result. It's like we're being
> > taken on a ride in your development workflow, and we don't get to
> > see what's coming around the corner, and the only assumption I
> > can make is that you don't know either.
> > 
> > I'm actually confused how any of the code is even tested or used.
> > It looks like things are getting merged without any users, for
> > what exactly I'm not sure. Please, please, get an end-to-end
> > solution going and actually use the code from day one on a real
> > device that can use it.
> 
> There is just too much code, specially Qcom specific, and I can't fit all that
> in a single series really. Its going to be more annoying for people to see that.
> I used to keep some Qcom test code in the earlier series which got merged and
> was told by Rajendra that the Qcom stuff will get posted after 4.15-rc1, but
> that didn't happen. I can't post final code for that as it touches lots of
> things and its Qcom who needs to upstream it. Now how much test code can I keep
> supplying every time ?

I'm not asking for test code. A git tree pointer in cover letter
is sufficient, with the full and complete solution to the
problem. Then only a few patches out of the tree sent to the list
is fine if you want to chunk it up into sub-topics. That way the
list and reviewers aren't overloaded, but if someone wants to
review the full picture they can do that easily.

> 
> I have already posted the code that will use these bindings few days back:
> 
> https://lkml.kernel.org/r/cover.1513926033.git.viresh.kumar@linaro.org
> 
> The only missing part left now (after bindings and above series) is, again,
> platform specific Qcom code to use it. Below is some dummy code to complete the
> story for you:
> 
> DT changes that shows two devices, mmc and dsp, using the performances states of
> domain:
> 
> 		foo: foo-power-domain@09000000 {
> 			compatible = "foo,genpd";
> 			#power-domain-cells = <0>;
> 			operating-points-v2 = <&domain_opp_table>;
> 		};
> 
> 	        domain_opp_table: domain_opp_table {
> 	        	compatible = "operating-points-v2";
> 
> 	        	domain_opp_1: opp00 {
> 	        		opp-hz = /bits/ 64 <1>; //This is performances state
> 	        	};
> 	        	domain_opp_2: opp01 {
> 	        		opp-hz = /bits/ 64 <2>;
> 	        	};
> 	        	domain_opp_3: opp02 {
> 	        		opp-hz = /bits/ 64 <3>;
> 	        	};
> 	        };
> 
> 		mmc@f7112000 {
> 			compatible = "***";
> 
>                         ***
> 
> 
>                         power-domains = <&foo>;
> 			operating-points-v2 = <&mmc_opp_table>;
> 		};
> 
> 
>         	mmc_opp_table: mmc-opp-table {
>         		compatible = "operating-points-v2";
>         		opp-shared;
>         
>         		opp00 {
>         			opp-hz = /bits/ 64 <208000000>;
>         			required-opp = <&domain_opp_1>;

It can have multiple phandles though, right? Makes me think it
should have been called 'required-opps' instead.

>         		};
>         		opp01 {
>         			opp-hz = /bits/ 64 <432000000>;
>         			required-opp = <&domain_opp_2>;
>         		};
>         		opp02 {
>         			opp-hz = /bits/ 64 <729000000>;
>         			required-opp = <&domain_opp_2>;
>         		};
>         		opp03 {
>         			opp-hz = /bits/ 64 <960000000>;
>         			required-opp = <&domain_opp_3>;
>         		};
>         	};
> 
> 		dsp@f8152000 {
> 			compatible = "***";
> 
>                         ***
> 
> 
>                         power-domains = <&foo>;
>                         required-opp = <&domain_opp_2>;
> 		};
> 
> 
> 
> 
> Platform specific power domain driver:
> 
> static int foo_set_performance(struct generic_pm_domain *genpd,
>                                unsigned int state)
> {
>         /* Set the state here */
> 
> 	return 0;
> }
> 
> static unsigned int foo_get_performance(struct generic_pm_domain *genpd,
> 			                struct dev_pm_opp *opp)
> {
>         /*
>          * Simply return freq value as we passed the state in opp-hz.
>          *
>          * If we choose to use platform-specific bindings instead of opp-hz,
>          * then only this routine requires to change to read the DT and provide
>          * the value from platform specific binding.

If we wanted to change this function to do a platform specific
thing, will we somehow get a way to access the DT node of the opp
passed into this function? I don't see another way to do it.

Also, I don't see how the foo_get_performance function will use
the genpd pointer passed here. Maybe that's never used?

Finally, I would think that a "getter" like this function would
be informing the framework about what the current performance
state is, not translating an OPP into a performance state. So the
whole thing looks like a misnomer, and probably should be called
something like xlate_opp_performance.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
