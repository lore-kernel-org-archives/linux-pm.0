From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
Date: Fri, 6 Dec 2013 15:54:34 +0100
Message-ID: <CAKfTPtAczqubAGFjEqLev2g-iLYKifr_1P3pUHf2zbhdPObA7Q@mail.gmail.com>
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20131204152010.GC2323@e103592.cambridge.arm.com> <20131204170623.GB26534@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:55736 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758507Ab3LFOy5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2013 09:54:57 -0500
Received: by mail-oa0-f54.google.com with SMTP id h16so872746oag.41
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2013 06:54:56 -0800 (PST)
In-Reply-To: <20131204170623.GB26534@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>, Amit Kucheria <amit.kucheria@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Hanjun Guo <hanjun.guo@linaro.org>, Mark Hambleton <mark.hambleton@broadcom.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>

On 4 December 2013 18:06, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> On Wed, Dec 04, 2013 at 03:20:10PM +0000, Dave Martin wrote:
>> On Mon, Dec 02, 2013 at 04:20:05PM +0000, Lorenzo Pieralisi wrote:
>> > ARM based platforms implement a variety of power management schemes that
>> > allow processors to enter at run-time low-power states, aka C-states
>> > in ACPI jargon. The parameters defining these C-states vary on a per-platform
>> > basis forcing the OS to hardcode the state parameters in platform
>> > specific static tables whose size grows as the number of platforms supported
>> > in the kernel increases and hampers device drivers standardization.
>> >
>> > Therefore, this patch aims at standardizing C-state device tree bindings for
>> > ARM platforms. Bindings define C-state parameters inclusive of entry methods
>> > and state latencies, to allow operating systems to retrieve the
>> > configuration entries from the device tree and initialize the related
>> > power management drivers, paving the way for common code in the kernel
>> > to deal with power states and removing the need for static data in current
>> > and previous kernel versions.
>> >
>> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> > +
>>
>> [...]
>>
>> > +   - cpus
>>
>> Because cpus is really a topology subtree, it might be good to have
>> different names.
>>
>> To avoid confusion with Mark's affinity properties, maybe a different
>> word would be preferable instead of "affinity".
>>
>> Maybe "topology" instead of "cpus", and "affected-topology" instead of
>> "affinity"?
>>
>>
>> cpufreq also has its concepts of "related" and "affected" cpus, which
>> tries to describe something similar (in all honesty, I always struggle
>> to remember which is which ... but if we were consistent with it, that
>> might help).
>
> Yes, I will try to come up with something clearer.
>
>> > +           Usage: Optional
>> > +           Value type: <phandle>
>> > +           Definition: If defined, the phandle points to a node in the
>> > +                       cpu-map[2] representing all CPUs on which C-state
>> > +                       is valid. If not present or system is UP, the
>> > +                       C-state has to be considered valid for all CPUs in
>> > +                       the system.
>> > +
>> > +   - affinity
>> > +           Usage: Optional
>> > +           Value type: <phandle>
>> > +           Definition: If defined, phandle points to a node in the
>> > +                       cpu-map[2] that represents all CPUs that are
>> > +                       affected (ie share) by the C-state and have to
>> > +                       be coordinated on C-state entry/exit. If not
>> > +                       present or system is UP, the C-state is local to
>> > +                       a CPU and need no coordination (ie it is a CPU
>> > +                       state, that does not require coordination with
>> > +                       other CPUs). If present, the affinity property
>> > +                       must contain a phandle to a cpu-map node that
>> > +                       represents a subset, possibly inclusive of the
>> > +                       CPUs described through the cpus property.
>>
>> Can you elaborate on how cpus and affinity might be different?
>
> I was referring to:
>
> - cpus -> processor type (eg valid on A15 or A7, or different implementations
>   of the same processor in the same chip)
> - affinity -> power domain (a subset of the cpus that require coordination)
>
> Nowadays the distinction does not make much sense (I hardly see a power
> state valid on eg A15 clusters [cpus], where just a subset of its cpus need to
> be coordinated [affinity] - might be if other levels of caches are added or
> if you have multiple clusters of the same CPU type with different power
> states capabilities).

Hi Lorenzo

not only linked to the cache. Be sure that you will have HW guys to
group a subset of cores of a cluster under same powergate. Now that
should probably be described thanks to power domain information as you
said below

>
> I think this deserves more attention, and probably adding power domain
> information can remove this mumbo jumbo, there is a scary level of
> duplicated information in there.
>
>> The statement about "having to be coordainted" also feels a bit vague,
>> though I'm not sure how much we can usefully say here.
>>
>> If we describe power domains more explicitly it might help with this,
>> because that could bring some description of what needs to be
>> coordinated.
>
> Yes, see above.
>
>> > +   - power-depth
>> > +           Usage: Required
>> > +           Value type: <u32>
>> > +           Definition: Integer value, starting from 2 (value 0 meaning
>> > +                       running and value 1 representing power depth of
>> > +                       wfi (C1)), that defines the level of depth of a
>> > +                       power state.
>> > +                       The system denotes power states with different
>> > +                       depths, an increasing value meaning less power
>> > +                       consumption and might involve powering down more
>> > +                       components.  Devices that are affected by
>> > +                       C-states entry must define the maximum power
>> > +                       depth supported in their respective device tree
>> > +                       bindings so that OSPM can take decision on how
>> > +                       to handle the device in question when the C-state
>> > +                       is entered. All devices (per-CPU or external) with
>> > +                       a power depth lower than the one defined in the
>> > +                       C-state entry stop operating when the C-state
>> > +                       is entered and action is required by OSPM to
>> > +                       guarantee their logic and memory content is saved
>> > +                       restored to guarantee proper functioning.
>>
>> Any reason to use numbers instead of strings?
>>
>> Strings make the DT more readable ... we would presumably only have to
>> parse this information once, so it shouldn't be an overhead, unless there
>> are hundreds of C-state nodes.
>
> Yes, but it is supposed to be a unique identifier in the entire system.
> Ok, we can create a list of strings denoting power depths, as long as
> they are "standard" fine by me, but I think that a number would be
> easier to use, even though honestly I think it is better to use power
> domains and get rid of this property altogether.
>
> Lorenzo
>
