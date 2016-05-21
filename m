From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Sat, 21 May 2016 02:56:20 +0200
Message-ID: <2148724.oQlEHos3jS@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com> <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com> <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60880 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751422AbcEUAwq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 20:52:46 -0400
In-Reply-To: <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Friday, May 20, 2016 09:36:52 PM Fabio Estevam wrote:
> On Fri, May 20, 2016 at 9:30 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> 
> > What exactly do you mean by reverting here?  It surely cannot be
> > reverted by itself and there are many things that depend on it.
> 
> Yes, it cannot be reverted cleanly on 4.6.
> 
> If I do 'git checkout 9be4fd2c7723a30' and then 'git revert
> 9be4fd2c7723a30' then the reboot command works.

OK, so in fact you need to go all the way to the parent of 9be4fd2c7723a30.

> >>> Is this an SMP board, actually?
> >>
> >> Yes, this is a single core CortexA7.
> >
> > Hmm.  Single core means non-SMP rather?
> 
> CONFIG_SMP can be set or not in the kernel config. With CONFIG_SMP=n
> the issue does not happen.

Yes, you can run an SMP kernel on a non-SMP board too, which is what leads to
the problem you're seeing.

If I'm not mistaken, the patch below should allow irq_work to make forward
progress for you, so please check if it makes any difference.

The root of the problem seems to be arch_irq_work_raise() and specifically
the __smp_cross_call function that appears to have problems.

I bet that is_smp() should return false on your platform, but it returns
true for some reason.

---
 drivers/cpufreq/cpufreq_governor.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.c
+++ linux-pm/drivers/cpufreq/cpufreq_governor.c
@@ -362,6 +362,7 @@ static struct policy_dbs_info *alloc_pol
 	mutex_init(&policy_dbs->timer_mutex);
 	atomic_set(&policy_dbs->work_count, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
+	policy_dbs->irq_work.flags = IRQ_WORK_LAZY;
 	INIT_WORK(&policy_dbs->work, dbs_work_handler);
 
 	/* Set policy_dbs for all CPUs, online+offline */

