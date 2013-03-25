From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 16:28:21 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1303251616070.1372@syhkavp.arg>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:55290 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029Ab3CYU2Z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 16:28:25 -0400
Received: by mail-ve0-f181.google.com with SMTP id pa12so3714303veb.40
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 13:28:24 -0700 (PDT)
In-Reply-To: <51509873.1010408@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On Mon, 25 Mar 2013, Daniel Lezcano wrote:

> On 03/25/2013 07:10 PM, Andrew Lunn wrote:
> > On Mon, Mar 25, 2013 at 06:55:32PM +0100, Daniel Lezcano wrote:
> >> The init and exit routine for most of the drivers are the same,
> >> that is register the driver and register the device.
> >>
> >> Provide a common function to do that in the cpuidle driver for ARM,
> >> so we can get rid of a lot of code duplication in the different SOC
> >> cpuidle drivers.
> > 
> > Hi Daniel
> > 
> > Please could you add a comment in the code about which piece is
> > specific to ARM, because its not obvious to me. Its not like there is
> > a reference to WFI for example. It looks like this code could go in
> > drivers/cpuidle/cpuidle.c
> 
> Yes, I agree. At the first glance, the code, as it is, could go in this
> file but more ARM specific code will be moved to this ARM generic code
> driver like device tree description and couple idle states. The init
> function would be more arch specific then.
> 
> For this reason, I think it is reasonable to move to
> arm/kernel/cpuidle.c rather than drivers/cpuidle/cpuidle.c first.

No.

Please move things under drivers/cpuidle/ upfront.

We do want drivers to be gathered according to their purpose and 
subsystem, not according to the architecture they belong to.

This is a simple maintenance optimization to do so.

The reason is when someone wishes to improve the subsystem then that 
someone who might know nothing about the ARM or other architectures 
won't have to look for obscure drivers buried into arch specific 
directories.  When things are gathered under a common directory it is 
then much easier to perform wide ranging changes to a subsystem.

And for those who do know the ARM architecture and wish to modify the 
ARM driver it is not that hard to locate the driver once.

The "downside" for you might be that the activity under drivers/cpuidle/ 
is more closely scrutinized by more people.  But that isn't a bad thing 
either.

> In the future, when all the ARM cpuidle driver will be fully
> consolidated, that will be easier to identify the common parts across
> the different arch and then move them to the generic framework.

Nothing prevents you from doing that consolidation work right in 
drivers/cpuidle/.


Nicolas
