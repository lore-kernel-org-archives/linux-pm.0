From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
Date: Wed, 11 Feb 2015 16:52:20 -0800
Message-ID: <20150212005220.GG11190@codeaurora.org>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:51512 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbBLAwX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Feb 2015 19:52:23 -0500
Content-Disposition: inline
In-Reply-To: <cover.1423642246.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, rob.herring@linaro.org, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, arnd.bergmann@linaro.org, grant.likely@linaro.org, olof@lixom.net, nm@ti.com, Sudeep.Holla@arm.com, devicetree@vger.kernel.org, santosh.shilimkar@oracle.com, mike.turquette@linaro.org, kesavan.abhilash@gmail.com, catalin.marinas@arm.com, ta.omasab@gmail.com, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com, l.stach@pengutronix.de, broonie@kernel.org, viswanath.puttagunta@linaro.org

On 02/11, Viresh Kumar wrote:
> Now that I have received an verbal Ack from Rob Herring (in a personal
> conversation) about the bindings, I am showing how the code looks like with
> these new bindings.
> 
> Some part is still now done:
> - Interface for adding new detailed OPPs from platform code instead of DT
> - Providing cpufreq helpers for the next OPPs
> - Providing regulator helpers for the target/min/max ranges
> 
> Please provide feedback on how this looks like..
> 

Here's some feedback on how we can't use OPPs (and OPPs in DT) on
qcom platforms.

On these platforms the OPPs are not always frequency voltage
pairs. Sometimes they're a frequency voltage voltage triplet, or
frequency voltage current triplet. I know that the OPP framework
in the kernel doesn't support more than frequency voltage pairs,
but that doesn't mean it can't in the future, and if it needs to
do so the DT bindings shouldn't need a v3 revision.

Furthermore, we have a large number of OPP sets that apply to
different speed bins and silicon characteristics of the SoC. In
our systems we read some efuses (an eeprom of sorts) that tell us
to use a certain set of OPPs because the silicon is so fast or
has these certain characteristics. The bootloader is *not*
reading these fuses and populating OPPs in DT. So right now we
just put all these custom OPPish tables in DT and then pick the
right one based on a node name match constructed from the bits we
read in the efuses. How can we express this in DT with these
bindings?

For example, on msm8974 we have a frequency voltage current
triplet and there are 18 different sets of these triplets, each
with 23 triplets per set. We could encode all of these tables as
a bunch of nodes with compatible = "operating-points-v2" but how
do we pick the right one to assign and populate for the CPU
devices? Do we need some sort of opp-fuse-map table that encodes
the information we want somewhere?

 qcom,opp-fuse-map = <speedX binY versionZ &oppN>,
                     ...

but where do we put it? In the cpus node? Or maybe we can keep
doing the node name matching? That would required dropping the
oppN convention.

Or take msm8916 as another example. On this device the voltage
for a few frequencies comes from the efuses and then we
interpolate the rest of the frequency voltage pairs. The speed
bins are picked from another set of efuses so we can do the
interpolation. Unfortunately we don't encode the frequency in the
fuses, so we rely on a handful of tables being defined somewhere
so that we know speed bin 0 means this set of frequencies and
speed bin 1 means this set of frequencies. How do we encode this
in DT?  Should we have the frequencies as OPPs and leave the
voltage part out, filling it in at runtime based on what we read
out of the efuses? I assume it's desirable to have the frequency
tables in DT but we could also have them in the driver and if we
did that there wouldn't be any shared-opp property to set and
have the cpufreq-dt driver use to figure out clock sharing.

Also sometimes we need to correlate OPPs between each other. For
example on msm8960/apq8064 if the CPU is running at a frequency
and voltage, the L2 needs to be running at another frequency,
voltage, and voltage (triplet). The L2 is in two power domains
but it only has one clock. Can/should this be expressed in DT? It
certainly seems that it's at least easier to add it on as a
feature because OPPs are nodes instead of an array. But we need
to make sure we can support multiple regulators somehow, either
through correlated OPPs and multiple OPPs for a single device or
by being able to say opp-0-microvolt, opp-1-microvolt. I would
guess something similar could happen if there were two clocks and
one regulator although I've never seen such a scenario in
practice.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
