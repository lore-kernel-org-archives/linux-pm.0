From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH][RFC] cpufreq: intel_pstate: Avoid time-costly
 synchronization if schedutil is not enabled
Date: Tue, 10 May 2016 21:07:24 +0200
Message-ID: <CAJZ5v0jCmcHS-J7L182+Xfv_FJiAzfWL4MNpvAHq7siuW1Bp=g@mail.gmail.com>
References: <1462872252-16152-1-git-send-email-yu.c.chen@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34714 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcEJTH0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 May 2016 15:07:26 -0400
In-Reply-To: <1462872252-16152-1-git-send-email-yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, May 10, 2016 at 11:24 AM,  <yu.c.chen@intel.com> wrote:
> From: Chen Yu <yu.c.chen@intel.com>

First, the subject.  It doesn't have anything to do with schedutil, so
I'd just use something like "Avoid unnecessary synchronize_sched()
during initialization".

> Commit bb6ab52f2bef ("intel_pstate: Do not set utilization update
> hook too early") moved the assignment of utilization update hook
> from intel_pstate_init_cpu to intel_pstate_set_policy(), however
> after moving, we need to leverage synchronize_sched() to deal
> with synchronization, which is time-costly because it needs to
> wait for all the CPUs to go through a grace period.
>
> Actuall we don't need to synchronize_sched if schedutil has
> not been enabled, which also can address the problem in our case,
> thus bypass the synchronize_sched during bootup.

"Actually, the synchronize_sched() is not necessary if the utilization
update hook has not been set for the given CPU yet, so make the driver
check if that's the case and avoid the synchronize_sched() call in
that case."

> Fixes: bb6ab52f2bef "intel_pstate: Do not set utilization update hook too early"

I'm not sure I'd call it a fix, unless there is a significant
difference in the system boot time or similar.  If that's not the
case, this simply is an optimization on top of the above commit.
