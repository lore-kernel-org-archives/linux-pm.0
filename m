From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 01/11] PM / Domains: Add DT bindings for the R-Car
 System Controller
Date: Tue, 16 Feb 2016 08:15:40 +0100
Message-ID: <CAMuHMdXJYjde1cqWyqzDL9Cgb-3cWSvJmrG61H6Jf6EOu0-=Fw@mail.gmail.com>
References: <1455571020-18968-1-git-send-email-geert+renesas@glider.be>
	<1455571020-18968-2-git-send-email-geert+renesas@glider.be>
	<1720075.YOPnCQ3mE1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36484 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbcBPHPl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 02:15:41 -0500
In-Reply-To: <1720075.YOPnCQ3mE1@avalon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Tue, Feb 16, 2016 at 12:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rcar.txt
>> @@ -0,0 +1,87 @@
>> +DT bindings for the Renesas R-Car System Controller
>> +
>> +== System Controller Node ==
>> +
>> +The R-Car System Controller provides power management for the CPU cores and
>> +various coprocessors.
>> +
>> +Required properties:
>> +  - compatible: Must contain one or more of the following:
>> +      - "renesas,r8a7779-sysc" (R-Car H1)
>> +      - "renesas,r8a7790-sysc" (R-Car H2)
>> +      - "renesas,r8a7791-sysc" (R-Car M2-W)
>> +      - "renesas,r8a7792-sysc" (R-Car V2H)
>> +      - "renesas,r8a7793-sysc" (R-Car M2-N)
>> +      - "renesas,r8a7794-sysc" (R-Car E2)
>> +      - "renesas,r8a7795-sysc" (R-Car H3)
>> +      - "renesas,rcar-gen2-sysc" (Generic R-Car Gen2)
>> +      - "renesas,rcar-gen3-sysc" (Generic R-Car Gen3)
>> +    When compatible with the generic version, nodes must list the
>> SoC-specific
>> +    version corresponding to the platform first, followed by the generic
>> +    version.
>> +  - reg: Address start and address range for the device.

You're quoting the description of the "reg" property for the SYSC device node...

> This isn't correct. I'll refrain from saying we abuse the reg property, as
> using the first cell as a power domain number should be fine (the second cell
> feels a bit more of an abuse to me though, but I won't complain too much), but
> the bindings document should describe what the reg cells contain.

... while the two cell format is for the PM domain nodes, not for the
SYSC device
node. Please check the other "reg" description.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
