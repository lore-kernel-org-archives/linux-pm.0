From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
Date: Wed, 13 May 2015 14:25:28 +0530
Message-ID: <20150513085528.GA6994@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35437 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbEMIze (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2015 04:55:34 -0400
Received: by pabtp1 with SMTP id tp1so44163418pab.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2015 01:55:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150512214224.16410.15922@quantum>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mike.turquette@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, arnd.bergmann@linaro.org, nm@ti.com, broonie@kernel.org, sboyd@codeaurora.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, grant.likely@linaro.org, olof@lixom.net, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, viswanath.puttagunta@linaro.org, l.stach@pengutronix.de, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org, ta.omasab@gmail.com, kesavan.abhilash@gmail.com, khilman@linaro.org, santosh.shilimkar@oracle.com

On 12-05-15, 14:42, Michael Turquette wrote:
> Quoting Viresh Kumar (2015-04-30 05:07:59)

> Sorry for chiming in so late in the process. Also, sorry for the long
> email. Lots of repetition below:

You are always welcome..

> Why should this new binding exist?

The answer to this particular query is perhaps simple, i.e. we have
unsolved problems that we wanted to solve in a generic way.

But probably the bigger question is "Should we really put the OPPs
(new or old bindings) in DT".

Lets start by agreeing on what can be kept in DT. AFAIU, anything that
describes the device in a OS independent way. Like:
  - base address
  - irq line + parent
  - clocks, regulators, etc..
  - What about things like register information? That's not what we do
    normally, but why?

    Perhaps because we want to get rid of redundancy as much as
    possible.
    - An implementation of the same device is going to be same across
      all platforms (unless the platform has tweaked it). And so there
      is no fun passing the same register information from multiple DT
      files.
    - And so we better keep things like register information, bit
      field descriptions, etc. in driver itself.
    - For example consider a proprietary controller that has three
      registers A, B and C. Now the bitwise description/behavior of
      all the registers in perfectly same for every implementation but
      the order of these in memory varies per implementation.

      Now we can keep the offsets of these registers in either DT or C
      code. If only few implementations are using it, then we might
      keep it in C code, but if there are 10-20 implementations using
      it in order ABC or BAC or CAB, then it will probably be a good
      option to try keeping these offsets in DT.

So its not really that we just describe connectivity between
devices/nodes in DT, it can be anything related to the device.

What if OPPs were kept in C code instead ?
- In most of the cases (not all of course), we will end up replicating
  code for platforms. But yes we can still do it and this is already
  allowed if you really think your platform is special.
- (Copied from booting-without-of.txt):
  "It also makes it more flexible for board vendors to do minor
  hardware upgrades without significantly impacting the kernel code or
  cluttering it with special cases."

> Is Devicetree really the right place
> to put all of this data? If DT is the right place for some users, some
> of the time ... is it always the right place for all users, all of the
> time?

This is just an attempt to reuse generic code. And platforms are free
to choose DT or non-DT way for keeping this information.

For some users it might be a good place to keep it, while for others
it may not be. For example, if a platform really needs to do some stuff
from its platform code, then it is free to do so.

> > - Expandability of OPPs in future.
> 
> This point above gives me heartburn. It appears that this binding is not
> meant to be "sub-classed" by vendor-specific compatible strings. Please
> let me know if I'm wrong on that.
> 
> The problem with this approach is that every little problem that someone
> has with the binding will have to be solved by changing the generic opp
> binding. I do not see how this can scale given the complexity of data,
> programming sequences and other stuff associated with operating points
> and dvfs transitions.

(I thought about it a bit more after our offline discussion):

If there is something generic enough, which is required by multiple
platforms, then of course we can make additions to the bindings.

But I believe we can 'sub-class' this by vendor-specific compatible
strings as well.

What I told you earlier (in our offline discussion) was that it isn't
allowed to put driver specific strings here to just choose a driver
amongst few available at runtime. For example, choosing between
cpufreq-dt or arm_big_little or any platform driver.

But if a Vendor do need few bindings just for his platforms, then we
can have a compatible sting for that. As the compatible string now
will express device's compatibility.

> I like the existing operating points binding. It is very simple. The
> data can be entirely encoded in DT and then used by the driver for
> simple dvfs use cases.

The new ones are also simple :)

