From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 4/6] thermal: armada: Support Armada 375 SoC
Date: Wed, 16 Apr 2014 12:40:16 -0400
Message-ID: <20140416164016.GH28159@titan.lakedaemon.net>
References: <1397657720-10893-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1397657720-10893-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140416153819.GF28159@titan.lakedaemon.net>
 <20140416154927.GA1892@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43747 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbaDPQkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 12:40:51 -0400
Content-Disposition: inline
In-Reply-To: <20140416154927.GA1892@arch.cereza>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhang Rui <rui.zhang@intel.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>

On Wed, Apr 16, 2014 at 12:49:27PM -0300, Ezequiel Garcia wrote:
> On Apr 16, Jason Cooper wrote:
> > On Wed, Apr 16, 2014 at 11:15:18AM -0300, Ezequiel Garcia wrote:
> > > +	/* This is only needed on A375 Z1 SoC silicon revision */
> > > +	reg |= A375_Z1_WORKAROUND_BIT;
> > 
> > and this seem to be the only differences between the two init functions.
> > 
> > It also appears to be the only reason for having two data structs below.
> > Is it worth checking for the compatible string in the init function so
> > you only have one init and one data struct?
> > 
> 
> Yes, thought about it at one point but I guess it seemed to me cleaner
> this way.
> 
> I'll squash it if you think keeping two structs is stupid bloat.

Well, it's really up to the thermal maintainer.  Either way will work.
I personally think it's easier to grok using the compatible string.
Unfortunately, you're going to have the either check it twice, or set a
variable.

thx,

Jason.
