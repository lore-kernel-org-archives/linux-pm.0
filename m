From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC PATCH 02/10] smp, cpu hotplug: Fix smp_call_function_*() to prevent CPU offline properly
Date: Wed, 05 Dec 2012 10:09:22 +1030
Message-ID: <87obi9gzf9.fsf@rustcorp.com.au>
References: <20121204085149.25919.29920.stgit@srivatsabhat.in.ibm.com> <20121204085419.25919.79543.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:49725 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752407Ab2LDXmG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 4 Dec 2012 18:42:06 -0500
In-Reply-To: <20121204085419.25919.79543.stgit@srivatsabhat.in.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, vincent.guittot@linaro.org
Cc: sbw@mit.edu, tj@kernel.org, amit.kucheria@linaro.org, rostedt@goodmis.org, rjw@sisk.pl, srivatsa.bhat@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
> From: Michael Wang <wangyun@linux.vnet.ibm.com>
>
> With stop_machine() gone from the CPU offline path, we can't depend on
> preempt_disable() to prevent CPUs from going offline from under us.

Minor gripe: I'd prefer this paragraph to use the future rather than
past tense, like: "Once stop_machine() is gone ... we won't be able to
depend".

Since you're not supposed to use the _stable() accessors without calling
get_online_cpus_stable_atomic(), why not have
get_online_cpus_stable_atomic() return a pointer to the stable cpumask?
(Which is otherwise static, at least for debug).

Might make the patches messier though...

Oh, and I'd love to see actual benchmarks to make sure we've actually
fixed a problem with this ;)

Rusty.
