From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Thu, 19 Jan 2017 15:29:34 -0800
Message-ID: <20170119232934.GA18102@roeck-us.net>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48782 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdASX3k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jan 2017 18:29:40 -0500
Content-Disposition: inline
In-Reply-To: <20170119230036.sjfqvqxgxutis6xs@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>

On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
> Hi Thierry,
> 
> > > > [...]
> > >
> > > Please use register_restart_handler() instead. It has support for
> > > priorities, is not arm specific and properly supports unregistering
> > > (some handler with lower priority will take over). You can check
> > > gpio-restart as an example for the API.
> > > 
> > > If you have some other arm_pm_restart handler (those are tried first)
> > > I suggest to convert that to the restart handler framework. Actually
> > > it may be a good idea to convert all of them and drop arm_pm_restart,
> > > since there are only 4 left:
> > > 
> > > $ git grep "arm_pm_restart ="
> > > drivers/firmware/psci.c:        arm_pm_restart = psci_sys_reset;
> > > arch/arm/mach-prima2/rstc.c:    arm_pm_restart = sirfsoc_restart;
> > > arch/arm/xen/enlighten.c:       arm_pm_restart = xen_restart;
> > > arch/arm/kernel/setup.c:                arm_pm_restart = mdesc->restart;
> > > 
> > > The first 3 should be easy to update and the last one could
> > > be solved by registering a wrapper function as restart handler,
> > > which calls mdesc->restart().
> > 
> > I remember this not being the first time that this confuses me. And from
> > looking around a little it seems like I'm not the only one.
> > 
> > Do you know if there's ever been any attempts to formalize all of this
> > by adding some sort of framework for this? That way some of the
> > confusion may be removed and architecture-specific bits could be
> > eliminated more easily.
> 
> We have a framework for restart handlers, which has been written
> by Guenter Roeck [0] in 2014. You just have to call register_restart_handler()
> during probe and unregister_restart_handler() during removal of
> your reboot driver. All reboot drivers in drivers/power/reset use
> that framework.
> 
> The restart handlers are invoked by calling do_kernel_restart()
> based on their configured priority. That function is called by
> the architecture's machine_restart() function. It's currently
> used by mips, ppc, arm & arm64 as far as I can see. ARM's
> implementation looks like this:
> 
> if (arm_pm_restart)
> 	arm_pm_restart()
> else
> 	do_kernel_restart() /* reboot handler framework */
> 
I actually have a set of patches somewhere which transforms the remaining
direct users of arm_pm_restart to use the framework (unless I removed it
from my trees - I don't really recall). I just never got around to submit
it, and then [2] happened and I lost interest.

> No such thing exists for poweroff. Guenter also wrote something for
> that [1], but Linus intervened [2]. Anyways, pm_power_off is at
> least architecture independent.
> 
That was by far the most frustrating kernel development experience
I ever head :-(.

Guenter

> [0] https://lwn.net/Articles/605298/
> [1] https://lwn.net/Articles/617345/
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351369.html
> 
> -- Sebastian


