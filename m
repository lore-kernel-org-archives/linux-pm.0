From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] PM / core: genpd fix and pm_runtime_force_suspend|resume() rework
Date: Wed, 17 Jan 2018 12:11:38 +0100
Message-ID: <63183998.QkZ9I1RmW8@aspire.rjw.lan>
References: <4928977.5hd79RbQlp@aspire.rjw.lan> <CAJZ5v0hEVdARvFQo7ma3F756aE0+3vbqu+-L7Ffw0rgpWYt2rA@mail.gmail.com> <CAMuHMdWR+V8d3geQutKr+f+e7+H2D9k-2_-5kJp-4n0rzMXoWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWR+V8d3geQutKr+f+e7+H2D9k-2_-5kJp-4n0rzMXoWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 17, 2018 10:14:23 AM CET Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Mon, Jan 15, 2018 at 5:17 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Mon, Jan 15, 2018 at 3:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 15 January 2018 at 14:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > [cut]
> >
> >>>
> >>> I did miss a small difference in topology: in pm/linux-next, H3 has DMA
> >>> enabled for SCIF2, while M3 hasn't (yet).
> >>> With DMA enabled on M3, it fails in the same way.
> >>>
> >>> As genpd_resume_noirq() no longer calls pm_runtime_force_resume(),
> >>> rcar_dmac_runtime_resume() is no longer called, and the DMAC's registers
> >>> are no longer reinitialized after system resume, breaking the serial port.
> >>
> >> In drivers/dma/sh/rcar-dmac.c, I would try to replace the below line:
> >> SET_SYSTEM_SLEEP_PM_OPS(rcar_dmac_sleep_suspend, rcar_dmac_sleep_resume)
> >>
> >> with:
> >> SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> >
> > Yes, that probably is the least intrusive thing that can be done to
> > address the issue.
> >
> >> in case that may be too early to suspend the dma device (which is
> >> rather common for dma devices) then try;
> >>
> >> SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> >
> > Good suggestion, and I would go straight for it anyway.
> >
> > Geert, can you try if this works, please?
> 
> Works. Both using SET_SYSTEM_SLEEP_PM_OPS() and
> SET_LATE_SYSTEM_SLEEP_PM_OPS(). But given this is a DMA engine
> driver, I'd settle for the latter.
> 
> And I did verify doing so doesn't break the system without the patch
> in $subject.
> 
> Thanks!
> 
> Will send a patch...

Thank you!
