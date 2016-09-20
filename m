From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v5 02/16] dt/bindings: Update binding for PM domain idle
 states
Date: Tue, 20 Sep 2016 10:17:48 -0600
Message-ID: <20160920161748.GB46914@linaro.org>
References: <20160902201605.GA1705@linaro.org>
 <87sht59mcw.fsf@arm.com>
 <20160912161600.GA21885@linaro.org>
 <a4fc71ae-6fa5-4142-6dd4-7bc96eb20186@arm.com>
 <87intz665i.fsf@arm.com>
 <20160913193844.GB28944@linaro.org>
 <87h99i6b5d.fsf@arm.com>
 <7hpoo3ix80.fsf@baylibre.com>
 <7af4c2d7-70a3-1881-2980-8ea49e594e5b@arm.com>
 <874m5cx6y8.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36065 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932320AbcITQRw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Sep 2016 12:17:52 -0400
Received: by mail-pa0-f48.google.com with SMTP id id6so8520945pad.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Sep 2016 09:17:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874m5cx6y8.fsf@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@baylibre.com>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

On Mon, Sep 19 2016 at 09:09 -0600, Brendan Jackman wrote:
>
>On Fri, Sep 16 2016 at 18:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Kevin,
>>
>> Thanks for looking at this and simplifying various discussions we had so
>> far. I was thinking of summarizing something very similar. I couldn't
>> due to lack of time.
>>
>> On 16/09/16 18:13, Kevin Hilman wrote:
>>
>> [...]
>>
>>> I think we're having some terminology issues...
>>>
>>> FWIW, the kernel terminolgy is actually "PM domain", not power domain.
>>> This was intentional because the goal of the PM domain was to group
>>> devices that some PM features.  To be very specific to the kernel, they
>>> us the same set of PM callbacks.  Today, this is most commonly used to
>>> model power domains, where a group of devices share a power rail, but it
>>> does not need to be limited to that.
>>>
>>
>> Agreed/Understood.
>>
>>> That being said, I'm having a hard time understanding the root of the
>>> disagreement.
>>>
>>
>> Yes. I tried to convey the same earlier, but have failed. The only
>> disagreement is about a small part of this DT bindings. We would like to
>> make it completely hierarchical up to CPU nodes. More comments on that
>> below.
>>
>>> It seems that you and Sudeep would like to use domain-idle-states to
>>> replace/superceed cpu-idle-states with the primary goal (and benefit)
>>> being that it simplifies the DT bindings.  Is that correct?
>>>
>>
>> Correct, we want to deprecate cpu-idle-states with the introduction of
>> this hierarchical PM bindings. Yes IMO, it simplifies things and avoids
>> any ABI break we might trigger if we miss to consider some use-case now.
>>
>>> The objections have come in because that means that implies that CPUs
>>> become their own domains, which may not be the case in hardware in the
>>> sense that they share a power rail.
>>>
>>
>> Agreed.
>>
>>> However, IMO, thinking of a CPU as it's own "PM domain" may make some
>>> sense based on the terminology above.
>>>
>>
>> Thanks for that, we do understand that it may not be 100% correct when
>> we strictly considers hardware terminologies instead of above ones.
>> As along as we see no issues with the above terminologies it should be fine.
>>
>>> I think the other objection may be that using a genpd to model domain
>>> with only a single device in it may be overkill, and I agree with that.
>>
>> I too agree with that. Just because we represent that in DT in that way
>> doesn't mean we need to create a genpd to model domain. We can always
>> skip that if not required. That's pure implementation specifics and I
>> have tried to convey the same in my previous emails. I must say you have
>> summarized it very clearly in this email. Thanks again for that.
>>
>>> But, I'm not sure if making CPUs use domain-idle-states implies that
>>> they necessarily have to use genpd is what you are proposing.  Maybe
>>> someone could clarify that?
>>>
>>
>> No, I have not proposing anything around implementation in the whole
>> discussion so far. I have constrained myself just to DT bindings so far.
>> That's the main reason why I was opposed to mentions of OS vs platform
>> co-ordinated modes of CPU suspend in this discussion. IMO that's
>> completely out of scope of this DT binding we are defining here.
>>
Fair. But understand the PM Domain bindings do not impose any
requirements of hierarchy. Domain idle states are defined by the
property domain-idle-states in the domain node. How the DT bindings are
organized is immaterial to the PM Domain core.

It is a different exercise all together to look at CPU PSCI modes and
have a unified way of representing them in DT. The current set of
patches does not dictate where the domain idle states be located (pardon
my example in the patch, which was not updated to reflect that). That
said, I do require that domains that are controlled by the PSCI f/w be
defined under the 'psci' node in DT, which is fair. All the domain needs
are phandles to the idle state definitions; how the nodes are arranged
in DT is not of consequence to the driver.

In my mind providing a structure to CPU PM domains that can be used for
both OSI and PC is a separate effort. It may also club what Brendan
mentions below as part of the effort. The hierarchy that is presented in
[1] is inherent in the PM domain hierarchy and idle states don't have to
duplicate that information.

>> Hope that helps/clarifies the misunderstanding/disagreement.
>
>Indeed. My intention was that the proposal would result in the exact
>same kernel behaviour as Lina's current patchset, i.e. there is one
>genpd per cluster, and CPU-level idle states are still handled by
>cpuidle.
>
>The only change from the current patchset would be in initialisation
>code: some coordination would need to be done to determine which idle
>states go into cpuidle and which go into the genpds (whereas with the
>current bindings, states from cpu-idle-states go into cpuidle and states
>from domain-idle-states go into genpd). So you could say that this would
>be a trade-off between binding simplicity and implementation simplicity.
>
I would not oppose the idea of virtual domains around CPUs (I admit I am
not comfortable with the idea though), if that is the right thing to do.
But the scope of that work is extensive and should not be clubbed as
part of this proposal. It is an extensive code rework spanning cpuidle
drivers and PSCI and there are hooks in this code to help you achieve
that.

Thanks,
Lina

[1]. https://patchwork.kernel.org/patch/9264507/
