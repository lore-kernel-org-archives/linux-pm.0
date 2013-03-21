From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 05/16] thermal: mvebu: Fix valid check for thermal
 register
Date: Thu, 21 Mar 2013 16:06:16 -0400
Message-ID: <20130321200616.GD13280@titan.lakedaemon.net>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321143539.GV13280@titan.lakedaemon.net>
 <20130321151609.GA24246@localhost>
 <20130321152400.GX13280@titan.lakedaemon.net>
 <20130321195708.GA2648@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:17658 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752637Ab3CUUG3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 16:06:29 -0400
Content-Disposition: inline
In-Reply-To: <20130321195708.GA2648@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <florian@openwrt.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Lior Amsalem <alior@marvell.com>

On Thu, Mar 21, 2013 at 04:57:09PM -0300, Ezequiel Garcia wrote:
> On Thu, Mar 21, 2013 at 11:24:00AM -0400, Jason Cooper wrote:
> > On Thu, Mar 21, 2013 at 12:16:10PM -0300, Ezequiel Garcia wrote:
> > > Hi Jason,
> > > 
> > > On Thu, Mar 21, 2013 at 10:35:39AM -0400, Jason Cooper wrote:
> > > > On Wed, Mar 20, 2013 at 07:36:26PM -0300, Ezequiel Garcia wrote:
> > > > > The correct value is obtain by first shifting the register by the offset,
> > > > > later applying the valid mask and finally invert the result.
> > > > > This check was lacking an extra parenthesis to be strictly correct.
> > > > > 
> > > > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > > > ---
> > > > >  drivers/thermal/mvebu_thermal.c |    4 ++--
> > > > >  1 files changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > For the next version of this series, could you please put this fix first
> > > > in the series?  In this state, it can't be applied to v3.9-rcX, nor
> > > > -stable.
> > > > 
> > > 
> > > Given we're still discussing the aproach of this patchset.
> > > I think I prefer to send the fixes now, not as part of the
> > > current series but as independent patches.
> > > 
> > > What do you think?
> > 
> > I agree.
> > 
> 
> I have a question about this though: Who should pick patches for
> drivers/thermal/{dove,kirkwood,mvebu} ? You or Zhang?

That's up to Zhang.  If he has a lot of changes going on this cycle,
he'll probably want to take them through his tree.  However, if he
doesn't, and we have a lot of stuff depending on it (the rest of your
series), he'll probably be ok with Ack'ing it and letting us take it
through our tree.

thx,

Jason.
