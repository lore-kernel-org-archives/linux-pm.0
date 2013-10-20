From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/4] cpufreq: Add a cpufreq driver for Marvell Dove
Date: Sun, 20 Oct 2013 10:42:01 +0200
Message-ID: <20131020084201.GA19257@lunn.ch>
References: <1382186261-14482-1-git-send-email-andrew@lunn.ch>
 <1382186261-14482-2-git-send-email-andrew@lunn.ch>
 <20131019230908.GA10934@w500.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:42647 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3JTIqj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Oct 2013 04:46:39 -0400
Content-Disposition: inline
In-Reply-To: <20131019230908.GA10934@w500.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Luka Perkov <luka@openwrt.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Sun, Oct 20, 2013 at 01:09:08AM +0200, Luka Perkov wrote:
> Hi Andrew,
> 
> On Sat, Oct 19, 2013 at 02:37:38PM +0200, Andrew Lunn wrote:
> > The Marvell Dove SoC can run the CPU at two frequencies. The high
> > frequencey is from a PLL, while the lower is the same as the DDR
> > clock. Add a cpufreq driver to swap between these frequences.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >  drivers/cpufreq/Kconfig.arm    |   7 ++
> >  drivers/cpufreq/Makefile       |   1 +
> >  drivers/cpufreq/dove-cpufreq.c | 276 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 284 insertions(+)
> >  create mode 100644 drivers/cpufreq/dove-cpufreq.c
> 
> ...
> 
> > --- /dev/null
> > +++ b/drivers/cpufreq/dove-cpufreq.c
> > @@ -0,0 +1,276 @@
> > +/*
> > + *	dove_freq.c: cpufreq driver for the Marvell dove
> > + *
> > + *	Copyright (C) 2013 Andrew Lunn <andrew@lunn.ch>
> > + *
> > + *	This program is free software; you can redistribute it and/or
> > + *	modify it under the terms of the GNU General Public License
> > + *	as published by the Free Software Foundation; either version
> > + *	2 of the License, or (at your option) any later version.
> > + */
> > +
> > +#define DEBUG
> 
> It seems to me that this define is not used at all...

Hi Luke

Correct. Its left over from my debugging. I will collect more comments
and then remove it in a v2 patchset.

    Thanks
	Andrew
