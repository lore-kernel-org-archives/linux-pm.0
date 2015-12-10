From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC PATCH 2/8] Documentation: arm: define DT cpu capacity
 bindings
Date: Thu, 10 Dec 2015 14:14:44 +0000
Message-ID: <566988D4.50406@arm.com>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <1448288921-30307-3-git-send-email-juri.lelli@arm.com>
 <20151124020631.GA15165@rob-hp-laptop> <20151124105423.GM26372@e106622-lin>
 <CAKfTPtAww=r6H2Jrgu+8jDsYohPj7HD=_sdAP2utEEH-YLVsaA@mail.gmail.com>
 <20151201112044.GV20439@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:40289 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752388AbbLJOOt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 09:14:49 -0500
In-Reply-To: <20151201112044.GV20439@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Rob Herring <robh@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Olof Johansson <olof@lixom.net>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Paul Walmsley <paul@pwsan.com>, Linus Walleij <linus.wall>

On 01/12/15 11:20, Juri Lelli wrote:
> Hi Vincent,
> 
> On 30/11/15 10:59, Vincent Guittot wrote:
>> Hi Juri,
>>
>> On 24 November 2015 at 11:54, Juri Lelli <juri.lelli@arm.com> wrote:

[...]

>>>>> +==========================================
>>>>> +3 - capacity-scale
>>>>> +==========================================
>>>>> +
>>>>> +CPUs capacities are defined with respect to capacity-scale property in the cpus
>>>>> +node [1]. The property is optional; if not defined a 1024 capacity-scale is
>>>>> +assumed. This property defines both the highest CPU capacity present in the
>>>>> +system and granularity of CPU capacity values.
>>>>
>>>> I don't really see the point of this vs. having an absolute scale.
>>>>
>>>
>>> IMHO, we need this for several reasons, one being to address one of your
>>> concerns below: vendors are free to choose their scale without being
>>> forced to publish absolute data. Another reason is that it might make
>>> life easier in certain cases; for example, someone could implement a
>>> system with a few clusters of, say, A57s, but some run at half the clock
>>> of the others (e.g., you have a 1.2GHz cluster and a 600MHz cluster); in
>>> this case I think it is just easier to define capacity-scale as 1200 and
>>> capacities as 1200 and 600. Last reason that I can think of right now is
>>> that we don't probably want to bound ourself to some particular range
>>> from the beginning, as that range might be enough now, but it could
>>> change in the future (as in, right now [1-1024] looks fine for
>>> scheduling purposes, but that might change).
>>
>> Like Rob, i don't really see the benefit of this optional
>> capacity-scale property. Parsing the capacity of all cpu nodes should
>> give you a range as well.
>> IMHO, this property looks like an optimization of the code that will
>> parse the dt more than a HW description
>>
> 
> I agree that we can come up with the same information just looking at
> the biggest capacity value of all CPUs and treat that value as
> capacity-scale. I just thought that having that explicit made things
> clearer, as it could be not easy to immediately see from a DT with many
> CPUs which is the biggest capacity value. But, yes, we could remove that
> anyway.

+1! This capacity-scale complicates things unnecessarily. It was hard
for me to understand the meaning of it. Your 2. example sets
'capacity-scale = <2>' but also 'capacity = <2>' for cpu[01] and
'capacity = <1>' for cpu[23]. This can be easily replaced by 'capacity =
<1024>' for cpu[01] and 'capacity = <512>' for cpu[23]. Much more
readable, as it was mentioned already in this thread.

I understand that we don't want to limit the range of capacity values in
the dt file to [1..1024] nor enforce that the cpu w/ the highest
capacity has to have the value of 1024 in the dt file so the scheduler
has to scale accordingly if we want to limit capacity to its supported
capacity range (like with EAS [1..1024]).

[...]

