From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Wed, 1 Apr 2015 14:13:12 +0200
Message-ID: <CAMuHMdWuVdOgk6RAzoUtskC3pzz3xs6HmGf5RyrAa3Rs-y56uQ@mail.gmail.com>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
	<1426708017-28885-2-git-send-email-geert+renesas@glider.be>
	<3861934.bVCAbQmBJW@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33407 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbbDAMNN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 08:13:13 -0400
In-Reply-To: <3861934.bVCAbQmBJW@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Tue, Mar 31, 2015 at 1:53 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 18 March 2015 20:46:53 Geert Uytterhoeven wrote:
>> Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
>> driver using the generic PM Domain.  This allows to power-manage the
>> module clocks of SoC devices that are part of the CPG Clock Domain using
>> Runtime PM, or for system suspend/resume.
>>
>> SoC devices that are part of the CPG Clock Domain and can be
>> power-managed through their primary clock should be tagged in DT with a
>> proper "power-domains" property.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> There's one thing that bothers me: the implementation is tied to the CPG
> driver, but the code is quite generic. That feels a bit wrong, it would be
> nice to come up with a generic implementation. On the other hand, the
> platform-dependent part is the list of clocks to manage, specified implicitly
> through the "pm_clk_add(dev, NULL)" call. That list needs to be specified
> somewhere, and adding it to the CPG driver is likely the best solution we can
> have at the moment.

This clock management code is identical to the one in pm-rmobile.c.
We may consolidate in the future, if we have more PM Domain support (e.g.
for R-Car Gen2 SYSC). Let's see...

> I'm slightly worried that adding the power-domains property to the DT node
> will introduce backward compatibility issues if we later switch to a different
> way to specify the clocks to manage automatically. I have no specific example
> though.

Specifying the clocks is indeed the hard part. I use the primary clocks, as
that is compatible with what we did in the past in drivers/sh/pm_runtime.c.
I thought about using a special clock name instead, but that may conflict
with an existing driver-specific DT binding for clk-names, and may cause
problems if you have to specify the same clock twice with different clk-names.

> For those reasons,
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
