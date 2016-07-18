From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH v2] thermal: tango: add resume support
Date: Mon, 18 Jul 2016 12:09:39 +0200
Message-ID: <7689133.3ycKRvbtrh@wuerfel>
References: <57726196.5060909@free.fr> <20160718093328.GB32259@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53952 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbcGRKKQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 06:10:16 -0400
In-Reply-To: <20160718093328.GB32259@ulmo.ba.sec>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Mason <slash.tmp@free.fr>, Sebastian Frias <sf84@laposte.net>, linux-pm <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On Monday, July 18, 2016 11:33:28 AM CEST Thierry Reding wrote:

> > +
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tango_thermal_pm, NULL, tango_thermal_resume);
> > +
> > +#define DEV_PM_OPS   &tango_thermal_pm
> > +#else
> > +#define DEV_PM_OPS   NULL
> > +#endif
> 
> In my experience it's often not useful to #ifdef the struct pm_ops.
> These days you almost certainly want PM enabled, and the conditional
> doesn't save you all that much in the first place, because it's not
> unlikely for this to fit into some of the space that would be padded
> out anyway.

This will also generate a warning when CONFIG_PM_SLEEP is not set.
Better write this as

#define DEV_PM_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &tango_thermal_pm : NULL)

so the compiler can drop the variable definition when it's not
needed.

> As a side-note, I've noticed that this driver has the following
> dependencies:
> 
>         depends on ARCH_TANGO || COMPILE_TEST
> 
> which, last I checked, is probably going to fail on some architectures
> because you need at least another one on HAS_IOMEM (for readl() and
> writel()). That's a pre-existing problem, of course, so should be fixed
> in a separate patch.

No need, we just merged a patch to no longer allow COMPILE_TEST on
arch/um/, so we can safely rely on MMIO to be available for COMPILE_TEST.

	Arnd
