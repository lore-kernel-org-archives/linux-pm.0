From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH for 3.9 0/2] thermal: Marvell SoC thermal formula fixes
Date: Mon, 25 Mar 2013 09:50:27 +0100
Message-ID: <20130325085027.GG5627@lunn.ch>
References: <1363954983-30822-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364199456.2465.46.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:58158 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757697Ab3CYIug (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 25 Mar 2013 04:50:36 -0400
Content-Disposition: inline
In-Reply-To: <1364199456.2465.46.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jason Cooper <jason@lakedaemon.net>, Lior Amsalem <alior@marvell.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>

On Mon, Mar 25, 2013 at 04:17:36PM +0800, Zhang Rui wrote:
> Hi,
> 
> Ezequiel, thanks for your patch.
> 
> On Fri, 2013-03-22 at 09:23 -0300, Ezequiel Garcia wrote:
> > This is a small patchset that fixes thermal sensor formulas for Kirkwood
> > and Dove thermal driver. The old formulas had been taken from 88AP510 public
> > datasheets which appears to be slightly wrong.
> > 
> > The current formula comes from Marvell internal documentation
> > and has been confirmed by Lior Amsalem.
> > 
> > This has been tested on a Kirkwood board (Openblocks A6) only.
> > If at all possible, I would like to have the Dove fix tested
> > before this is merged.
> > 
> > Please note that this fix was previously part of a bigger thermal
> > patchset [1]. I've taken this out so it can be applied on v3.9 first.
> > 
> > [1] http://www.spinics.net/lists/arm-kernel/msg231697.html
> > 
> > Ezequiel Garcia (2):
> >   thermal: kirkwood: Fix thermal sensor formula
> >   thermal: dove: Fix thermal sensor formula
> > 
> 
> Nobuhiro and Andrew,
> 
> what do you think of these patches?
> As I have no idea of the hardware details, I need your comments before
> applying them.

I have no access to the internal documentation, so i cannot say if
this formula is correct or not. However, Lior Amsalem should be in the
know.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew
