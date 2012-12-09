From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v3 7/9] yield_to(), cpu-hotplug: Prevent offlining
	of other CPUs properly
Date: Sun, 9 Dec 2012 20:48:26 +0100
Message-ID: <20121209194826.GB2816@redhat.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173950.27305.39499.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3895 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758871Ab2LITsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 9 Dec 2012 14:48:25 -0500
Content-Disposition: inline
In-Reply-To: <20121207173950.27305.39499.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/07, Srivatsa S. Bhat wrote:
>
> Once stop_machine() is gone from the CPU offline path, we won't be able to
> depend on local_irq_save() to prevent CPUs from going offline from under us.

OK, I guess we need to avoid resched_task()->smp_send_reschedule()
after __cpu_disable() and before migrate_tasks().

But, whatever problem we have,

> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
> while invoking from atomic context.

it should be solved, so...

> -		if (preempt && rq != p_rq)
> +		if (preempt && rq != p_rq && cpu_online(task_cpu(p)))

Why do we need this change?

Afaics, you could add BUG_ON(!cpu_online(...)) instead?

I am just curious.

Oleg.

