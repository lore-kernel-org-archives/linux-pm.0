From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RFC 5/6] staging: board: Add support for devices with
 complex dependencies
Date: Fri, 3 Apr 2015 18:07:57 +0100
Message-ID: <20150403170757.GB13898@n2100.arm.linux.org.uk>
References: <1428064923-24950-1-git-send-email-geert+renesas@glider.be>
 <1428064923-24950-6-git-send-email-geert+renesas@glider.be>
 <20150403125727.GT10964@mwanda>
 <CAMuHMdVhX-MrFxeW5j98NLaQQtJ+DToxkz2Z1+SRSs7YF27RDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVhX-MrFxeW5j98NLaQQtJ+DToxkz2Z1+SRSs7YF27RDw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, driverdevel <devel@driverdev.osuosl.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Linux PM list <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <damm+renesas@opensource.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 03, 2015 at 03:27:40PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 3, 2015 at 2:57 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >> +     error = clk_register_clkdev(clk, bsc->con_id, bsc->dev_id);
> >> +     if (error)
> >> +             pr_err("Failed to register clock %s (%d)\n", bsc->clk, error);
> >> +             return error;
> >
> > Missing curly braces.  Also it's weird that don't we need a clk_put()
> > on the error patch as well as the success path?
> 
> Thanks!
> 
> So it worked only by accident: with the new per-user struct clk instances
> clk_put() must not be called if clk_register_clkdev() succeeded.

Yes, that's because the per-user struct clk messed quite a lot of things
up - the patches were /not/ well tested before they went in.

That's no excuse to work around the breakage they caused though.

That said, I never did post the work I did earlier this month to fix the
problems in clkdev which those patches caused... so, I guess it's time
to post them and rush them in for the 4.1 merge window...  (frankly, the
per-user struct clk patches should've been reverted.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
