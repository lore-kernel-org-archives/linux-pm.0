From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH] PM / sleep: define inline functions
Date: Thu, 17 Dec 2015 13:25:49 +0530
Message-ID: <20151217075549.GA18571@sudip-pc>
References: <1450266099-4352-1-git-send-email-sudipm.mukherjee@gmail.com>
 <87wpsdrjni.fsf@eliezer.anholt.net>
 <6732607.IpmkEPKP2k@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32907 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbbLQHz7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 02:55:59 -0500
Content-Disposition: inline
In-Reply-To: <6732607.IpmkEPKP2k@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Eric Anholt <eric@anholt.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On Thu, Dec 17, 2015 at 02:43:38AM +0100, Rafael J. Wysocki wrote:
> On Wednesday, December 16, 2015 04:41:37 PM Eric Anholt wrote:
> > 
> > --=-=-=
> > Content-Type: text/plain
> > 
> > Sudip Mukherjee <sudipm.mukherjee@gmail.com> writes:
> > 
> > > If CONFIG_PM_SLEEP is not defined then the functions are defined as
> > > NULL. And as a result we are getting build failure with
> > > alpha allmodconfig with the error:
> > >
> > > drivers/gpu/drm/vc4/vc4_v3d.c: In function 'vc4_v3d_set_power':
> > > include/linux/stddef.h:7:14: error: called object is not a function or function pointer
> > >  #define NULL ((void *)0)
> > >               ^
> > > include/linux/pm.h:776:30: note: in expansion of macro 'NULL'
> > >  #define pm_generic_poweroff  NULL
> > >                               ^
> > > drivers/gpu/drm/vc4/vc4_v3d.c:157:10: note: in expansion of macro 'pm_generic_poweroff'
> > >    return pm_generic_poweroff(&vc4->v3d->pdev->dev);
> > >           ^
> > > include/linux/stddef.h:7:14: error: called object is not a function or function pointer
> > >  #define NULL ((void *)0)
> > >               ^
> > > include/linux/pm.h:764:28: note: in expansion of macro 'NULL'
> > >  #define pm_generic_resume  NULL
> > >                             ^
> > > drivers/gpu/drm/vc4/vc4_v3d.c:159:10: note: in expansion of macro 'pm_generic_resume'
> > >    return pm_generic_resume(&vc4->v3d->pdev->dev);
> > >           ^
> > >
> > > Fixes: d5b1a78a772f ("drm/vc4: Add support for drawing 3D frames.")
> > > Cc: Eric Anholt <eric@anholt.net>
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > 
> > I'm happy with this solution, and would also be willing to just depend
> > on the config option as well.  Whatever people prefer.
> 
> These functions are intended to be used as PM callbacks rather than to be
> called directly from code that doesn't depend on PM_SLEEP, so I'd prefer
> all code calling them directly to depend on the config option.

Apart from alpha some other arch also failed on allmodconfig for
next-20151216.
next-20151217 is now getting compiled on travis. If it still shows the
build failure I will send v2 with config options.

regards
sudip