> Maybe we should just stop there and keep it simple? If the data needed
> to express an operating point or dvfs transition is very complex, why
> use DT for that?

Its simple but not complete. And I don't really agree that things are
way too complex here. In some cases, yes they can be.

> > +Optional properties:
> > +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
> > +  switch their DVFS state together, i.e. they share clock/voltage/current lines.
> > +  Missing property means devices have independent clock/voltage/current lines,
> > +  but they share OPP tables.
> 
> What is the behavior of not setting 'shared-opp'? The same table is
> re-used by multiple consumers/devices?

Yes.

> I think a provider/consumer model works better here. E.g. if we have 4
> cpus that scale independently then there would be 4 opp providers, each
> provider corresponding to the unique frequency and voltage domains per
> cpu. If multiple cpu nodes consume the same opp phandle then the sharing
> becomes implicit: those cpus are in the same frequency and power
> domains.
> 
> This is how it works for other resources, such as specifying a clock or
> regulator in DT. If two device nodes reference that same resource then
> it clear that they are using the same physical hardware. Having just a
> table of data in a node that does not clearly map onto hardware (or a
> software abstraction that provides access to that hardware) is not as
> nice IMO.

I partially agree to what you are saying. It is written this way to
reduce redundancy in DT. For example, in a quad-core system with
independently scalable CPUs that have exactly same tables for all
CPUs, we do not want to replicate the same set of 20 OPPs, four times.

But perhaps we can improve it, based on your suggestion. The way I
have written it today:

/ {
	cpus {
		cpu@0 {
			operating-points-v2 = <&cpu_opp>;
		};

		cpu@1 {
			operating-points-v2 = <&cpu_opp>;
		};
	};

	cpu_opp: opp {
		compatible = "operating-points-v2";
		// shared-opp; Not an shared OPP

		entry00 {
			opp-khz = <1000000>;
		};
		entry01 {
			opp-khz = <1100000>;
		};
	};
};

And we can rewrite it as:

/ {
	cpus {
		cpu@0 {
			operating-points-v2 = <&opp0_provider>;
		};

		cpu@1 {
			operating-points-v2 = <&opp1_provider>;
		};
	};

        /* Table is shared between providers */
	opp_table: opp_table {
		entry00 {
			opp-khz = <1000000>;
		};
		entry01 {
			opp-khz = <1100000>;
		};
	};

	opp0_provider: opp0 {
		compatible = "operating-points-v2";
                opp_table = <&opp_table>;
	};

	opp1_provider: opp1 {
		compatible = "operating-points-v2";
                opp_table = <&opp_table>;
	};
};


But this is similar to what I proposed initially and people objected
to it.

> > +- clock-latency-ns: Specifies the maximum possible transition latency (in
> > +  nanoseconds) for switching to this OPP from any other OPP.
> > +- turbo-mode: Marks the OPP to be used only for turbo modes.
> > +- status: Marks the node enabled/disabled.
> 
> s/clock/transition/
> 
> Scaling the regulator can take longer than the clock. Better to reflect
> that this value is capturing the total transition time.

So this is how we are doing it today and I am not sure if we want to
get it from DT now.

	ret = regulator_set_voltage_time(cpu_reg, min_uV, max_uV);
	if (ret > 0)
		transition_latency += ret * 1000;

> It seems wrong to me that the clock and supply data is owned by the cpu
> node, and not the opp descriptor. Everything about the opp transition
> should belong to a provider node. Then the cpu simply needs to consume
> that via a phandle.

https://lists.linaro.org/pipermail/linaro-kernel/2014-December/019505.html

> > +Deprecated Bindings
> > +-------------------
> >  
> >  Properties:
> >  - operating-points: An array of 2-tuples items, and each item consists
> 
> I think we should keep these. They work for the simple case.

Hmm, maybe.

-- 
viresh
