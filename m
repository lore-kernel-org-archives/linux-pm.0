From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Wed, 24 Aug 2016 16:25:40 +0800
Message-ID: <1472027140.2682.49.camel@intel.com>
References: <57726196.5060909@free.fr> <8406200.nXRkviT67W@wuerfel>
         <1471606196.2691.58.camel@intel.com> <3377280.mzxhCYOnLL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31838 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755196AbcHXI0D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Aug 2016 04:26:03 -0400
In-Reply-To: <3377280.mzxhCYOnLL@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 一, 2016-08-22 at 23:00 +0200, Arnd Bergmann wrote:
> On Friday, August 19, 2016 7:29:56 PM CEST Zhang Rui wrote:
> > 
> > On 二, 2016-07-26 at 14:13 +0200, Arnd Bergmann wrote:
> > > 
> > > On Monday, July 25, 2016 11:48:47 AM CEST Mason wrote:
> > > > 
> > > > 
> > > > On 25/07/2016 10:52, Arnd Bergmann wrote:
> > > > 
> > > > > 
> > > > > 
> > > > > On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > Moving the SIMPLE_DEV_PM_OPS macro outside the
> > > > > > CONFIG_PM_SLEEP
> > > > > > guard
> > > > > > would unconditionally define a struct dev_pm_ops, which
> > > > > > just
> > > > > > wastes
> > > > > > space when CONFIG_PM_SLEEP is undefined (if I'm not
> > > > > > mistaken).
> > > > > > 
> > > > > > That's why I put SIMPLE_DEV_PM_OPS inside the
> > > > > > CONFIG_PM_SLEEP
> > > > > > guard.
> > > > > If you want to avoid the extra few bytes, just use the trick
> > > > > I
> > > > > suggested:
> > > > > 
> > > > >       .pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm :
> > > > > NULL,
> > > > This would achieve the same result as the solution I proposed
> > > > in my v2 patch, right?
> > > > 
> > > > So you're saying you prefer the IS_ENABLED macro over using
> > > > #ifdef ... #else define stuff as NULL #endif
> > > > 
> > > > Did I get that right?
> > > Yes, but I'd also prefer not to hide the operations structure
> > > at all and just rely on the __maybe_unused (ideally) or
> > > #ifdef (not as good, but commonly used) to leave out the
> > > functions.
> > > 
> > IMO, the typical way is to use #ifdef for the pm callbacks, and
> > leave
> > SIMPLE_DEV_PM_OPS outside the #ifdef.
> > For example, drivers/ata/ahci_imx.c.
> > 
> Lots of drivers do it like that, the main downside I see is that a
> lot of them also get it wrong and use incorrect #ifdef guards,
> either checking the wrong Kconfig symbol,

This also happens when IS_ENABLED macro is used.

>  or hiding the wrong
> subset of functions.
> 
This also sounds a driver bug to me, and the driver should get fixed.
For us, it's not a problem if we do it right here, right? :)

thanks,
rui
