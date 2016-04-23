From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v6 00/11] soc: renesas: Add R-Car SYSC PM Domain Support
Date: Sat, 23 Apr 2016 03:30:50 +0300
Message-ID: <2153312.KdOjkoV82j@avalon>
References: <20160422081531.GA5453@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160422081531.GA5453@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Simon,

On Friday 22 Apr 2016 18:15:35 Simon Horman wrote:
> On Fri, Apr 22, 2016 at 07:12:23AM +0300, Laurent Pinchart wrote:
> > On Friday 22 Apr 2016 10:33:11 Simon Horman wrote:
> >> On Thu, Apr 21, 2016 at 05:14:40PM +0200, Geert Uytterhoeven wrote:
> >>> On Thu, Apr 21, 2016 at 5:28 AM, Simon Horman wrote:
> >>>> On Wed, Apr 20, 2016 at 02:02:35PM +0200, Geert Uytterhoeven wrote:
> >>>>> This patch series introduces a DT-based driver for the R-Car System
> >>>>> Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car
> >>>>> Gen3 SoCs.
> >>>>> 
> >>>>> This is a dependency for the enablement of DU and VSP on R-Car H3,
> >>>>> as the VSPs are located in a PM Domain.
> 
> [...]
> 
> >> I do wonder, as we are almost at the closing point for queuing up
> >> changes for v4.7 if, assuming the above patches are scheduled for
> >> inclusion in v4.7-rc1, it might not be better for me to queue up this
> >> series for v4.8.
> > 
> > Then that would delay a bunch of multimedia patch by one more kernel
> > cycle, which I was hoping to avoid.
> 
> On Fri, Apr 22, 2016 at 09:02:01AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 22, 2016 at 2:33 AM, Simon Horman <horms@verge.net.au> wrote:
> >> On Thu, Apr 21, 2016 at 05:14:40PM +0200, Geert Uytterhoeven wrote:
> >>> On Thu, Apr 21, 2016 at 5:28 AM, Simon Horman wrote:
> >>>> On Wed, Apr 20, 2016 at 02:02:35PM +0200, Geert Uytterhoeven wrote:
> >>>>> This patch series introduces a DT-based driver for the R-Car System
> >>>>> Controller, as found on Renesas R-Car H1, R-Car Gen2, and R-Car Gen3
> >>>>> SoCs.
> >>>>> 
> >>>>> This is a dependency for the enablement of DU and VSP on R-Car H3,
> >>>>> as the VSPs are located in a PM Domain.
> 
> [...]
> 
> >> To my mind I need some kind of assurance from the clk maintainers that
> >> the patches are stable there - in particular that the commit ids won't
> >> change.
> > 
> > As the clock maintainer pulled the same tag instead of applying emailed
> > patches, the commit IDs won't change, even if he has to rework the
> > clk-next branch and repull.
> > 
> >> And that both they and the ARM-SoC maintainers are happy with me pulling
> >> it into my tree for this purpose.
> > 
> > I also mentioned that in the pull request. Pulling in a stable branch is
> > standard procedure: the code fails to compile if you don't merge
> > tags/clk-renesas-for-v4.7-tag2 first.
> >
> >> I do wonder, as we are almost at the closing point for queuing up
> >> changes for v4.7 if, assuming the above patches are scheduled for
> >> inclusion in v4.7-rc1, it might not be better for me to queue up this
> >> series for v4.8.
> >> 
> >> I could do that sooner rather than later in the devel branch of the
> >> renesas tree if you like.
> > 
> > v4.7-rc1 is still more than one month in the future.
> > 
> > As Laurent said, that would delay multimedia work by one more kernel
> > cycle, as R-Car SYSC PM Domains already missed v4.6.
> > In addition, it would mean continued rebasing/updating of "[PATCH v5
> > 00/12] ARM/arm64: dts: rcar: Add SYSC PM domains" in renesas-drivers, as
> > it touches all R-Car DTSes all over the place.
> > 
> > Thanks for reconsidering!
> 
> Thanks for your feedback. I now have a better understanding of the
> situation both in regards to the state of the branch and the dependencies
> on it.
> 
> I have reconsidered and queued up this series for v4.7.
> It is now present in the next branch of the renesas tree.

Thanks a lot.

-- 
Regards,

Laurent Pinchart
