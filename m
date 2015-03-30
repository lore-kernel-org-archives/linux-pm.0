From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] clk: shmobile: rcar-gen2: Add CPG Clock Domain support
Date: Mon, 30 Mar 2015 11:58:10 +0200
Message-ID: <CAMuHMdUKjYH9U_o2q9maxCUfvijP=EpX=NUVGOnp=qOF7BHUOw@mail.gmail.com>
References: <1426708017-28885-1-git-send-email-geert+renesas@glider.be>
	<1426708017-28885-2-git-send-email-geert+renesas@glider.be>
	<20150324230036.7930.50037@quantum>
	<20150325010440.GC1767@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33054 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbbC3J6K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 05:58:10 -0400
In-Reply-To: <20150325010440.GC1767@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Michael Turquette <mturquette@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Mar 25, 2015 at 2:04 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Mar 24, 2015 at 04:00:36PM -0700, Michael Turquette wrote:
>> Quoting Geert Uytterhoeven (2015-03-18 12:46:53)
>> > Add Clock Domain support to the R-Car Gen2 Clock Pulse Generator (CPG)
>> > driver using the generic PM Domain.  This allows to power-manage the
>> > module clocks of SoC devices that are part of the CPG Clock Domain using
>> > Runtime PM, or for system suspend/resume.
>> >
>> > SoC devices that are part of the CPG Clock Domain and can be
>> > power-managed through their primary clock should be tagged in DT with a
>> > proper "power-domains" property.
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Looks good to me. Which tree do you want this patch to go through?
>
> My tree seems reasonable from my point of view.
> Though at this point it would be targeted at v4.2.

Definitely. Please give Laurent some time to comment.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
