From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Tue, 11 Aug 2015 09:58:19 -0600
Message-ID: <20150811155819.GH52339@linaro.org>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
 <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
 <7hd1yyvf1b.fsf@deeprootsystems.com>
 <CAMuHMdWRoUOBvz7MEGgF1oHz95D-GhaYG1yHr_kGe5NUQ0EnrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36727 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965508AbbHKP56 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 11:57:58 -0400
Received: by pdco4 with SMTP id o4so85116432pdc.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 08:57:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMuHMdWRoUOBvz7MEGgF1oHz95D-GhaYG1yHr_kGe5NUQ0EnrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@kernel.org>, Rob Herring <robherring2@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 11 2015 at 07:07 -0600, Geert Uytterhoeven wrote:
>On Sat, Aug 8, 2015 at 1:45 AM, Kevin Hilman <khilman@kernel.org> wrote:
>> Rob Herring <robherring2@gmail.com> writes:
>>> On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>>> +ARM CPU Power domains
>>>> +
>>>> +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
>>>> +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
>>>> +caches, VFP and power controller and other peripheral hardware. Generally,
>>>> +when the CPUs in the cluster are idle/suspended, the shared resources may also
>>>> +be suspended and resumed before any of the CPUs resume execution.
>>>> +
>>>> +CPUs are the defined as the PM domain consumers and there is a PM domain
>>>> +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
>>>> +[1].
>>>> +
>>>> +The ARM CPU PM domain follows the same binding convention as any generic PM
>>>> +domain. Additional binding properties are -
>>>> +
>>>> +- compatible:
>>>> +       Usage: required
>>>> +       Value type: <string>
>>>> +       Definition: Must also have
>>>> +                       "arm,pd"
>>>> +               inorder to initialize the genpd provider as ARM CPU PM domain.
>>>
>>> A compatible string should represent a particular h/w block. If it is
>>> generic, it should represent some sort of standard programming
>>> interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
>>> is rather just a mapping of what "driver" you want to use.
>>>
>>> I would expect that identifying a cpu's or cluster's power domain
>>> would be done by a phandle between the cpu/cluster node and power
>>> domain node.
>>
>> That's correct, the CPU nodes (and other nodes in the cluster like GIC,
>> Coresight, etc.) would have phandles to the cluster power domain node.
>
>Indeed.
>
>> But this series is meant to create the driver & binding for those cluster
>> power domain(s), so the question is how exactly describe it.
>
>I don't think I can add an "arm,pd" compatible property to e.g. a2sl
>(for CA15-CPUx) and a3sm (for CA15-SCU) in arch/arm/boot/dts/r8a73a4.dtsi,
>as these are just subdomains in a power domain hierarchy, all driven by a
>single hardware block.
>
>I can call e.g. a special registration method, or set up some ops pointer,
>for the a2sl and a3sm subdomains from within the "renesas,sysc-rmobile"
>driver.
>
I was hoping the macro would help in such a case. But since your domain
cannot be defined as arm,pd (could you explain why, I seem to missing
the obvious) would it help if I export a function like that the
renesas,sysc-rmobile driver could call and setup the CPU PM domain?
There is catch to it though.

The problem is -

To be generic and not have every driver write code to do this generic
functionality, the common code would want to instantiate the
arm_pm_domain and therefore the embedded genpd. A pointer instead of
actual object, would mean maintaining a list and iterating through it,
everytime the domain is suspended/resumed. With an object, I could just
do container_of and get the arm_pd. But, we also want to give the
platform an option to define certain aspects of the CPU's generic PM
domain like the flags, genpd callbacks etc, before the genpd is
registered with the framework.

Would such a function work for you? What does everyone think about the
@template?

struct generic_pm_domain *of_arm_cpu_domain(struct device_node *dn,
                struct of_arm_pd_ops *ops, struct generic_pm_domain *template)
{
        struct arm_pm_domain *pd;

        if (!of_device_is_available(dn))
                return NULL;

	/* This creates the memory for pd and setup basic stuff */
        pd = setup_arm_pd(dn);

	/* copy the platform's template genpd over to the pd's genpd */
        memcpy(&pd.genpd, template, sizeof(*template));

	/* 
	 * Now set up the additional ops and flags and register with
	 * genpd framework
	 */
        register_arm_pd(dn, pd);

	/* 
	 * Returning the genpd back to the platform so it can be added
	 * as subdomains to other domains etc.
	 */
        return &pd.genpd;
}
EXPORT_SYMBOL(of_arm_cpu_domain);

The catch is that platform drivers have to provide a template for the
genpd. The @template would never be registered, but would just be used
to create the common code's genpd.

Any other ideas?

Thanks,
Lina
