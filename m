From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 15/16] clk: shmobile: mstp: Consider "zb_clk" suitable
 for power management
Date: Fri, 18 Sep 2015 09:12:23 +0900
Message-ID: <20150918001220.GB12858@verge.net.au>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
 <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
 <20150917084446.GA8197@verge.net.au>
 <20150917085314.GA29509@verge.net.au>
 <20150917222454.GW23081@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917222454.GW23081@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 17, 2015 at 03:24:54PM -0700, Stephen Boyd wrote:
> On 09/17, Simon Horman wrote:
> > On Thu, Sep 17, 2015 at 05:45:18PM +0900, Simon Horman wrote:
> > > Hi Mike, Hi Stephen,
> > > 
> > > On Tue, Aug 04, 2015 at 02:28:16PM +0200, Geert Uytterhoeven wrote:
> > > > Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
> > > > manage a device.
> > > > 
> > > > Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
> > > > the Bus State Controller (BSC) is not power-managed by an MSTP clock,
> > > > but by a plain CPG clock (zb_clk).  Add a special case to handle this,
> > > > so the clock is properly managed, and devices connected to the BSC work
> > > > as expected.
> > > > 
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > 
> > > for one reason or another I seem to have this patch queued up in
> > > my renesas tree for v4.4, without any Acks.
> > > 
> > > I think it would be best if one of you took the patch instead.
> > > Though I'm also happy to take it with Acks.
> > > 
> > > Let me know how you would like to proceed.
> > 
> > Sorry to revise the above, I should have checked more closely
> > before I sent my previous email. I now see that I have an SoC patch
> > that depends on this one. So if possible I'd like to take this one
> > through my tree with an Ack or two.
> > 
> 
> Sure.
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks, much appreciated.
