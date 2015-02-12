From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Date: Thu, 12 Feb 2015 00:20:04 -0800
Message-ID: <20150212082004.GJ11190@codeaurora.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <20150212005220.GG11190@codeaurora.org>
 <CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48866 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbbBLIUH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 03:20:07 -0500
Content-Disposition: inline
In-Reply-To: <CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Rob Herring <rob.herring@linaro.org>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viswanath Puttagunta <viswanath.puttagunta@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, santosh shilimkar <santosh.shilimkar@oracle.com>, Rafael Wysocki <rjw@rjwysocki.net>, "olof@lixom.net" <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Mike Turquette <mike.turquette@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/12, Viresh Kumar wrote:
> On 12 February 2015 at 08:52, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > Here's some feedback on how we can't use OPPs (and OPPs in DT) on
> > qcom platforms.
> >
> > On these platforms the OPPs are not always frequency voltage
> > pairs. Sometimes they're a frequency voltage voltage triplet, or
> 
> So, making opp-microvolt an array of <target/min/max>, values should fix this?
> Do we also need a opp-microvolt-names array as well? or can we reused
> similar ones from the CPU node where regulator are defined.
> 

I don't follow how target/min/max does anything for two different
voltages. I suppose something like opp-microvolt-names would work
though but I don't know how software would correlate that to the
regulator it uses because that information is elsewhere in the
device's node. Why not put the information about which clock and
regulator is used into the opp node?

> 
> > Furthermore, we have a large number of OPP sets that apply to
> > different speed bins and silicon characteristics of the SoC. In
> > our systems we read some efuses (an eeprom of sorts) that tell us
> > to use a certain set of OPPs because the silicon is so fast or
> > has these certain characteristics. The bootloader is *not*
> > reading these fuses and populating OPPs in DT. So right now we
> > just put all these custom OPPish tables in DT and then pick the
> > right one based on a node name match constructed from the bits we
> > read in the efuses. How can we express this in DT with these
> > bindings?
> 
> What about keeping things as is in DT and disabling the OPPs which
> you don't support at boot? And only keep enabled the set of OPPs
> that you want to use based on these efuses ?

Let's look at an example:


	speed0 bin0 version0 = /* Hz      uV  uA */
                        <  300000000  815000  73 >,
                        <  345600000  825000  85 >,
                        <  422400000  835000 104 >,
			....

	speed0 bin1 version0 =
                        <  300000000  800000  73 >,
                        <  345600000  810000  85 >,
                        <  422400000  820000 104 >,
			...

Each set of fuses has the exact same frequency (as long as the
speed is the same) but the bin changes the voltage and sometimes
current. Maybe we could make this into:

 speed0_bin0_version0_opp: opp0 {
	 compatible = "qcom,speed0-bin0-version0-opp", "operating-points-v2";
	 entry0 {
		 opp-khz = <300000>;
		 opp-microvolt = <815000>;
		 opp-milliamp = <73>;
	 };
	 
	 entry1 {
		 opp-khz = <345600>;
		 opp-microvolt = <825000>;
		 opp-milliamp = <85>;
	 };
	 ...
 };
 
 speed0_bin1_version0_opp: opp0 {
	 compatible = "qcom,speed0-bin1-version0-opp", "operating-points-v2";
	 entry0 {
		 opp-khz = <300000>;
		 opp-microvolt = <800000>;
		 opp-milliamp = <73>;
	 };
	 
	 entry1 {
		 opp-khz = <345600>;
		 opp-microvolt = <810000>;
		 opp-milliamp = <85>;
	 };
	 ...
 };

And then we can construct a compatible string to search the cpus
node for. I wonder if we shouldn't put all this into an opps node
under the cpus node?

 cpus {
  opps { 
   opp0 {
     entry0 { }
     ...
   }
   opp1 {
    entry0 { }
     ...
   }
  }
 }


> 
> > Or take msm8916 as another example. On this device the voltage
> > for a few frequencies comes from the efuses and then we
> > interpolate the rest of the frequency voltage pairs. The speed
> > bins are picked from another set of efuses so we can do the
> > interpolation. Unfortunately we don't encode the frequency in the
> > fuses, so we rely on a handful of tables being defined somewhere
> > so that we know speed bin 0 means this set of frequencies and
> > speed bin 1 means this set of frequencies. How do we encode this
> > in DT?  Should we have the frequencies as OPPs and leave the
> > voltage part out, filling it in at runtime based on what we read
> 
> Maybe yes.
> 
> > out of the efuses? I assume it's desirable to have the frequency
> > tables in DT but we could also have them in the driver and if we
> > did that there wouldn't be any shared-opp property to set and
> > have the cpufreq-dt driver use to figure out clock sharing.
> 
> Probably better keep them in DT. But for platforms with dynamic OPPs
> only, we will surely provide some API to make OPPs shared at runtime
> too..

That would be good. Hopefully we can do that so that the
cpufreq-dt driver doesn't have to open code DT probing to figure
out that the OPPs are shared between CPUs.

> 
> > Also sometimes we need to correlate OPPs between each other. For
> > example on msm8960/apq8064 if the CPU is running at a frequency
> > and voltage, the L2 needs to be running at another frequency,
> > voltage, and voltage (triplet). The L2 is in two power domains
> > but it only has one clock. Can/should this be expressed in DT? It
> 
> Not sure.
> 
> > certainly seems that it's at least easier to add it on as a
> > feature because OPPs are nodes instead of an array. But we need
> 
> It wouldn't be a great idea to make these nodes too large just to support
> some corner cases, and we better try to find the best way out. But if
> we need it this way, we need it this way :)
> 
> > to make sure we can support multiple regulators somehow, either
> > through correlated OPPs and multiple OPPs for a single device or
> > by being able to say opp-0-microvolt, opp-1-microvolt. I would
> 
> an array would be better.

Sure.

> 
> > guess something similar could happen if there were two clocks and
> > one regulator although I've never seen such a scenario in
> > practice.
> 
> Isn't this common? A single regulator voltage supporting multiple clock
> rates? Or did I misunderstood it :)
> 
> We can have separate OPP nodes in this case.
> 

I was thinking the same device has two clocks that share the same
voltage and these two clocks can run at different rates. If two
opp nodes under the same device works then it sounds like it will
be ok. We probably still need some way to correlate the two so
that if one clock is at some freq, the other clock should be at
the corresponding freq in the OPP, assuming that the OPP is
really two clocks and a voltage (i.e. the clocks need to scale
together).

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
