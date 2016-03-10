From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 2/7] soc: renesas: Add r8a7779 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 09:02:57 +0100
Message-ID: <CAMuHMdXnUxr6kCtonKFoRRASy1t1Zzyk+SHkz3hzqkSXLcod1Q@mail.gmail.com>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
	<1457551122-21838-3-git-send-email-geert+renesas@glider.be>
	<3847967.WBShi7eqzc@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <3847967.WBShi7eqzc@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Thu, Mar 10, 2016 at 3:40 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 09 March 2016 20:18:37 Geert Uytterhoeven wrote:
>> --- /dev/null
>> +++ b/include/dt-bindings/power/r8a7779-sysc.h

>> +#define R8A7779_PD_SH                        16
>
> I don't see this power domain in version 0.6 of the datasheet, you might have
> a more recent version than I do.

It's indeed not in the datasheet.
I based it's presence on the value written to SYSCIER, which has bit 16 set,
both in upstream and in the BSP.

Perhaps Magnus knows, as he's the author of that code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
