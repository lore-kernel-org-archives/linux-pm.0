From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Mon, 30 Nov 2015 10:59:04 +0100
Message-ID: <CAKfTPtAww=r6H2Jrgu+8jDsYohPj7HD=_sdAP2utEEH-YLVsaA@mail.gmail.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com> <20151124020631.GA15165@rob-hp-laptop>
 <20151124105423.GM26372@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33432 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbK3J70 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 04:59:26 -0500
Received: by lfaz4 with SMTP id z4so189435468lfa.0
        for <linux-pm@vger.kernel.org>; Mon, 30 Nov 2015 01:59:24 -0800 (PST)
In-Reply-To: <20151124105423.GM26372@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul

Hi Juri,

On 24 November 2015 at 11:54, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi,
>
> On 23/11/15 20:06, Rob Herring wrote:
>> On Mon, Nov 23, 2015 at 02:28:35PM +0000, Juri Lelli wrote:
>> > ARM systems may be configured to have cpus with different power/performance
>> > characteristics within the same chip. In this case, additional information
>> > has to be made available to the kernel (the scheduler in particular) for it
>> > to be aware of such differences and take decisions accordingly.
>> >

[snip]

>> > +==========================================
>> > +2 - CPU capacity definition
>> > +==========================================
>> > +
>> > +CPU capacity is a number that provides the scheduler information about CPUs
>> > +heterogeneity. Such heterogeneity can come from micro-architectural differences
>> > +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
>> > +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
>> > +context is about differing performance characteristics; this binding tries to
>> > +capture a first-order approximation of the relative performance of CPUs.
>> > +
>> > +One simple way to estimate CPU capacities is to iteratively run a well-known
>> > +CPU user space benchmark (e.g, sysbench, dhrystone, etc.) on each CPU at
>> > +maximum frequency and then normalize values w.r.t.  the best performing CPU.
>> > +One can also do a statistically significant study of a wide collection of
>> > +benchmarks, but pros of such an approach are not really evident at the time of
>> > +writing.
>> > +
>> > +==========================================
>> > +3 - capacity-scale
>> > +==========================================
>> > +
>> > +CPUs capacities are defined with respect to capacity-scale property in the cpus
>> > +node [1]. The property is optional; if not defined a 1024 capacity-scale is
>> > +assumed. This property defines both the highest CPU capacity present in the
>> > +system and granularity of CPU capacity values.
>>
>> I don't really see the point of this vs. having an absolute scale.
>>
>
> IMHO, we need this for several reasons, one being to address one of your
> concerns below: vendors are free to choose their scale without being
> forced to publish absolute data. Another reason is that it might make
> life easier in certain cases; for example, someone could implement a
> system with a few clusters of, say, A57s, but some run at half the clock
> of the others (e.g., you have a 1.2GHz cluster and a 600MHz cluster); in
> this case I think it is just easier to define capacity-scale as 1200 and
> capacities as 1200 and 600. Last reason that I can think of right now is
> that we don't probably want to bound ourself to some particular range
> from the beginning, as that range might be enough now, but it could
> change in the future (as in, right now [1-1024] looks fine for
> scheduling purposes, but that might change).

Like Rob, i don't really see the benefit of this optional
capacity-scale property. Parsing the capacity of all cpu nodes should
give you a range as well.
IMHO, this property looks like an optimization of the code that will
parse the dt more than a HW description

>
>> > +
>> > +==========================================
>> > +4 - capacity
>> > +==========================================
>> > +
>> > +capacity is an optional cpu node [1] property: u32 value representing CPU
>> > +capacity, relative to capacity-scale. It is required and enforced that capacity
>> > +<= capacity-scale.
>>
>> I think you need something absolute and probably per MHz (like
>> dynamic-power-coefficient property). Perhaps the IPC (instructions per
>> clock) value?
>>
>> In other words, I want to see these numbers have a defined method
>> of determining them and don't want to see random values from every
>> vendor. ARM, Ltd. says core X has a value of Y would be good enough for
>> me. Vendor X's A57 having a value of 2 and Vendor Y's A57 having a
>> value of 1024 is not what I want to see. Of course things like cache
>> sizes can vary the performance, but is a baseline value good enough?
>>
>
> A standard reference baseline is what we advocate with this set, but
> making this baseline work for every vendor's implementation is hardly
> achievable, IMHO. I don't think we can come up with any number that
> applies to each and every implementation; you can have different
> revisions of the same core and vendors might make implementation choices
> that end up with different peak performance.
>
>> However, no vendor will want to publish their values if these are
>> absolute values relative to other vendors.
>>
>
> Right. That is why I think we need to abstract numbers, as we do with
> capacity-scale.
>
>> If you expect these to need frequent tuning, then don't put them in DT.
>>
>
> I expect that it is possible to come up with a sensible baseline number
> for a specific platform implementation, so there is value in
> standardizing how we specify this value and how it is then consumed.
> Finer grained tuning might then happen both offline (with changes to the
> mainline DT) and online (using the sysfs interface), but that should
> only apply to a narrow set of use cases.
>
> Thanks,
>
> - Juri
