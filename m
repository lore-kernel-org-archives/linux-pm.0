From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 3/3] soc: renesas: rcar-sysc: Keep wakeup sources
 active during system suspend
Date: Wed, 20 Dec 2017 12:46:12 +0100
Message-ID: <20171220114611.nd4y7ja6cyu7o4lo@verge.net.au>
References: <1510234022-29442-1-git-send-email-geert+renesas@glider.be>
 <1510234022-29442-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFrxaghoAcWJN1R7d7k5b=QwMpusGFuohVZpTaWngf3aiw@mail.gmail.com>
 <CAMuHMdU2CUE_68ZoQ5ssKaXYJ0L_P0gSTqVFS1GGa_cY7e-8cA@mail.gmail.com>
 <20171220102305.pibdggkfycmj63l4@verge.net.au>
 <CAMuHMdW7r74wGvpDjBr94N0y6_414hxgXmMjzKAPU+bOfeG7Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW7r74wGvpDjBr94N0y6_414hxgXmMjzKAPU+bOfeG7Jg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 20, 2017 at 11:28:43AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Dec 20, 2017 at 11:23 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Dec 18, 2017 at 12:22:17PM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Dec 14, 2017 at 3:11 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> > On 9 November 2017 at 14:27, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> >> >> If an R-Car SYSC slave device is part of the CPG/MSTP or CPG/MSSR Clock
> >> >> Domain and to be used as a wakeup source, it must be kept active during
> >> >> system suspend.
> >> >>
> >> >> Currently this is handled in device-specific drivers by explicitly
> >> >> increasing the use count of the module clock when the device is
> >> >> configured as a wakeup source.  However, the proper way to prevent the
> >> >> device from being stopped is to inform this requirement to the genpd
> >> >> core, by setting the GENPD_FLAG_ACTIVE_WAKEUP flag.
> >> >>
> >> >> Note that this will only affect devices configured as wakeup sources.
> >> >>
> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >
> >> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> Thank you!
> >>
> >> Simon: can you please queue this up for v4.16?
> >> I have queued the other 2 clock patches in clk-renesas-for-v4.16, and sent
> >> a PR for it.
> >
> > Thanks, I have applied this patch to the soc-for-v4.16 branch.
> > It is currently not based v4.15-rc1. Let me know if it should
> > be rebased on top of your pull request for clk-renesas-for-v4.16.
> 
> If the base is not v4.15-rc1, what is it? GENPD_FLAG_ACTIVE_WAKEUP was
> introduced in v4.15-rc1, so it won't compile based on v4.14.

Sorry, I typed my message incorrectly. The base _is_ v4.15-rc1.

> There's no dependency on the clock drivers, so no need to base on
> top of clk-renesas-for-v4.16.

Thanks, got it.
