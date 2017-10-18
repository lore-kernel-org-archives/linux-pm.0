From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 4/5] regulator: bd9571mwv: Add support for backup mode
Date: Wed, 18 Oct 2017 13:28:30 +0200
Message-ID: <CAMuHMdWnJwMk5DrnAQebKB23X2WJGPQ2m-0OX8-AC2QYguTQ5w@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-5-git-send-email-geert+renesas@glider.be>
 <20171018110238.hjv7huiievhr5obs@sirena.co.uk> <CAMuHMdU2PpiSftwnqHjb8uFpu5Huw7hpedk4cSzDY-eeKio_Dw@mail.gmail.com>
 <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50585 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbdJRL2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 07:28:32 -0400
In-Reply-To: <20171018112419.3eqz34epcshxas3f@sirena.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Lee Jones <lee.jones@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Mark,

On Wed, Oct 18, 2017 at 1:24 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Oct 18, 2017 at 01:19:08PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Oct 18, 2017 at 1:02 PM, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Oct 10, 2017 at 05:26:17PM +0200, Geert Uytterhoeven wrote:
>> >> Backup mode is not enabled automatically, as e.g. on Renesas
>> >> Salvator-X(S) boards enabling backup mode changes the role of the ACC
>> >> switch from a power switch to a wake-up switch.  Hence enabling it
>> >> prevents the board from being powered off using the ACC switch, which
>> >> may confuse the user.
>
>> > This sounds an awful lot like the standard power/wakeup, though the
>> > power change is a bit unexpected there.  I'm also wondering if it makes
>> > sense to just only enable the wakeup mode when suspending which
>> > preserves the power off functionality while also keeping the wakeup
>> > support.
>
>> The ACC switch is not a momentary switch (push button), but a toggle
>> switch with two positions.
>> Hence you cannot enable wakeup mode while suspending, as the proper
>> system suspend/resume procedure is:
>>   1. Enable backup mode in the PMIC,
>>   2. Switch ACC off (no-op as backup mode has been enabled),
>>   3. Suspend to RAM (PSCI suspend) => system suspends,
>>   4. Switch ACC on => system wakes up.
>> If you would combine steps 1 and 3, you can no longer do step 2 in between.
>
>> Yes, it's complicated :-(
>
> I'm confused, I thought this was a physical switch but that's talking
> about this as something software controlled (at least in step 2)?

The ACC switch is a physical switch.
Steps 1 and 3 are performed by software running on the board's SoC.
Steps 2 and 4 are performed by the external user (human or remote board
farm control hookup).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
