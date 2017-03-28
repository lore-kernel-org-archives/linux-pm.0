From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RFC] cpufreq: Bring CPUs up even if cpufreq_online failed
Date: Tue, 28 Mar 2017 18:23:17 +0200
Message-ID: <20170328162317.qqfep6edbovchqps@linutronix.de>
References: <1490415611-16945-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1490415611-16945-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 2017-03-25 12:20:11 [+0800], Chen Yu wrote:
> There is a report that after
> commit 27622b061eb4 ("cpufreq: Convert to hotplug state machine"),
> the normal CPU offline/online cycle failed on some platforms.
> According to the ftrace result, this problem was triggered on
> platforms using acpi-freq as the default cpufreq driver,
> and due to the lack of some ACPI freq method(_PCT eg), the
> cpufreq_online failed and returned a negative value, thus the cpu
> hotplug statemachine rollbacked the CPU online process. Actually
> the failure of cpufreq_online should not impact the whole CPU
> online process according to the original semantics before above patch.

Well, an error during bring up of CPU should not keep the system going
like nothing happend and cpufreq was ignoring return values without a
comment _why_ it is a good iea to do so.

> BTW, during system bootup the cpufreq_online is not invoked via
> cpuhotplug statemachine but by the cpufreq device creation process,
> thus the APs can be brought up although cpufreq_online failed in that
> stage.
> 
> This patch ignores the return value of cpufreq_online/offline and
> prints a warning if there is a failure.

What about dealing with this known error instead printing? If something
like "cpufreq_policy_alloc()" fails I will definitely a rollback and not
just a print. 

So what happens if we miss this "method(_PCT eg)"? We still want the
hotplug event right? So I would suggest a pr_once() that this _PCT
thingy is missing and continue without an error. I think pr_err_once()
is enough because I doubt the situation changes without an BIOS update
and a pr_err() will be visible also during suspend/resume, right?

Sebastian
