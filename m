From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Tue, 14 Jan 2014 10:27:05 +0900
Message-ID: <20140114012705.GA11259@verge.net.au>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
 <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
 <CAMuHMdWVZhWKDS46GWo83z940B9+Z-yt1WrBKSuiS+zwYMqZQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWVZhWKDS46GWo83z940B9+Z-yt1WrBKSuiS+zwYMqZQA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 13, 2014 at 09:57:08AM +0100, Geert Uytterhoeven wrote:
> Hi Morimoto-san,
> 
> On Wed, Jan 8, 2014 at 11:23 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Wed, Jan 8, 2014 at 2:08 AM, Kuninori Morimoto
> > <kuninori.morimoto.gx@gmail.com> wrote:
> >>> +     common->clk = devm_clk_get(&pdev->dev, NULL);
> >>> +     if (IS_ERR(common->clk)) {
> >>> +             dev_err(&pdev->dev, "cannot get clock\n");
> >>> +             return PTR_ERR(common->clk);
> >>> +     }
> >>> +
> >>> +     ret = clk_prepare(common->clk);
> >>> +     if (ret < 0) {
> >>> +             dev_err(&pdev->dev, "unable to prepare clock\n");
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     clk_enable(common->clk);
> >>> +
> >>>       pm_runtime_enable(dev);
> >>>       pm_runtime_get_sync(dev);
> >>
> >> And this patch seems strange for me.
> >> pm_runtime_xxx() is doing same things.
> >> If it didn't work, wrong place is not driver, clock side ?
> >
> > That's an interesting observation...
> 
> You were right. After applying both of "ARM: shmobile: compile drivers/sh
> for CONFIG_ARCH_SHMOBILE_MULTI" and "power: clock_ops.c: fixup clk
> prepare/unprepare count" from Ben Dooks the issue went away.

There seems to be some lively discussion around Ben's patch.

> So my patch can be dropped.

I have marked this patch as Rejected accordingly.
