From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: rcar: Add binding docs for new R-Car Gen2
 SoCs
Date: Mon, 8 Sep 2014 06:48:37 -0400
Message-ID: <20140908104835.GB3573@developer>
References: <1409213552-5713-1-git-send-email-geert+renesas@glider.be>
 <20140906161357.GA3573@developer>
 <CAMuHMdW_BYT8ughx=-j3Y+5Bd1Jkb3An8D=uTNcXa6rU3nfNQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdW_BYT8ughx=-j3Y+5Bd1Jkb3An8D=uTNcXa6rU3nfNQg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Zhang Rui <rui.zhang@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Sat, Sep 06, 2014 at 08:10:13PM +0200, Geert Uytterhoeven wrote:
> Hi Eduardo,
> 
> On Sat, Sep 6, 2014 at 6:13 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> > On Thu, Aug 28, 2014 at 10:12:32AM +0200, Geert Uytterhoeven wrote:
> >>   - r8a7792 (R-Car V2H)
> >>   - r8a7793 (R-Car M2-N)
> >>   - r8a7794 (R-Car E2)
> >>
> >> r8a7791 is now called "R-Car M2-W".
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > I don't have any concerns on this patch and will be adding to my next
> > branch. But before that, I have one simple question. Although the
> 
> Thanks!
> 
> > binding description mention about soc types, the rcar thermal driver do
> > not differentiate soc types, only supports the "renesas,rcar-thermal"
> > compatible.
> >
> > Do you care explaining why we need the soc specific compatibles?
> 
> The reason we also have the SoC-specific values is that we are not
> 100% sure the thermal IP cores in the Renesas R-Car Gen1 and R-Car Gen2
> series are really identical.
> 
> Currently the driver treats all of them the same, but if we ever discover
> a difference, and the driver needs to start distinguishing among different
> versions, we will need to have the SoC-specific values in the DTSes to
> do so.

In this case, wouldn't make sense to find out first the differences
before changing DT documentation?

Otherwise, you may also figure out that there is no difference and
then send a patch to remove the changes you are sending now
(or even removing the -<soc specific> parts).


> 
> I hope this explains our rationale.
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
