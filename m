From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 1/5] dt-bindings: mfd: bd9571mwv: Document rohm,ddr-backup-power
Date: Fri, 13 Oct 2017 11:02:56 +0200
Message-ID: <CAMuHMdWOzgHeB9bSbaz69_xDCY7YbLRSct4gs6fCnYc_Q_eUyw@mail.gmail.com>
References: <1507649178-31473-1-git-send-email-geert+renesas@glider.be>
 <1507649178-31473-2-git-send-email-geert+renesas@glider.be> <20171013085504.i65ohil6dqdzrd2q@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171013085504.i65ohil6dqdzrd2q@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Lee,

On Fri, Oct 13, 2017 at 10:55 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 10 Oct 2017, Geert Uytterhoeven wrote:
>> Document the new optional "rohm,ddr-backup-power" property.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  Documentation/devicetree/bindings/mfd/bd9571mwv.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
>> index 9ab216a851d5619b..7ea3f2db41d4e501 100644
>> --- a/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
>> +++ b/Documentation/devicetree/bindings/mfd/bd9571mwv.txt
>> @@ -25,6 +25,12 @@ Required properties:
>>                           Each child node is defined using the standard
>>                           binding for regulators.
>>
>> +Optional properties:
>> +  - rohm,ddr-backup-power : Value to use for DDR-Backup Power.  This controls
>> +                         which DDR rails need to be kept powered when backup
>> +                         mode is enabled, cfr. the KEEPON_DDR* bits in the
>
> Perhaps it's just me, but I'm confused by this line.
>
> Can you word it another way?

I'll ttry... Let me think a bit about it...

>> +                         documentation for the "BKUP Mode Cnt" register.
>> +
>>  Example:
>>
>>       pmic: pmic@30 {
>> @@ -36,6 +42,7 @@ Example:
>>               #interrupt-cells = <2>;
>>               gpio-controller;
>>               #gpio-cells = <2>;
>> +             rohm,ddr-backup-power = <15>;
>
> Can you explain what this means?  Is it a mask, or does line 15 need
> to be kept on?  What is the range?  Is 0 acceptable?  Clarification
> required please.

It's a mask (OR of (in this case all four) needed KEEPON_DDR* bits).
Unfortunately the datasheet is not publicly available.

0 is acceptable, but as the property is optional, you better just leave it out.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
