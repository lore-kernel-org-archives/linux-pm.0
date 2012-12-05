From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 01/10] CPU hotplug: Provide APIs for "light" atomic
 readers to prevent CPU offline
Date: Thu, 06 Dec 2012 00:21:06 +0530
Message-ID: <50BF979A.50304@linux.vnet.ibm.com>
References: <20121205184041.3750.64945.stgit@srivatsabhat.in.ibm.com> <20121205184258.3750.31879.stgit@srivatsabhat.in.ibm.com> <50BF96DF.3000500@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:46849 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab2LESwc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Dec 2012 13:52:32 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 6 Dec 2012 00:22:18 +0530
In-Reply-To: <50BF96DF.3000500@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, oleg@redhat.com, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Replaying what Oleg wrote:

Hi,

Sorry I don't understand the context and I can't find this thread
anywhere, so I am not sure I understand...

> Replaying what Tejun wrote:
> So, we basically need percpu_rwlock.  We already have percpu_rwsem.

Yes, and with -mm patches it becomes reader-friendly. In particular
see http://marc.info/?l=linux-mm-commits&m=135240650828875

> Oleg, it seems
> CPU hotplug needs big-reader rwlock, ideas on how to proceed?
> 

I am going to convert get_online_cpus() to use percpu_down_read(),
this looks simple.

We already discussed this with Paul, see

	http://marc.info/?l=linux-kernel&m=135248463226031

and the whole thread.

In short, all we need is percpu_down_write_recursive_readers() and
afaics the only complication is lockdep, we need down_read_no_lockdep()
which (like __up_read) doesn't do rwsem_acquire_read().

Oleg.

