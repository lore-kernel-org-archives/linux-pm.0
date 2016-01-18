From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH v2 0/4] CPUs capacity information for heterogeneous systems
Date: Mon, 18 Jan 2016 17:42:58 +0100
Message-ID: <CAKfTPtDJBAXUz=_-QQSkrqwAvmUJd1bUJ-VfSaNER-0NzWpunA@mail.gmail.com>
References: <1452262172-31861-1-git-send-email-juri.lelli@arm.com>
 <56994D87.6000709@linaro.org> <20160118151316.GD7159@e106622-lin>
 <CAKfTPtBFR4cowT-j4qVxfUvh6NDNmi6R=J7z9kywi6bONU3Pow@mail.gmail.com> <20160118163014.GA10332@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160118163014.GA10332@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18 January 2016 at 17:30, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Vincent,
>
> On 18/01/16 17:13, Vincent Guittot wrote:
>> On 18 January 2016 at 16:13, Juri Lelli <juri.lelli@arm.com> wrote:
>> > Hi Steve,
>> >
>> > On 15/01/16 11:50, Steve Muckle wrote:
>> >> On 01/08/2016 06:09 AM, Juri Lelli wrote:
>> >> >  2. Dynamic profiling at boot (v2)
>> >> >
>> >> >     pros: - does not require a standardized definition of capacity
>> >> >           - cannot be incorrectly tuned (once benchmark is fixed)
>> >> >           - does not require user/integrator work
>> >> >
>> >> >     cons: - not easy to come up with a clean solution, as it seems interaction
>> >> >             with several subsystems (e.g., cpufreq) is required
>> >> >           - not easy to agree upon a single benchmark (that has to be both
>> >> >             representative and simple enough to run at boot)
>> >> >           - numbers might (and do) vary from boot to boot
>> >>
>> >> An important additional con that was mentioned earlier IIRC was the
>> >> additional boot time required for the benchmark.
>> >
>> > Right. I forgot about that.
>> >
>> >> Perhaps there could be
>> >> a kernel command line argument to bypass the benchmark if it is known
>> >> that predetermined values will be provided via sysfs later?
>> >>
>> >
>> > This might work, yes.
>>
>> Instead of command line, I prefer to use DT.
>>
>> Can't we use something similar to what is currently done in arm arch
>> for the early stage of the boot ? We don't have to provide performance
>> value for which it's difficult to find a consensus on how to define it
>> and which benchmark should be used. We use the micro arch and the
>> frequency of the core to define a relative capacity. This give us a
>> relatively good idea of the capacity of each core.
>
> I'm not sure I understand what you are proposing. arm arch is currently
> based on having static hardcoded data (efficiency values). But, this has
> already been NACKed for arm64 during last review of this RFC.
>
> Are you proposing something different?

No, i'm proposing to use it at boot time until the dynamic profiling
gives better value.
We don't have to set any new properties.
IIRC, It was nacked because it was of static hardcoded value that was
not always reflecting the best accurate capacity of a system. IMHO,
it's not that far from reality so can't this be used as an
intermediate step while waiting for dynamic profiling ?

Vincent

>
> Thanks,
>
> - Juri
>
>> Then, the dynamic profiling can update it with a more accurate value
>> during the boot.
>>
>> >
>> >> Though there may be another issue with that as mentioned below.
>> >>
>> >> >  3. sysfs (v1)
>> >> >
>> >> >     pros: - clean and super easy to implement
>> >> >           - values don't require to be physical properties, defining them is
>> >> >             probably easier
>> >> >
>> >> >     cons: - CPUs capacity have to be provided after boot (by some init script?)
>> >> >           - API is modified, still some discussion/review is needed
>> >> >           - values can still be incorrectly used for runtime tuning purposes
>> >>
>> >> Initializing the values via userspace init will cause more of the boot
>> >> process to run with incorrect CPU capacity values. Boot times may be
>> >> increased with tasks running on suboptimal CPUs. Such increases may also
>> >> not be deterministic.
>> >>
>> >> Extending the kernel command line idea above, perhaps capacity values
>> >> could be provided there as well, similar to the lpj parameter? That has
>> >> scalability issues though if there's a huge highly heterogeneous platform...
>> >>
>> >
>> > Yeah, adding such option is not difficult, but I'm also a bit concerned
>> > about the scalability of such a thing.
>> >
>> >> DT solves these issues and would be the perfect place for this - we are
>> >> defining the compute capacity of a CPU which is a property of the
>> >> hardware. However there are a couple things forcing us to compromise.
>> >> One is that the amount and detail of information required to adequately
>> >> capture the computational abilities of a CPU across all possible
>> >> workloads seem onerous to collect and enumerate. The second is that even
>> >> if we were willing to undertake that, CPU vendors probably won't be
>> >> forthcoming with that information.
>> >>
>> >
>> > You mean because they won't publish performance data of their hw?
>> >
>> > But we already use per platform normalized values (as you are proposing
>> > below). So that a platform to platform comparison doesn't make sense.
>> >
>> >> Despite this DT still seems to me like the best way to go. At their
>> >> heart these are properties of the hardware, even if we can't specify
>> >> them as such per se because of the problems above. The capacity would
>> >> have to be defined as a relative value among CPUs. And while it's true
>> >> it may be abused for tuning purposes, that's true of any strategy.
>> >> Certainly the sysfs strategy and even if only a dynamic option is
>> >> provided, it is guaranteed to be hacked by platform vendors.
>> >
>> > I also like the DT approach and consider the sysfs option as something
>> > that can go together with any solution we want to adopt.
>>
>> I'm not sure that we should consider sysfs as an option because of all
>> the concerned that as already been put forward.
>> I would prefer a debugfs if we have play with these capacity values in
>> order to test their accuracy.
>>
>> Regards,
>> Vincent
>> >
>> > Best,
>> >
>> > - Juri
>>
