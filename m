From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v3 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Sun, 9 Dec 2012 21:22:34 +0100
Message-ID: <20121209202234.GA5793@redhat.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173759.27305.84316.stgit@srivatsabhat.in.ibm.com> <20121209191437.GA2816@redhat.com> <50C4EB79.5050203@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758925Ab2LIUWf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 9 Dec 2012 15:22:35 -0500
Content-Disposition: inline
In-Reply-To: <50C4EB79.5050203@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/10, Srivatsa S. Bhat wrote:
>
> On 12/10/2012 12:44 AM, Oleg Nesterov wrote:
>
> > But yes, it is easy to blame somebody else's code ;) And I can't suggest
> > something better at least right now. If I understand correctly, we can not
> > use, say, synchronize_sched() in _cpu_down() path
>
> We can't sleep in that code.. so that's a no-go.

But we can?

Note that I meant _cpu_down(), not get_online_cpus_atomic() or take_cpu_down().

Oleg.

