From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Wed, 29 Nov 2017 16:50:29 -0800
Message-ID: <20171130005029.GC19419@codeaurora.org>
References: <cover.1509453284.git.viresh.kumar@linaro.org>
 <23ba51eaa6b52117458165dccc00a95cf8e86e1d.1509453284.git.viresh.kumar@linaro.org>
 <CAL_JsqKr7MsM6iZ_QYO=iCzXNwANEGQGDLFUEwe0Z-p2Z_aMYw@mail.gmail.com>
 <CAKohpokvQD4Z6YY6MRG8c+hnsS=Z52X4XhyTgC5FTgf7VuaNmw@mail.gmail.com>
 <CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ@mail.gmail.com>
 <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org>
 <20171102090033.GZ4240@vireshk-i7>
 <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753596AbdK3Auc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Nov 2017 19:50:32 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Rafael Wysocki <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 11/28, Ulf Hansson wrote:
> On 2 November 2017 at 10:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 02-11-17, 00:15, Stephen Boyd wrote:
> >> Sorry I'm not following. We're going to need to have platform
> >> specific code that understands platform specific bindings that
> >> aren't shoved into the generic OPP bindings.
> >
> > At least I am not targeting any platform specific binding right now.
> > The way I see this to work is:
> >
> > - We will reuse earlier bindings and allow opp-hz and opp-microvolt to
> >   contain special values (this patch).
> > - Platform specific DT entries will put corner numbers in opp-hz (or
> >   opp-microvolt) fields.
> > - Some platform specific driver (in OPP or genpd) will be used to
> >   convert OPP into a performance state (corner) value. Now that can
> >   simply read opp-hz (or opp-microvolt) and return its value.
> 
> Since the "operating-points-v2" phandle(s) belongs in the power-domain
> controller device node, which anyway is being parsed by the genpd SoC
> specific driver, I assume it makes sense to start the initialization
> from there. Unless there is something that prevents that, of course.
> 
> Then whatever library/helper functions we need for parse and create
> the OPP tables, can be provided to the OPP framework and the OPP OF
> library.
> 
> > - OPP core will request for a performance state (code is already
> >   merged for that).
> >
> > And so there is no platform specific binding here. Do you want to do
> > this differently ?
> 
> This makes sense to me!
> 
> Also, the SoC (QCOM) specific genpd driver is free to use the
> terminology "corner values", when it translates opp-hz|microvolt into
> such values.
> 

Sorry it still makes zero sense to me. It seems that we're trying
to make the OPP table parsing generic just for the sake of code
brevity. Is this the goal? From a DT writer perspective it seems
confusing to say that opp-microvolt is sometimes a microvolt and
sometimes not a microvolt. Why can't the SoC specific genpd
driver parse something like "qcom,corner" instead out of the
node?

BTW, I don't believe I have a use-case where I want to express
power domain OPP tables. I have many devices that all have
different frequencies that are all tied into the same power
domain. This binding makes it look like we can only have one
frequency per domain which won't work.

I want to express that a device with a range of frequencies (or
really multiple ranges of frequencies) is inside certain physical
power domains and the frequency of the clks dictates the minimum
voltage requirement of those power domains.

For the most complicated case, imagine something like our eMMC
controller that has two clks (clk1,clk2) that it changes the rate
of independently and those two clks rely on two different
regulators (vreg1, vreg2) that supply voltage domains in the SoC
which the eMMC controller happens to be part of (pd1, pd2). And
the device is also part of another power domain that we use to
turn everything off (pd3).

 +-------+                                 +-------+
 | vreg1 |                                 | vreg2 |
 +---+---+                                 +----+--+
     |                                          |
     |     +------------+-------------+         |
     |     | +-------+  |  +--------+ |         |
     +-----> | clk1  |  |  |  clk2  | <---------+
           | +---+---+  |  +----+---+ |
           |     |      |       |     |
      +----------v--------------v-----------+
      |    |            |             |     |
      |    |            |             |     |
      |    |   pd1      |     pd2     |     |
      |    |            |             |     |
      |    +------------+-------------+     |
      |                                     |
      |  pd3                          eMMC  |
      +-------------------------------------+


>From a DT perspective, I see this as one emmc node:

    pd: power-domain-controller {
        #power-domain-cells = <1>;
    };

    cc: clock-controller {
        #clock-cells = <1>;
    };

    emmc {
        power-domains = <&pd 1> <&pd 2>, <&pd 3>;
        clocks = <&cc 1> <&cc 2>;
    }

And then we really don't want to have to express every single
possible frequency that clk1 and clk2 can be just to express the
voltage/corner constraints. It could be that we have some table
like so:

       clk1 Hz  |  pd1 Corner
    ------------+-----------
         40000  |   0
        960000  |   0
      19200000  |   1
      25000000  |   1
      50000000  |   2
      74000000  |   3

       clk2 Hz  |  pd2 Corner
    ------------+-----------
       19200000 |   0
      150000000 |   1
      340000000 |   2


BUT we also have another device that uses pd1 and has it's own
clk3 with different frequency constraints:

       clk3 Hz   |  pd1 Corner
    -------------+-----------
      250000000  |   0
      360000000  |   1
      730000000  |   2

So when clk3 is at 730000000, we don't care what frequency clk1
is running at, pd1 needs to be at least at corner 2. If it's at
corner 3 because clk1 is at 74000000 then that's fine.

I imagine DT would look like our "fmax tables" that are currently
out of tree. Something like:

	clk1_fmax_table {
		fmax0 {
			reg = /bits/ 64 <960000>;
			qcom,corner = <0>;
		};
		fmax1 {
			reg = /bits/ 64 <25000000>;
			qcom,corner = <1>;
		};
		fmax2 {
			reg = /bits/ 64 <50000000>;
			qcom,corner = <2>;
		};
		fmax3 {
			reg = /bits/ 64 <740000000>;
			qcom,corner = <3>;
		};
	};

Which is similar to OPP table, but we only list the maximum
frequency that requires a particular corner. We're back to the
same problem we have with OPPs of figuring out how to relate a
table to a certain clk and power domain though. At least for
qcom, we could do that with some sort of complicated list
property:

    emmc {
        performance-states = <&fmax_table &cc 1 &pd 1>
    };

or something like that which would parse a table, a clock, and a
number of power domains.

Reminds me, we can have one clk frequency map to multiple power
domains too. We have this case for our CPUs and PLLs where we
have individual power control on two domains for one frequency.
So when the PLL frequency changes, we need to turn on and set the
voltage or corner of two regulators.

So I don't really know how this is all going to work. I'd really
appreciate to see the full picture though. Reviewing this a bit
at a time makes me lose sight of the bigger picture.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
