From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Fri, 17 Nov 2017 11:02:56 +0000
Message-ID: <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
        <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
        <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan>
        <20171116234422.GA6141@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33186 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbdKQLC6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Nov 2017 06:02:58 -0500
In-Reply-To: <20171116234422.GA6141@localhost.localdomain> (Eduardo Valentin's
        message of "Thu, 16 Nov 2017 15:44:24 -0800")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Ionela Voinescu <ionela.voinescu@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>

Hi Eduardo,

Eduardo Valentin <edubezval@gmail.com> writes:

> Hello,
>
> On Fri, Nov 17, 2017 at 12:31:41AM +0100, Rafael J. Wysocki wrote:
>> On Thursday, November 16, 2017 4:20:58 PM CET Viresh Kumar wrote:
>> > On 16-11-17, 15:02, Ionela Voinescu wrote:
>> > > When it was added in lsk 3.18 in what was then a thermal driver for Juno
>> > > it was believed to have an effect in thermal mitigation, but that was
>> > > not proven later as to justify posting it upstream, and that is why the
>> > > code never made it in mainline.
>
>
> Really?  Do you have data that can be shared to back up the above
> statement?
>
> Last time I checked, not only in Juno, static power does have
> a non-negligible contribution. Neglecting static power can essentially
> make IPA to undershoot in many cases to eventually overshoot. And that
> is what I recollect from the data that I was presented, even for getting
> this code reviewed. Just do not recollect to have the link to it.

Just to make sure we are on the same page - static power can be a
significant portion of SoC power consumption. It varies widely across
SoCs and from experience depends on things like fabrication process,
ambient temperature, applied voltage/current drain, etc. There are many
SoCs where static power is a significant part of power consumption and
needs to be modelled for good thermal control.

Specifically in the case of Juno - we'd done some thermal and
performance benchmarking when working on IPA. This included implementing
a static power model to understand and test it's impact. If memory
serves me right static power was approximately in the 10-15%
range. Unfortunately, I can't find any datasets to support or disprove
this claim.

My take away from the Juno experiment was that it is not a particularly
thermally constrained system. At the least it took many 10s of seconds
running at max frequency (both clusters and the GPU) with the case fan
turned off for it to see a 10C increase. So the lack of a static power
model wasn't affecting it's thermal control.

But this situation is only true for Juno. More below...

>
>> > > The code added there can be found at:
>> > > https://git.linaro.org/landing-teams/working/arm/kernel-release.git/tree/drivers/thermal/scpi-thermal.c?h=lsk-3.18-armlt#n247
>> > > 
>> > > As for removing this code now, I would not want to make that decision without
>> > > spending more time to check if it impacts other customer codelines.
>> > >
>
> Maybe this is a matter of Linaro/ARM failing to convince SoC vendors to
> really publish static power to mainline Linux instead of really having
> the benefit of modeling it? Even simple models based on temperature
> ranges would be better than only using dynamic power model.

I know of a few SoCs implementing static power model in their kernel
(not mainline). It would be great for that code to hit mainline. But as
with all the out of tree code, I'm not sure have much influence we have
in making that happen.

Again, I don't think we are arguing about the importance of static power
in a power model based thermal control strategy like IPA.

>
>> > > I'll come back with a reply to this in the next couple of days.
>> > 
>> > Sure, we can wait for few days definitely :)
>> 
>> While the above certainly is true, it doesn't matter whether or not any
>> out-of-the-tree code will be affected by removing this from the mainline.
>> 
>> What matters is *only* whether or not anyone is going to add anything
>> depending on it to the mainline any time soon.  If that's not the case,
>> the stuff goes away (and may be added back in the future if need be).
>> 
>> To avoid delaying this indefinitely, let's make a deal as follows.
>> 
>> Unless anyone with some changes targeted at the mainline and depending on the
>> code in question shows up before the end of the merge window currently under
>> way, I will queue up the patches from Viresh for 4.16.  Then, there will be
>> 8 weeks (or more) of time before the 4.16 merge window opens to drop them if
>> any new material depending on the code removed by them materializes in the
>> meantime.
>
>
> Sure, as I mentioned before, if we failed to convince SoC manufacturers
> to provide valid models, makes no sense to keep dead code in the tree,
> you have my support and you can add my:
>
> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>
> I am just not convinced that this is really about the static power
> being negligible for IPA.

Just to reiterate once more, we are in agreement here. :)

I'd like to think this patchset has come out of a plan to develop
functionality on top but I don't know if that is the case.

>
>> 
>> Thanks,
>> Rafael
>> 
