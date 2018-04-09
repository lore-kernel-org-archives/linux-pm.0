From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
Date: Mon, 9 Apr 2018 14:01:11 +0200
Message-ID: <20180409120111.GA4043@hirez.programming.kicks-ass.net>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320094312.24081-3-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
> From: Quentin Perret <quentin.perret@arm.com>
> 
> The energy consumption of each CPU in the system is modeled with a list
> of values representing its dissipated power and compute capacity at each
> available Operating Performance Point (OPP). These values are derived
> from existing information in the kernel (currently used by the thermal
> subsystem) and don't require the introduction of new platform-specific
> tunables. The energy model is also provided with a simple representation
> of all frequency domains as cpumasks, hence enabling the scheduler to be
> aware of dependencies between CPUs. The data required to build the energy
> model is provided by the OPP library which enables an abstract view of
> the platform from the scheduler. The new data structures holding these
> models and the routines to populate them are stored in
> kernel/sched/energy.c.
> 
> For the sake of simplicity, it is assumed in the energy model that all
> CPUs in a frequency domain share the same micro-architecture. As long as
> this assumption is correct, the energy models of different CPUs belonging
> to the same frequency domain are equal. Hence, this commit builds only one
> energy model per frequency domain, and links all relevant CPUs to it in
> order to save time and memory. If needed for future hardware platforms,
> relaxing this assumption should imply relatively simple modifications in
> the code but a significantly higher algorithmic complexity.

What this doesn't mention is why this isn't part of the regular topology
bits. IIRC this is because the frequency domains don't necessarily need
to align with the existing topology, but this completely fails to state
any of that.

Also, since I'm not at all familiar with DT and the OPP library stuff,
this code is completely unreadable to me and there isn't a nice comment
to help me along.
