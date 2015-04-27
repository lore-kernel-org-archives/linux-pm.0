From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional properties
Date: Mon, 27 Apr 2015 10:25:35 -0500
Message-ID: <CAL_JsqKjXuGp0SRFAVWskJRfyeoko6ybtceJQcDzymshuz9wPw@mail.gmail.com>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:32866 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbbD0PZ4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 11:25:56 -0400
In-Reply-To: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, SH-Linux <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 27, 2015 at 10:00 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> On some SoCs, the GIC may be part of a PM Domain (hardware Power and/or
> Clock Domain).  Document the related optional DT properties.
>
> Note: As the current GIC driver doesn't support Runtime PM yet, PM
> Domain constraints must be handled elsewhere in e.g. platform code.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Rob Herring <robh@kernel.org>

One comment below.

> ---
> To preserve DT stability, we would like to add these properties to the
> affected shmobile dtsi files.
>
> On Thu, Mar 26, 2015 at 11:39 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On 25/03/15 21:19, Geert Uytterhoeven wrote:
>>> I would like to add the clock and GIC dependency on the clock in the DTS now,
>>> for reasons of DTS stability. But that means I need a temporary workaround
>>> to avoid the clock from being disabled, until the GIC driver handles this.
>>>
>>> I don't expect a fix for the GIC code to just show up magically. I just wanted
>>> you to be aware of the problem. GIC is not the only problematic module here,
>>> there are others, cfr. the last slide of [2].
>>
>> As long as there is an agreement from the DT people on the presence of
>> that extra property in the GIC node, I'm happy with that. I'd like it to
>> be documented though.
>
> Full thread at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/331876.html
>
>  Documentation/devicetree/bindings/arm/gic.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 2da059a4790cb3c6..b21113b35f085f27 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -58,6 +58,14 @@ Optional
>    regions, used when the GIC doesn't have banked registers. The offset is
>    cpu-offset * cpu-nr.
>
> +- power-domains : A phandle and PM domain specifier as defined by bindings of
> +                 the power controller specified by phandle, used when the GIC
> +                 is part of a Power or Clock Domain.

"or Clock" should be removed?

> +
> +- clocks        : A phandle and clock specifier as defined by bindings of
> +                 the clock controller specified by phandle, used when the GIC
> +                 is part of a Clock Domain.
> +
>  Example:
>
>         intc: interrupt-controller@fff11000 {
> --
> 1.9.1
>
