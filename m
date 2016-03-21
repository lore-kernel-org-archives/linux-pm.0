From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
Date: Mon, 21 Mar 2016 12:09:33 +0100
Message-ID: <CAKfTPtDP3zMR+zbvvqJCBvJ5r44do8NS03wC7pAejxPd0zHTMA@mail.gmail.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com> <56EC3F9E.4050209@nvidia.com>
 <20160321105330.GB12319@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36026 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbcCULJz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Mar 2016 07:09:55 -0400
Received: by mail-lb0-f175.google.com with SMTP id qe11so69784233lbc.3
        for <linux-pm@vger.kernel.org>; Mon, 21 Mar 2016 04:09:54 -0700 (PDT)
In-Reply-To: <20160321105330.GB12319@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Sai Gurrappadi <sgurrappadi@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Mark Brown <broonie@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@l>

On 21 March 2016 at 11:53, Juri Lelli <juri.lelli@arm.com> wrote:
> Hi Sai,
>
> On 18/03/16 10:49, Sai Gurrappadi wrote:
>> Hi Juri,
>>
>> On 03/18/2016 07:24 AM, Juri Lelli wrote:
>>
>> <snip>
>>
>> > +
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
>>
>> Any reason why this capacity number is not dynamically generated based on the
>> max frequency for each CPU? The DT property would then instead specify just
>> the micro-architectural differences between the CPU types.
>>
>
> I'm not sure I clearly understand your question, so I'll try to
> reiterate it.
>
> Are you asking why we don't dynamically profile the system, at boot for
> example, to get this number? Or do you ask why this number couldn't be
> only describing micro-arch differences (so, if I get it right, we should
> then multiply it by max freq to get the capacity of a CPU)?
>
> We already played with the first option (please refer to v2 and v3), but
> we ended up agreeing that dynamic profiling adds overhead to the boot
> process (while a DT approach can provide information to speed up boot)
> and it is in general not repeatable/reliable (as numbers can vary from
> boot to boot for different reasons).
>
> The second option I think can be feasible, but I'm not sure what we gain
> in practice. We will still need to specify a per-platform number, right?

So could we use dt binding like dhrystone = <xyz> (with a unit like
DMIPS/Mhz)  which can then be combined with OPP table to gives a
1st-order approximation of each CPU capacity ?

>
> Best,
>
> - Juri
