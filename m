From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] thermal: armada: Remove support for A375-Z1 SoC
Date: Fri, 7 Nov 2014 07:59:50 -0500
Message-ID: <20141107125950.GK3698@titan.lakedaemon.net>
References: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1415116839-4323-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141107032619.GD3698@titan.lakedaemon.net>
 <545CBDEF.6050502@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52053 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751232AbaKGNAF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 7 Nov 2014 08:00:05 -0500
Content-Disposition: inline
In-Reply-To: <545CBDEF.6050502@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: Zhang Rui <rui.zhang@intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org

Ezequiel,

+ Mark, Grant (sorry, thought you were Cc'd on the original patch)

On Fri, Nov 07, 2014 at 09:41:19AM -0300, Ezequiel Garcia wrote:
> On 11/07/2014 12:26 AM, Jason Cooper wrote:
> > Ezequiel,
> > 
> > On Tue, Nov 04, 2014 at 01:00:38PM -0300, Ezequiel Garcia wrote:
> >> The Armada 375 Z1 SoC revision is no longer supported. This commit
> >> removes the quirk needed for the thermal sensor.
> >>
> >> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> >> ---
> >>  .../devicetree/bindings/thermal/armada-thermal.txt   |  8 --------
> >>  drivers/thermal/armada_thermal.c                     | 20 --------------------
> >>  2 files changed, 28 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> >> index 4cf0249..4698e0e 100644
> >> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> >> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> >> @@ -5,17 +5,9 @@ Required properties:
> >>  - compatible:	Should be set to one of the following:
> >>  		marvell,armada370-thermal
> >>  		marvell,armada375-thermal
> >> -		marvell,armada375-z1-thermal
> >>  		marvell,armada380-thermal
> >>  		marvell,armadaxp-thermal
> >>  
> >> -		Note: As the name suggests, "marvell,armada375-z1-thermal"
> >> -		applies for the SoC Z1 stepping only. On such stepping
> >> -		some quirks need to be done and the register offset differs
> >> -		from the one in the A0 stepping.
> >> -		The operating system may auto-detect the SoC stepping and
> >> -		update the compatible and register offsets at runtime.
> >> -
> >>  - reg:		Device's register space.
> >>  		Two entries are expected, see the examples below.
> >>  		The first one is required for the sensor register;
> > 
> > I've no problem with removing support for the z1 stepping from the
> > kernel.  However, I don't think we should erase it from binding docs.
> > I'm not sure what the DT maintainers think is the appropriate action
> > here, but I'm thinking we could add a 'Deprecated' section at the end of
> > the doc and move these hunks there.  With a little rewording of course.
> > 
> > I'm primarily concerned about users with older dtbs looking to upgrade,
> > "Hey, wtf is marvell,armada375-z1-thermal?  I looked in the binding docs
> > and there's nothing there, do I replace it with marvell,armada375-thermal?"
> > 
> 
> We can do that if you think it's really useful. However, I think we've
> designed this so *nobody* would actually have to put the z1 compatible
> string. The mvebu quirk (tries) to auto-detect it from the revision
> register and hot fix the compatible string.
> 
> Moreover, I'm not at all sure *anyone* would have a Z1 board except
> early developers like us. Am I being too naive here?

I'm primarily concerned about dtbs in the wild which have that
compatible string.  But as you mention, and a quick grep proves, this
compatible string was never in a dts{i} file.  At least not in the
kernel tree.

It's not a rush, so I'd like to hear from Mark/Grant what they prefer
for this sort of situation.  It'll be in the git history either way, but
not everyone goes there when the current docs don't mention something.
:)

thx,

Jason.
