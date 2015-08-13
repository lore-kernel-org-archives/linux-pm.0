From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Thu, 13 Aug 2015 09:45:03 -0600
Message-ID: <20150813154503.GO52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
 <20150813150154.GB13356@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34571 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbHMPoi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 11:44:38 -0400
Received: by pawu10 with SMTP id u10so39915638paw.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 08:44:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150813150154.GB13356@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Krzysztof Koz??owski <k.kozlowski@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "msivasub@codeaurora.org" <msivasub@codeaurora.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 13 2015 at 09:01 -0600, Lorenzo Pieralisi wrote:
>On Thu, Aug 06, 2015 at 04:14:51AM +0100, Rob Herring wrote:
>> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> > Define and add Generic PM domains (genpd) for ARM CPU clusters. Many new
>> > SoCs group CPUs as clusters. Clusters share common resources like GIC,
>> > power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
>> > idle, these shared resources may also be put in their idle state.
>> >
>> > The idle time between the last CPU entering idle and a CPU resuming
>> > execution is an opportunity for these shared resources to be powered
>> > down. Generic PM domain provides a framework for defining such power
>> > domains and attach devices to the domain. When the devices in the domain
>> > are idle at runtime, the domain would also be suspended and resumed
>> > before the first of the devices resume execution.
>> >
>> > We define a generic PM domain for each cluster and attach CPU devices in
>> > the cluster to that PM domain. The DT definitions for the SoC describe
>> > this relationship. Genpd callbacks for power_on and power_off can then
>> > be used to power up/down the shared resources for the domain.
>>
>> [...]
>>
>> > +ARM CPU Power domains
>> > +
>> > +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
>> > +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
>> > +caches, VFP and power controller and other peripheral hardware. Generally,
>> > +when the CPUs in the cluster are idle/suspended, the shared resources may also
>> > +be suspended and resumed before any of the CPUs resume execution.
>> > +
>> > +CPUs are the defined as the PM domain consumers and there is a PM domain
>> > +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
>> > +[1].
>> > +
>> > +The ARM CPU PM domain follows the same binding convention as any generic PM
>> > +domain. Additional binding properties are -
>> > +
>> > +- compatible:
>> > +       Usage: required
>> > +       Value type: <string>
>> > +       Definition: Must also have
>> > +                       "arm,pd"
>> > +               inorder to initialize the genpd provider as ARM CPU PM domain.
>>
>> A compatible string should represent a particular h/w block. If it is
>> generic, it should represent some sort of standard programming
>> interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
>> is rather just a mapping of what "driver" you want to use.
>>
>> I would expect that identifying a cpu's or cluster's power domain
>> would be done by a phandle between the cpu/cluster node and power
>> domain node. But I've not really looked at the power domain bindings
>> so who knows.
>
>I would expect the same, meaning that a cpu node, like any other device
>node would have a phandle pointing at the respective HW power domain.
>
CPUs have phandles to their domains. That is how the relationship
between the domain provider (power-controller) and the consumer (CPU) is
established.

>I do not really understand why we want a "generic" CPU power domain, what
>purpose does it serve ? Creating a collection of cpu devices that we
>can call "cluster" ?
>
Nope, not for calling a cluster, a cluster :)

This compatible is used to define a generic behavior of the CPU domain
controller (in addition to the platform specific behavior of the domain
power controller). The kernel activities for such power controller are
generally the same which otherwise would be repeated across platforms.
An analogy to this would be the "arm,idle-state" that defines the DT
node as something that also depicts a generic cpuidle C state.

Thanks,
Lina
