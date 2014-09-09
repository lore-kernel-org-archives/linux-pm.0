From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 00/11] ARM: shmobile: r8a7740/armadillo legacy prototype
 pm domain support
Date: Tue, 9 Sep 2014 11:26:50 +0900
Message-ID: <20140909022649.GC31320@verge.net.au>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

I would like Magnus's opinion but mine is that the non-WIP patches
could be queued up. At least patch 1 and 2. Possibly others if
they don't depend (other than diff noise) on WIP patches.

With the WIP patches, I am not entirely opposed to merging them
too, so long as they move things in a good direction. And in particular
don't break anything.

On Fri, Aug 29, 2014 at 03:50:06PM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This series contains prototype patches to improve pm domain support for
> r8a7740/armadillo800eva, mimicking (parts of) the existing pm domain support
> for sh7372/mackerel.
> 
> More specifically, they
>   - Add missing devices to existing pm domains,
>   - Add missing pm domains, hooking up devices and subdomains,
> 
> There are a few things commented out, and a few rough edges or missing things
> (cfr. the patches marked with "[WIP]", and the "FIXME" sections therein),
> but the result does boot, and s2ram works.
> 
> Please note that DT/multi-platform support will be added later.
> 
> This series depends on my series "[PATCH 0/5] ARM: shmobile: pm domain
> improvements and cleanups".
> 
> Thanks for your comments and suggestions!
> 
> Geert Uytterhoeven (11):
>   ARM: shmobile: r8a7740: Add missing A3SP pm domain devices
>   ARM: shmobile: r8a7740: Add missing A4S pm domain devices
>   [WIP] ARM: shmobile: armadillo800eva legacy: Add missing A3SP pm
>     domain devices
>   ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain
>     devices
>   ARM: shmobile: r8a7740: Add A3RV pm domain support
>   ARM: shmobile: r8a7740: Add A3SG pm domain support
>   [WIP] ARM: shmobile: r8a7740/armadillo legacy: Add A4MP pm domain
>     support
>   [WIP] ARM: shmobile: r8a7740: Add D4 pm domain support
>   ARM: shmobile: r8a7740/armadillo legacy: Add A4R pm domain support
>   [WIP] ARM: shmobile: r8a7740: Add A4SU pm domain support
>   [WIP] ARM: shmobile: r8a7740: Add A3SM pm domain support
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |   11 ++++++++++-
>  arch/arm/mach-shmobile/pm-r8a7740.c            |   25 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-r8a7740.c         |   11 +++++++++++
>  3 files changed, 46 insertions(+), 1 deletion(-)
> 
> -- 
> 1.7.9.5
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
