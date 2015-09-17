From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 15/16] clk: shmobile: mstp: Consider "zb_clk" suitable
 for power management
Date: Thu, 17 Sep 2015 17:53:14 +0900
Message-ID: <20150917085314.GA29509@verge.net.au>
References: <1438691297-29235-1-git-send-email-geert+renesas@glider.be>
 <1438691297-29235-16-git-send-email-geert+renesas@glider.be>
 <20150917084446.GA8197@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150917084446.GA8197@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 17, 2015 at 05:45:18PM +0900, Simon Horman wrote:
> Hi Mike, Hi Stephen,
> 
> On Tue, Aug 04, 2015 at 02:28:16PM +0200, Geert Uytterhoeven wrote:
> > Currently the CPG/MSTP Clock Domain code looks for MSTP clocks to power
> > manage a device.
> > 
> > Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
> > the Bus State Controller (BSC) is not power-managed by an MSTP clock,
> > but by a plain CPG clock (zb_clk).  Add a special case to handle this,
> > so the clock is properly managed, and devices connected to the BSC work
> > as expected.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> for one reason or another I seem to have this patch queued up in
> my renesas tree for v4.4, without any Acks.
> 
> I think it would be best if one of you took the patch instead.
> Though I'm also happy to take it with Acks.
> 
> Let me know how you would like to proceed.

Sorry to revise the above, I should have checked more closely
before I sent my previous email. I now see that I have an SoC patch
that depends on this one. So if possible I'd like to take this one
through my tree with an Ack or two.

Thanks in advance!

> > ---
> > v4:
> >   - Add Reviewed-by,
> > 
> > v3:
> >   - Use "CPG/MSTP Clock Domain" instead of "CPG Clock Domain",
> > 
> > v2:
> >   - New.
> > ---
> >  drivers/clk/shmobile/clk-mstp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
> > index b1df7b2f1e970adb..a117c3f0f257b5e1 100644
> > --- a/drivers/clk/shmobile/clk-mstp.c
> > +++ b/drivers/clk/shmobile/clk-mstp.c
> > @@ -259,6 +259,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
> >  					    "renesas,cpg-mstp-clocks"))
> >  			goto found;
> >  
> > +		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/
> > +		if (!strcmp(clkspec.np->name, "zb_clk"))
> > +			goto found;
> > +
> >  		of_node_put(clkspec.np);
> >  		i++;
> >  	}
> > -- 
> > 1.9.1
> > 
