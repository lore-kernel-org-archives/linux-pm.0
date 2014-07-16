From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCHv2 00/17] cpuidle for Marvell Armada 370 and 38x
Date: Wed, 16 Jul 2014 09:16:58 -0400
Message-ID: <20140716131658.GB13108@titan.lakedaemon.net>
References: <1404913221-17343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140713222223.GH13108@titan.lakedaemon.net>
 <20140716124522.GV13108@titan.lakedaemon.net>
 <20140716145905.33105756@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:58581 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932748AbaGPNRK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 09:17:10 -0400
Content-Disposition: inline
In-Reply-To: <20140716145905.33105756@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

On Wed, Jul 16, 2014 at 02:59:05PM +0200, Thomas Petazzoni wrote:
> Dear Jason Cooper,
> 
> On Wed, 16 Jul 2014 08:45:22 -0400, Jason Cooper wrote:
> 
> > Ok, so I applied patch #10 to mvebu/dt, and #17 to mvebu/defconfig.  I
> > was then going to apply the rest into a tentative topic branch
> > (mvebu/soc-cpuidle), but it failed when based on v3.16-rc1, and it
> > failed when based on mvebu/soc.
> > 
> > Could you please outline the deps so I can get this into -next?  We're
> > really cutting the deadline close for v3.17, and I'd like to already
> > have some time in -next if/when cpuidle Ack's it going through the mvebu
> > tree.
> 
> As explained in the cover letter:
> 
>  * Series rebased on top of mvebu/fixes + mvebu/soc to take into
>    account the conflicts with the changes already merged on the PMSU
>    code.

Ok, I've tentatively applied this series to mvebu/soc-cpuidle with a dep
on mvebu/soc and mvebu/fixes.  It'll be in -next tonight.

thx,

Jason.
