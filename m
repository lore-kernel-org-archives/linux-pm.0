From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 7/7] soc: renesas: Add r8a7795 SYSC PM Domain Binding Definitions
Date: Thu, 10 Mar 2016 09:17:40 +0100
Message-ID: <CAMuHMdUyFy427ydtojd_4uDUuxUs0Erf-KDJR1y-dMzy3o_vgA@mail.gmail.com>
References: <1457551122-21838-1-git-send-email-geert+renesas@glider.be>
	<1457551122-21838-8-git-send-email-geert+renesas@glider.be>
	<1636171.nVxheqdHqq@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1636171.nVxheqdHqq@avalon>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Laurent,

On Thu, Mar 10, 2016 at 3:32 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 09 March 2016 20:18:42 Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> --- /dev/null
>> +++ b/include/dt-bindings/power/r8a7795-sysc.h
>> @@ -0,0 +1,42 @@

>> +/* Always-on power area */
>> +#define R8A7795_PD_ALWAYS_ON         32
>
> Shouldn't we also define the always-on power domain for the other SoCs
> (patches 2/7 to 6/7 in this series) ? I know they're already covered by the
> cpg power domain, but going forward I believe that standardizing on the SYSC
> power domains would be beneficial. We of course have to keep backward
> compatibility in the implementation.

Yes, that's the plan. I didn't want to make that change now, as someone
may object against the always-on power domain. On r8a7795 it feels more
natural, as it also has I/O devices in SYSC power areas, unlike R-Car Gen2
and H1.

Note that it also complicates the rcar-sysc core driver: it has to choose
between the cpg_mssr_*() or cpg_mstp_*() callbacks, depending on SoC, and also
depending on DTS if we migrate the older SoCs to CPG/MSSR and want to
maintain backwards-compatibility.

Time to finish the "renesas,apmu" enable-method work, and celebrate one big
flag day for all the new DT evolutions?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
