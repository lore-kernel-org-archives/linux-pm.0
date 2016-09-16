From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle states
Date: Fri, 16 Sep 2016 10:13:51 -0700
Message-ID: <7hpoo3ix80.fsf@baylibre.com>
References: <1472242678-33700-1-git-send-email-lina.iyer@linaro.org>
        <1472242678-33700-3-git-send-email-lina.iyer@linaro.org>
        <0b233802-f459-c6bb-ff42-70745a225cfb@arm.com>
        <20160902201605.GA1705@linaro.org> <87sht59mcw.fsf@arm.com>
        <20160912161600.GA21885@linaro.org>
        <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com>
        <87intz665i.fsf@arm.com> <20160913193844.GB28944@linaro.org>
        <87h99i6b5d.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34292 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1764885AbcIPRNy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 13:13:54 -0400
Received: by mail-pa0-f51.google.com with SMTP id wk8so27759428pab.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2016 10:13:53 -0700 (PDT)
In-Reply-To: <87h99i6b5d.fsf@arm.com> (Brendan Jackman's message of "Wed, 14
        Sep 2016 11:14:38 +0100")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

Brendan Jackman <brendan.jackman@arm.com> writes:

> On Tue, Sep 13 2016 at 20:38, Lina Iyer wrote:
>> On Tue, Sep 13 2016 at 11:50 -0600, Brendan Jackman wrote:
>>>
>>>On Mon, Sep 12 2016 at 18:09, Sudeep Holla wrote:
>>>> On 12/09/16 17:16, Lina Iyer wrote:
>>>>> On Mon, Sep 12 2016 at 09:19 -0600, Brendan Jackman wrote:
>>>>>>
>>>>>> Hi Lina,
>>>>>>
>>>>>> Sorry for the delay here, Sudeep and I were both been on holiday last
>>>>>> week.
>>>>>>
>>>>>> On Fri, Sep 02 2016 at 21:16, Lina Iyer wrote:
>>>>>>> On Fri, Sep 02 2016 at 07:21 -0700, Sudeep Holla wrote:
>>>>>> [...]
>>>>>>>> This version is *not very descriptive*. Also the discussion we had
>>>>>>>> on v3
>>>>>>>> version has not yet concluded IMO. So can I take that we agreed on what
>>>>>>>> was proposed there or not ?
>>>>>>>>
>>>>>>> Sorry, this example is not very descriptive. Pls. check the 8916 dtsi
>>>>>>> for the new changes in the following patches. Let me know if that makes
>>>>>>> sense.
>>>>
>>>> Please add all possible use-cases in the bindings. Though one can refer
>>>> the usage examples, it might not cover all usage descriptions. It helps
>>>> preventing people from defining their own when they don't see examples.
>>>> Again DT bindings are like specifications, it should be descriptive
>>>> especially this kind of generic ones.
>>>>
>>>>>>
>>>>>> The not-yet-concluded discussion Sudeep is referring to is at [1].
>>>>>>
>>>>>> In that thread we initially proposed the idea of, instead of splitting
>>>>>> state phandles between cpu-idle-states and domain-idle-states, putting
>>>>>> CPUs in their own domains and using domain-idle-states for _all_
>>>>>> phandles, deprecating cpu-idle-states. I've brought this up in other
>>>>>> threads [2] but discussion keeps petering out, and neither this example
>>>>>> nor the 8916 dtsi in this patch series reflect the idea.
>>>>>>
>>>>> Brendan, while your idea is good and will work for CPUs, I do not expect
>>>>> other domains and possibly CPU domains on some architectures to follow
>>>>> this model. There is nothing that prevents you from doing this today,
>>>
>>>As I understand it your opposition to this approach is this:
>>>
>>>There may be devices/CPUs which have idle states which do not constitute
>>>"power off". If we put those  devices in their own power domain for the
>>>purpose of putting their (non-power-off) idle state phandles in
>>>domain-idle-states, we are "lying" because no true power domain exists
>>>there.
>>>
>>>Am I correct that that's your opposition?
>>>
>>>If so, it seems we essentially disagree on the definition of a power
>>>domain, i.e. you define it as a set of devices that are powered on/off
>>>together while I define it as a set of devices whose power states
>>>(including idle states, not just on/off) are tied together. I said
>>>something similar on another thread [1] which died out.
>>>
>>>Do you agree that this is basically where we disagree, or am I missing
>>>something else?
>>>
>>>[2] http://www.spinics.net/lists/devicetree/msg141050.html
>>>
>> Yes, you are right, I disagree with the definition of a domain around a
>> device.
> OK, great.
>> However, as long as you don't force SoC's to define devices in
>> the CPU PM domain to have their own virtual domains, I have no problem.
>> You are welcome to define it the way you want for Juno or any other
>> platform.
> I don't think that's true; the bindings have to work the same way for
> all platforms. If for Juno we put CPU idle state phandles in a
> domain-idle-states property for per-CPU domains then, with the current
> implementation, the CPU-level idle states would be duplicated between
> cpuidle and the CPU PM domains.
>> I don't want that to be the forced and expected out of all
>> SoCs. All I am saying here is that the current implementation would
>> handle your case as well.
>
> The current implementation certainly does cover the work I want to
> do. The suggestion of per-device power domains for devices/CPUs with
> their own idle states is simply intended to minimise the binding design,
> since we'd no longer need cpu-idle-states or device-idle-states
> (the latter was proposed elsewhere).
>
> I am fine with the bindings as they are implemented currently so long
> as:
>
> - The binding doc makes clear how idle state phandles should be split
>   between cpu-idle-states and domain-idle-states. It should make it
>   obvious that no phandle should ever appear in both properties. It
>   would even be worth briefly going over the backward-compatibility
>   implications (e.g. what happens with old-kernel/new-DT and
>   new-kernel/old-DT combos if a platform has OSI and PC support and we
>   move cluster-level idle state phandles out of cpu-idle-states and into
>   domai-idle-states).
>
> - We have a reason against the definition of power domains as "a set of
>   devices bound by a common power (including idle) state", since that
>   definition would simplify the bindings. In my view, "nobody thinks
>   that's what a power domain is" _is_ a compelling reason, so if others
>   on the list get involved I'm convinced. I think I speak for Sudeep
>   here too.

I think we're having some terminology issues...

FWIW, the kernel terminolgy is actually "PM domain", not power domain.
This was intentional because the goal of the PM domain was to group
devices that some PM features.  To be very specific to the kernel, they
us the same set of PM callbacks.  Today, this is most commonly used to
model power domains, where a group of devices share a power rail, but it
does not need to be limited to that.

That being said, I'm having a hard time understanding the root of the
disagreement.

It seems that you and Sudeep would like to use domain-idle-states to
replace/superceed cpu-idle-states with the primary goal (and benefit)
being that it simplifies the DT bindings.  Is that correct?

The objections have come in because that means that implies that CPUs
become their own domains, which may not be the case in hardware in the
sense that they share a power rail.

However, IMO, thinking of a CPU as it's own "PM domain" may make some
sense based on the terminology above.

I think the other objection may be that using a genpd to model domain
with only a single device in it may be overkill, and I agree with that.
But, I'm not sure if making CPUs use domain-idle-states implies that
they necessarily have to use genpd is what you are proposing.  Maybe
someone could clarify that?

Kevin



