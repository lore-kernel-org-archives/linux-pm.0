From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [FOR DISCUSSION 0/9] Dove PMU support
Date: Fri, 13 Mar 2015 13:26:17 +0100
Message-ID: <3456973.vXF9zkXSFZ@wuerfel>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk> <5579362.zNki0VzW6v@wuerfel> <20150313121126.GE8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:55241 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465AbbCMM1R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 08:27:17 -0400
In-Reply-To: <20150313121126.GE8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Friday 13 March 2015 12:11:27 Russell King - ARM Linux wrote:
> On Fri, Mar 13, 2015 at 12:57:11PM +0100, Arnd Bergmann wrote:
> > On Thursday 12 March 2015 18:30:21 Russell King - ARM Linux wrote:
> > >  Documentation/devicetree/bindings/soc/dove/pmu.txt |  49 +++
> > >  arch/arm/boot/dts/dove.dtsi                        |  25 ++
> > >  arch/arm/mach-mvebu/Kconfig                        |   1 +
> > >  drivers/base/platform.c                            |   2 +
> > >  drivers/base/power/common.c                        |  15 +
> > >  drivers/base/power/domain.c                        |  33 +-
> > >  drivers/soc/Makefile                               |   1 +
> > >  drivers/soc/dove/Makefile                          |   1 +
> > >  drivers/soc/dove/pmu.c                             | 399 +++++++++++++++++++++
> > >  include/linux/pm.h                                 |   1 +
> > >  include/linux/pm_domain.h                          |   4 +
> > >  include/linux/soc/dove/pmu.h                       |   6 +
> > >  12 files changed, 532 insertions(+), 5 deletions(-)
> > 
> > I see add the header file and the global dove_init_pmu() function,
> > but I don't see a caller of that function. Is that intentional, or
> > did you accidentally leave out another patch that you meant to include?
> 
> I kind'a did - it needs an explicit call from arch/arm/mach-mvebu/dove.c
> which I haven't added even in my tree (because I don't use that path,
> even when I test DT booting - I still use most of the arch/arm/mach-dove
> code when DT booting.)  I'll add that now.
> 
> Of course, I also have a patch which adds legacy support to
> arch/arm/mach-dove, but I've assumed you're not interested in that...

You mean legacy support in mach-mvebu?

I don't mind that at all, it was the mvebu maintainers that decided
it would be best to combine the multiplatform and DT work in order
to simplify both. I've also sent a patch set that moves mach-dove
into multiplatform, which is a different way of doing the same thing.

	Arnd
