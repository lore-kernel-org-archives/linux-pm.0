From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Sun, 9 Dec 2012 21:57:33 +0100
Message-ID: <20121209205733.GA7038@redhat.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751751Ab2LIU5d (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 9 Dec 2012 15:57:33 -0500
Content-Disposition: inline
In-Reply-To: <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, rostedt@goodmis.org
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/07, Srivatsa S. Bhat wrote:
>
> 4. No deadlock possibilities
>
>    Per-cpu locking is not the way to go if we want to have relaxed rules
>    for lock-ordering. Because, we can end up in circular-locking dependencies
>    as explained in https://lkml.org/lkml/2012/12/6/290

OK, but this assumes that, contrary to what Steven said, read-write-read
deadlock is not possible when it comes to rwlock_t. So far I think this
is true and we can't deadlock. Steven?

However. If this is true, then compared to preempt_disable/stop_machine
livelock is possible. Probably this is fine, we have the same problem with
get_online_cpus(). But if we can accept this fact I feel we can simmplify
this somehow... Can't prove, only feel ;)

Oleg.

