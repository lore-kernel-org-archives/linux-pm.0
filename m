From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Wed, 12 Dec 2012 20:36:46 +0100
Message-ID: <20121212193646.GA29395@redhat.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <50C8C4A5.4080104@linux.vnet.ibm.com> <20121212180248.GA24882@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18451 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212Ab2LLTg6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Dec 2012 14:36:58 -0500
Content-Disposition: inline
In-Reply-To: <20121212180248.GA24882@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/12, Oleg Nesterov wrote:
>
> On 12/12, Srivatsa S. Bhat wrote:
> >
> > On 12/12/2012 10:47 PM, Oleg Nesterov wrote:
> > >
> > > Why it needs to be per-cpu? It can be global and __read_mostly to avoid
> > > the false-sharing. OK, perhaps to put reader_percpu_refcnt/writer_signal
> > > into a single cacheline...
> >
> > Even I realized this (that we could use a global) after posting out the
> > series.. But do you think that it would be better to retain the per-cpu
> > variant itself, due to the cache effects?
>
> I don't really know, up to you. This was the question ;)

But perhaps there is another reason to make it per-cpu...

It seems we can avoid cpu_hotplug.active_writer == current check in
get/put.

take_cpu_down() can clear this_cpu(writer_signal) right after it takes
hotplug_rwlock for writing. It runs with irqs and preemption disabled,
nobody else will ever look at writer_signal on its CPU.

Oleg.

