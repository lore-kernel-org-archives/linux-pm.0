From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] thermal: tango: add resume support
Date: Tue, 26 Jul 2016 14:13:07 +0200
Message-ID: <8406200.nXRkviT67W@wuerfel>
References: <57726196.5060909@free.fr> <4062048.3qHsMMf8fO@wuerfel> <5795E07F.6010506@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:60780 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbcGZMNn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Jul 2016 08:13:43 -0400
In-Reply-To: <5795E07F.6010506@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mason <slash.tmp@free.fr>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Sebastian Frias <sf84@laposte.net>, Kevin Hilman <khilman@baylibre.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pm <linux-pm@vger.kernel.org>

On Monday, July 25, 2016 11:48:47 AM CEST Mason wrote:
> On 25/07/2016 10:52, Arnd Bergmann wrote:
> 
> > On Monday, July 25, 2016 10:18:22 AM CEST Mason wrote:
> > 
> >> Moving the SIMPLE_DEV_PM_OPS macro outside the CONFIG_PM_SLEEP guard
> >> would unconditionally define a struct dev_pm_ops, which just wastes
> >> space when CONFIG_PM_SLEEP is undefined (if I'm not mistaken).
> >>
> >> That's why I put SIMPLE_DEV_PM_OPS inside the CONFIG_PM_SLEEP guard.
> > 
> > If you want to avoid the extra few bytes, just use the trick I
> > suggested:
> > 
> >       .pm = IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL,
> 
> This would achieve the same result as the solution I proposed
> in my v2 patch, right?
> 
> So you're saying you prefer the IS_ENABLED macro over using
> #ifdef ... #else define stuff as NULL #endif
> 
> Did I get that right?

Yes, but I'd also prefer not to hide the operations structure
at all and just rely on the __maybe_unused (ideally) or
#ifdef (not as good, but commonly used) to leave out the
functions.

> Eduardo, Zhang, what do thermal maintainers prefer?
> 
> > You should basically never have that #ifdef inside of the
> > platform_driver definition.
> 
> Except when the fields don't exist, like the bug I introduced
> in struct smp_operations (which you fixed).

Right.

	Arnd
