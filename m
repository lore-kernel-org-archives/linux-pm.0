From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 0/6] ARM/arm64 : shmobile/renesas: Add L2
 cache-controller nodes
Date: Mon, 15 Feb 2016 11:15:16 +0100
Message-ID: <CAMuHMdVRTJ9nXFNQSz+WGSuUGWho3x08WMNZwPS=B-Q8sdzd4w@mail.gmail.com>
References: <1449512659-16688-1-git-send-email-geert+renesas@glider.be>
	<20160215015848.GD14034@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33955 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbcBOKPR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 05:15:17 -0500
In-Reply-To: <20160215015848.GD14034@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Simon,

On Mon, Feb 15, 2016 at 2:58 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 07, 2015 at 07:24:13PM +0100, Geert Uytterhoeven wrote:
>> This patch series adds the missing L2 cache-controller nodes to the
>> DTSes for various Renesas ARM-based SoCs, and links the CPU nodes to
>> them.
>>
>> For R-Mobile APE6 (r8a73a4), the L2 cache-controllers are also linked to
>> the respective (already existing) SYSC Power Domains. Fortunately these
>> Power Domains were never powered down, as they are parents of the Power
>> Domains containing CPU cores. This may change in the future.
>>
>> For R-Car Gen2 and Gen3 (r8a779x), this serves as a preparatory step for
>> adding SYSC Power Domain support later.
>>
>> Question for the ARM/DT people: What are the DT bindings for
>> Cortex-A15/A7/A57/A53 L2 cache controllers?
>> Everybody just seems to use "cache" for the compatible values...
>>
>> Patches 2-5 were extracted from series "[PATCH/RFC 00/15]
>> ARM: shmobile: R-Car: Add SYSC PM Domain DT Support",
>> (http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348742.html)
>> and received some fixes. You can find more detailed changelogs in the
>> individual patches).
>>
>> This has been tested on r8a73a4/ape6evm, r8a7791/koelsch, and
>> r8a7795/salvator-x.
>
> Sorry for loosing track of this until now.
>
> It seems to me that the Gen-2 changes could be applied, is that correct?

And APE6 :-)

> It also seems to me that there was inconclusive discussion regarding
> the r8a7795 change, is that also correct.

There was discussion (for all SoCs) about the presence of the arm,data-latency
and arm,tag-latency properties. Given the mess^H^H^H^H presence or
absence of virtualization they may or may not be valid...

I think the way forward (keeping the dependency for SYSC PM Domains in mind) is
to apply the series, after removing the controversial latency properties.

Should I resend, or can/will you handle that?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
