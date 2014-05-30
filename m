From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 15:59:33 -0500
Message-ID: <5388F135.2040309@ti.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>	<1401440477-4328-3-git-send-email-thomas.ab@samsung.com>	<20140530130827.GK24233@leverpostej>	<CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com>	<20140530185549.GN24233@leverpostej>	<5388E105.3070609@ti.com>	<5388E3D2.2060602@gmail.com>	<5388E666.2090203@ti.com>	<5388E7DC.40606@gmail.com>	<5388EB21.5020300@ti.com> <CAL_JsqKvNsmJf_-hh+MHmopwGwDBWLMVH7H7Z4-EmLmRays0+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36686 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbaE3VAR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 May 2014 17:00:17 -0400
In-Reply-To: <CAL_JsqKvNsmJf_-hh+MHmopwGwDBWLMVH7H7Z4-EmLmRays0+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Abraham <ta.omasab@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 05/30/2014 03:45 PM, Rob Herring wrote:
> On Fri, May 30, 2014 at 3:33 PM, Nishanth Menon <nm@ti.com> wrote:
>> On 05/30/2014 03:19 PM, Tomasz Figa wrote:
>>> On 30.05.2014 22:13, Nishanth Menon wrote:
>>>> On 05/30/2014 03:02 PM, Tomasz Figa wrote:
>>>>> On 30.05.2014 21:50, Nishanth Menon wrote:
>>>>>> On 05/30/2014 01:55 PM, Mark Rutland wrote:
>>>>>>> On Fri, May 30, 2014 at 07:05:43PM +0100, Thomas Abraham wrote:
>>>>>>>> Hi Mark,
>>>>>>>>
>>>>>>>> On Fri, May 30, 2014 at 6:38 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Apologies for being somewhat late w.r.t. review on this.
>>>>>>>>>
[...]
>>>>>>>>> Why are these in both operating-points and boost-frequencies? It'll be
>>>>>>>>> really easy to accidentally forget to mark something as a
>>>>>>>>> boost-frequency this way. Why not have a boost-points instead?
>>>>>>>>
>>>>>>>> Does boost-points mean a set of clock speeds which are not listed as
>>>>>>>> part of operating-points property? If yes, that also is a possible
>>>>>>>> implementation (it was implemented in one of the earlier version of
>>>>>>>> this series). Could you confirm that you want the boost mode speeds to
>>>>>>>> be exclusive of the speeds listed in operating-points?
>>>>>>>
>>>>>>> If these boost mode operating points are not generally advisable for use
>>>>>>> as the other operating-points are, then they should IMO been in an
>>>>>>> entirely separate property exclusive of (but in the same format as) the
>>>>>>> operating-points property, e.g.
>>>>>>>
>>>>>>> operating points = <A B>, <C D>;
>>>>>>> boost-points = <E F>;
>>>>>>
>>>>>> you are asking boost frequencies to remain for ever tied down to OPP
>>>>>> style description.
>>>>>>
>>>>>> What we are trying to describe? "What are my SoC's overclocked
>>>>>> frequencies"? That description can be used even in a system that does
>>>>>> not use OPP style table (say ACPI based OPP tables or whatever
>>>>>> acronymned table).
>>>>>>
>>>>>> Tying it down to operating points just because we have it today as a
>>>>>> convenient description, is limiting.
>>>>>>
>>>>>> Further, if we decide to educate boost-frequencies to also indicate
>>>>>> how long is it safe? That does indeed belong to boost-frequency
>>>>>> description and not OPP description. Or if we decide to change
>>>>>> operating-points description[1] in the future has an impact on
>>>>>> "boost-points" description, when it should not have.
>>>>>>
>>>>>>>
>>>>>>> Otherwise, without boost-mode support we have to parse the boost mode
>>>>>>> table to figure out which points to avoid. Or if someone typos a value
>>>>>> That is OS usage of h/w description - yeah - in anycase, if OS has no
>>>>>> ability to deal with boost-frequencies, it should skip it for sure.
>>>>>>
>>>>>>> in either table we might go into a boost mode when we didn't want to!
>>>>>>>
>>>>>> There are other ways to screw up device with dts typo. you could give
>>>>>> a wrong voltage(extra 0?) and ensure you never use the chip ever
>>>>>> again.. typos are dt bugs, we can do the best to write robust code to
>>>>>> report them.
>>>>>>
>>>>>
>>>>> Typos are not the primary thing to worry about here. Adding boost
>>>>> frequencies to the list of primary operating points is flawed, because
>>>>> an OS that has no idea of boost mode will use them as normal operating
>>>>> points and this is not desired.
>>>>
>>>> That means we have an implementation bug in OS since it does not
>>>> consider the complete hardware description that device tree is
>>>> providing. An analogy will be a regulator compatible match being used
>>>> but regulator-min-microvolt and regulator-max-microvolt being ignored
>>>> by OS.
>>>
>>> No. The operating points bindings were defined far before this
>>> boost-frequency and so there is no requirement to support the latter.
>>
>> So, we dont add any new bindings ever again? /me blinks. *IF* we add a
>> new property in the future, do we expect the new description to be
>> supported in older kernel(which could not have known about it)? How
>> far are we taking this ABI thing?
>> Documentation/devicetree/bindings/ABI.txt states:
>> 3) Bindings can be augmented, but the driver shouldn't break when given
>>    the old binding. ie. add additional properties, but don't change the
>>    meaning of an existing property. For drivers, default to the original
>>    behaviour when a newly added property is missing.
>>
>> we are not changing the meaning of existing property, we are
>> augumenting it.
> 
> You are changing the meaning of entries in that they can have
> additional data which changes their properties.
> 
> If we accept the DT changes (as DT maintainers) and reject the kernel
> changes (as kernel maintainers), you would be left with a broken
> system.

That is true and I agree.

> 
>> In my opinion, *IF* we are concerned about polluting operating-points
>> description, why dont we enforce that the boost operating points
>> should NOT be defined in the current "operating-points" description -
>> and - just follow what Rob suggested and iMx already does - add such
>> operating points from platform code.
> 
> I believe I also said on this and other attempts to bandage up the
> existing OPP binding, that we should not change/append it, but define
> a new binding for OPPs that addresses this and other issues.
> Otherwise, I'm going to just NAK every incomplete OPP binding bandaid.

Are we open to creating a completely mutually-exclusive binding and
maintain the legacy one as "legacy support without any modification"
while we debate the new binding? I dont deny that we have more bandage
discussions that we'd like on these bindings, So, would like views if
we want to define a better one from scratch rather than continue to
figure out how to live with existing one?

Here are the options I can think of.
1. New binding: Lets say each OPP as phandles? -> that sounds like the
closest I have heard as something that remotely makes sense to scale
properties?
2. Remove OPP bindings entirely - only way to add/modify OPP is from
platform code.

Anyone has better suggestions what we can do?

-- 
Regards,
Nishanth Menon
