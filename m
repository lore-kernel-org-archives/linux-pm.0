From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 07/11] ARM: shmobile: r8a7740/armadillo legacy: Add
 A4MP pm domain support
Date: Mon, 27 Oct 2014 09:17:55 +0100
Message-ID: <CAMuHMdWkM4jgWX7fL63e4WGwhpGt2W1R8Jx-q+dz0GmesrRsOw@mail.gmail.com>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
	<1414063141-8856-8-git-send-email-geert+renesas@glider.be>
	<20141027040305.GG31487@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20141027040305.GG31487@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Mon, Oct 27, 2014 at 5:03 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Oct 23, 2014 at 01:18:57PM +0200, Geert Uytterhoeven wrote:
>> Add support for the A4MP power domain, and hook up the HDMI-Link and FSI
>> hardware blocks.
>> This domain also contains the SPU2, FMSI, and BBIF2 hardware blocks,
>> but these are currently not used by any driver.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Is it possible to split this into two patches.
>
> A board patch (that touches board-armadillo800eva.c)
> and an SoC patch (the rest). Likewise for any remaining
> patches in this series that touch both board and SoC code.
>
> The reason for this is that it would make the patches fit
> the branch scheme that arm-soc people like. In particular splitting
> patches between soc and boards branches.

I kept them together as adding the PM domain without the devices will
cause regressions (the PM domain core will power down the PM domain as
it doesn't know about the to-be-added devices, and thus thinks it's unused).

As the link from a device to a PM domain is a name string, and not a
C reference, I could split them in two parts: first the board part
that adds some
devices, and then the SoC part that adds the PM domain and more devices.
But only if you can guarantee that the SoC part will be merged first, also
by arm-soc and Linus.

Still, I prefer to keep them together. Hooking up devices to PM domains is
SoC-specific, not board specific (for DT it lives in the .dtsi). It's
unfortunate this code is in the board-specific C files due to board-specific
configuration (cfr. .dts overriding/extending .dtsi).

What do you think? Do you agree?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
