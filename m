From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/6] Revert "staging: board: disable as it breaks the
 build"
Date: Wed, 8 Apr 2015 09:44:05 +0900
Message-ID: <20150408004400.GA3456@verge.net.au>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-2-git-send-email-geert+renesas@glider.be>
 <20150406004031.GD1841@verge.net.au>
 <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdX1uHq23h_qsq2csTSYbAhN9ZDdMviDi=KtbLuWucYWXA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <damm+renesas@opensource.se>, Arnd Bergmann <arnd@arndb.de>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Marc Zyngier <marc.zyngier@arm.com>, driverdevel <devel@driverdev.osuosl.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 07, 2015 at 03:16:54PM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 6, 2015 at 2:40 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Apr 03, 2015 at 02:41:58PM +0200, Geert Uytterhoeven wrote:
> >> This reverts commit d13778d537a0ed6115d2a79a942af999cfb8eec6.
> >>
> >> Commit 13c11072536f2613 ("staging:board: remove unnecessary function")
> >> fixed the build of drivers/staging/board/board.c.
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by? Reviewed-by? Tested-by? Rejected-by?

To be honest I was flipping between Signed-off-by and Acked-by.
But it seems you don't think either of those would be appropriate.
So how about:

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

