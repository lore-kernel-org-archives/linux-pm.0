From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v3 7/9] yield_to(), cpu-hotplug: Prevent offlining
	of other CPUs properly
Date: Sun, 9 Dec 2012 21:40:53 +0100
Message-ID: <20121209204053.GA6593@redhat.com>
References: <20121207173702.27305.1486.stgit@srivatsabhat.in.ibm.com> <20121207173950.27305.39499.stgit@srivatsabhat.in.ibm.com> <20121209194826.GB2816@redhat.com> <50C4ED46.3070100@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50C4ED46.3070100@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/10, Srivatsa S. Bhat wrote:
>
> On 12/10/2012 01:18 AM, Oleg Nesterov wrote:
> >> -		if (preempt && rq != p_rq)
> >> +		if (preempt && rq != p_rq && cpu_online(task_cpu(p)))
> >
> > Why do we need this change?
> >
> > Afaics, you could add BUG_ON(!cpu_online(...)) instead?
> >
> > I am just curious.
> >
>
> Oh, I think that's a remnant of v1 (which needed readers to use
> cpu_online_stable()). You're right, we don't need it.

Ah OK, thanks.

> Or we could put a
> BUG_ON instead, like you suggested.

IMHO it would be better to simply drop this chunk.

Oleg.
