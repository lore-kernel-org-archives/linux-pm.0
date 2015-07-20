From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH V3 02/19] memory: tegra: Add MC flush support
Date: Mon, 20 Jul 2015 12:59:41 +0300
Message-ID: <20150720095941.GZ6287@tbergstrom-lnx.Nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-3-git-send-email-jonathanh@nvidia.com>
 <20150717095754.GG3057@ulmo>
 <20150717102049.GQ6287@tbergstrom-lnx.Nvidia.com>
 <20150717113124.GP3057@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18231 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319AbbGTJ7s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 05:59:48 -0400
Content-Disposition: inline
In-Reply-To: <20150717113124.GP3057@ulmo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, Prashant Gaikwad <pgaikwad@nvidia.com>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Hans de Goede <hdegoede@redhat.com>, Tejun Heo <tj@kernel.org>, Vince Hsu <vinceh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-tegra@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org

On Fri, Jul 17, 2015 at 01:31:24PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Jul 17, 2015 at 01:20:49PM +0300, Peter De Schrijver wrote:
> > On Fri, Jul 17, 2015 at 11:57:55AM +0200, Thierry Reding wrote:
> > > > Old Signed by an unknown key
> > > 
> > > On Mon, Jul 13, 2015 at 01:39:40PM +0100, Jon Hunter wrote:
> > > > The Tegra memory controller implements a flush feature to flush pending
> > > > accesses and prevent further accesses from occurring. This feature is
> > > > used when powering down IP blocks to ensure the IP block is in a good
> > > > state. The flushes are organised by software groups and IP blocks are
> > > > assigned in hardware to the different software groups. Add helper
> > > > functions for requesting a handle to an MC flush for a given
> > > > software group and enabling/disabling the MC flush itself.
> > > > 
> > > > This is based upon a change by Vince Hsu <vinceh@nvidia.com>.
> > > > 
> > > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > > ---
> > > >  drivers/memory/tegra/mc.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/memory/tegra/mc.h |   2 +
> > > >  include/soc/tegra/mc.h    |  34 ++++++++++++++
> > > >  3 files changed, 146 insertions(+)
> > > 
> > > Do we know if this is actually necessary? I remember having a discussion
> > > with Arnd Bergmann a while ago, and the Linux driver model kind of
> > > assumes that by the time a device is disabled all outstanding accesses
> > > will have stopped.
> > > 
> > > Do we have a way to determine that this even makes a difference? Can we
> > > trigger a case where not doing this would cause breakage and see that
> > > adding this fixes that particular issue?
> > > 
> > 
> > Most likely it is. The memory controller can still be processing requests
> > when the peripheral domain is powergated. This would mean the response cannot
> > be delivered in that case. So we need to be sure there are no outstanding
> > requests before shutting down the domain.
> 
> My point is that that's the driver's responsibility anyway, hence making
> the explicit flush unnecessary.
> 

The peripheral driver doesn't know how long a request is queued in the memory
controller. So it can't be responsible for ensuring this.

Cheers,

Peter.
