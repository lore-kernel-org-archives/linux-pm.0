From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Wed, 12 Dec 2012 18:24:31 +0100
Message-ID: <20121212172431.GA23328@redhat.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121212171720.GA22289@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/12, Oleg Nesterov wrote:
>
> On 12/11, Srivatsa S. Bhat wrote:
> >
> > IOW, the hotplug readers just increment/decrement their per-cpu refcounts
> > when no writer is active.
>
> plus cli/sti ;) and increment/decrement are atomic.
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

OOPS, sorry I was going to say "adds mb()".

And when I look at get_online_cpus_atomic() again it uses rmb(). This
doesn't look correct, we need the full barrier between this_cpu_inc()
and writer_active().

At the same time reader_nested_percpu() can be checked before mb().

Oleg.
