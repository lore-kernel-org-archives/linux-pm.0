From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH][RFC] cpufreq: Bring CPUs up even if cpufreq_online failed
Date: Tue, 28 Mar 2017 18:40:01 +0200
Message-ID: <6355160.0UpRUzJM6Y@aspire.rjw.lan>
References: <1490415611-16945-1-git-send-email-yu.c.chen@intel.com> <20170328162317.qqfep6edbovchqps@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:65140 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754152AbdC1QqL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 12:46:11 -0400
In-Reply-To: <20170328162317.qqfep6edbovchqps@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

On Tuesday, March 28, 2017 06:23:17 PM Sebastian Andrzej Siewior wrote:
> On 2017-03-25 12:20:11 [+0800], Chen Yu wrote:
> > There is a report that after
> > commit 27622b061eb4 ("cpufreq: Convert to hotplug state machine"),
> > the normal CPU offline/online cycle failed on some platforms.
> > According to the ftrace result, this problem was triggered on
> > platforms using acpi-freq as the default cpufreq driver,
> > and due to the lack of some ACPI freq method(_PCT eg), the
> > cpufreq_online failed and returned a negative value, thus the cpu
> > hotplug statemachine rollbacked the CPU online process. Actually
> > the failure of cpufreq_online should not impact the whole CPU
> > online process according to the original semantics before above patch.
> 
> Well, an error during bring up of CPU should not keep the system going
> like nothing happend and cpufreq was ignoring return values without a
> comment _why_ it is a good iea to do so.
> 
> > BTW, during system bootup the cpufreq_online is not invoked via
> > cpuhotplug statemachine but by the cpufreq device creation process,
> > thus the APs can be brought up although cpufreq_online failed in that
> > stage.
> > 
> > This patch ignores the return value of cpufreq_online/offline and
> > prints a warning if there is a failure.
> 
> What about dealing with this known error instead printing? If something
> like "cpufreq_policy_alloc()" fails I will definitely a rollback and not
> just a print. 

cpufreq_online() will do a proper rollback in that case.  It may even log an
error by itself. :-)

> So what happens if we miss this "method(_PCT eg)"? We still want the
> hotplug event right? So I would suggest a pr_once() that this _PCT
> thingy is missing and continue without an error. I think pr_err_once()
> is enough because I doubt the situation changes without an BIOS update
> and a pr_err() will be visible also during suspend/resume, right?

Right.

That's why I wouldn't print anything here and let cpufreq_online()
and cpufreq_offline() deal with that.

Thanks,
Rafael
