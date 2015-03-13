From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [FOR DISCUSSION 0/9] Dove PMU support
Date: Fri, 13 Mar 2015 12:11:27 +0000
Message-ID: <20150313121126.GE8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <5579362.zNki0VzW6v@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:42805 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbCMMLk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2015 08:11:40 -0400
Content-Disposition: inline
In-Reply-To: <5579362.zNki0VzW6v@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Fri, Mar 13, 2015 at 12:57:11PM +0100, Arnd Bergmann wrote:
> On Thursday 12 March 2015 18:30:21 Russell King - ARM Linux wrote:
> > This is a re-posting of the patch set which I posted almost 10 months
> > ago to support the Dove PMU, with a few additional changes.  This set
> > is based upon 3.19.
> > 
> > In this set are:
> > 
> > * two patches which Rafael originally acked, but there was indecision
> >   last time around how to handle them due to potential conflicts with
> >   work that Ulf was doing.  These patches have been updated to apply
> >   cleanly to 3.19.  I don't know if people want to take these as
> >   fixes to the PM domain code or not (hence why I'm posting this
> >   series during the merge window - if it weren't for this, I'd hold
> >   it off.)
> 
> I don't seem to have received the first three patches for some reason.
> Can you check if you got them back from the mailing list?

That's because you're not listed as the maintainer for PM domain stuff,
and I forgot to ensure lakml was copied on all patches.

> >  Documentation/devicetree/bindings/soc/dove/pmu.txt |  49 +++
> >  arch/arm/boot/dts/dove.dtsi                        |  25 ++
> >  arch/arm/mach-mvebu/Kconfig                        |   1 +
> >  drivers/base/platform.c                            |   2 +
> >  drivers/base/power/common.c                        |  15 +
> >  drivers/base/power/domain.c                        |  33 +-
> >  drivers/soc/Makefile                               |   1 +
> >  drivers/soc/dove/Makefile                          |   1 +
> >  drivers/soc/dove/pmu.c                             | 399 +++++++++++++++++++++
> >  include/linux/pm.h                                 |   1 +
> >  include/linux/pm_domain.h                          |   4 +
> >  include/linux/soc/dove/pmu.h                       |   6 +
> >  12 files changed, 532 insertions(+), 5 deletions(-)
> 
> I see add the header file and the global dove_init_pmu() function,
> but I don't see a caller of that function. Is that intentional, or
> did you accidentally leave out another patch that you meant to include?

I kind'a did - it needs an explicit call from arch/arm/mach-mvebu/dove.c
which I haven't added even in my tree (because I don't use that path,
even when I test DT booting - I still use most of the arch/arm/mach-dove
code when DT booting.)  I'll add that now.

Of course, I also have a patch which adds legacy support to
arch/arm/mach-dove, but I've assumed you're not interested in that...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
