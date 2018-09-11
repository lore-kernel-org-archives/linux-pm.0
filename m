From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v6 03/14] PM: Introduce an Energy Model management
 framework
Date: Tue, 11 Sep 2018 11:34:56 +0200
Message-ID: <20180911093456.GA27352@andrea>
References: <20180820094420.26590-1-quentin.perret@arm.com>
 <20180820094420.26590-4-quentin.perret@arm.com>
 <20180829100435.GP2960@e110439-lin>
 <20180829132811.iacfltcos6kfgp7e@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180829132811.iacfltcos6kfgp7e@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@codeaurora.org, skannan@codeaurora.org, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Quentin,

> > 1. use of a single memory barrier
> > 
> >    Since we are already em_pd_mutex protected, i.e. there cannot be a
> >    concurrent writers, we can use one single memory barrier after the
> >    loop, i.e.
> > 
> >         for_each_cpu(cpu, span)
> >                 WRITE_ONCE()
> >         smp_wmb()
> > 
> >    which should be just enough to ensure that all other CPUs will see
> >    the pointer set once we release the mutex
> 
> Right, I'm actually wondering if the memory barrier is needed at all ...
> The mutex lock()/unlock() should already ensure the ordering I want no ?
> 
> WRITE_ONCE() should prevent load/store tearing with concurrent em_cpu_get(),
> and the release/acquire semantics of mutex lock/unlock should be enough to
> serialize the memory accesses of concurrent em_register_perf_domain() calls
> properly ...
> 
> Hmm, let me read memory-barriers.txt again.

FYI, the directory "tools/memory-model/" provides an "automated
memory-barriers.txt": in short, you encode your "memory ordering
questions" into "litmus tests" to be passed to the tool/simulator;
the tool will then answer with "Yes/No" (plus other information).

Some preparation is required to set up and learn how to use the
LKMM tools, but once there, I expect them to be more "efficient"
than reading memory-barriers.txt... ;-)  Please don't hesitate
to contact me/the LKMM maintainers if you need help with this.

You'd need some info in order to write down a _well-formed litmus
test, e.g., matching barrier/synchronization and interested memory
accesses on the reader side (IAC, the replacement "store-release
-> store-once+smp_wmb" discussed above is suspicious...).

  Andrea
