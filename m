From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH v4 1/9] CPU hotplug: Provide APIs to prevent CPU
	offline from atomic context
Date: Wed, 12 Dec 2012 19:23:08 +0100
Message-ID: <20121212182308.GA26094@redhat.com>
References: <20121211140314.23621.64088.stgit@srivatsabhat.in.ibm.com> <20121211140358.23621.97011.stgit@srivatsabhat.in.ibm.com> <20121212171720.GA22289@redhat.com> <20121212172431.GA23328@redhat.com> <50C8C8C9.2070605@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50C8C8C9.2070605@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org, tj@kernel.org, sbw@mit.edu, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/12, Srivatsa S. Bhat wrote:
>
> On 12/12/2012 10:54 PM, Oleg Nesterov wrote:
>
> > And when I look at get_online_cpus_atomic() again it uses rmb(). This
> > doesn't look correct, we need the full barrier between this_cpu_inc()
> > and writer_active().
>
> Hmm..
>
> > At the same time reader_nested_percpu() can be checked before mb().
>
> I thought that since the increment and the check (reader_nested_percpu)
> act on the same memory location, they will naturally be run in the given
> order, without any need for barriers. Am I wrong?

And this is what I meant, you do not need a barrier before
reader_nested_percpu().

But you need to ensure that WRITE(reader_percpu_refcnt) and READ(writer_signal)
can't be reordered, so you need mb() in between. rmb() can serialize LOADs and
STOREs.

Or I misunderstood?

Oleg.
