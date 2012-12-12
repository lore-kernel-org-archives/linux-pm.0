From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Wed, 12 Dec 2012 18:17:20 +0100
Message-ID: <20121212171720.GA22289@redhat.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/11, Srivatsa S. Bhat wrote:
>
> IOW, the hotplug readers just increment/decrement their per-cpu refcounts
> when no writer is active.

plus cli/sti ;) and increment/decrement are atomic.

At first glance looks correct to me, but I'll try to read it carefully
later.

A couple of minor nits,

> +static DEFINE_PER_CPU(bool, writer_signal);

Why it needs to be per-cpu? It can be global and __read_mostly to avoid
the false-sharing. OK, perhaps to put reader_percpu_refcnt/writer_signal
into a single cacheline...

> +void get_online_cpus_atomic(void)
> +{
> +	unsigned long flags;
> +
> +	preempt_disable();
> +
> +	if (cpu_hotplug.active_writer == current)
> +		return;
> +
> +	local_irq_save(flags);

Yes... this is still needed, we are going to increment reader_percpu_refcnt
unconditionally and this makes reader_nested_percpu() == T.

But,

> +void put_online_cpus_atomic(void)
> +{
> +	unsigned long flags;
> +
> +	if (cpu_hotplug.active_writer == current)
> +		goto out;
> +
> +	local_irq_save(flags);
> +
> +	/*
> +	 * We never allow heterogeneous nesting of readers. So it is trivial
> +	 * to find out the kind of reader we are, and undo the operation
> +	 * done by our corresponding get_online_cpus_atomic().
> +	 */
> +	if (__this_cpu_read(reader_percpu_refcnt))
> +		__this_cpu_dec(reader_percpu_refcnt);
> +	else
> +		read_unlock(&hotplug_rwlock);
> +
> +	local_irq_restore(flags);
> +out:
> +	preempt_enable();
> +}

Do we really need local_irq_save/restore in put_ ?

Oleg.
