From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 6/6] arm64: dts: r8a7795: Add SYSC PM domains
Date: Fri, 11 Mar 2016 09:01:09 +0100
Message-ID: <CAMuHMdWH96S6W_h+zYqos6r2-kr6qf_3yo_PvDUc1zfJTzwfdw@mail.gmail.com>
References: <1457551135-22078-1-git-send-email-geert+renesas@glider.be>
	<1457551135-22078-7-git-send-email-geert+renesas@glider.be>
	<20160310233411.GC7423@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33648 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934358AbcCKIBK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Mar 2016 03:01:10 -0500
In-Reply-To: <20160310233411.GC7423@verge.net.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Fri, Mar 11, 2016 at 12:34 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Mar 09, 2016 at 08:18:55PM +0100, Geert Uytterhoeven wrote:
>> Add a device node for the System Controller.
>> Hook up the Cortex-A57 CPU cores and the Cortex-A57 and Cortex A53 L2
>> caches/SCUs to their respective PM domains.
>> Hook up all devices that are part of the CPG/MSSR Clock Domain to the
>> SYSC "always-on" PM Domain.
>
> [snip]
>
>> +             sysc: system-controller@e6180000 {
>> +                     compatible = "renesas,r8a7795-sysc";
>> +                     reg = <0 0xe6180000 0 0x0400>;
>
> In table 9.2 of v0.51e of the documentation I see some registers
> beyond the 0x400 range above. Perhaps it could be enlarged accordingly?

No, these registers do not apply to R-Car H3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
