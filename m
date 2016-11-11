From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Fri, 11 Nov 2016 11:07:13 +0100
Message-ID: <20161111100713.GF2324@pathway.suse.cz>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
 <1476707572-32215-4-git-send-email-pmladek@suse.com>
 <20161021132118.4239af86@jacob-builder>
 <20161024154807.GQ23809@pathway.suse.cz>
 <20161024095529.2b1855b4@icelake>
 <20161027145348.GV23809@pathway.suse.cz>
 <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
 <20161027132736.2a74c0b6@jacob-builder>
 <20161111093330.GE2324@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33610 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754256AbcKKKHQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Nov 2016 05:07:16 -0500
Content-Disposition: inline
In-Reply-To: <20161111093330.GE2324@pathway.suse.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 2016-11-11 10:33:30, Petr Mladek wrote:
> Then I tried to revert the conversion to the kthread worker
> API (2nd patch from this patchset), see below. And it still
> hangs during the suspend inside
> 
> 	powerclamp_cpu_predown()
> 	  kthread_stop(*percpu_thread);
> 
> 
> Note that both kthread_flush_worker() and kthread_stop()
> waits until the kthread gets scheduled and do some job.
> Also note that the kthread is bound to the given CPU.
> 
> My guess is that the kthread cannot be scheduled at this stage.
> I wonder if the CPU is already partially down or that tasks
> are freezed so that "normal" tasks are not scheduled at
> this point. I am still trying to understand the code
> related to suspend, cpu hotplug, and scheduler.

And yes, the problem seems to be that the kthread is freezed
so that it could not run. The suspend works when I disable:

	clamp_thread()
//	  set_freezable();
//	  try_to_freeze();

In fact, we should not need these calls. They are needed only
when we want to stop the kthread on exact location so that
it does not produce I/O that would block/break suspend.
But this is not the case of intel_powerclamp.

I am going to do some more tests and will send a fix. It should
be enough to remove the KTW_FREEZABLE flag from the
kthread_create_worker_on_cpu() call.

Best Regards,
Petr
