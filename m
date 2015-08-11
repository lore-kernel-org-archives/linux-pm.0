From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Tue, 11 Aug 2015 15:07:52 +0200
Message-ID: <CAMuHMdWRoUOBvz7MEGgF1oHz95D-GhaYG1yHr_kGe5NUQ0EnrQ@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
	<1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
	<CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
	<7hd1yyvf1b.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35871 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934090AbbHKNHx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 09:07:53 -0400
Received: by oikt4 with SMTP id t4so8123674oik.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 06:07:53 -0700 (PDT)
In-Reply-To: <7hd1yyvf1b.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Rob Herring <robherring2@gmail.com>, Lina Iyer <lina.iyer@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Aug 8, 2015 at 1:45 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Rob Herring <robherring2@gmail.com> writes:
>> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>> +ARM CPU Power domains
>>> +
>>> +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
>>> +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
>>> +caches, VFP and power controller and other peripheral hardware. Generally,
>>> +when the CPUs in the cluster are idle/suspended, the shared resources may also
>>> +be suspended and resumed before any of the CPUs resume execution.
>>> +
>>> +CPUs are the defined as the PM domain consumers and there is a PM domain
>>> +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
>>> +[1].
>>> +
>>> +The ARM CPU PM domain follows the same binding convention as any generic PM
>>> +domain. Additional binding properties are -
>>> +
>>> +- compatible:
>>> +       Usage: required
>>> +       Value type: <string>
>>> +       Definition: Must also have
>>> +                       "arm,pd"
>>> +               inorder to initialize the genpd provider as ARM CPU PM domain.
>>
>> A compatible string should represent a particular h/w block. If it is
>> generic, it should represent some sort of standard programming
>> interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
>> is rather just a mapping of what "driver" you want to use.
>>
>> I would expect that identifying a cpu's or cluster's power domain
>> would be done by a phandle between the cpu/cluster node and power
>> domain node.
>
> That's correct, the CPU nodes (and other nodes in the cluster like GIC,
> Coresight, etc.) would have phandles to the cluster power domain node.

Indeed.

> But this series is meant to create the driver & binding for those cluster
> power domain(s), so the question is how exactly describe it.

I don't think I can add an "arm,pd" compatible property to e.g. a2sl
(for CA15-CPUx) and a3sm (for CA15-SCU) in arch/arm/boot/dts/r8a73a4.dtsi,
as these are just subdomains in a power domain hierarchy, all driven by a
single hardware block.

I can call e.g. a special registration method, or set up some ops pointer,
for the a2sl and a3sm subdomains from within the "renesas,sysc-rmobile"
driver.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
