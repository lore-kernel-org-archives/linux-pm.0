From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 04/11] dt: psci: Update DT bindings to support
 hierarchical PSCI states
Date: Fri, 12 Oct 2018 11:43:11 +0200
Message-ID: <CAPDyKFq3=E=qDkozsu-MupEL_Efpdq62Z3aMWwGQWc+OdzPq8w@mail.gmail.com>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
 <20181003143824.13059-5-ulf.hansson@linaro.org> <20181010150312.GA4844@e107155-lin>
 <CAPDyKFqP3wbd+5rvLcscNf1LUSZDROLqafsLq0Kyh0KziRJrZQ@mail.gmail.com> <20181011164126.GD28583@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011164126.GD28583@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 11 October 2018 at 18:41, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 04:44:07PM +0200, Ulf Hansson wrote:
>> +Raju
>>
>> On 10 October 2018 at 17:03, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> > On Wed, Oct 03, 2018 at 04:38:17PM +0200, Ulf Hansson wrote:
>> >> From: Lina Iyer <lina.iyer@linaro.org>
>> >>
>> >> Update DT bindings to represent hierarchical CPU and CPU PM domain idle
>> >> states for PSCI. Also update the PSCI examples to clearly show how
>> >> flattened and hierarchical idle states can be represented in DT.
>> >>
>> >> Cc: Lina Iyer <ilina@codeaurora.org>
>> >> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> >> Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> >> Reviewed-by: Rob Herring <robh@kernel.org>
>> >> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> >> ---
>> >>  .../devicetree/bindings/arm/psci.txt          | 156 ++++++++++++++++++
>> >>  1 file changed, 156 insertions(+)
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
>> >> index a2c4f1d52492..17aa3d3a1c8e 100644
>> >> --- a/Documentation/devicetree/bindings/arm/psci.txt
>> >> +++ b/Documentation/devicetree/bindings/arm/psci.txt
>> >> @@ -105,7 +105,163 @@ Case 3: PSCI v0.2 and PSCI v0.1.
>> >>               ...
>> >>       };
>> >>
>> >> +ARM systems can have multiple cores sometimes in hierarchical arrangement.
>> >> +This often, but not always, maps directly to the processor power topology of
>> >> +the system. Individual nodes in a topology have their own specific power states
>> >> +and can be better represented in DT hierarchically.
>> >> +
>> >> +For these cases, the definitions of the idle states for the CPUs and the CPU
>> >> +topology, must conform to the domain idle state specification [3]. The domain
>> >> +idle states themselves, must be compatible with the defined 'domain-idle-state'
>> >> +binding [1], and also need to specify the arm,psci-suspend-param property for
>> >> +each idle state.
>> >> +
>> >> +DT allows representing CPUs and CPU idle states in two different ways -
>> >> +
>> >> +The flattened model as given in Example 1, lists CPU's idle states followed by
>> >> +the domain idle state that the CPUs may choose. Note that the idle states are
>> >> +all compatible with "arm,idle-state".
>> >> +
>> >> +Example 2 represents the hierarchical model of CPUs and domain idle states.
>> >> +CPUs define their domain provider in their psci DT node. The domain controls
>> >> +the power to the CPU and possibly other h/w blocks that would enter an idle
>> >> +state along with the CPU. The CPU's idle states may therefore be considered as
>> >> +the domain's idle states and have the compatible "arm,idle-state". Such domains
>> >> +may also be embedded within another domain that may represent common h/w blocks
>> >> +between these CPUs. The idle states of the CPU topology shall be represented as
>> >> +the domain's idle states.
>> >> +
>> >> +In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order to use it,
>> >> +the hierarchical representation must be used.
>> >> +
>> >> +Example 1: Flattened representation of CPU and domain idle states
>> >
>> > [...]
>> >
>> >> +Example 2: Hierarchical representation of CPU and domain idle states
>> >
>> > I understand that this may not be of interest for this series, but do
>> > we need to add any suggestions on how to arrive Flattened representation
>> > of CPU idle states from its hierarchical representation. If the DT has
>> > latter and PSCI call returns as PC mode only for idle. We need to deal
>> > with that case.
>>
>> For sure, I think this is valid comment for this series (or at least
>> v8 which contains the hole set).
>>
>
> Thanks.
>
>> The approach I have taken, so far, is to closely tie the support for
>> PSCI OSI mode to the hierarchical representation in DT of the idle
>> states. Simply because of changing as little as possible, in a first
>> step, then build on top.
>>
>
> That's fine. I just want a note in the bindings to state that we can use
> the hierarchical representation and generate flattened list for PC.

OK, let's discuss it below.

>
>> However, in the offlist discussion I had with Lorenzo, he raised a
>> concern, very similar to what you are bringing up here. There are
>> indeed platform configurations, using PSCI PC mode, which would
>> benefit from the using the hierarchical representation. BTW, that is
>> kind of what Raju just tried to get working for QCOM SDM845 [1], but
>> let's discuss that separately.
>>
>
> OK, we can discuss details in that thread, but I don't even see the PSCI
> domains there.
>
>> The conclusion I made, is that no matter of we are using the PC mode
>> or the OSI mode, the hierarchical representation shall just work.
>>
>
> Indeed.
>
>> To me, this means that I have to re-work the series, such that the
>> PSCI driver (and cpuidle), dynamically in runtime, can agree on which
>> of the idle states that are "shared among a group of CPUs" and which
>> are CPU specific. Exactly how, I am still exploring a few different
>> approaches on.
>>
>> Does it make sense?
>>
>
> Yes

Great!

>
>> So, when it comes to the updated DT bindings in regards to $subject
>> patch, I think it's good as is. Or do you think there is something
>> that needs to be clarified?
>>
>
> Yes, nearly there. Just thought good to add a note that the representation
> has no affinity towards any PSCI idle state mechanism(PC or OSI). So
> that it's never assumed or misunderstood.

I understand your point. However, I think the following sentence still
makes sense (exist in the suggest change above).

"In PSCI firmware v1.0, the OS-Initiated mode is introduced. In order
to use it, the hierarchical representation must be used."

How about if I add: "For the default platform-coordinated mode, both
representations are viable options."

Kind regards
Uffe
