From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 3/3] thermal/intel_powerclamp: Convert to CPU hotplug
 state
Date: Thu, 27 Oct 2016 13:27:36 -0700
Message-ID: <20161027132736.2a74c0b6@jacob-builder>
References: <1476707572-32215-1-git-send-email-pmladek@suse.com>
        <1476707572-32215-4-git-send-email-pmladek@suse.com>
        <20161021132118.4239af86@jacob-builder>
        <20161024154807.GQ23809@pathway.suse.cz>
        <20161024095529.2b1855b4@icelake>
        <20161027145348.GV23809@pathway.suse.cz>
        <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:13711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935293AbcJ0UZx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Oct 2016 16:25:53 -0400
In-Reply-To: <20161027151726.s2uavcnnbtjvmboq@linutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>, Zhang Rui <rui.zhang@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com

On Thu, 27 Oct 2016 17:17:26 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2016-10-27 16:53:48 [+0200], Petr Mladek wrote:
> > 
> > In each case, I wonder if the problem is caused by the conversion
> > to the kthread worker or by the CPU hotplug state conversion.  
> 
> drop the hotplug patch and you will see.
> 
Petr,

I dropped hp patch no long see the hang during suspend to s3. However,
the problem seems to be this line,

diff --git a/drivers/thermal/intel_powerclamp.c
b/drivers/thermal/intel_powerclamp.c index 390e50b..b61da57 100644
--- a/drivers/thermal/intel_powerclamp.c
+++ b/drivers/thermal/intel_powerclamp.c
@@ -574,7 +574,7 @@ static void stop_power_clamp_worker(unsigned long
cpu) */
        del_timer_sync(&w_data->wakeup_timer);
        clear_bit(w_data->cpu, cpu_clamping_mask);
-       kthread_destroy_worker(w_data->worker);
+//     kthread_destroy_worker(w_data->worker);
 
        w_data->worker = NULL;
 }

If I do the above, everything works with S3 and CPU HP patch.

Inside kthread_destroy_worker()
	kthread_flush_worker(worker);
never completes then blocks s3 entry!

I will be at LPC next week also, we can chat about that.


Thanks,

Jacob


> > Best Regards,
> > Petr  
> 
> Sebastian

[Jacob Pan]
