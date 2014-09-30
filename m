From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy
 PM domain support
Date: Tue, 30 Sep 2014 13:20:48 +0900
Message-ID: <20140930042047.GA24253@verge.net.au>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 25, 2014 at 06:15:31PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This series improves PM domain support for r8a7740/armadillo800eva legacy,
> mimicking (parts of) the existing PM domain support for sh7372/mackerel.
> 
> More specifically, they
>   - Add missing devices to existing PM domains,
>   - Add missing PM domains, hooking up devices and subdomains,
> 
> Changes in v2:
>   - Dropped FIXMes on behavior that turned out to be expected,
>   - Hook up the HDMI-Link hardware block,
>   - Really add the A4MP and D4 PM domains, as fixes are available (see
>     dependencies below),
>   - Move special CPU domain handling from A4S to A3SM,
> 
> There are a few dependencies to make resume from s2ram work:
>   - "[PATCH/RFC] fbdev: sh_mobile_hdmi: Re-init regs before irq re-enable on
>     resume",
>   - "[PATCH] ARM: hw_breakpoint: Trap undef instruction exceptions on wake-up",
>     or an alternative solution.
> 
> Apart from that, I'm not aware of any regressions (except perhaps for USB,
> which I was unable to get working anyway).

Hi Geert,

what is your feeling about (me) queueing up part of all of this series now?

> 
> Please note that DT/multi-platform PM domain support is added in an (almost)
> independent series.
> 
> Thanks!
> 
> Geert Uytterhoeven (11):
>   ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
>   ARM: shmobile: r8a7740: Add missing A4S pm domain devices
>   ARM: shmobile: armadillo800eva legacy: Add missing A3SP pm domain
>     devices
>   ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain
>     devices
>   ARM: shmobile: r8a7740: Add A3RV pm domain support
>   ARM: shmobile: r8a7740: Add A3SG pm domain support
>   ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain support
>   ARM: shmobile: r8a7740: Add D4 pm domain support
>   ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
>   ARM: shmobile: r8a7740: Add A4SU pm domain support
>   ARM: shmobile: r8a7740: Add A3SM pm domain support
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 12 +++++++++-
>  arch/arm/mach-shmobile/pm-r8a7740.c            | 32 ++++++++++++++++++++++----
>  arch/arm/mach-shmobile/setup-r8a7740.c         | 11 +++++++++
>  3 files changed, 50 insertions(+), 5 deletions(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
