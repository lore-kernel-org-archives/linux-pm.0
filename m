From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v6 00/11] soc: renesas: Add R-Car SYSC PM Domain Support
Date: Fri, 22 Apr 2016 09:02:01 +0200
Message-ID: <CAMuHMdVWONBiKYo1w4HwhPQV1oZvw2Kgya7Gxb=NCHXvnr48Tw@mail.gmail.com>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
	<20160421032811.GF11116@verge.net.au>
	<CAMuHMdW8uyWUBiqrbkQ=SYd+k-_Ag2PmsGf6N0+-TtJvx0YFQg@mail.gmail.com>
	<20160422003310.GE25416@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160422003310.GE25416@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Fri, Apr 22, 2016 at 2:33 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Apr 21, 2016 at 05:14:40PM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 21, 2016 at 5:28 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Apr 20, 2016 at 02:02:35PM +0200, Geert Uytterhoeven wrote:
>> >> This patch series introduces a DT-based driver for the R-Car System
>> >> Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car Gen3
>> >> SoCs.
>> >>
>> >> This is a dependency for the enablement of DU and VSP on R-Car H3, as
>> >> the VSPs are located in a PM Domain.
>>
>> [...]
>>
>> >> Dependencies:
>> >>   - clk-renesas-for-v4.7 (which now includes "[PATCH v2 0/4] clk:
>> >>     renesas: R-Car SYSC PM Domain Preparation"; pull request sent),
>> >>   - renesas-devel-20160420-v4.6-rc4 (which already contains series
>> >>     "[PATCH v5 0/7] PM / Domains: Add DT bindings for the R-Car System
>> >>     Controller").
>> >>
>> >> I won't be resending follow-up series "[PATCH v5 00/12] ARM/arm64: dts:
>> >> rcar: Add SYSC PM domains" for now, as it's unchanged, except for an
>> >> ugly rebase due to dropping the commits to reference both DMA
>> >> controllers on R-Car Gen2.
>> >>
>> >> For your convenience, I've pushed this, incl. all dependencies, to the
>> >> topic/rcar-sysc-pd-v6 branch of
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
>> >> Integration with renesas-drivers-2016-04-12-v4.6-rc3 is available in the
>> >> topic/gen3-latest branch.
>> >>
>> >> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
>> >> r8a7794/alt, and r8a7795/salvator-x.
>> >>
>> >> Thanks!
>> >
>> > Thanks. I am not planning to queue these up at this point.
>> > Let me know if that is not what you expected.
>>
>> As the clock maintainers has merged the preparatory clock work, and pushed
>> it out into clk-next, you can now:
>>   1. Pull the preparatory clock work in your tree, i.e. pull from:
>>
>>         git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
>> tags/clk-renesas-for-v4.7-tag2
>
> To my mind I need some kind of assurance from the clk maintainers that the
> patches are stable there - in particular that the commit ids won't change.

As the clock maintainer pulled the same tag instead of applying emailed
patches, the commit IDs won't change, even if he has to rework the clk-next
branch and repull.

> And that both they and the ARM-SoC maintainers are happy with me pulling
> it into my tree for this purpose.

I also mentioned that in the pull request. Pulling in a stable branch is
standard procedure: the code fails to compile if you don't merge
tags/clk-renesas-for-v4.7-tag2 first.

> I do wonder, as we are almost at the closing point for queuing up changes
> for v4.7 if, assuming the above patches are scheduled for inclusion in
> v4.7-rc1, it might not be better for me to queue up this series for v4.8.
>
> I could do that sooner rather than later in the devel branch of the renesas
> tree if you like.

v4.7-rc1 is still more than one month in the future.

As Laurent said, that would delay multimedia work by one more kernel cycle,
as R-Car SYSC PM Domains already missed v4.6.
In addition, it would mean continued rebasing/updating of "[PATCH v5 00/12]
ARM/arm64: dts: rcar: Add SYSC PM domains" in renesas-drivers, as it touches
all R-Car DTSes all over the place.

Thanks for reconsidering!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
