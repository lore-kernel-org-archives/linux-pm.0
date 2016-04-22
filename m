From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v6 00/11] soc: renesas: Add R-Car SYSC PM Domain Support
Date: Fri, 22 Apr 2016 10:33:11 +1000
Message-ID: <20160422003310.GE25416@verge.net.au>
References: <1461153766-750-1-git-send-email-geert+renesas@glider.be>
 <20160421032811.GF11116@verge.net.au>
 <CAMuHMdW8uyWUBiqrbkQ=SYd+k-_Ag2PmsGf6N0+-TtJvx0YFQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40953 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcDVAdO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Apr 2016 20:33:14 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8uyWUBiqrbkQ=SYd+k-_Ag2PmsGf6N0+-TtJvx0YFQg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>

On Thu, Apr 21, 2016 at 05:14:40PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Apr 21, 2016 at 5:28 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Apr 20, 2016 at 02:02:35PM +0200, Geert Uytterhoeven wrote:
> >> This patch series introduces a DT-based driver for the R-Car System
> >> Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car Gen3
> >> SoCs.
> >>
> >> This is a dependency for the enablement of DU and VSP on R-Car H3, as
> >> the VSPs are located in a PM Domain.
> 
> [...]
> 
> >> Dependencies:
> >>   - clk-renesas-for-v4.7 (which now includes "[PATCH v2 0/4] clk:
> >>     renesas: R-Car SYSC PM Domain Preparation"; pull request sent),
> >>   - renesas-devel-20160420-v4.6-rc4 (which already contains series
> >>     "[PATCH v5 0/7] PM / Domains: Add DT bindings for the R-Car System
> >>     Controller").
> >>
> >> I won't be resending follow-up series "[PATCH v5 00/12] ARM/arm64: dts:
> >> rcar: Add SYSC PM domains" for now, as it's unchanged, except for an
> >> ugly rebase due to dropping the commits to reference both DMA
> >> controllers on R-Car Gen2.
> >>
> >> For your convenience, I've pushed this, incl. all dependencies, to the
> >> topic/rcar-sysc-pd-v6 branch of
> >> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git.
> >> Integration with renesas-drivers-2016-04-12-v4.6-rc3 is available in the
> >> topic/gen3-latest branch.
> >>
> >> This has been tested on r8a7779/marzen, r8a7790/lager, r8a7791/koelsch,
> >> r8a7794/alt, and r8a7795/salvator-x.
> >>
> >> Thanks!
> >
> > Thanks. I am not planning to queue these up at this point.
> > Let me know if that is not what you expected.
> 
> As the clock maintainers has merged the preparatory clock work, and pushed
> it out into clk-next, you can now:
>   1. Pull the preparatory clock work in your tree, i.e. pull from:
> 
>         git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
> tags/clk-renesas-for-v4.7-tag2

To my mind I need some kind of assurance from the clk maintainers that the
patches are stable there - in particular that the commit ids won't change.
And that both they and the ARM-SoC maintainers are happy with me pulling
it into my tree for this purpose.

I do wonder, as we are almost at the closing point for queuing up changes
for v4.7 if, assuming the above patches are scheduled for inclusion in
v4.7-rc1, it might not be better for me to queue up this series for v4.8.

I could do that sooner rather than later in the devel branch of the renesas
tree if you like.

>   2. Apply this series.
> 
> After that,
>   3. I will rebase and update "[PATCH v5 00/12] ARM/arm64: dts: rcar: Add SYSC
>      PM domains" to match your current dt-for-v4.7 and arm64-dt-for-v4.7 (for
>      dmas/dma-names changes and recently added mmc and sdhi nodes),
>      and send it out,
>   4. You can apply it to a branch containing all of the above as prerequisites.
> 
> Is that OK for you?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
