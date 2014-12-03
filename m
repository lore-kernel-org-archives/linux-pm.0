From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH] iio / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 23:46:45 +0100
Message-ID: <5292660.MpQBlxNLlG@vostro.rjw.lan>
References: <202529361.GBbZ7zGgn8@vostro.rjw.lan> <1417623491.2043.320.camel@spandruv-desktop.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417623491.2043.320.camel-hINH/TbAiWppyMZ9rn1DP+ejPoqOX1/hEvhb3Hwu1Ks@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 03, 2014 08:18:11 AM Srinivas Pandruvada wrote:
> On Wed, 2014-12-03 at 03:06 +0100, Rafael J. Wysocki wrote: 
> > From: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > 
> > After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> > selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> > depending on CONFIG_PM_RUNTIME may now be changed to depend on
> > CONFIG_PM.
> > 
> > Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> > drivers/iio/.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> > ---
> > 
> > Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> > PM_SLEEP is selected) which is only in linux-next at the moment (via the
> > linux-pm tree).
> > 
> > Please let me know if it is OK to take this one into linux-pm.
> 
> There are some other drivers using this define, we need to change all
> those.

Yes, I'm doing this everywhere, this patch is just one part of it.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
