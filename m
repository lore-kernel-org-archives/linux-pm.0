From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 5/6] ARM: mvebu: Add thermal quirk for the Armada 375
 DB board
Date: Wed, 16 Apr 2014 12:55:48 -0400
Message-ID: <20140416165548.GI28159@titan.lakedaemon.net>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <534EA8C9.7010907@gmail.com>
 <20140416180315.5153c3f7@skate>
 <20140416160824.GA14842@lunn.ch>
 <20140416181938.6e8f8f4b@skate>
 <20140416163447.GB14842@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11722 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbaDPQ4L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 12:56:11 -0400
Content-Disposition: inline
In-Reply-To: <20140416163447.GB14842@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

On Wed, Apr 16, 2014 at 06:34:47PM +0200, Andrew Lunn wrote:
> > So, I would like to see the Z1 stepping supported for now, and have the
> > freedom to remove its support later once we are all ready to switch to
> > A0.
> 
> Hi Thomas
> 
> Sounds like a good plan. Try to keep all the mess to support Z1 in one
> place so that it can be easily taken out once people have A0.

Agreed.  Thomas, do you think you'll be able to get a definitive answer
from Marvell re the number of Z1 boards in the wild?  Once they've moved
to the A0, of course.

Unless we can get a hard answer on that, I doubt we'll ever withdraw
support for the Z1.  Not that that's a bad thing, just trying to be
realistic.  If we add code, expect to support it.

And keeping it all in one place is kind of an impossibility.  Just for
thermal Z1, there are changes to the binding docs, the thermal driver,
and the soc code.

I'd say it's more important to keep it clean, with dts files targeting
the A0+ SoCs, and the Z1 being the exception case(s).

thx,

Jason.
