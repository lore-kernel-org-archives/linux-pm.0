From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Fri, 3 Apr 2015 18:04:08 +0100
Message-ID: <20150403170407.GA13898@n2100.arm.linux.org.uk>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <20150403125727.GT10964@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150403125727.GT10964@mwanda>
Sender: linux-sh-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, devel@driverdev.osuosl.org, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-pm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, Magnus Damm <damm+renesas@opensource.se>, linux-kernel@vger.kernel.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 03, 2015 at 03:57:27PM +0300, Dan Carpenter wrote:
> On Fri, Apr 03, 2015 at 02:42:02PM +0200, Geert Uytterhoeven wrote:
> > +int __init board_staging_register_clock(const struct board_staging_clk *bsc)
> > +{
> > +	struct clk *clk;
> > +	int error;
> > +
> > +	pr_debug("Registering clock %s for con_id %s dev_id %s\n", bsc->clk,
> > +		 bsc->con_id, bsc->dev_id);
> > +	clk = clk_get(NULL, bsc->clk);
> > +	if (IS_ERR(clk)) {
> > +		error = PTR_ERR(clk);
> > +		pr_err("Failed to get clock %s (%d)\n", bsc->clk, error);
> > +		return error;
> > +	}
> > +
> > +	error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> > +	if (error)
> > +		pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> > +		return error;
> 
> Missing curly braces.  Also it's weird that don't we need a clk_put()
> on the error patch as well as the success path?

What's also concerning is that this is an abuse of this.

clk_register_clkdev() is supposed to be used with clocks created with
the CCF functions, it's not for creating aliases.

We have clk_add_alias() which does *everything* that this function does,
only in a less buggy way.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
