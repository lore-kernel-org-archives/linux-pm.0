From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 7/7] preempt: Take away preempt_enable_no_resched() from
 modules
Date: Wed, 20 Nov 2013 11:29:35 -0800
Message-ID: <20131120112935.6be596e4@ultegra>
References: <20131120160450.072555619@infradead.org>
	<20131120162736.760865926@infradead.org>
	<20131120105457.04f6e51e@ultegra>
	<20131120191841.GY16796@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29189 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754545Ab3KTT3j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 20 Nov 2013 14:29:39 -0500
In-Reply-To: <20131120191841.GY16796@laptop.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>

On Wed, 20 Nov 2013 20:18:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> I think the below will cure both -- will fold in the proper patches
> tomorrow, need to get away from the computer noaw.
[Jacob Pan] looks good to me. one more thing for tomorrow :)


diff --git a/kernel/softirq.c b/kernel/softirq.c
index d3283d3..750e853 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -114,6 +114,7 @@ void __local_bh_disable_ip(unsigned long ip,
unsigned int cnt) if (preempt_count() == cnt)
                trace_preempt_off(CALLER_ADDR0,
get_parent_ip(CALLER_ADDR1)); }
+EXPORT_SYMBOL_GPL(__local_bh_disable_ip);
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 static void __local_bh_enable(unsigned int cnt)
@@ -169,7 +170,7 @@ void __local_bh_enable_ip(unsigned long ip,
unsigned int cnt) #endif
        preempt_check_resched();
 }
-
+EXPORT_SYMBOL_GPL(__local_bh_enable_ip);
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
