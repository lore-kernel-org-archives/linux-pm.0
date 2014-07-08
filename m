From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCHv2 1/8] clk: add an APPLY_RATE_CHANGE notifier event
 during clk_set_rate()
Date: Tue, 8 Jul 2014 22:25:16 +0200
Message-ID: <20140708222516.6b0c0d66@free-electrons.com>
References: <1404744702-32010-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1404744702-32010-2-git-send-email-thomas.petazzoni@free-electrons.com>
	<53BB30D2.3010908@codeaurora.org>
	<20140708091540.0f886cfc@free-electrons.com>
	<53BC522E.8080302@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:41311 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752223AbaGHUZT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jul 2014 16:25:19 -0400
In-Reply-To: <53BC522E.8080302@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, linux-pm@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Boris Brezillon <boris.brezillon@free-electrons.com>

Dear Stephen Boyd,

On Tue, 08 Jul 2014 13:18:54 -0700, Stephen Boyd wrote:

> >>> In order to solve this problem, we propose to add an APPLY_RATE_CHANGE
> >>> notifier event, which gets called right after ->set_rate(), but before
> >>> ->recalc_rate(), and therefore regardless of whether there was an
> >>> actualy frequency change or not.
> >> Is there any reason why we can't call the pmsu code (part #3) directly
> >> from the cpu clock driver? It seems like if we just called the
> >> .set_rate() op we wouldn't actually have changed the clock's rate. That
> >> doesn't seem very intuitive and it really makes the code flow hard to
> >> follow.
> > Right, but what solution would you propose to achieve that? These days,
> > a direct call from drivers/ code to arch/arm/mach-<foo>/ code is
> > frowned upon, no? (The code handling the PMSU is in
> > arch/arm/mach-mvebu/pmsu.c).
> 
> I don't see a problem with having an include file in include/linux/ for
> this, maybe others do though.

I'm fine with that as well, but I believe one of the policy was to
avoid having too much drivers/ stuff call into arch/arm/ stuff.

> If it actually is a problem then perhaps
> moving the pmsu.c code into drivers/ is the right solution.

Yes, but where would it belong? The PMSU hardware block is tightly
linked to SMP initialization (which means it should be up and running
very early), CPU hotplug, cpuidle, cpufreq and suspend/resume. It means
that it interacts with a lot of different subsystems.

Maybe the solution of adding a direct call from
drivers/clk/mvebu/clk-cpu.c to arch/arm/mach-mvebu/pmsu.c is the
easiest and most explicit solution.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
