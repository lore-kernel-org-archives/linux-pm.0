From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 5/9] ARM: common: Introduce PM domains for CPUs/clusters
Date: Wed, 5 Aug 2015 22:14:51 -0500
Message-ID: <CAL_JsqK67=DTtjZwwnonObLDjLbahkREfm0RvyXVV95bhR-d4Q@mail.gmail.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org> <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32919 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbHFDPL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 23:15:11 -0400
Received: by ykoo205 with SMTP id o205so52469050yko.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 20:15:10 -0700 (PDT)
In-Reply-To: <1438731339-58317-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, msivasub@codeaurora.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Gross <agross@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 4, 2015 at 6:35 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Define and add Generic PM domains (genpd) for ARM CPU clusters. Many new
> SoCs group CPUs as clusters. Clusters share common resources like GIC,
> power rail, caches, VFP, Coresight etc. When all CPUs in the cluster are
> idle, these shared resources may also be put in their idle state.
>
> The idle time between the last CPU entering idle and a CPU resuming
> execution is an opportunity for these shared resources to be powered
> down. Generic PM domain provides a framework for defining such power
> domains and attach devices to the domain. When the devices in the domain
> are idle at runtime, the domain would also be suspended and resumed
> before the first of the devices resume execution.
>
> We define a generic PM domain for each cluster and attach CPU devices in
> the cluster to that PM domain. The DT definitions for the SoC describe
> this relationship. Genpd callbacks for power_on and power_off can then
> be used to power up/down the shared resources for the domain.

[...]

> +ARM CPU Power domains
> +
> +The device tree allows describing of CPU power domains in a SoC. In ARM SoC,
> +CPUs may be grouped as clusters. A cluster may have CPUs, GIC, Coresight,
> +caches, VFP and power controller and other peripheral hardware. Generally,
> +when the CPUs in the cluster are idle/suspended, the shared resources may also
> +be suspended and resumed before any of the CPUs resume execution.
> +
> +CPUs are the defined as the PM domain consumers and there is a PM domain
> +provider for the CPUs. Bindings for generic PM domains (genpd) is described in
> +[1].
> +
> +The ARM CPU PM domain follows the same binding convention as any generic PM
> +domain. Additional binding properties are -
> +
> +- compatible:
> +       Usage: required
> +       Value type: <string>
> +       Definition: Must also have
> +                       "arm,pd"
> +               inorder to initialize the genpd provider as ARM CPU PM domain.

A compatible string should represent a particular h/w block. If it is
generic, it should represent some sort of standard programming
interface (e.g, AHCI, EHCI, etc.). This doesn't seem to be either and
is rather just a mapping of what "driver" you want to use.

I would expect that identifying a cpu's or cluster's power domain
would be done by a phandle between the cpu/cluster node and power
domain node. But I've not really looked at the power domain bindings
so who knows.

Rob
