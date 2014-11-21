From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Fri, 21 Nov 2014 15:18:58 -0500
Message-ID: <20141121201858.GB22670@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141120193804.GA7252@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:20810 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaKUUTM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 21 Nov 2014 15:19:12 -0500
Content-Disposition: inline
In-Reply-To: <20141120193804.GA7252@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

On Thu, Nov 20, 2014 at 03:38:06PM -0400, Eduardo Valentin wrote:
> Ezequiel and Jason,
> 
> On Sat, Nov 08, 2014 at 10:16:46PM -0500, Jason Cooper wrote:
> > On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> > > The Armada 375 Z1 SoC revision is no longer supported. This commit
> > > removes the quirk needed for the thermal sensor.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
> > >  drivers/thermal/armada_thermal.c                     | 20 --------------------
> > >  2 files changed, 28 deletions(-)
> > 
> > As Thomas and Ezequiel rightfully mentioned, the compatible string below
> > has never been in a dts file.  Our arch code detected the Z1, and
> > changed the compatible on the fly.  As a result, there shouldn't be any
> > dtbs in the wild with this compatible string.  If there are, it will be
> > held by the few developers (Marvell, partners) that know what they are
> > doing.
> 
> First of, I would like to mention that best thing to avoid such
> situation is to be careful when documenting dt entries that represent hw
> that no one has access to (except internal people).

Agreed, mainline support for an SoC so early in it's lifetime was new
for all of us.  Lesson learned.

> > 
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > 
> 
> OK Jason. I saw you picked patch 2. Does it mean I can queue this one? 

Yep.  Take it away.

thx,

Jason.
