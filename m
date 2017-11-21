From: Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue, 21 Nov 2017 11:30:44 +0000
Message-ID: <35d3751d-f28d-38c2-02b2-c9980f11c52e@arm.com>
References: <cover.1510735482.git.viresh.kumar@linaro.org>
 <65fef2a1-d23f-3de2-bd91-021296c3e2f7@arm.com>
 <20171116152058.GR3257@vireshk-i7> <2810372.fJ2vMN0cWO@aspire.rjw.lan>
 <20171116234422.GA6141@localhost.localdomain>
 <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38892 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbdKULa4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Nov 2017 06:30:56 -0500
In-Reply-To: <878tf5tbfj.fsf@e105922-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, lukasz.luba@arm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Javi Merino <javi.merino@arm.com>

Hi guys,

On 17/11/17 11:02, Punit Agrawal wrote:
> Hi Eduardo,
> 
> Eduardo Valentin <edubezval@gmail.com> writes:
> 
>> Hello,
>>
>> On Fri, Nov 17, 2017 at 12:31:41AM +0100, Rafael J. Wysocki wrote:
>>> On Thursday, November 16, 2017 4:20:58 PM CET Viresh Kumar wrote:
>>>> On 16-11-17, 15:02, Ionela Voinescu wrote:
>>>>> When it was added in lsk 3.18 in what was then a thermal driver for Juno
>>>>> it was believed to have an effect in thermal mitigation, but that was
>>>>> not proven later as to justify posting it upstream, and that is why the
>>>>> code never made it in mainline.
>>
>>
>> Really?  Do you have data that can be shared to back up the above
>> statement?
>>
>> Last time I checked, not only in Juno, static power does have
>> a non-negligible contribution. Neglecting static power can essentially
>> make IPA to undershoot in many cases to eventually overshoot. And that
>> is what I recollect from the data that I was presented, even for getting
>> this code reviewed. Just do not recollect to have the link to it.
> 
> Just to make sure we are on the same page - static power can be a
> significant portion of SoC power consumption. It varies widely across
> SoCs and from experience depends on things like fabrication process,
> ambient temperature, applied voltage/current drain, etc. There are many
> SoCs where static power is a significant part of power consumption and
> needs to be modelled for good thermal control.
> 
> Specifically in the case of Juno - we'd done some thermal and
> performance benchmarking when working on IPA. This included implementing
> a static power model to understand and test it's impact. If memory
> serves me right static power was approximately in the 10-15%
> range. Unfortunately, I can't find any datasets to support or disprove
> this claim.
> 
> My take away from the Juno experiment was that it is not a particularly
> thermally constrained system. At the least it took many 10s of seconds
> running at max frequency (both clusters and the GPU) with the case fan
> turned off for it to see a 10C increase. So the lack of a static power
> model wasn't affecting it's thermal control.
> 
> But this situation is only true for Juno. More below...
> 

Sorry, I did not mean to say that static power is irrelevant. I only
specified that for Juno, the values used in the lsk3.18 kernel did not
have a significant effect in thermal mitigation, as Punit detailed here
and below.

Talking generically, IPA uses approximate values for dynamic power
consumption (due to approximate values for the dynamic power
coefficient, frequency at the end of the analysis window, an approximate
value for utilization), approximate values for sustainable power in
within a thermal zone, and approximate values for static power. A lot of
my own experiments so far showed that IPA can compensate very well for
inaccuracies in all of these due to the PID control loop but it pays the
price in the stability of its signal when they are way off.

As you also mention, when the accuracy of these values is neglected this
can result in an inefficient ramp up and seesaw effects (undershoots and
overshoots). That's why is very important for IPA to be properly tuned
and I would not suggest that any of these should be neglected, but to be
as accurate as possible.

But there is only so much accuracy that you can achieve given the high
cost of added complexity: static power and the dynamic power coefficient
depend on PVT which sometimes cannot easily be factored in, the
utilization that scales the dynamic power cannot be easily tracked
especially for clusters of CPUs and given inaccurate estimations of idle
states, etc.

This being said, I believe there are platforms out there where the
static power cost might be much too expensive to model for the gain it
brings in the stability and accuracy of IPA power request estimation and
allocation. Also, as you pointed out, there is reluctance in sharing
these models.

>>
>>>>> The code added there can be found at:
>>>>> https://git.linaro.org/landing-teams/working/arm/kernel-release.git/tree/drivers/thermal/scpi-thermal.c?h=lsk-3.18-armlt#n247
>>>>>
>>>>> As for removing this code now, I would not want to make that decision without
>>>>> spending more time to check if it impacts other customer codelines.
>>>>>
>>
>> Maybe this is a matter of Linaro/ARM failing to convince SoC vendors to
>> really publish static power to mainline Linux instead of really having
>> the benefit of modeling it? Even simple models based on temperature
>> ranges would be better than only using dynamic power model.
> 
> I know of a few SoCs implementing static power model in their kernel
> (not mainline). It would be great for that code to hit mainline. But as
> with all the out of tree code, I'm not sure have much influence we have
> in making that happen.
> 
> Again, I don't think we are arguing about the importance of static power
> in a power model based thermal control strategy like IPA.
> 
>>
>>>>> I'll come back with a reply to this in the next couple of days.
>>>>
>>>> Sure, we can wait for few days definitely :)
>>>
>>> While the above certainly is true, it doesn't matter whether or not any
>>> out-of-the-tree code will be affected by removing this from the mainline.
>>>
>>> What matters is *only* whether or not anyone is going to add anything
>>> depending on it to the mainline any time soon.  If that's not the case,
>>> the stuff goes away (and may be added back in the future if need be).
>>>
>>> To avoid delaying this indefinitely, let's make a deal as follows.
>>>
>>> Unless anyone with some changes targeted at the mainline and depending on the
>>> code in question shows up before the end of the merge window currently under
>>> way, I will queue up the patches from Viresh for 4.16.  Then, there will be
>>> 8 weeks (or more) of time before the 4.16 merge window opens to drop them if
>>> any new material depending on the code removed by them materializes in the
>>> meantime.
>>
>>
>> Sure, as I mentioned before, if we failed to convince SoC manufacturers
>> to provide valid models, makes no sense to keep dead code in the tree,
>> you have my support and you can add my:
>>
>> Acked-by: Eduardo Valentin <edubezval@gmail.com>
>>
>> I am just not convinced that this is really about the static power
>> being negligible for IPA.
> 

Static power is definitely significant for IPA as is the accuracy of
all other values that contribute to the power request and allocation
calculations. 

For me, part the decision or whether to remove or to keep this code is
about how much use we can make of it now or in the future, as it stands.

Information on static power, depending on platform and achievable
accuracy, can be as simple as a DT value (I would definitely not
recommend this to be the only supported source), a more complex callback
or maybe a value provided by firmware where the mechanism to obtain that
value is hidden.
A DT model would be easy to support with the current code but it would
be very inaccurate.
More complex algorithms provided as callbacks should give the possibility 
for platform specific customization which lacks at the moment. But even
if it was supported, SoC manufactures are usually reluctant to share that 
information.
Passing information from firmware would allow for platform specific 
customization as well as hiding the mechanism through which is obtained,
but there's no standard way to obtain this value at the moment (probably
can be added to the OPP framework in the future).

Another factor to consider is the imbalance between cpufreq and devfreq
cooling devices (devfreq cooling devices are still able to provide
static power information) that removing this code creates.

Therefore, I would rather see this interface extended and not removed
completely, in order to give users the possibility to link a source of
information more appropriate for them. And it should all start with 
support for one platform. But I can't volunteer my time in short term 
to make these changes. So I can ack these patches for now, as the 
justification for cleaning this code is correct, but sooner or later 
better support for providing static power information should and will 
be added.

Best regards,
Ionela.

> Just to reiterate once more, we are in agreement here. :)
> 
> I'd like to think this patchset has come out of a plan to develop
> functionality on top but I don't know if that is the case.
> 
>>
>>>
>>> Thanks,
>>> Rafael
>>>
> 
