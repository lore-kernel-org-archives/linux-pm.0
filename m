From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/2] ARM: shmobile: r8a7790: implement CPU clock
 scaling for CPUFreq
Date: Fri, 27 Sep 2013 06:40:11 +0900
Message-ID: <20130926214008.GA19788@verge.net.au>
References: <Pine.LNX.4.64.1305211601180.2863@axis700.grange>
 <20130525013445.GE24005@verge.net.au>
 <20130925045007.GC24243@verge.net.au>
 <Pine.LNX.4.64.1309261052580.11968@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1309261052580.11968@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 26, 2013 at 10:56:02AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> Thanks for following on this.
> 
> On Wed, 25 Sep 2013, Simon Horman wrote:
> 
> > On Sat, May 25, 2013 at 10:34:45AM +0900, Simon Horman wrote:
> > > On Tue, May 21, 2013 at 04:07:46PM +0200, Guennadi Liakhovetski wrote:
> > > > This patch adds support for the Z-clock on r8a7790 SoCs, which is driving
> > > > the Cortex A15 core, and a "cpufreq-cpu0" platform device. Adding an
> > > > "operating-points" property to the CPU0 DT node and a regulator, this
> > > > patch allows platforms to use the generic cpufreq-cpu0 driver to use
> > > > SoC's DVFS capabilities.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > > ---
> > > > 
> > > > v2:
> > > > 1. a typo in the r8a7790 datasheet confused me to implement kick-bit 
> > > > handling wrongly, this is fixed in this version
> > > > 2. patch 3 merged with this one
> > > > 
> > > > Same comments, as to v1 of this series, apply.
> > > 
> > > Magnus,
> > > 
> > > could you please review this series?
> > 
> > I have marked this patch as deferred in the patch tracker
> > as it has been rotting there for several months now.
> > 
> > I will need the following before taking it into the tree:
> > 1. Repost, rebased if needed.
> > 2. An ack from Magnus or indication from him that someone else should
> >    review it.
> 
> This patch is superseded by my recent patches
> 
> [PATCH 3/4] ARM: shmobile: r8a7790: add CPUFreq clock support
> [PATCH/RFC 4/4] ARM: shmobile: lager: add CPUFreq support

Thanks, noted.
