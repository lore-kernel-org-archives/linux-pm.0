From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 5/8] dt/bindings: Update binding for PM domain idle
 states
Date: Mon, 10 Oct 2016 16:45:06 +0100
Message-ID: <4e55d6ad-8de7-72d7-7512-5e4ff2aabc79@arm.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org>
 <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49272 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751392AbcJJPpL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 11:45:11 -0400
In-Reply-To: <1475879821-8035-6-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, khilman@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>



On 07/10/16 23:36, Lina Iyer wrote:
> Update DT bindings to describe idle states of PM domains.
>
> This patch is based on the original patch by Marc Titinger.
>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/power/power_domain.txt     | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 025b5e7..7f8f27e 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -29,6 +29,10 @@ Optional properties:
>     specified by this binding. More details about power domain specifier are
>     available in the next section.
>
> +- domain-idle-states : A phandle of an idle-state that shall be soaked into a
> +                generic domain power state. The idle state definitions are
> +                compatible with arm,idle-state specified in [1].
> +

Please do add the following details to the binding. IMO, this binding is
not complete in terms of specification as there are few open questions:

1. What not define a standard compatible instead of "arm,idle-state" ?
    I agree it can be used, but as part of this *generic* binding, IMO
    it's better to have something generic and can be used by devices.
    Otherwise, this binding becomes CPU specific, that too ARM CPU
    specific.

2. Now taking CPU as a special device, how does this co-exist with the
    cpu-idle-states ? Better to have some description may be in the ARM
    CPU idle binding document(not here of-course)

3. I still haven't seen any explanation for not considering complete
    hierarchical power domain representation which was raised in earlier
    versions. I had provided example for the proposal. I just saw them
    already in use in the upstream kernel by Renasas. e.g.:
    arch/arm/boot/dts/r8a73a4.dtsi

    How does that fit with your proposal, though you have not made one
    yet for CPUs in this binding ? In the above file, CPUs have either
    own power domain inside the L2 one which is cluster level power
    domain.

One must be able to get answers to these above questions with this
binding. Until then it's *incomplete* though it may be correct.

-- 
Regards,
Sudeep
