From: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Tue, 21 Jul 2015 13:57:51 +0300
Message-ID: <20150721105751.GK6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo>
 <20150720095941.GZ6287@tbergstrom-lnx.Nvidia.com>
 <20150720131410.GA1098@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150720131410.GA1098@ulmo>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 20, 2015 at 03:14:25PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 20, 2015 at 12:59:41PM +0300, Peter De Schrijver wrote:
> > On Fri, Jul 17, 2015 at 01:31:24PM +0200, Thierry Reding wrote:
> > > > Old Signed by an unknown key
> > > 
> > > On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> > > > On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> > > > > > Old Signed by an unknown key
> > > > > 
> > > > > On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> > > > > > The Tegra memory controller implements a flush feature to flush pending
> > > > > > accesses and prevent further accesses from occurring. This feature is
> > > > > > used when powering down IP blocks to ensure the IP block is in a good
> > > > > > state. The flushes are organised by software groups and IP blocks are
> > > > > > assigned in hardware to the different software groups. Add helper
> > > > > > functions for requesting a handle to an MC flush for a given
> > > > > > software group and enabling/disabling the MC flush itself.
> > > > > > 
> > > > > > This is based upon a change by Vince Hsu <vinceh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>.
> > > > > > 
> > > > > > Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > > > > > ---
> > > > > >  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/memory/tegra/mc.h |   2 +
> > > > > >  include/soc/tegra/mc.h    |  34 ++++++++++++++
> > > > > >  3 files changed, 146 insertions(+)
> > > > > 
> > > > > Do we know if this is actually necessary? I remember having a discussion
> > > > > with Arnd Bergmann a while ago, and the Linux driver model kind of
> > > > > assumes that by the time a device is disabled all outstanding accesses
> > > > > will have stopped.
> > > > > 
> > > > > Do we have a way to determine that this even makes a difference? Can we
> > > > > trigger a case where not doing this would cause breakage and see that
> > > > > adding this fixes that particular issue?
> > > > > 
> > > > 
> > > > Most likely it is. The memory controller can still be processing requests
> > > > when the peripheral domain is powergated. This would mean the response cannot
> > > > be delivered in that case. So we need to be sure there are no outstanding
> > > > requests before shutting down the domain.
> > > 
> > > My point is that that's the driver's responsibility anyway, hence making
> > > the explicit flush unnecessary.
> > > 
> > 
> > The peripheral driver doesn't know how long a request is queued in the memory
> > controller. So it can't be responsible for ensuring this.
> 
> Surely whenever the peripheral reports that the operation is done (be
> that via some DMA controller interrupt or syncpoint increment) the
> operation would have flushed from the memory controller. Drivers are
> already supposed to make sure this is the case when they are removed or
> suspended, so this would mean that we'd be adding all this code for no
> real gain.
> 

That highly depends on how the peripheral is implemented. I'm not sure we
can assume things work this way.

> It would also explain why we're currently not seeing any such problems.
> 

I don't think we are doing agressive enough powergating today to see any
problems. That might also mean we're just lucky.

Cheers,

Peter.
