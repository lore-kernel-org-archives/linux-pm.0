From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Mon, 22 Aug 2016 23:00:26 +0200
Message-ID: <3377280.mzxhCYOnLL@wuerfel>
References: <57726196.5060909@free.fr> <8406200.nXRkviT67W@wuerfel> <1471606196.2691.58.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:64378 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbcHVVBL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 17:01:11 -0400
In-Reply-To: <1471606196.2691.58.camel@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Friday, August 19, 2016 7:29:56 PM CEST Zhang Rui wrote:
> On 二, 2016-07-26 at 14:13 +0200, Arnd Bergmann wrote:
> > On Monday, July 25, 2016 11:48:47 AM CEST Mason wrote:
> > > 
> > > On 25/07/2016 10:52, Arnd Bergmann wrote:
> > > 
> > > > 
> > > > On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> > > > 
> > > > > 
> > > > > Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP
> > > > > guard
> > > > > would unconditionally define a struct dev_pm_ops, which just
> > > > > wastes
> > > > > space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).
> > > > > 
> > > > > That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP
> > > > > guard.
> > > > If you want to avoid the extra few bytes, just use the trick I
> > > > suggested:
> > > > 
> > > >       .pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm :
> > > > NULL,
> > > This would achieve the same result as the solution I proposed
> > > in my v2 patch, right?
> > > 
> > > So you're saying you prefer the IS_ENABLED macro over using
> > > #ifdef ... #else define stuff as NULL #endif
> > > 
> > > Did I get that right?
> > Yes, but I'd also prefer not to hide the operations structure
> > at all and just rely on the __maybe_unused (ideally) or
> > #ifdef (not as good, but commonly used) to leave out the
> > functions.
> > 
> IMO, the typical way is to use #ifdef for the pm callbacks, and leave
> SIMPLE_DEV_PM_OPS outside the #ifdef.
> For example, drivers/ata/ahci_imx.c.
> 

Lots of drivers do it like that, the main downside I see is that a
lot of them also get it wrong and use incorrect #ifdef guards,
either checking the wrong Kconfig symbol, or hiding the wrong
subset of functions.

	Arnd

