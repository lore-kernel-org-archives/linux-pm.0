From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
Date: Wed, 16 Jul 2014 08:45:22 -0400
Message-ID: <20140716124522.GV13108@titan.lakedaemon.net>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140713222223.GH13108@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40906 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbaGPMph (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 08:45:37 -0400
Content-Disposition: inline
In-Reply-To: <20140713222223.GH13108@titan.lakedaemon.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Sun, Jul 13, 2014 at 06:22:23PM -0400, Jason Cooper wrote:
> Rafael, Daniel,
> 
> On Wed, Jul 09, 2014 at 03:40:04PM +0200, Thomas Petazzoni wrote:
> > Hello,
> > 
> > Here comes the second version of the cpuidle support for Armada 370
> > and Armada 38x. This series has been tested on the following
> > configurations:
> > 
> >  * Armada XP, LE and BE, to verify that the existing, SMP, cpuidle and
> >    CPU hotplug functionalities are still working.
> > 
> >  * Armada 375, Z1 and A0, LE and BE, to verify that the existing SMP
> >    functionality is still working (SMP support on Armada 375 Z1 is
> >    affected by this series).
> > 
> >  * Armada 370, LE and BE, to verify that the newly introduced cpuidle
> >    functionality is working fine.
> > 
> >  * Armada 38x, LE and BE, to verify that the existing SMP
> >    functionality, and the newly introduced cpuidle functionality is
> >    working fine.
> > 
> > We are hoping to see this patch series merged for 3.17.
> > 
> > Most patches are touching only arch/arm/mach-mvebu/ code so they
> > should be handled by the mvebu maintainers. However, patches 11-14 are
> > touching the mvebu cpuidle driver, with a possible issue on patch 11,
> > which touches both the cpuidle driver and the mach-mvebu code in order
> > to rename the driver without breaking functionality (if needed, we can
> > decide to split the commits, it would break functionality temporarly,
> > but not buildability).
> 
> Would one or both of you mind Acking this series so we can keep it
> together?

Ok, so I applied patch #10 to mvebu/dt, and #17 to mvebu/defconfig.  I
was then going to apply the rest into a tentative topic branch
(mvebu/soc-cpuidle), but it failed when based on v3.16-rc1, and it
failed when based on mvebu/soc.

Could you please outline the deps so I can get this into -next?  We're
really cutting the deadline close for v3.17, and I'd like to already
have some time in -next if/when cpuidle Ack's it going through the mvebu
tree.

thx,

Jason.
